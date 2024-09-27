import * as fs from 'fs-extra';
import translate from 'google-translate-api';

// Максимальная длина текста для одного запроса к Google Translate API
const MAX_TEXT_LENGTH = 5000;

// Функция для чтения файла и разбиения на блоки
async function readFileAndSplit(inputFilePath: string): Promise<string[]> {
  try {
    const fileContent = await fs.readFile(inputFilePath, 'utf-8');
    // Разбиваем на блоки по заголовкам, блокам кода и пустым строкам
    const blocks = fileContent.split(/(?=^#)|(?=^```)|(?=^\s*$)/gm);
    console.log('Текст разбит на блоки');
    return blocks;
  } catch (error) {
    console.error('Ошибка при чтении файла:', error);
    throw error;
  }
}

// Функция для разбивки длинного блока на более мелкие части
function splitLargeBlock(block: string): string[] {
  const parts: string[] = [];
  let currentPart: string = '';

  // Разделяем блок на строки
  const lines: string[] = block.split('\n');

  for (const line of lines) {
    if ((currentPart + line).length > MAX_TEXT_LENGTH) {
      parts.push(currentPart.trim());
      currentPart = line;
    } else {
      currentPart += `\n${line}`;
    }
  }

  // Добавляем оставшийся текст, если есть
  if (currentPart) {
    parts.push(currentPart.trim());
  }

  console.log('Блок Разбит');
  return parts;
}

// Функция для перевода одного блока текста
async function translateBlock(block: string, fromLang: string, toLang: string): Promise<string> {
  try {
    // Пропускаем блоки кода и пустые строки без перевода
    if (block.startsWith('```') || block.trim() === '') {
      return block;
    }

    // Если блок слишком длинный, разделим его на части
    const parts = splitLargeBlock(block);
    let translatedBlock = '';

    for (const part of parts) {
      const result = await translate(part, { from: fromLang, to: toLang });
      translatedBlock += `${result.text}\n`;
    }

    console.log('Блок переведен');
    return translatedBlock;
  } catch (error) {
    console.error('Ошибка при переводе блока:', error);
    return block; // Возвращаем исходный блок в случае ошибки, чтобы не терять контент
  }
}

// Функция для перевода файла по блокам
async function translateFileInBlocks(
  inputFilePath: string,
  outputFilePath: string,
  fromLang: string,
  toLang: string
) {
  try {
    // Чтение файла и разделение на блоки
    const blocks = await readFileAndSplit(inputFilePath);

    let translatedContent = '';

    // Перевод каждого блока
    for (const block of blocks) {
      const translatedBlock = await translateBlock(block, fromLang, toLang);
      translatedContent += `${translatedBlock}\n`; // Сохраняем переведенный блок с разделением
    }

    // Запись переведенного контента в новый файл
    await fs.writeFile(outputFilePath, translatedContent, 'utf-8');

    console.log(`Файл успешно переведен и сохранен в: ${outputFilePath}`);
  } catch (error) {
    console.error('Ошибка при переводе файла:', error);
  }
}

// Пример использования
const inputFilePath = 'apps/docs/docs/ru.md'; // Путь к исходному файлу
const outputFilePath = 'apps/docs/docs/en.md'; // Путь к переведенному файлу
const fromLang = 'ru'; // Исходный язык
const toLang = 'en'; // Язык перевода

translateFileInBlocks(inputFilePath, outputFilePath, fromLang, toLang);

const a: number = 10;
const b: string = '10';
const c: boolean = true;
const d: Date = new Date();
const e: bigint = BigInt(10);
const f: symbol = Symbol(); //???
const g: object = {};
const h: Array<number> = [1, 2, 3];
const i: Array<string> = ['1', '2', '3'];
const j: Array<boolean> = [true, false, true];
const k: Array<Date> = [new Date(), new Date(), new Date()];
const l: Array<bigint> = [BigInt(1), BigInt(2), BigInt(3)];
const m: Array<symbol> = [Symbol(), Symbol(), Symbol()];
const n: Array<object> = [{}, {}, {}];
const o: Array<Array<number>> = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
];
const p: Array<Array<string>> = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9']
];
const q: Array<Array<boolean>> = [
  [true, false, true],
  [false, true, false],
  [true, false, true]
];
const r: Array<Array<Date>> = [
  [new Date(), new Date(), new Date()],
  [new Date(), new Date(), new Date()],
  [new Date(), new Date(), new Date()]
];
const s: Array<Array<bigint>> = [
  [BigInt(1), BigInt(2), BigInt(3)],
  [BigInt(4), BigInt(5), BigInt(6)],
  [BigInt(7), BigInt(8), BigInt(9)]
];
const t: Array<Array<symbol>> = [
  [Symbol(), Symbol(), Symbol()],
  [Symbol(), Symbol(), Symbol()],
  [Symbol(), Symbol(), Symbol()]
];
const u: Array<Array<object>> = [
  [{}, {}, {}],
  [{}, {}, {}],
  [{}, {}, {}]
];
const v: Array<number | boolean | string | object | Array<number>> = [1, true, 'Hello World!', { a: [1] }, [1]];

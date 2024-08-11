@echo off

taskkill /f /im explorer.exe
timeout /t 2 /nobreak >nul


if not exist "%UserProfile%\Documents" mkdir "%UserProfile%\Documents"

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal" /t REG_SZ /d "C:\Users\%USERNAME%\Documents" /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Personal" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Documents" /f

attrib +r -s -h "%USERPROFILE%\Documents" /S /D



if not exist "%UserProfile%\Downloads" mkdir "%UserProfile%\Downloads"

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Downloads" /t REG_SZ /d "C:\Users\%USERNAME%\Downloads" /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Downloads" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Downloads" /f

attrib +r -s -h "%USERPROFILE%\Downloads" /S /D



if not exist "%UserProfile%\Pictures" mkdir "%UserProfile%\Pictures"

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Pictures" /t REG_SZ /d "C:\Users\%USERNAME%\Pictures" /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Pictures" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Pictures" /f

attrib +r -s -h "%USERPROFILE%\Pictures" /S /D



if not exist "%UserProfile%\Videos" mkdir "%UserProfile%\Videos"

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Videos" /t REG_SZ /d "C:\Users\%USERNAME%\Videos" /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Videos" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Videos" /f

attrib +r -s -h "%USERPROFILE%\Videos" /S /D



if not exist "%UserProfile%\Music" mkdir "%UserProfile%\Music"

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Music" /t REG_SZ /d "C:\Users\%USERNAME%\Music" /f

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Music" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Music" /f

attrib +r -s -h "%USERPROFILE%\Music" /S /D


timeout /t 1 /nobreak >nul
start explorer.exe
@echo off
:config
Rem You can edit config here
set w2xcexe=waifu2x-converter-cpp.exe
set ScaleFactor=2
set NoiseLevel=0
Set ModelDir=models_rgb\
set BlockSize=512
set AutoShutDown=0

:MainMenu
cls
title Waifu2x simple GUI by max20091
If not exist %w2xcexe% echo waifu2x converter not found! Please check again if you put this file at the right place.
echo scale factor: %ScaleFactor%x
if %NoiseLevel% equ 0 (echo Disabled image denoising) else (echo Noise level: %NoiseLevel%)
echo Model directory: %ModelDir%
echo Block size: %BlockSize%
if %AutoShutDown% equ 1 (echo Auto shutdown: on) else (echo Auto shutdown: off)
echo ------------------------
cmdmenusel f8%f0 "Run upscale" "Convert to PNG" "Change scale factor" "Change noise level" "Change Model Directory" "Change block size" "Auto shutdown toggle on/off" "Exit"
if %ERRORLEVEL% == 1 goto Scale
if %ERRORLEVEL% == 2 goto ConvertToPNG
if %ERRORLEVEL% == 3 goto ChangeScaleFactor
if %ERRORLEVEL% == 4 goto ChangeNoiseLevel
if %ERRORLEVEL% == 5 goto ChangeModelDir
if %ERRORLEVEL% == 6 goto ChangeBlockSize
if %ERRORLEVEL% == 7 if %AutoShutDown% equ 0 (set AutoShutDown=1) else (set AutoShutDown=0)
if %ERRORLEVEL% == 8 exit
goto MainMenu

:scale
title Upscaling...
cls
if %NoiseLevel% equ 0 (FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call %w2xcexe% --scale_ratio %ScaleFactor% --model_dir %ModelDir% -m scale --block_size %BlockSize% -i "input\%%a" -o "output\%%~na.png") else (FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call %w2xcexe% --scale_ratio %ScaleFactor% --model_dir %ModelDir% -m noise_scale --noise_level %NoiseLevel% --block_size %BlockSize% -i "input\%%a" -o "output\%%~na.png")
if %AutoShutDown% equ 1 shutdown -s
pause
goto MainMenu

:ConvertToPNG
cls
FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call %w2xcexe% --scale_ratio 1 --model_dir %ModelDir% -m scale -i "input\%%a" -o "output\%%~na.png"
if %AutoShutDown% equ 1 shutdown -s
pause
goto MainMenu

:ChangeScaleFactor
title Change scale factor
cls
cmdmenusel f8%f0 "2x (Default)" "4x" "8x" "Custom factor" "Go back to main menu"
if %ERRORLEVEL% == 1 set ScaleFactor=2
if %ERRORLEVEL% == 2 set ScaleFactor=4
if %ERRORLEVEL% == 3 set ScaleFactor=8
if %ERRORLEVEL% == 4 set /p ScaleFactor= Put your custom factor here: 
if %ERRORLEVEL% == 5 goto MainMenu
goto MainMenu

:ChangeNoiseLevel
title Change noise level
cls
cmdmenusel f8%f0 "0 (Default)" "1" "2" "3 (Only a few of converters support this)" "Go back to main menu"
if %ERRORLEVEL% == 1 set NoiseLevel=0
if %ERRORLEVEL% == 2 set NoiseLevel=1
if %ERRORLEVEL% == 3 set NoiseLevel=2
if %ERRORLEVEL% == 4 set NoiseLevel=3
if %ERRORLEVEL% == 5 goto MainMenu
goto MainMenu

:ChangeModelDir
title Change model directory
cls
set /p ModelDir=Put your model directory name to here (Default is models_rgb\): 
goto MainMenu

:ChangeBlockSize
title Change block size
cls
echo Increase block size will increase speed as well as increase RAM usage and vice versa
cmdmenusel f8%f0 "128 (Best option for low RAM space)" "256" "512 (Default)" "Custom block size" "Go back to main menu"
if %ERRORLEVEL% == 1 set BlockSize=128
if %ERRORLEVEL% == 2 set BlockSize=256
if %ERRORLEVEL% == 3 set BlockSize=512
if %ERRORLEVEL% == 4 set /p BlockSize= Put your block size here: 
if %ERRORLEVEL% == 5 goto MainMenu
goto MainMenu

@echo off
:config
set ScaleFactor=2
Set ModelDir=models_rgb\
set NoiseLevel=0
set w2xcexe=waifu2x-converter-cpp.exe
set BlockSize=512

:MainMenu
cls
title Waifu2x simple GUI by max20091
If not exist %w2xcexe% echo waifu2x converter not found! Please check again if you put this file at the right place.
echo scale factor: %ScaleFactor%x
echo Model directory: %ModelDir%
echo Noise level: %NoiseLevel%
echo Block size: %BlockSize%
cmdmenusel f8%f0 "Run" "Change scale factor" "Change noise level" "Change Model Directory" "Change block size" "Convert to PNG" "Exit"
if %ERRORLEVEL% == 1 goto Scale
if %ERRORLEVEL% == 2 goto ChangeScaleFactor
if %ERRORLEVEL% == 3 goto ChangeNoiseLevel
if %ERRORLEVEL% == 4 goto ChangeModelDir
if %ERRORLEVEL% == 5 goto ChangeBlockSize
if %ERRORLEVEL% == 6 goto ConvertToPNG
if %ERRORLEVEL% == 7 exit
:MainMenuCompleted
title Waifu2x simple GUI by max20091
cls
echo Completed!
echo scale factor: %ScaleFactor%x
echo Model directory: %ModelDir%
echo Noise level: %NoiseLevel%
echo Block size: %BlockSize%
cmdmenusel f8%f0 "Run" "Change scale factor" "Change noise level" "Change Model Directory" "Change block size" "Convert to PNG" "Exit"
if %ERRORLEVEL% == 1 goto Scale
if %ERRORLEVEL% == 2 goto ChangeScaleFactor
if %ERRORLEVEL% == 3 goto ChangeNoiseLevel
if %ERRORLEVEL% == 4 goto ChangeModelDir
if %ERRORLEVEL% == 5 goto ChangeBlockSize
if %ERRORLEVEL% == 6 goto ConvertToPNG
if %ERRORLEVEL% == 7 exit

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

:ConvertToPNG
cls
FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call %w2xcexe% --scale_ratio 1 --model_dir %ModelDir% -m scale -i "input\%%a" -o "output\%%~na.png"
goto MainMenuCompleted

:ChangeModelDir
title Change model directory
cls
set /p ModelDir=Put your model directory name to here (Default is models_rgb\): 
goto MainMenu

:scale
title Upscaling...
cls
if %NoiseLevel% equ 0 (FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call %w2xcexe% --scale_ratio %ScaleFactor% --model_dir %ModelDir% -m scale --block_size %BlockSize% -i "input\%%a" -o "output\%%~na.png") else (FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call %w2xcexe% --scale_ratio %ScaleFactor% --model_dir %ModelDir% -m noise_scale --noise_level %NoiseLevel% --block_size %BlockSize% -i "input\%%a" -o "output\%%~na.png")
pause
goto MainMenuCompleted

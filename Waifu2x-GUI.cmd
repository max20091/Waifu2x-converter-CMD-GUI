@echo off
set ScaleFactor=2
Set ModelDir=models_rgb\
set NoiseLevel=1

:MainMenu
cls
title Waifu2x simple GUI by max20091
If not exist "waifu2x-converter-cpp.exe" echo waifu2x-converter-cpp not found! Please check again if you put this at right place.
echo scale factor: %ScaleFactor%x
echo Model directory: %ModelDir%
echo Noise level: %NoiseLevel%
cmdmenusel f8%f0 "Run" "Change scale factor" "Change noise level" "Change Model Directory" "Convert to PNG" "Exit"
if %ERRORLEVEL% == 1 goto Scale
if %ERRORLEVEL% == 2 goto ChangeScaleFactor
if %ERRORLEVEL% == 3 goto ChangeNoiseLevel
if %ERRORLEVEL% == 4 goto ChangeModelDir
if %ERRORLEVEL% == 5 goto ConvertToPNG
if %ERRORLEVEL% == 6 exit
:MainMenuCompleted
title Waifu2x simple GUI by max20091
cls
echo Completed!
echo scale factor: %ScaleFactor%
echo Model directory: %ModelDir%
echo Noise level: %NoiselLevel%
cmdmenusel f8%f0 "Run" "Change scale factor" "Change noise level" "Change Model Directory" "Convert to PNG" "Exit"
if %ERRORLEVEL% == 1 goto Scale
if %ERRORLEVEL% == 2 goto ChangeScaleFactor
if %ERRORLEVEL% == 3 goto ChangeNoiseLevel
if %ERRORLEVEL% == 4 goto ChangeModelDir
if %ERRORLEVEL% == 5 goto ConvertToPNG
if %ERRORLEVEL% == 6 exit

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
cmdmenusel f8%f0 "1 (Default)" "2" "3 (Only a few of converters support this)" "Go back to main menu"
if %ERRORLEVEL% == 1 set NoiseLevel=1
if %ERRORLEVEL% == 2 set NoiseLevel=2
if %ERRORLEVEL% == 3 set NoiseLevel=3
if %ERRORLEVEL% == 4 goto MainMenu
goto MainMenu

:ConvertToPNG
FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call waifu2x-converter-cpp.exe --scale_ratio 1 --model_dir %ModelDir% -m scale -i "input\%%a" -o "output\%%~na.png"
goto MainMenuCompleted

:ChangeModelDir
title Change model directory
cls
set /p ModelDir=Put your model directory name to here (Default is models_rgb\): 
goto MainMenu

:scale
title Upscaling...
FOR /f "delims=" %%a IN ('dir /b input\*.*') DO call waifu2x-converter-cpp.exe --scale_ratio %ScaleFactor% --model_dir %ModelDir% -m noise_scale --noise_level %NoiseLevel% -i "input\%%a" -o "output\%%~na.png"
goto MainMenuCompleted

:: Path to Flex SDK
@set FLEX_SDK=C:\SDKs\AIR23
@set PASS=none

:validation
@if not exist "%FLEX_SDK%\bin" goto flexsdk
@goto succeed


:flexsdk
@echo.
@echo ERROR: incorrect path to Flex SDK
@echo.
@echo Looking for: %FLEX_SDK%\bin
@echo.
@if %PAUSE_ERRORS%==1 pause
@exit

:succeed

call clean.bat

mkdir src\assets
copy "..\01-ANEAndroidPermissions-swc\com.amanitadesign.AndroidPermissions.swc" src\assets

xcopy /S /Y res\* src\assets\platform\Android-ARM\

mkdir src\assets\swc-contents
pushd src\assets\swc-contents
JAR xf ..\com.amanitadesign.AndroidPermissions.swc catalog.xml library.swf
popd

mkdir src\assets\platform
mkdir src\assets\platform\Android-ARM

copy "..\02-ANEAndroidPermissions\AndroidPermissions.jar" src\assets\platform\Android-ARM
copy src\assets\swc-contents\library.swf src\assets\platform\Android-ARM

@java -jar "%FLEX_SDK%\lib\adt.jar" -package        ^
    -target ane ANEAndroidPermissions.ane src\extension.xml	^
    -swc src\assets\com.amanitadesign.AndroidPermissions.swc	^
    -platform Android-ARM                               ^
    -C src\assets\platform\Android-ARM .

RD  /S /Q .\src\assets


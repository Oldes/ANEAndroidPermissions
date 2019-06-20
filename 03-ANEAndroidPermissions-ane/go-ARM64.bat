:: Path to AIR SDK
SET AIR_SDK_VERSION=AIRSDK-Windows-Harman

call clean.bat

mkdir "src\assets\platform\Android-ARM"
mkdir "src\assets\platform\Android-ARM64"
mkdir "src\assets\platform\Android-x86"
copy "..\01-ANEAndroidPermissions-swc\com.amanitadesign.AndroidPermissions.swc" src\assets

xcopy /S /Y res\* src\assets\platform\Android-ARM\
xcopy /S /Y res\* src\assets\platform\Android-ARM64\
xcopy /S /Y res\* src\assets\platform\Android-x86\

mkdir src\assets\swc-contents
pushd src\assets\swc-contents
JAR xf ..\com.amanitadesign.AndroidPermissions.swc catalog.xml library.swf
popd

mkdir src\assets\platform
mkdir src\assets\platform\Android-ARM
mkdir src\assets\platform\Android-x86

copy "..\02-ANEAndroidPermissions\AndroidPermissions.jar" src\assets\platform\Android-ARM
copy src\assets\swc-contents\library.swf src\assets\platform\Android-ARM

copy "..\02-ANEAndroidPermissions\AndroidPermissions.jar" src\assets\platform\Android-ARM64
copy src\assets\swc-contents\library.swf src\assets\platform\Android-ARM64

copy "..\02-ANEAndroidPermissions\AndroidPermissions.jar" src\assets\platform\Android-x86
copy src\assets\swc-contents\library.swf src\assets\platform\Android-x86

java -jar "..\..\%AIR_SDK_VERSION%\lib\adt.jar" -package          ^
	-target ane ANEAndroidPermissions.ane src\extension.xml    ^
	-swc src\assets\com.amanitadesign.AndroidPermissions.swc   ^
	-platform Android-ARM -C src\assets\platform\Android-ARM . ^
	-platform Android-ARM64 -C src\assets\platform\Android-ARM64 . ^
	-platform Android-x86 -C src\assets\platform\Android-x86 . 

RD  /S /Q .\src\assets


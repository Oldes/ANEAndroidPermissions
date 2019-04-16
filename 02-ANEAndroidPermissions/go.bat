@echo off

MKDIR AndroidPermissions
CD AndroidPermissions
jar -xvf ..\ANEAndroidPermissions-studio\app\build\outputs\aar\app-release.aar
MOVE classes.jar ..\AndroidPermissions.jar

CD ..

RD  /S /Q AndroidPermissions
@echo off

jar cvf AndroidPermissions.jar ANEAndroidPermissions-eclipse\bin\classes\*

MKDIR AndroidPermissions
MOVE /Y AndroidPermissions.jar AndroidPermissions/
CD AndroidPermissions
jar -xvf  AndroidPermissions.jar
DEL AndroidPermissions.jar
RD  /S /Q META-INF

MKDIR classes
MOVE /Y ANEAndroidPermissions-eclipse/bin/classes/com classes/
CD classes
DEL com\amanitadesign\ane\BuildConfig.class

jar cvf AndroidPermissions.jar *
MOVE /Y AndroidPermissions.jar ../../

CD ../../

RD  /S /Q AndroidPermissions
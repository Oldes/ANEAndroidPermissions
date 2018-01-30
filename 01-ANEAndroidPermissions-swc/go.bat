:: Path to AIR SDK
@call ../setup.bat

@IF EXIST com.amanitadesign.AndroidPermissions.swc DEL com.amanitadesign.AndroidPermissions.swc

@echo.
"%AIR_SDK%"/bin/acompc -namespace http://amanita-design.net/extensions src/manifest.xml ^
    -swf-version 33     ^
    -source-path src	^
    -include-classes	^
    com.amanitadesign.AndroidPermissions	^
    -output=com.amanitadesign.AndroidPermissions.swc


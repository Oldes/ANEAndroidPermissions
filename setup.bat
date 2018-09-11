
@IF DEFINED AIR_SDK @goto validation
	
SET AIR_SDK=c:\SDKs\AIR30
SET PASS=none

SET ARCH_OPTION=armv7
::ARCH_OPTION can be one of: armv7 | x86 | x64

:validation
@if not exist "%AIR_SDK%\bin" goto airsdk
@goto succeed


:airsdk
@echo.
@echo ERROR: incorrect path to AIR SDK
@echo.
@echo Looking for: %AIR_SDK%\bin
@echo.
@if %PAUSE_ERRORS%==1 pause
@exit

:succeed

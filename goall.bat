@echo off
set PAUSE_ERRORS=1

SET FLEX_SDK=c:\SDKs\AIR23
set PATH=%PATH%;%FLEX_SDK%\bin


echo "===== Step 01 =========================================================="
cd 01*
call ./go.bat
cd ..
echo

echo "===== Step 02 =========================================================="
cd 02*
call ./go.bat
cd ..
echo

echo "===== Step 03 =========================================================="
cd 03*
call ./go.bat
cd ..
echo

echo "===== Step 04 =========================================================="
cd 04*
call ./go.bat
cd ..
echo


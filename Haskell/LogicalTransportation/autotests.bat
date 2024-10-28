@echo off
setlocal

echo Compiling Haskell program...
ghc -o trans trans.hs
if errorlevel 1 (
    echo Compilation failed.
    exit /b 1
)

for %%f in (tests\*.txt) do (
    echo Running test %%~nf...
    
    trans.exe < %%f > output.txt
    type output.txt
    
    echo Test %%~nf completed.
    echo ---------------------------------
    echo.
)

del trans.exe
del output.txt

endlocal
@echo off
setlocal

:: Compile the Haskell program
echo Compiling Haskell program...
ghc -o trans trans.hs
if errorlevel 1 (
    echo Compilation failed.
    exit /b 1
)

:: Iterate over each test file in the tests directory
for %%f in (tests\*.txt) do (
    echo Running test %%~nf...
    
    :: Run the compiled Haskell program with the test inputs from the file
    trans.exe < %%f > output.txt
    
    :: Display the test result
    type output.txt
    
    echo Test %%~nf completed.
    echo ---------------------------------
    
    :: Insert a blank line
    echo.
)

:: Clean up
del trans.exe
del output.txt

endlocal
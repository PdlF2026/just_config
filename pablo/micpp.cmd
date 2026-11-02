@echo off
if "%~1"=="" (
    echo "Missing file. Try to use `help` to have a bit information."
    exit /b 1
)
if "%~1"=="clean" (
    echo "This will clean ccache."
    @echo on
    ccache -C
    exit /b 0
)

ccache.exe clang++.exe -std=c++26 -g -O0 --target=x86_64-w64-mingw32 -Wconversion -Wfloat-equal %* -o "%~n1.exe"
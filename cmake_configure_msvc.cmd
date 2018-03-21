@echo off

cmake -G"Visual Studio 12 2013" ^
    -DDIA_SDK="C:\\Program Files (x86)\\Microsoft Visual Studio 12.0\\DIA SDK" ^
    ../

cmake_minimum_required(VERSION 3.5)

project(Breakpad CXX C)

message(STATUS "CMAKE_SYSTEM_NAME: " ${CMAKE_SYSTEM_NAME})

add_subdirectory(src)

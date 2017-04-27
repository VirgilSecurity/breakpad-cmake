cmake_minimum_required(VERSION 3.5)

project(Breakpad CXX C)

message(STATUS "CMAKE_SYSTEM_NAME: " ${CMAKE_SYSTEM_NAME})

#
# Download GMock and GTest
#
find_package(Git REQUIRED)

if(NOT EXISTS ${CMAKE_SOURCE_DIR}/src/testing)
	execute_process(
		COMMAND ${GIT_EXECUTABLE} clone --branch release-1.7.0
			https://github.com/google/googlemock.git src/testing
		
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		OUTPUT_QUIET
	)
endif()

if(NOT EXISTS ${CMAKE_SOURCE_DIR}/src/testing/gtest)
	execute_process(
		COMMAND ${GIT_EXECUTABLE} clone --branch release-1.7.0
			https://github.com/google/googletest.git src/testing/gtest
			
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		OUTPUT_QUIET
	)
endif()

add_subdirectory(src)

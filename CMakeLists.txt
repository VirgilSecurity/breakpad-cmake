cmake_minimum_required(VERSION 3.5)

project(Breakpad CXX C)

message(STATUS "CMAKE_SYSTEM_NAME: " ${CMAKE_SYSTEM_NAME})

# macro to find packages on the host OS
macro( find_host_package )
 set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
 set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
 set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
 if( CMAKE_HOST_WIN32 )
  SET( WIN32 1 )
  SET( UNIX )
 elseif( CMAKE_HOST_APPLE )
  SET( APPLE 1 )
  SET( UNIX )
 endif()
 find_package( ${ARGN} )
 SET( WIN32 )
 SET( APPLE )
 SET( UNIX 1 )
 set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
 set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
 set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
endmacro()

# macro to find programs on the host OS
macro( find_host_program )
 set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
 set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
 set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
 if( CMAKE_HOST_WIN32 )
  SET( WIN32 1 )
  SET( UNIX )
 elseif( CMAKE_HOST_APPLE )
  SET( APPLE 1 )
  SET( UNIX )
 endif()
 find_program( ${ARGN} )
 SET( WIN32 )
 SET( APPLE )
 SET( UNIX 1 )
 set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
 set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
 set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
endmacro()

#
# Download GMock and GTest
#
if(CMAKE_CROSSCOMPILING)
	find_host_package(Git REQUIRED)
else()
	find_package(Git REQUIRED)
endif()

if(NOT EXISTS ${CMAKE_SOURCE_DIR}/src/testing)
	execute_process(
		COMMAND ${GIT_EXECUTABLE} clone --branch release-1.7.0 --quiet
			https://github.com/google/googlemock.git src/testing
		
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		OUTPUT_QUIET
	)
endif()

if(NOT EXISTS ${CMAKE_SOURCE_DIR}/src/testing/gtest)
	execute_process(
		COMMAND ${GIT_EXECUTABLE} clone --branch release-1.7.0 --quiet
			https://github.com/google/googletest.git src/testing/gtest
			
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		OUTPUT_QUIET
	)
endif()

if(NOT EXISTS ${CMAKE_SOURCE_DIR}/src/third_party/lss)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} clone --quiet
            https://chromium.googlesource.com/linux-syscall-support src/third_party/lss
            
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_QUIET
    )
endif()

add_subdirectory(src)

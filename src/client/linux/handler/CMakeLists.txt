add_library(exception_handler STATIC
    exception_handler.cc
    minidump_descriptor.cc
)

target_include_directories(exception_handler PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)

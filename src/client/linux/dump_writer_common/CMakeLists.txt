add_library(dump_writer_common STATIC
    thread_info.cc
    ucontext_reader.cc
)

target_include_directories(dump_writer_common PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)

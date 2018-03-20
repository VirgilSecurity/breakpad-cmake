#
# processor_bits
#
add_library(processor_bits STATIC
    ${CMAKE_SOURCE_DIR}/src/common/string_conversion.cc
    ${CMAKE_SOURCE_DIR}/src/processor/basic_code_modules.cc
    ${CMAKE_SOURCE_DIR}/src/processor/dump_context.cc
    ${CMAKE_SOURCE_DIR}/src/processor/dump_object.cc
    ${CMAKE_SOURCE_DIR}/src/processor/logging.cc
    ${CMAKE_SOURCE_DIR}/src/processor/minidump.cc
    ${CMAKE_SOURCE_DIR}/src/processor/pathname_stripper.cc
    ${CMAKE_SOURCE_DIR}/src/processor/proc_maps_linux.cc
)

target_include_directories(processor_bits PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(processor_bits
    MSVC::static_runtime
)

add_executable(client_tests
    exception_handler_test.h
    exception_handler_test.cc
    exception_handler_death_test.cc
    exception_handler_nesting_test.cc
    minidump_test.cc
    dump_analysis.cc
    dump_analysis.h
    crash_generation_server_test.cc
)

target_include_directories(client_tests PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(client_tests
    MSVC::static_runtime
    gmock_main
    common
    crash_generation_server
    crash_generation_client
    exception_handler
    processor_bits
    wininet.lib
    version.lib
    dbghelp.lib
    ImageHlp.lib
)

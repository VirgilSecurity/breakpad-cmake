#
# processor_bits
#
add_library(processor_bits STATIC
	common/string_conversion.cc
	processor/basic_code_modules.cc
	processor/dump_context.cc
	processor/dump_object.cc
	processor/logging.cc
	processor/minidump.cc
	processor/pathname_stripper.cc
	processor/proc_maps_linux.cc
)

target_include_directories(processor_bits PRIVATE
	${CMAKE_SOURCE_DIR}/src
)

target_compile_definitions(processor_bits PRIVATE
	_CRT_SECURE_NO_WARNINGS
)

target_compile_options(processor_bits PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

add_executable(client_tests
    client/windows/unittests/exception_handler_test.h
    client/windows/unittests/exception_handler_test.cc
    client/windows/unittests/exception_handler_death_test.cc
    client/windows/unittests/exception_handler_nesting_test.cc
    client/windows/unittests/minidump_test.cc
    client/windows/unittests/dump_analysis.cc
    client/windows/unittests/dump_analysis.h
    client/windows/unittests/crash_generation_server_test.cc

	client/windows/unittests/client_tests.cmake
)

target_compile_definitions(client_tests PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

target_compile_options(client_tests PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

target_link_libraries(client_tests
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

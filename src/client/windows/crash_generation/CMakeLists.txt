set(CrashGenerationServerSources
	client_info.cc
	crash_generation_server.cc
	minidump_generator.cc
	client_info.h
	crash_generation_client.h
	crash_generation_server.h
	minidump_generator.h
)

add_library(crash_generation_server STATIC
	${CrashGenerationServerSources}
)

target_include_directories(crash_generation_server PUBLIC
	${CMAKE_SOURCE_DIR}/src
)

target_compile_definitions(crash_generation_server PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

target_compile_options(crash_generation_server PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

set(CrashGenerationClientSources
	crash_generation_client.h
	crash_generation_client.cc
	crash_generation_server.h
)

add_library(crash_generation_client STATIC
	${CrashGenerationClientSources}
)

target_include_directories(crash_generation_client PUBLIC
	${CMAKE_SOURCE_DIR}/src
)

target_compile_definitions(crash_generation_client PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

target_compile_options(crash_generation_client PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

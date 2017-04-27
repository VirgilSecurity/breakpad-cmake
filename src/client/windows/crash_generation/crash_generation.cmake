set(CrashGenerationServerSources
	client/windows/crash_generation/client_info.cc
	client/windows/crash_generation/crash_generation_server.cc
	client/windows/crash_generation/minidump_generator.cc
	client/windows/crash_generation/client_info.h
	client/windows/crash_generation/crash_generation_client.h
	client/windows/crash_generation/crash_generation_server.h
	client/windows/crash_generation/minidump_generator.h
)

add_library(crash_generation_server STATIC
	${CrashGenerationServerSources}
)

target_include_directories(crash_generation_server PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(crash_generation_server PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

set(CrashGenerationClientSources
	client/windows/crash_generation/crash_generation_client.h
	client/windows/crash_generation/crash_generation_client.cc
	client/windows/crash_generation/crash_generation_server.h
	
	client/windows/crash_generation/crash_generation.cmake
)

add_library(crash_generation_client STATIC
	${CrashGenerationClientSources}
)

target_include_directories(crash_generation_client PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(crash_generation_client PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

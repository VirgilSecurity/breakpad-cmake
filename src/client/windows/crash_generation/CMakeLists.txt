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

target_link_libraries(crash_generation_server
    MSVC::static_runtime
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

target_link_libraries(crash_generation_client
    MSVC::static_runtime
)

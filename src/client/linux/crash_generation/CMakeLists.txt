add_library(crash_generation_client STATIC
    crash_generation_client.cc
)

target_include_directories(crash_generation_client PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)

add_library(crash_generation_server STATIC
    crash_generation_server.cc
)

target_include_directories(crash_generation_server PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)

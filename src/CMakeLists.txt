#
# GTest and GMock targets
#
add_library(gtest STATIC
    testing/gtest/src/gtest-all.cc
)

target_include_directories(gtest PUBLIC
    testing/gtest
    testing/gtest/include
)

target_compile_options(gtest PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

add_library(gtest_main STATIC
    testing/gtest/src/gtest_main.cc
)

target_link_libraries(gtest_main
    gtest
)

target_compile_options(gtest_main PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

add_library(gmock STATIC
    testing/src/gmock-all.cc
)

target_include_directories(gmock PUBLIC
    testing
    testing/include
)

target_compile_options(gmock PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

target_link_libraries(gmock
    gtest
)

add_library(gmock_main STATIC
    testing/src/gmock_main.cc
)

target_compile_options(gmock_main PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

target_link_libraries(gmock_main
    gmock
)

#
# Breakpad targets
#
if(MSVC)
    add_subdirectory(client/windows/crash_generation)
    add_subdirectory(client/windows/handler)
    add_subdirectory(client/windows/sender)
    add_subdirectory(client/windows/tests/crash_generation_app)
    add_subdirectory(client/windows/unittests)

    add_subdirectory(tools/windows)
endif()

if(ANDROID)
    include(android.cmake)
endif()

add_subdirectory(common)
add_subdirectory(third_party/libdisasm)
add_subdirectory(processor)

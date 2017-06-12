add_library(gtest STATIC
    testing/gtest/src/gtest-all.cc
)

target_include_directories(gtest PUBLIC
    testing/gtest
    testing/gtest/include
)

add_library(gtest_main STATIC
    testing/gtest/src/gtest_main.cc
)

target_link_libraries(gtest_main
    gtest
)

add_library(gmock STATIC
    testing/src/gmock-all.cc
)

target_include_directories(gmock PUBLIC
    testing
    testing/include
)

target_link_libraries(gmock
    gtest
)

add_library(gmock_main STATIC
    testing/src/gmock_main.cc
)

target_link_libraries(gmock_main
    gmock
)

if(MSVC)
    include(client/windows/crash_generation/crash_generation.cmake)
    include(client/windows/handler/exception_handler.cmake)
    include(client/windows/sender/crash_report_sender.cmake)
    include(client/windows/tests/crash_generation_app/crash_generation_app.cmake)
    include(client/windows/unittests/client_tests.cmake)

    include(tools/windows/tools_windows.cmake)
endif()

include(common/common.cmake)
include(third_party/libdisasm/libdisasm.cmake)
include(processor/processor.cmake)

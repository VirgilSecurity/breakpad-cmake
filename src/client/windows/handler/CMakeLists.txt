add_library(exception_handler STATIC
    exception_handler.cc
    exception_handler.h
)

target_link_libraries(exception_handler
    MSVC::static_runtime
    crash_generation_server
)

add_executable(crash_generation_app WIN32
    abstract_class.cc
    abstract_class.h
    crash_generation_app.cc
    crash_generation_app.h
    crash_generation_app.ico
    crash_generation_app.rc
    resource.h
    small.ico
)

target_compile_definitions(crash_generation_app PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

target_link_libraries(crash_generation_app
    common
    crash_generation_server
    crash_generation_client
    exception_handler
)

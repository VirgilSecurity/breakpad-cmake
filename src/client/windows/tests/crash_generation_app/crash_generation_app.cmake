add_executable(crash_generation_app WIN32
    client/windows/tests/crash_generation_app/abstract_class.cc
    client/windows/tests/crash_generation_app/abstract_class.h
    client/windows/tests/crash_generation_app/crash_generation_app.cc
    client/windows/tests/crash_generation_app/crash_generation_app.h
    client/windows/tests/crash_generation_app/crash_generation_app.ico
    client/windows/tests/crash_generation_app/crash_generation_app.rc
    client/windows/tests/crash_generation_app/resource.h
    client/windows/tests/crash_generation_app/small.ico

	client/windows/tests/crash_generation_app/crash_generation_app.cmake
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

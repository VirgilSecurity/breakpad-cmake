add_library(exception_handler STATIC
    client/windows/handler/exception_handler.cc
    client/windows/handler/exception_handler.h
)

target_link_libraries(exception_handler
	crash_generation_server
)

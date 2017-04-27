add_library(crash_report_sender STATIC
	client/windows/sender/crash_report_sender.cc
	client/windows/sender/crash_report_sender.h
	
	client/windows/sender/crash_report_sender.cmake
)

target_link_libraries(crash_report_sender
	common
)

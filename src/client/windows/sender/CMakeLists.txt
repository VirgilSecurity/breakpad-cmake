add_library(crash_report_sender STATIC
    crash_report_sender.cc
    crash_report_sender.h
)

target_link_libraries(crash_report_sender
    MSVC::static_runtime
    common
)

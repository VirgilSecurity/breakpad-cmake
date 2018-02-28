set(Sources
    client/linux/crash_generation/crash_generation_client.cc
    client/linux/dump_writer_common/thread_info.cc
    client/linux/dump_writer_common/ucontext_reader.cc
    client/linux/handler/exception_handler.cc
    client/linux/handler/minidump_descriptor.cc
    client/linux/log/log.cc
    client/linux/microdump_writer/microdump_writer.cc
    client/linux/minidump_writer/linux_dumper.cc
    client/linux/minidump_writer/linux_ptrace_dumper.cc
    client/linux/minidump_writer/minidump_writer.cc
    client/minidump_file_writer.cc
    common/android/breakpad_getcontext.S
    common/convert_UTF.c
    common/md5.cc
    common/string_conversion.cc
    common/linux/elfutils.cc
    common/linux/file_id.cc
    common/linux/guid_creator.cc
    common/linux/linux_libc_support.cc
    common/linux/memory_mapped_file.cc
    common/linux/safe_readlink.cc
)

set_property(SOURCE common/android/breakpad_getcontext.S PROPERTY LANGUAGE ASM)

add_library(breakpad_client STATIC
    ${Sources}
)

target_include_directories(breakpad_client PUBLIC
    ${CMAKE_SOURCE_DIR}/src/common/android/include
    ${CMAKE_SOURCE_DIR}/src
)

target_compile_features(breakpad_client PUBLIC
    cxx_std_11
)

target_link_libraries(breakpad_client
    log
)

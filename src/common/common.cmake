set(CommonSources)

if(ANDROID)
    list(APPEND CommonSources
        common/android/breakpad_getcontext.S
        common/android/include/elf.h
        common/android/include/link.h
        common/android/include/sgidefs.h
        common/android/include/stab.h
        common/android/include/sys/procfs.h
        common/android/include/sys/signal.h
        common/android/include/sys/user.h
        common/android/include/ucontext.h
        common/android/testing/include/wchar.h
        common/android/testing/mkdtemp.h
        common/android/testing/pthread_fixes.h
        common/android/ucontext_constants.h
    )
endif()

list(APPEND CommonSources
    common/basictypes.h
    common/byte_cursor.h
    common/convert_UTF.c
    common/convert_UTF.h
    # dwarf/bytereader-inl.h
    # dwarf/bytereader.cc
    # dwarf/bytereader.h
    # dwarf/cfi_assembler.cc
    # dwarf/cfi_assembler.h
    # dwarf/dwarf2diehandler.cc
    # dwarf/dwarf2diehandler.h
    # dwarf/dwarf2enums.h
    # dwarf/dwarf2reader.cc
    # dwarf/dwarf2reader.h
    # dwarf/dwarf2reader_test_common.h
    # dwarf/elf_reader.cc
    # dwarf/elf_reader.h
    # dwarf/functioninfo.cc
    # dwarf/functioninfo.h
    # dwarf/line_state_machine.h
    # dwarf/types.h
    # dwarf_cfi_to_module.cc
    # dwarf_cfi_to_module.h
    # dwarf_cu_to_module.cc
    # dwarf_cu_to_module.h
    # dwarf_line_to_module.cc
    # dwarf_line_to_module.h
    # language.cc
    # language.h
)

if(UNIX)
    list(APPEND CommonSources
        common/linux/crc32.cc
        common/linux/crc32.h
        common/linux/dump_symbols.cc
        common/linux/dump_symbols.h
        common/linux/eintr_wrapper.h
        common/linux/elf_core_dump.cc
        common/linux/elf_core_dump.h
        common/linux/elf_gnu_compat.h
        common/linux/elf_symbols_to_module.cc
        common/linux/elf_symbols_to_module.h
        common/linux/elfutils-inl.h
        common/linux/elfutils.cc
        common/linux/elfutils.h
        common/linux/file_id.cc
        common/linux/file_id.h
        common/linux/google_crashdump_uploader.cc
        common/linux/google_crashdump_uploader.h
        common/linux/guid_creator.cc
        common/linux/guid_creator.h
        common/linux/http_upload.cc
        common/linux/http_upload.h
        common/linux/ignore_ret.h
        common/linux/libcurl_wrapper.cc
        common/linux/libcurl_wrapper.h
        common/linux/linux_libc_support.cc
        common/linux/linux_libc_support.h
        common/linux/memory_mapped_file.cc
        common/linux/memory_mapped_file.h
        common/linux/safe_readlink.cc
        common/linux/safe_readlink.h
        common/linux/synth_elf.cc
        common/linux/synth_elf.h
    )
endif()

if(APPLE)
    list(APPEND CommonSources
        common/mac/arch_utilities.cc
        common/mac/arch_utilities.h
        common/mac/bootstrap_compat.cc
        common/mac/bootstrap_compat.h
        common/mac/byteswap.h
        common/mac/dump_syms.h
        common/mac/dump_syms.cc
        common/mac/file_id.cc
        common/mac/file_id.h
        common/mac/GTMDefines.h
        common/mac/GTMLogger.h
        common/mac/GTMLogger.m
        common/mac/HTTPMultipartUpload.h
        common/mac/HTTPMultipartUpload.m
        common/mac/MachIPC.h
        common/mac/MachIPC.mm
        common/mac/macho_id.cc
        common/mac/macho_id.h
        common/mac/macho_reader.cc
        common/mac/macho_reader.h
        common/mac/macho_utilities.cc
        common/mac/macho_utilities.h
        common/mac/macho_walker.cc
        common/mac/macho_walker.h
        common/mac/scoped_task_suspend-inl.h
        common/mac/string_utilities.cc
        common/mac/string_utilities.h
        common/mac/super_fat_arch.h
    )
endif()

list(APPEND CommonSources
    common/md5.cc
    common/md5.h
    common/memory.h
    common/memory_range.h
    common/module.cc
    common/module.h
    common/scoped_ptr.h
    common/simple_string_dictionary.cc
    common/simple_string_dictionary.h
)

if(Solaris)
    list(APPEND CommonSources
        common/solaris/dump_symbols.cc
        common/solaris/dump_symbols.h
        common/solaris/file_id.cc
        common/solaris/file_id.h
        common/solaris/guid_creator.cc
        common/solaris/guid_creator.h
        common/solaris/message_output.h
    )
endif()

list(APPEND CommonSources
    # stabs_reader.cc
    # stabs_reader.h
    # stabs_to_module.cc
    # stabs_to_module.h
    common/string_conversion.cc
    common/string_conversion.h
    common/symbol_data.h
    common/test_assembler.cc
    common/test_assembler.h
    common/unordered.h
    common/using_std_string.h
)

if(MSVC)
    list(APPEND CommonSources
        common/windows/dia_util.cc
        common/windows/dia_util.h
        common/windows/guid_string.cc
        common/windows/guid_string.h
        common/windows/http_upload.cc
        common/windows/http_upload.h
        common/windows/omap.cc
        common/windows/omap.h
        common/windows/omap_internal.h
        common/windows/pdb_source_line_writer.cc
        common/windows/pdb_source_line_writer.h
        common/windows/string_utils-inl.h
        common/windows/string_utils.cc
    )
endif()

add_library(common STATIC
    ${CommonSources}
)

target_include_directories(common PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    "C:/Program Files (x86)/Microsoft Visual Studio 14.0/DIA SDK/include"
	"C:/Program Files (x86)/Microsoft Visual Studio 12.0/DIA SDK/include"
    "C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/atlmfc/include"
	"C:/Program Files (x86)/Microsoft Visual Studio 12.0/VC/atlmfc/include"
)

target_compile_definitions(common PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS UNICODE>
    $<$<PLATFORM_ID:Darwin>:HAVE_MACH_O_NLIST_H>
    $<$<PLATFORM_ID:Linux>:HAVE_A_OUT_H>
)


#       'target_name': 'common_unittests
#       'type': 'executable
#       'sources': [
#     android/breakpad_getcontext_unittest.cc
#     byte_cursor_unittest.cc
#     dwarf/bytereader_unittest.cc
#     dwarf/dwarf2diehandler_unittest.cc
#     dwarf/dwarf2reader_cfi_unittest.cc
#     dwarf/dwarf2reader_die_unittest.cc
#     dwarf_cfi_to_module_unittest.cc
#     dwarf_cu_to_module_unittest.cc
#     dwarf_line_to_module_unittest.cc
#     linux/dump_symbols_unittest.cc
#     linux/elf_core_dump_unittest.cc
#     linux/elf_symbols_to_module_unittest.cc
#     linux/file_id_unittest.cc
#     linux/google_crashdump_uploader_test.cc
#     linux/linux_libc_support_unittest.cc
#     linux/memory_mapped_file_unittest.cc
#     linux/safe_readlink_unittest.cc
#     linux/synth_elf_unittest.cc
#     linux/tests/auto_testfile.h
#     linux/tests/crash_generator.cc
#     linux/tests/crash_generator.h
#     mac/macho_reader_unittest.cc
#     memory_range_unittest.cc
#     memory_unittest.cc
#     module_unittest.cc
#     simple_string_dictionary_unittest.cc
#     stabs_reader_unittest.cc
#     stabs_to_module_unittest.cc
#     test_assembler_unittest.cc
#     tests/auto_tempdir.h
#     tests/file_utils.cc
#     tests/file_utils.h
#     windows/omap_unittest.cc
#       ],
#       'include_dirs': [
#     ..
#       ],
#       'dependencies': [
#     common
#     ../build/testing.gypi:gmock_main
#     ../build/testing.gypi:gmock
#     ../build/testing.gypi:gtest
#       ],
#       'libraries': [
#     -ldl
#       ],
#     },
#   ],
# }

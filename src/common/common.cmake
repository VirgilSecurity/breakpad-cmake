set(CommonSources)

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

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
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

	common/common.cmake
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

set(DIA_SEARCH_DIR "$ENV{VSINSTALLDIR}")
if (MSVC)
	string(REGEX REPLACE "\\\\" "/" DIA_SEARCH_DIR ${DIA_SEARCH_DIR})
endif()

find_path(DIA_INCLUDE_DIR
	NAMES dia2.h
	HINTS "${DIA_SEARCH_DIR}DIA SDK/include")

target_include_directories(common PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
	$<$<CXX_COMPILER_ID:MSVC>:${DIA_INCLUDE_DIR}>
)

target_compile_definitions(common PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS UNICODE>
    $<$<PLATFORM_ID:Darwin>:HAVE_MACH_O_NLIST_H>
    $<$<PLATFORM_ID:Linux>:HAVE_A_OUT_H>
)

if(NOT CMAKE_CROSSCOMPILING)
    set(CommonTestsSources)

    if(ANDROID)
        list(APPEND CommonTestsSources
            common/android/breakpad_getcontext_unittest.cc
        )
    endif()

    list(APPEND CommonTestsSources
        common/byte_cursor_unittest.cc
    #     dwarf/bytereader_unittest.cc
    #     dwarf/dwarf2diehandler_unittest.cc
    #     dwarf/dwarf2reader_cfi_unittest.cc
    #     dwarf/dwarf2reader_die_unittest.cc
    #     dwarf_cfi_to_module_unittest.cc
    #     dwarf_cu_to_module_unittest.cc
    #     dwarf_line_to_module_unittest.cc
    )

    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        list(APPEND CommonTestsSources
            common/linux/dump_symbols_unittest.cc
            common/linux/elf_core_dump_unittest.cc
            common/linux/elf_symbols_to_module_unittest.cc
            common/linux/file_id_unittest.cc
            common/linux/google_crashdump_uploader_test.cc
            common/linux/linux_libc_support_unittest.cc
            common/linux/memory_mapped_file_unittest.cc
            common/linux/safe_readlink_unittest.cc
            common/linux/synth_elf_unittest.cc
            common/linux/tests/auto_testfile.h
            common/linux/tests/crash_generator.cc
            common/linux/tests/crash_generator.h
        )
    endif()

    if(APPLE)
        list(APPEND CommonTestsSources
            common/mac/macho_reader_unittest.cc
        )
    endif()

    list(APPEND CommonTestsSources
         common/memory_range_unittest.cc
         #common/memory_unittest.cc FIXME: platform?
         common/module_unittest.cc
         common/simple_string_dictionary_unittest.cc
         #common/stabs_reader_unittest.cc FIXME: platform?
         #common/stabs_to_module_unittest.cc FIXME: platform?
         common/test_assembler_unittest.cc
         common/tests/auto_tempdir.h
         #common/tests/file_utils.cc FIXME: platform?
         common/tests/file_utils.h
    )

    if(MSVC)
        list(APPEND CommonTestsSources
            common/windows/omap_unittest.cc
        )
    endif()

    add_executable(common_unittests
        ${CommonTestsSources}
    )

    target_include_directories(common_unittests PRIVATE
        ${CMAKE_SOURCE_DIR}/src
    )

    target_compile_definitions(common_unittests PUBLIC
        $<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS UNICODE>
    )

    target_link_libraries(common_unittests
        common
        gmock_main
        gtest
        #dl
    )
endif()

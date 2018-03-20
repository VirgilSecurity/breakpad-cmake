set(CommonSources)

list(APPEND CommonSources
    basictypes.h
    byte_cursor.h
    convert_UTF.c
    convert_UTF.h
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
        linux/crc32.cc
        linux/crc32.h
        linux/dump_symbols.cc
        linux/dump_symbols.h
        linux/eintr_wrapper.h
        linux/elf_core_dump.cc
        linux/elf_core_dump.h
        linux/elf_gnu_compat.h
        linux/elf_symbols_to_module.cc
        linux/elf_symbols_to_module.h
        linux/elfutils-inl.h
        linux/elfutils.cc
        linux/elfutils.h
        linux/file_id.cc
        linux/file_id.h
        linux/google_crashdump_uploader.cc
        linux/google_crashdump_uploader.h
        linux/guid_creator.cc
        linux/guid_creator.h
        linux/http_upload.cc
        linux/http_upload.h
        linux/ignore_ret.h
        linux/libcurl_wrapper.cc
        linux/libcurl_wrapper.h
        linux/linux_libc_support.cc
        linux/linux_libc_support.h
        linux/memory_mapped_file.cc
        linux/memory_mapped_file.h
        linux/safe_readlink.cc
        linux/safe_readlink.h
        linux/synth_elf.cc
        linux/synth_elf.h
    )
endif()

if(APPLE)
    list(APPEND CommonSources
        mac/arch_utilities.cc
        mac/arch_utilities.h
        mac/bootstrap_compat.cc
        mac/bootstrap_compat.h
        mac/byteswap.h
        mac/dump_syms.h
        mac/dump_syms.cc
        mac/file_id.cc
        mac/file_id.h
        mac/GTMDefines.h
        mac/GTMLogger.h
        mac/GTMLogger.m
        mac/HTTPMultipartUpload.h
        mac/HTTPMultipartUpload.m
        mac/MachIPC.h
        mac/MachIPC.mm
        mac/macho_id.cc
        mac/macho_id.h
        mac/macho_reader.cc
        mac/macho_reader.h
        mac/macho_utilities.cc
        mac/macho_utilities.h
        mac/macho_walker.cc
        mac/macho_walker.h
        mac/scoped_task_suspend-inl.h
        mac/string_utilities.cc
        mac/string_utilities.h
        mac/super_fat_arch.h
    )
endif()

list(APPEND CommonSources
    md5.cc
    md5.h
    memory_range.h
    module.cc
    module.h
    scoped_ptr.h
    simple_string_dictionary.cc
    simple_string_dictionary.h
)

if(Solaris)
    list(APPEND CommonSources
        solaris/dump_symbols.cc
        solaris/dump_symbols.h
        solaris/file_id.cc
        solaris/file_id.h
        solaris/guid_creator.cc
        solaris/guid_creator.h
        solaris/message_output.h
    )
endif()

list(APPEND CommonSources
    # stabs_reader.cc
    # stabs_reader.h
    # stabs_to_module.cc
    # stabs_to_module.h
    string_conversion.cc
    string_conversion.h
    symbol_data.h
    test_assembler.cc
    test_assembler.h
    unordered.h
    using_std_string.h
)

if(MSVC)
    list(APPEND CommonSources
        windows/dia_util.cc
        windows/dia_util.h
        windows/guid_string.cc
        windows/guid_string.h
        windows/http_upload.cc
        windows/http_upload.h
        windows/omap.cc
        windows/omap.h
        windows/omap_internal.h
        windows/pdb_source_line_writer.cc
        windows/pdb_source_line_writer.h
        windows/string_utils-inl.h
        windows/string_utils.cc
    )
endif()

add_library(common STATIC
    ${CommonSources}
)

if (MSVC)
    string(REGEX REPLACE "\\\\" "/" DIA_SEARCH_DIR ${DIA_SDK})
endif()

find_path(DIA_INCLUDE_DIR
    NAMES dia2.h
    HINTS "${DIA_SDK}/include"
)

target_include_directories(common PUBLIC
    ${CMAKE_SOURCE_DIR}/src
    $<$<CXX_COMPILER_ID:MSVC>:${DIA_INCLUDE_DIR}>
)

target_compile_definitions(common PUBLIC
    $<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS UNICODE>
    $<$<PLATFORM_ID:Darwin>:HAVE_MACH_O_NLIST_H>
    $<$<PLATFORM_ID:Linux>:HAVE_A_OUT_H>
)

target_compile_options(common PUBLIC
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
    $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

if(NOT CMAKE_CROSSCOMPILING)
    set(CommonTestsSources)

    if(ANDROID)
        list(APPEND CommonTestsSources
            android/breakpad_getcontext_unittest.cc
        )
    endif()

    list(APPEND CommonTestsSources
        byte_cursor_unittest.cc
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
            linux/dump_symbols_unittest.cc
            linux/elf_core_dump_unittest.cc
            linux/elf_symbols_to_module_unittest.cc
            linux/file_id_unittest.cc
            linux/google_crashdump_uploader_test.cc
            linux/linux_libc_support_unittest.cc
            linux/memory_mapped_file_unittest.cc
            linux/safe_readlink_unittest.cc
            linux/synth_elf_unittest.cc
            linux/tests/auto_testfile.h
            linux/tests/crash_generator.cc
            linux/tests/crash_generator.h
        )
    endif()

    if(APPLE)
        list(APPEND CommonTestsSources
            mac/macho_reader_unittest.cc
        )
    endif()

    list(APPEND CommonTestsSources
         memory_range_unittest.cc
         #memory_unittest.cc FIXME: platform?
         module_unittest.cc
         simple_string_dictionary_unittest.cc
         #stabs_reader_unittest.cc FIXME: platform?
         #stabs_to_module_unittest.cc FIXME: platform?
         test_assembler_unittest.cc
         tests/auto_tempdir.h
         #tests/file_utils.cc FIXME: platform?
         tests/file_utils.h
    )

    if(MSVC)
        list(APPEND CommonTestsSources
            windows/omap_unittest.cc
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

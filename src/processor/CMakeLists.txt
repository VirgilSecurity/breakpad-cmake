#
# processor
#
set(ProcessorSources
    basic_code_modules.cc
    basic_source_line_resolver.cc
    call_stack.cc
    cfi_frame_info.cc
    disassembler_x86.cc
    dump_context.cc
    dump_object.cc
    exploitability.cc
    exploitability_linux.cc
    exploitability_win.cc
    fast_source_line_resolver.cc
    logging.cc
    microdump_processor.cc
    minidump.cc
    minidump_processor.cc
    module_comparer.cc
    module_serializer.cc
    pathname_stripper.cc
    proc_maps_linux.cc
    process_state.cc
    simple_symbol_supplier.cc
    source_line_resolver_base.cc
    stack_frame_cpu.cc
    stack_frame_symbolizer.cc
    stackwalk_common.cc
    stackwalker.cc
    stackwalker_address_list.cc
    stackwalker_amd64.cc
    stackwalker_arm.cc
    stackwalker_arm64.cc
    stackwalker_mips.cc
    stackwalker_ppc.cc
    stackwalker_ppc64.cc
    stackwalker_selftest.cc
    stackwalker_sparc.cc
    stackwalker_x86.cc
    symbolic_constants_win.cc
    synth_minidump.cc
    tokenize.cc
)
source_group("" FILES ${ProcessorSources})

add_library(processor STATIC
    ${ProcessorSources}
)

target_include_directories(processor PUBLIC
    ${CMAKE_SOURCE_DIR}/src
)

target_compile_definitions(processor PRIVATE
    BPLOG_MINIMUM_SEVERITY=SEVERITY_ERROR
)

target_compile_options(processor PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/wd4800 /wd4146>
)

target_compile_features(processor PUBLIC
    cxx_std_11
)

target_link_libraries(processor
    MSVC::static_runtime
)

#
# minidump_stackwalk
#
#if(NOT CMAKE_CROSSCOMPILING)
if(FALSE)
    set(MinidumSources
        minidump_stackwalk.cc
    )
    source_group("" FILES ${MinidumSources})

    add_executable(minidump_stackwalk
        ${MinidumSources}
    )

    target_include_directories(minidump_stackwalk PRIVATE
        ${CMAKE_SOURCE_DIR}/src
    )

    target_compile_definitions(minidump_stackwalk PRIVATE
        BPLOG_MINIMUM_SEVERITY=SEVERITY_ERROR
    )

    target_compile_options(minidump_stackwalk PRIVATE
        $<$<CXX_COMPILER_ID:MSVC>:/wd4800 /wd4146>
    )

    target_compile_features(minidump_stackwalk PUBLIC
        cxx_std_11
    )

    target_link_libraries(minidump_stackwalk
        MSVC::static_runtime
        processor
        disasm
        common
    )
endif()

#
# processor_unittests
#
#add_executable(processor_unittests
#	address_map_unittest.cc
#	basic_source_line_resolver_unittest.cc
#	cfi_frame_info_unittest.cc
#	contained_range_map_unittest.cc
#	#disassembler_x86_unittest.cc FIXME: platform?
#	#exploitability_unittest.cc FIXME: platform?
#	fast_source_line_resolver_unittest.cc
#	map_serializers_unittest.cc
#	microdump_processor_unittest.cc
#	minidump_processor_unittest.cc
#	minidump_unittest.cc
#	pathname_stripper_unittest.cc
#	postfix_evaluator_unittest.cc
#	range_map_shrink_down_unittest.cc
#	range_map_unittest.cc
#	stackwalker_address_list_unittest.cc
#	stackwalker_amd64_unittest.cc
#	stackwalker_arm64_unittest.cc
#	stackwalker_arm_unittest.cc
#	stackwalker_mips_unittest.cc
#	stackwalker_mips64_unittest.cc
#	stackwalker_unittest_utils.h
#	stackwalker_x86_unittest.cc
#	static_address_map_unittest.cc
#	static_contained_range_map_unittest.cc
#	static_map_unittest.cc
#	static_range_map_unittest.cc
#	synth_minidump_unittest.cc
#	synth_minidump_unittest_data.h
#)
#
#target_include_directories(processor_unittests PRIVATE
#	${CMAKE_SOURCE_DIR}/src
#)
#
#target_compile_definitions(processor_unittests PRIVATE
#	$<$<CXX_COMPILER_ID:MSVC>:UNICODE _CRT_SECURE_NO_WARNINGS _SCL_SECURE_NO_WARNINGS>
#)
#
#target_compile_options(processor_unittests PRIVATE
#	$<$<CXX_COMPILER_ID:MSVC>:/wd4800 /wd4146>
#	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
#	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
#	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
#	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
#)
#
#target_link_libraries(processor_unittests
#	processor
#	disasm
#	gmock
#	gtest
#)

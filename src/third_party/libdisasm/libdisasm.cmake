set(DisasmSources
    third_party/libdisasm/ia32_implicit.c
    third_party/libdisasm/ia32_insn.c
    third_party/libdisasm/ia32_invariant.c
    third_party/libdisasm/ia32_modrm.c
    third_party/libdisasm/ia32_opcode_tables.c
    third_party/libdisasm/ia32_operand.c
    third_party/libdisasm/ia32_reg.c
    third_party/libdisasm/ia32_settings.c
    third_party/libdisasm/x86_disasm.c
    third_party/libdisasm/x86_format.c
    third_party/libdisasm/x86_imm.c
    third_party/libdisasm/x86_insn.c
    third_party/libdisasm/x86_misc.c
    third_party/libdisasm/x86_operand_list.c
)
source_group("" FILES ${DisasmSources})

add_library(disasm STATIC
	${DisasmSources}
)

target_include_directories(disasm PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(disasm PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_WARNINGS>
	$<$<CXX_COMPILER_ID:MSVC>:_SCL_SECURE_NO_WARNINGS>
	BPLOG_MINIMUM_SEVERITY=SEVERITY_ERROR
)

target_compile_options(disasm PRIVATE
	$<$<CXX_COMPILER_ID:MSVC>:/wd4800 /wd4146>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/MTd>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/MT>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:MinSizeRel>>:/MT>
	$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:RelWithDebInfo>>:/MT>
)

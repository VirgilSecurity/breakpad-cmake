set(DisasmSources
    ia32_implicit.c
    ia32_insn.c
    ia32_invariant.c
    ia32_modrm.c
    ia32_opcode_tables.c
    ia32_operand.c
    ia32_reg.c
    ia32_settings.c
    x86_disasm.c
    x86_format.c
    x86_imm.c
    x86_insn.c
    x86_misc.c
    x86_operand_list.c
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

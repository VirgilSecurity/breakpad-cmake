#
# ms_symbol_server_converter
#
add_library(ms_symbol_server_converter
    converter/ms_symbol_server_converter.cc
)

target_compile_definitions(ms_symbol_server_converter PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

target_link_libraries(ms_symbol_server_converter
    common
)

#'msvs_guid': '1463C4CD-23FC-4DE9-BFDE-283338200157',

#
# dump_syms
#
add_executable(dump_syms
    dump_syms/dump_syms.cc
)

target_compile_definitions(dump_syms PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

find_library(DiaLibrary
    NAMES diaguids
    HINTS ${DIA_SDK}/lib
)

target_link_libraries(dump_syms
    common
    wininet.lib
    version.lib
    dbghelp.lib
    ImageHlp.lib
    ${DiaLibrary}
)

#{
#  'target_name': 'dump_syms_unittest',
#  'type': 'executable',
#  'sources': [
#    'dump_syms_unittest.cc',
#  ],
#  'dependencies': [
#    '<(DEPTH)/client/windows/unittests/testing.gyp:gmock',
#    '<(DEPTH)/client/windows/unittests/testing.gyp:gtest',
#    'dump_syms',
#  ],
#  'msvs_settings': {
#    'VCLinkerTool': {
#      'AdditionalDependencies': [
#        'shell32.lib',
#      ],

#
# symupload
#
add_executable(symupload
    symupload/symupload.cc
)

target_compile_definitions(symupload PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:UNICODE>
)

target_link_libraries(symupload
    common
    wininet.lib
    version.lib
    dbghelp.lib
    ImageHlp.lib
    ${DiaLibrary}
)

set_target_properties(symupload PROPERTIES
    LINK_FLAGS /LARGEADDRESSAWARE
)

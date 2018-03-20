#
# ms_symbol_server_converter
#
add_library(ms_symbol_server_converter
    converter/ms_symbol_server_converter.cc
)

target_link_libraries(ms_symbol_server_converter
    MSVC::static_runtime
    common
)

#
# dump_syms
#
add_executable(dump_syms
    dump_syms/dump_syms.cc
)

find_library(DiaLibrary
    NAMES diaguids
    HINTS ${DIA_SDK}/lib
)

target_link_libraries(dump_syms
    MSVC::static_runtime
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

target_link_libraries(symupload
    MSVC::static_runtime
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

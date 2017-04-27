if(MSVC)
	include(client/windows/crash_generation/crash_generation.cmake)
endif()

include(common/common.cmake)
include(third_party/libdisasm/libdisasm.cmake)
include(processor/processor.cmake)

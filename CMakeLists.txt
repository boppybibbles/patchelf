cmake_minimum_required(VERSION 3.12)

project(patchelf
    DESCRIPTION "A small utility to modify the dynamic linker and RPATH of ELF executables."
    HOMEPAGE_URL "http://nixos.org/patchelf.html"
)

file(READ ${CMAKE_CURRENT_LIST_DIR}/version PROJECT_VERSION)

add_executable(patchelf)

target_include_directories(patchelf
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}/src
)

target_sources(patchelf
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/patchelf.cc
        ${CMAKE_CURRENT_SOURCE_DIR}/src/elf.h
)

target_compile_features(patchelf
    PRIVATE
        cxx_std_11
)

target_compile_options(patchelf
    PRIVATE
        $<$<AND:$<CXX_COMPILER_ID:GNU>,$<C_COMPILER_ID:GNU>>:-Wall -pedantic>
)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/page-size.cmake)

target_compile_definitions(patchelf
    PRIVATE
        _FILE_OFFSET_BITS=64
        PACKAGE_STRING="${PROJECT_NAME} ${PROJECT_VERSION}"
        PAGESIZE=${PAGESIZE}
)

include(GNUInstallDirs)
install(TARGETS patchelf
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/tests.cmake)

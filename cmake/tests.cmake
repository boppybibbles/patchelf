include(CTest)
#libfoo_so_SOURCES = foo.c
#libfoo_so_LDADD = -lbar $(AM_LDADD)
#libfoo_so_DEPENDENCIES = libbar.so
#libfoo_so_LDFLAGS = $(LDFLAGS_sharedlib)
#
#libfoo_scoped_so_SOURCES = foo.c
#libfoo_scoped_so_LDADD = -lbar-scoped $(AM_LDADD)
#libfoo_scoped_so_DEPENDENCIES = libbar-scoped.so
#libfoo_scoped_so_LDFLAGS = $(LDFLAGS_sharedlib)
#
#libbar_so_SOURCES = bar.c
#libbar_so_LDFLAGS = $(LDFLAGS_sharedlib) -Wl,-rpath,`pwd`/no-such-path
#
#libbar_scoped_so_SOURCES = bar.c
#libbar_scoped_so_LDFLAGS = $(LDFLAGS_sharedlib)
#
#libsimple_so_SOURCES = simple.c
#libsimple_so_LDFLAGS = $(LDFLAGS_sharedlib)

add_library(bar-o OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/tests/bar.c)

add_library(bar SHARED) # -Wl,-rpath,`pwd`/no-such-path
target_link_libraries(bar bar-o)

add_library(bar-scoped SHARED)
target_link_libraries(bar-scoped bar-o)

add_library(foo-o OBJECT "${CMAKE_CURRENT_SOURCE_DIR}/tests/foo.c")

add_library(foo SHARED)
target_link_libraries(foo foo-o bar)

add_library(foo-scoped SHARED)
target_link_libraries(foo-scoped foo-o bar-scoped)

add_library(simple SHARED "${CMAKE_CURRENT_SOURCE_DIR}/tests/simple.c")

add_library(no-rpath SHARED "${CMAKE_CURRENT_SOURCE_DIR}/tests/no-rpath.c") # no -fpic for no-rpath.o

add_executable(main "${CMAKE_CURRENT_SOURCE_DIR}/tests/main.c")
target_link_libraries(main foo)

add_executable(main-scoped "${CMAKE_CURRENT_SOURCE_DIR}/tests/main.c")
target_link_libraries(main-scoped foo-scoped)

foreach(idx RANGE 1 2000)
    set(DYNSTR "${DYNSTR}\nvoid f${idx}(void) { }\;")
endforeach()
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/tests/main.c" "${CMAKE_CURRENT_BINARY_DIR}/tests/big-dynstr.c")
file(APPEND "${CMAKE_CURRENT_BINARY_DIR}/tests/big-dynstr.c" ${DYNSTR})



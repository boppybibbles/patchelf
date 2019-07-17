set(PAGESIZE "Auto" CACHE STRING "Specify default page size (default auto)")

find_program(GETCONF_PROGRAM getconf)

execute_process(
    COMMAND
        "${GETCONF_PROGRAM}" PAGESIZE
    RESULT_VARIABLE result
    OUTPUT_VARIABLE output
#    ERROR_VARIABLE output
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE
)
if(result)
    execute_process(
        COMMAND
            "${GETCONF_PROGRAM}" PAGE_SIZE
        RESULT_VARIABLE result
        OUTPUT_VARIABLE output
#        ERROR_VARIABLE output
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE
    )
    if(result)
        set(PAGESIZE 4096)
#        message("1 PAGESIZE ${PAGESIZE}")
    else()
        set(PAGESIZE ${output})
#        message("2 PAGESIZE ${PAGESIZE}")
    endif()
else()
    set(PAGESIZE ${output})
#    message("3 PAGESIZE ${PAGESIZE}")
endif()

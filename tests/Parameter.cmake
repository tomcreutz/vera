message("Running: \"${VERA_PROGRAM}\" \"--root\" \"/home/smartmatic/workspace/vera\" \"--rule\" \"L004\" \"--parameter\" \"max-line-length=99\" \"/home/smartmatic/workspace/vera/tests/L004.cpp\"")
execute_process(COMMAND "${VERA_PROGRAM}"
  "--root" "/home/smartmatic/workspace/vera" "--rule" "L004" "--parameter" "max-line-length=99" "/home/smartmatic/workspace/vera/tests/L004.cpp"
  RESULT_VARIABLE ret
  OUTPUT_VARIABLE output
  ERROR_VARIABLE error
  )
message("return value: ${ret}")
message("---output---\n${output}---error----\n${error}------------")

set(fail OFF)
if(NOT ${ret} EQUAL 0)
  message("Invalid return code. Expected return code was 0.")
  set(fail ON)
endif()
if(NOT "${output}" STREQUAL "/home/smartmatic/workspace/vera/tests/L004.cpp:1: line is longer than 99 characters
/home/smartmatic/workspace/vera/tests/L004.cpp:2: line is longer than 99 characters
")
  message("Output mismatch. Expected content was:")
  message("/home/smartmatic/workspace/vera/tests/L004.cpp:1: line is longer than 99 characters
/home/smartmatic/workspace/vera/tests/L004.cpp:2: line is longer than 99 characters
---")
  set(fail ON)
endif()
if(NOT "${error}" STREQUAL "")
  message("Output mismatch. Expected content was:")
  message("---")
  set(fail ON)
endif()

if(fail)
  message(FATAL_ERROR "some errors occurred.")
endif()
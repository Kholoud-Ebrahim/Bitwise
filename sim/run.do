#***************************************************#
# Clean Work Library
#***************************************************#
if [file exists "work"] {vdel -all}
vlib work

#***************************************************#
# Start a new Transcript File
#***************************************************#
#transcript file log/bitwise.log
# better make one for each test

#***************************************************#
# Compile RTL and TB files
#***************************************************#
vlog -f Bitwise_dut.f
vlog -f Bitwise_tb.f

#***************************************************#
# Optimizing Design with vopt
#***************************************************#
vopt bitwise_top -o top_opt -debugdb  +acc +cover=sbecf+bitwise(rtl).

#***************************************************#
# Simulation of a Test
#***************************************************#
#********************************** 1. RANDOM TEST ***********************************#
transcript file log/random_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=random_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value bitwise_random_test
coverage save coverage/bitwise_random_test.ucdb

#********************************** 2. ALL ZERO TEST ***********************************#
transcript file log/all_zero_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=all_zero_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value bitwise_all_zero_test
coverage save coverage/bitwise_all_zero_test.ucdb

#********************************** 3. ALL ONE TEST ***********************************#
transcript file log/all_one_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=all_one_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value bitwise_all_one_test
coverage save coverage/bitwise_all_one_test.ucdb

#***************************************************#
# Close the Transcript file
#***************************************************#
transcript file ()

#***************************************************#
# save the coverage in text files
#***************************************************#
vcover merge  coverage/bitwise_all.ucdb \
              coverage/bitwise_random_test.ucdb \
              coverage/bitwise_all_zero_test.ucdb \
              coverage/bitwise_all_one_test.ucdb 


vcover report coverage/bitwise_all.ucdb -cvg -details -output coverage/fun_coverage.txt
vcover report coverage/bitwise_all.ucdb  -output coverage/code_coverage.txt
vcover report coverage/bitwise_all.ucdb -details -assert  -output coverage/assertions.txt
#!/bin/bash -f
xv_path="/home/doshi/Xlinx/Vivado/2017.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim TLC_Control_tb_behav -key {Behavioral:sim_1:Functional:TLC_Control_tb} -tclbatch TLC_Control_tb.tcl -log simulate.log

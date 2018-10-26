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
ExecStep $xv_path/bin/xelab -wto 74f922fae57b4ad29436b095be7a34c2 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot TLC_Control_tb_behav xil_defaultlib.TLC_Control_tb -log elaborate.log

wvResizeWindow -win $_nWave1 58 262 960 332
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab7b/fsm_mealy.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test"
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/fsm_mealy_test/ans\[17:0\]} \
{/fsm_mealy_test/clk} \
{/fsm_mealy_test/cnt\[31:0\]} \
{/fsm_mealy_test/en} \
{/fsm_mealy_test/reset} \
{/fsm_mealy_test/xin\[7:0\]} \
{/fsm_mealy_test/zout} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/fsm_mealy_test/ans\[17:0\]} \
{/fsm_mealy_test/clk} \
{/fsm_mealy_test/cnt\[31:0\]} \
{/fsm_mealy_test/en} \
{/fsm_mealy_test/reset} \
{/fsm_mealy_test/xin\[7:0\]} \
{/fsm_mealy_test/zout} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave1 {("G1" 7)}
wvGetSignalClose -win $_nWave1
wvZoomAll -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test"
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test"
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test/dut"
wvSetPosition -win $_nWave1 {("G1" 14)}
wvSetPosition -win $_nWave1 {("G1" 14)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/fsm_mealy_test/ans\[17:0\]} \
{/fsm_mealy_test/clk} \
{/fsm_mealy_test/cnt\[31:0\]} \
{/fsm_mealy_test/en} \
{/fsm_mealy_test/reset} \
{/fsm_mealy_test/xin\[7:0\]} \
{/fsm_mealy_test/zout} \
{/fsm_mealy_test/dut/C_STATE\[1:0\]} \
{/fsm_mealy_test/dut/N_STATE\[1:0\]} \
{/fsm_mealy_test/dut/clk} \
{/fsm_mealy_test/dut/en} \
{/fsm_mealy_test/dut/reset} \
{/fsm_mealy_test/dut/xin} \
{/fsm_mealy_test/dut/zout} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 8 9 10 11 12 13 14 )} 
wvSetPosition -win $_nWave1 {("G1" 14)}
wvSetPosition -win $_nWave1 {("G1" 14)}
wvSetPosition -win $_nWave1 {("G1" 14)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/fsm_mealy_test/ans\[17:0\]} \
{/fsm_mealy_test/clk} \
{/fsm_mealy_test/cnt\[31:0\]} \
{/fsm_mealy_test/en} \
{/fsm_mealy_test/reset} \
{/fsm_mealy_test/xin\[7:0\]} \
{/fsm_mealy_test/zout} \
{/fsm_mealy_test/dut/C_STATE\[1:0\]} \
{/fsm_mealy_test/dut/N_STATE\[1:0\]} \
{/fsm_mealy_test/dut/clk} \
{/fsm_mealy_test/dut/en} \
{/fsm_mealy_test/dut/reset} \
{/fsm_mealy_test/dut/xin} \
{/fsm_mealy_test/dut/zout} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 8 9 10 11 12 13 14 )} 
wvSetPosition -win $_nWave1 {("G1" 14)}
wvGetSignalClose -win $_nWave1
wvZoomAll -win $_nWave1
wvResizeWindow -win $_nWave1 -4 -1 1274 864
wvResizeWindow -win $_nWave1 -4 -1 1274 864
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test/dut"
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 14.907975 -snap {("G1" 12)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test"
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test/dut"
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test/dut"
wvGetSignalSetScope -win $_nWave1 "/fsm_mealy_test"
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/fsm_mealy_test/clk} \
{/fsm_mealy_test/cnt\[31:0\]} \
{/fsm_mealy_test/en} \
{/fsm_mealy_test/reset} \
{/fsm_mealy_test/zout} \
{/fsm_mealy_test/dut/C_STATE\[1:0\]} \
{/fsm_mealy_test/dut/N_STATE\[1:0\]} \
{/fsm_mealy_test/dut/clk} \
{/fsm_mealy_test/dut/en} \
{/fsm_mealy_test/dut/reset} \
{/fsm_mealy_test/dut/xin} \
{/fsm_mealy_test/dut/zout} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/fsm_mealy_test/ans} \
{/fsm_mealy_test/xin} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/fsm_mealy_test/clk} \
{/fsm_mealy_test/cnt\[31:0\]} \
{/fsm_mealy_test/en} \
{/fsm_mealy_test/reset} \
{/fsm_mealy_test/zout} \
{/fsm_mealy_test/dut/C_STATE\[1:0\]} \
{/fsm_mealy_test/dut/N_STATE\[1:0\]} \
{/fsm_mealy_test/dut/clk} \
{/fsm_mealy_test/dut/en} \
{/fsm_mealy_test/dut/reset} \
{/fsm_mealy_test/dut/xin} \
{/fsm_mealy_test/dut/zout} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/fsm_mealy_test/ans} \
{/fsm_mealy_test/xin} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 16.067485 -snap {("G2" 2)}
wvSetCursor -win $_nWave1 18.717791 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 19.849693 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 15.984663 -snap {("G1" 7)}
wvExit

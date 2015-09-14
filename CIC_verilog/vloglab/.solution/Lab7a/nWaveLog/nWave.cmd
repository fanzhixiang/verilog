wvResizeWindow -win $_nWave1 58 262 960 332
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab7a/fsm.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/test_fsm"
wvGetSignalSetScope -win $_nWave1 "/test_fsm/i_fsm"
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/test_fsm/i_fsm/C_STATE\[2:0\]} \
{/test_fsm/i_fsm/N_STATE\[2:0\]} \
{/test_fsm/i_fsm/bit_in} \
{/test_fsm/i_fsm/clk} \
{/test_fsm/i_fsm/det_out} \
{/test_fsm/i_fsm/reset} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/test_fsm/i_fsm/C_STATE\[2:0\]} \
{/test_fsm/i_fsm/N_STATE\[2:0\]} \
{/test_fsm/i_fsm/bit_in} \
{/test_fsm/i_fsm/clk} \
{/test_fsm/i_fsm/det_out} \
{/test_fsm/i_fsm/reset} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvGetSignalClose -win $_nWave1
wvZoomAll -win $_nWave1
wvExit

wvResizeWindow -win $_nWave1 1 27 1274 864
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab3b/FIR.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/FIR_test"
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/FIR_test/Din\[7:0\]} \
{/FIR_test/Dout\[17:0\]} \
{/FIR_test/clk} \
{/FIR_test/k\[31:0\]} \
{/FIR_test/reset} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 )} 
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/FIR_test/Din\[7:0\]} \
{/FIR_test/Dout\[17:0\]} \
{/FIR_test/clk} \
{/FIR_test/k\[31:0\]} \
{/FIR_test/reset} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 )} 
wvSetPosition -win $_nWave1 {("G1" 5)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 2.084742 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 6.086103 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3.967736 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1.983868 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3.934111 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 2.017493 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 4.034985 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 6.086103 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1.849368 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 4.068610 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 0.907872 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 1.983868 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3.934111 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 5.581730 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 7.901846 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 2.051118 -snap {("G1" 3)}
wvZoom -win $_nWave1 1.378620 8.036346
wvSetCursor -win $_nWave1 1.986809 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3.966657 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 6.004737 -snap {("G1" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomAll -win $_nWave1
wvZoom -win $_nWave1 0.000000 1983.867833
wvSetCursor -win $_nWave1 208.219364 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 595.738737 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 395.231201 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 196.651622 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 397.159158 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 200.507536 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 401.015072 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 543.683896 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 406.798943 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1222.324787 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 489.701098 -snap {("G1" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvResizeWindow -win $_nWave1 449 83 1274 864
wvExit

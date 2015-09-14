wvResizeWindow -win $_nWave1 62 271 960 332
wvConvertFile -win $_nWave1 -o \
           "/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab2/lab1.vcd.fsdb" \
           "/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab2/lab1.vcd"
wvOpenFile -win $_nWave1 \
           {/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab2/lab1.vcd.fsdb}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/mux_test"
wvGetSignalSetScope -win $_nWave1 "/mux_test/mux"
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group  {"G1" \
{/mux_test/mux/a} \
{/mux_test/mux/a1} \
{/mux_test/mux/b} \
{/mux_test/mux/b1} \
{/mux_test/mux/out} \
{/mux_test/mux/sel} \
{/mux_test/mux/sel_} \
}
wvAddSignal -win $_nWave1 -group  {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group  {"G1" \
{/mux_test/mux/a} \
{/mux_test/mux/a1} \
{/mux_test/mux/b} \
{/mux_test/mux/b1} \
{/mux_test/mux/out} \
{/mux_test/mux/sel} \
{/mux_test/mux/sel_} \
}
wvAddSignal -win $_nWave1 -group  {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvGetSignalClose -win $_nWave1
wvZoomAll -win $_nWave1
wvSelectGroup -win $_nWave1 {G1}
wvSelectGroup -win $_nWave1 {G1} {G2}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )}
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvConvertFile -win $_nWave1 -o \
           "/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab2/lab1.fsdb.fsdb" \
           "/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab2/lab1.fsdb"
wvOpenFile -win $_nWave1 \
           {/user/DSD/hlchen/CICTRAINING/VERILOG/vloglab/.solution/Lab2/lab1.fsdb.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/mux_test"
wvGetSignalSetScope -win $_nWave1 "/mux_test/mux"
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/mux_test/mux"
wvGetSignalSetScope -win $_nWave1 "/mux_test/mux"
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group  {"G1" \
{/mux_test/mux/a} \
{/mux_test/mux/a1} \
{/mux_test/mux/b} \
{/mux_test/mux/b1} \
{/mux_test/mux/out} \
{/mux_test/mux/sel} \
{/mux_test/mux/sel_} \
}
wvAddSignal -win $_nWave1 -group  {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group  {"G1" \
{/mux_test/mux/a} \
{/mux_test/mux/a1} \
{/mux_test/mux/b} \
{/mux_test/mux/b1} \
{/mux_test/mux/out} \
{/mux_test/mux/sel} \
{/mux_test/mux/sel_} \
}
wvAddSignal -win $_nWave1 -group  {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 )}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvGetSignalClose -win $_nWave1
wvZoom -win $_nWave1 7.761966 24.320828
wvZoomAll -win $_nWave1
wvExit

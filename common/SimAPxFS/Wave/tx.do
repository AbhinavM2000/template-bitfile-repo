onerror { resume }
set curr_transcript [transcript]
transcript off

add wave -varray TxInData \
	/IridisSfTb/U_IridisTx/fifoDataIn(63) \
	/IridisSfTb/U_IridisTx/fifoDataIn(62) \
	/IridisSfTb/U_IridisTx/fifoDataIn(61) \
	/IridisSfTb/U_IridisTx/fifoDataIn(60) \
	/IridisSfTb/U_IridisTx/fifoDataIn(59) \
	/IridisSfTb/U_IridisTx/fifoDataIn(58) \
	/IridisSfTb/U_IridisTx/fifoDataIn(57) \
	/IridisSfTb/U_IridisTx/fifoDataIn(56) \
	/IridisSfTb/U_IridisTx/fifoDataIn(55) \
	/IridisSfTb/U_IridisTx/fifoDataIn(54) \
	/IridisSfTb/U_IridisTx/fifoDataIn(53) \
	/IridisSfTb/U_IridisTx/fifoDataIn(52) \
	/IridisSfTb/U_IridisTx/fifoDataIn(51) \
	/IridisSfTb/U_IridisTx/fifoDataIn(50) \
	/IridisSfTb/U_IridisTx/fifoDataIn(49) \
	/IridisSfTb/U_IridisTx/fifoDataIn(48) \
	/IridisSfTb/U_IridisTx/fifoDataIn(47) \
	/IridisSfTb/U_IridisTx/fifoDataIn(46) \
	/IridisSfTb/U_IridisTx/fifoDataIn(45) \
	/IridisSfTb/U_IridisTx/fifoDataIn(44) \
	/IridisSfTb/U_IridisTx/fifoDataIn(43) \
	/IridisSfTb/U_IridisTx/fifoDataIn(42) \
	/IridisSfTb/U_IridisTx/fifoDataIn(41) \
	/IridisSfTb/U_IridisTx/fifoDataIn(40) \
	/IridisSfTb/U_IridisTx/fifoDataIn(39) \
	/IridisSfTb/U_IridisTx/fifoDataIn(38) \
	/IridisSfTb/U_IridisTx/fifoDataIn(37) \
	/IridisSfTb/U_IridisTx/fifoDataIn(36) \
	/IridisSfTb/U_IridisTx/fifoDataIn(35) \
	/IridisSfTb/U_IridisTx/fifoDataIn(34) \
	/IridisSfTb/U_IridisTx/fifoDataIn(33) \
	/IridisSfTb/U_IridisTx/fifoDataIn(32) \
	/IridisSfTb/U_IridisTx/fifoDataIn(31) \
	/IridisSfTb/U_IridisTx/fifoDataIn(30) \
	/IridisSfTb/U_IridisTx/fifoDataIn(29) \
	/IridisSfTb/U_IridisTx/fifoDataIn(28) \
	/IridisSfTb/U_IridisTx/fifoDataIn(27) \
	/IridisSfTb/U_IridisTx/fifoDataIn(26) \
	/IridisSfTb/U_IridisTx/fifoDataIn(25) \
	/IridisSfTb/U_IridisTx/fifoDataIn(24) \
	/IridisSfTb/U_IridisTx/fifoDataIn(23) \
	/IridisSfTb/U_IridisTx/fifoDataIn(22) \
	/IridisSfTb/U_IridisTx/fifoDataIn(21) \
	/IridisSfTb/U_IridisTx/fifoDataIn(20) \
	/IridisSfTb/U_IridisTx/fifoDataIn(19) \
	/IridisSfTb/U_IridisTx/fifoDataIn(18) \
	/IridisSfTb/U_IridisTx/fifoDataIn(17) \
	/IridisSfTb/U_IridisTx/fifoDataIn(16) \
	/IridisSfTb/U_IridisTx/fifoDataIn(15) \
	/IridisSfTb/U_IridisTx/fifoDataIn(14) \
	/IridisSfTb/U_IridisTx/fifoDataIn(13) \
	/IridisSfTb/U_IridisTx/fifoDataIn(12) \
	/IridisSfTb/U_IridisTx/fifoDataIn(11) \
	/IridisSfTb/U_IridisTx/fifoDataIn(10) \
	/IridisSfTb/U_IridisTx/fifoDataIn(9) \
	/IridisSfTb/U_IridisTx/fifoDataIn(8) \
	/IridisSfTb/U_IridisTx/fifoDataIn(7) \
	/IridisSfTb/U_IridisTx/fifoDataIn(6) \
	/IridisSfTb/U_IridisTx/fifoDataIn(5) \
	/IridisSfTb/U_IridisTx/fifoDataIn(4) \
	/IridisSfTb/U_IridisTx/fifoDataIn(3) \
	/IridisSfTb/U_IridisTx/fifoDataIn(2) \
	/IridisSfTb/U_IridisTx/fifoDataIn(1) \
	/IridisSfTb/U_IridisTx/fifoDataIn(0)
add wave -bin -varray TxInCtrlBits \
	/IridisSfTb/U_IridisTx/fifoDataIn(71) \
	/IridisSfTb/U_IridisTx/fifoDataIn(70) \
	/IridisSfTb/U_IridisTx/fifoDataIn(69) \
	/IridisSfTb/U_IridisTx/fifoDataIn(68) \
	/IridisSfTb/U_IridisTx/fifoDataIn(67) \
	/IridisSfTb/U_IridisTx/fifoDataIn(66) \
	/IridisSfTb/U_IridisTx/fifoDataIn(65) \
	/IridisSfTb/U_IridisTx/fifoDataIn(64)
add wave -expand /IridisSfTb/U_IridisTx/r_iCSPFSM
add wave -color 34,139,34 -color_waveform -bold -literal -varray AxiStreamData \
	( -logic /IridisSfTb/AxisTxMaster.tData(63) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(62) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(61) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(60) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(59) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(58) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(57) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(56) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(55) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(54) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(53) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(52) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(51) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(50) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(49) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(48) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(47) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(46) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(45) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(44) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(43) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(42) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(41) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(40) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(39) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(38) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(37) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(36) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(35) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(34) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(33) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(32) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(31) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(30) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(29) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(28) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(27) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(26) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(25) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(24) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(23) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(22) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(21) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(20) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(19) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(18) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(17) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(16) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(15) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(14) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(13) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(12) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(11) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(10) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(9) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(8) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(7) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(6) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(5) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(4) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(3) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(2) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(1) ) \
	( -logic /IridisSfTb/AxisTxMaster.tData(0) )
add wave /IridisSfTb/U_IridisTx/r_oCSPFSM.DataBuf
add wave /IridisSfTb/U_IridisTx/r_oCSPFSM.HdrBuf
add wave -color 0,128,0 -color_waveform -bold /IridisSfTb/U_IridisTx/fifoDataOut
add wave -color 0,128,0 -color_waveform -bold /IridisSfTb/U_IridisTx/fifoRead
add wave -height 34 -bold -literal /IridisSfTb/U_IridisTx/fifoDataIn
add wave /IridisSfTb/U_IridisTx/fifoWrite
add wave /IridisSfTb/U_IridisTx/fifoUdf
add wave /IridisSfTb/U_IridisTx/fifoOvf
add wave /IridisSfTb/U_IridisTx/fifoEmpty
wv.grid.signal.set -name fifoDataIn -edge all -color 128,128,128 -from 179234900ps -count sim:/IridisSfTb/U_IridisTx/fifoDataIn
wv.cursors.add -time 268361132580fs -name {Default cursor}
wv.cursors.setactive -name {Default cursor}
wv.cursors.lock true
wv.cursors.subcursor.add -time 268364910358fs -name {Cursor 1}
wv.cursors.setactive -name {Cursor 1}
wv.cursors.lock true
wv.cursors.setactive -name {Default cursor}
wv.cursors.subcursor.add -time 269805592ps -name {Cursor 2}
wv.cursors.setactive -name {Cursor 2}
wv.cursors.lock true
wv.cursors.setactive -name {Default cursor}
wv.cursors.subcursor.add -time 269802028ps -name {Cursor 3}
wv.cursors.setactive -name {Cursor 3}
wv.cursors.lock true
wv.cursors.setactive -name {Default cursor}
wv.cursors.subcursor.add -time 250041786670fs -name {Cursor 4}
wv.cursors.setactive -name {Cursor 4}
wv.cursors.lock true
wv.cursors.add -time 179217681004fs -name {Cursor 5}
wv.cursors.setactive -name {Cursor 5}
wv.cursors.lock true
wv.cursors.subcursor.add -time 179233856ps -name {Cursor 6}
wv.cursors.setactive -name {Cursor 6}
wv.cursors.lock true
wv.cursors.setactive -name {Cursor 5}
wv.cursors.subcursor.add -time 250041786670fs -name {Cursor 7}
wv.cursors.setactive -name {Cursor 7}
wv.cursors.lock true
wv.cursors.add -time 3ms+3 -name {Cursor 8}
wv.cursors.setactive -name {Cursor 8}
wv.zoom.range -from 2524999955253fs -to 3025000002355fs
wv.time.unit.auto.set
transcript $curr_transcript

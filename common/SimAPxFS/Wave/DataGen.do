onerror { resume }
set curr_transcript [transcript]
transcript off

add wave -expand /IridisSfTb/r
add wave /IridisSfTb/RxOrbitStrobe
add wave /IridisSfTb/OrbitStrobe
add wave /IridisSfTb/AxisOrbitStrobe
add wave /IridisSfTb/AxisTxMaster.tValid
add wave /IridisSfTb/AxisTxMaster.tUser(1)
add wave /IridisSfTb/AxisTxMaster.tUser(0)
add wave /IridisSfTb/AxisTxMaster.tLast
add wave -varray AxiStreamData \
	/IridisSfTb/AxisTxMaster.tData(63) \
	/IridisSfTb/AxisTxMaster.tData(62) \
	/IridisSfTb/AxisTxMaster.tData(61) \
	/IridisSfTb/AxisTxMaster.tData(60) \
	/IridisSfTb/AxisTxMaster.tData(59) \
	/IridisSfTb/AxisTxMaster.tData(58) \
	/IridisSfTb/AxisTxMaster.tData(57) \
	/IridisSfTb/AxisTxMaster.tData(56) \
	/IridisSfTb/AxisTxMaster.tData(55) \
	/IridisSfTb/AxisTxMaster.tData(54) \
	/IridisSfTb/AxisTxMaster.tData(53) \
	/IridisSfTb/AxisTxMaster.tData(52) \
	/IridisSfTb/AxisTxMaster.tData(51) \
	/IridisSfTb/AxisTxMaster.tData(50) \
	/IridisSfTb/AxisTxMaster.tData(49) \
	/IridisSfTb/AxisTxMaster.tData(48) \
	/IridisSfTb/AxisTxMaster.tData(47) \
	/IridisSfTb/AxisTxMaster.tData(46) \
	/IridisSfTb/AxisTxMaster.tData(45) \
	/IridisSfTb/AxisTxMaster.tData(44) \
	/IridisSfTb/AxisTxMaster.tData(43) \
	/IridisSfTb/AxisTxMaster.tData(42) \
	/IridisSfTb/AxisTxMaster.tData(41) \
	/IridisSfTb/AxisTxMaster.tData(40) \
	/IridisSfTb/AxisTxMaster.tData(39) \
	/IridisSfTb/AxisTxMaster.tData(38) \
	/IridisSfTb/AxisTxMaster.tData(37) \
	/IridisSfTb/AxisTxMaster.tData(36) \
	/IridisSfTb/AxisTxMaster.tData(35) \
	/IridisSfTb/AxisTxMaster.tData(34) \
	/IridisSfTb/AxisTxMaster.tData(33) \
	/IridisSfTb/AxisTxMaster.tData(32) \
	/IridisSfTb/AxisTxMaster.tData(31) \
	/IridisSfTb/AxisTxMaster.tData(30) \
	/IridisSfTb/AxisTxMaster.tData(29) \
	/IridisSfTb/AxisTxMaster.tData(28) \
	/IridisSfTb/AxisTxMaster.tData(27) \
	/IridisSfTb/AxisTxMaster.tData(26) \
	/IridisSfTb/AxisTxMaster.tData(25) \
	/IridisSfTb/AxisTxMaster.tData(24) \
	/IridisSfTb/AxisTxMaster.tData(23) \
	/IridisSfTb/AxisTxMaster.tData(22) \
	/IridisSfTb/AxisTxMaster.tData(21) \
	/IridisSfTb/AxisTxMaster.tData(20) \
	/IridisSfTb/AxisTxMaster.tData(19) \
	/IridisSfTb/AxisTxMaster.tData(18) \
	/IridisSfTb/AxisTxMaster.tData(17) \
	/IridisSfTb/AxisTxMaster.tData(16) \
	/IridisSfTb/AxisTxMaster.tData(15) \
	/IridisSfTb/AxisTxMaster.tData(14) \
	/IridisSfTb/AxisTxMaster.tData(13) \
	/IridisSfTb/AxisTxMaster.tData(12) \
	/IridisSfTb/AxisTxMaster.tData(11) \
	/IridisSfTb/AxisTxMaster.tData(10) \
	/IridisSfTb/AxisTxMaster.tData(9) \
	/IridisSfTb/AxisTxMaster.tData(8) \
	/IridisSfTb/AxisTxMaster.tData(7) \
	/IridisSfTb/AxisTxMaster.tData(6) \
	/IridisSfTb/AxisTxMaster.tData(5) \
	/IridisSfTb/AxisTxMaster.tData(4) \
	/IridisSfTb/AxisTxMaster.tData(3) \
	/IridisSfTb/AxisTxMaster.tData(2) \
	/IridisSfTb/AxisTxMaster.tData(1) \
	/IridisSfTb/AxisTxMaster.tData(0)
wv.cursors.add -time 268363910358fs -name {Default cursor}
wv.cursors.setactive -name {Default cursor}
wv.cursors.lock true
wv.cursors.add -time 3ms+3 -name {Cursor 1}
wv.cursors.setactive -name {Cursor 1}
wv.zoom.range -from 2999884033190fs -to 3000006103516fs
wv.time.unit.auto.set
transcript $curr_transcript

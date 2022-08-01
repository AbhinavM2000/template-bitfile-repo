onerror { resume }
set curr_transcript [transcript]
transcript off

add wave /IridisSfTb/RxOrbitStrobe
add wave /IridisSfTb/mgtRxInitDone
add wave /IridisSfTb/mgtRxDataD1
add wave /IridisSfTb/iridisSfRxCtrl
add wave /IridisSfTb/iridisSfRxStat
add wave -expand /IridisSfTb/U_IridisRx/r_iCSPFSM
add wave -color 138,43,226 -color_waveform -bold /IridisSfTb/U_IridisRx/unscramblerDin
add wave -color 138,43,226 -color_waveform -bold /IridisSfTb/U_IridisRx/unscramblerDout
add wave /IridisSfTb/U_IridisRx/unscramblerSBout
add wave /IridisSfTb/U_IridisRx/unscramblerVout
add wave -color 34,139,34 -color_waveform -bold /IridisSfTb/U_IridisRx/RxHeader
add wave -color 0,100,0 -color_waveform -bold /IridisSfTb/U_IridisRx/RxDataWord
add wave /IridisSfTb/mgtClk
add wave -color 30,144,255 -color_waveform -bold /IridisSfTb/U_IridisRx/comb_iCSPFSM/v_fifoWriteICin
add wave -color 30,144,255 -color_waveform -bold /IridisSfTb/U_IridisRx/comb_iCSPFSM/v_CRCnibble
add wave -color 30,144,255 -color_waveform -bold /IridisSfTb/U_IridisRx/comb_iCSPFSM/v_fifoFFOflag
add wave -color 30,144,255 -color_waveform -bold /IridisSfTb/U_IridisRx/comb_iCSPFSM/v_fifoEOFflag
add wave -vgroup IridisTxSection \
	( -color 0,128,0 -color_waveform -bold /IridisSfTb/U_IridisTx/r_oCSPFSM.HdrBuf ) \
	( -color 0,128,0 -color_waveform -bold /IridisSfTb/U_IridisTx/r_oCSPFSM.DataBuf )
add wave -expand -vgroup LinkAlign \
	/IridisSfTb/U_IridisRx/iFSMRst \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/resync \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/r
add wave /IridisSfTb/U_IridisRx/U_LinkResyncCtrl/resync
add wave -color 218,112,214 -color_waveform -bold /IridisSfTb/U_IridisRx/U_LinkResyncCtrl/bc0
add wave /IridisSfTb/OrbitStrobe
add wave -expand -varray LinkAlignOutputs \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/resyncOut \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/fifoRelease \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/mgtRst \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/resyncFSMDone \
	/IridisSfTb/U_IridisRx/U_LinkResyncCtrl/channelBC0Out
add wave -vrecord RxAxiStreamSignlas \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/AxisRxMaster.tUser(0) ) \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/AxisRxMaster.tUser(1) ) \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/AxisRxMaster.tLast ) \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/AxisRxMaster.tValid ) \
	( -color 218,112,214 -color_waveform -bold -varray RxAxiStreamData \
		/IridisSfTb/AxisRxMaster.tData(63) \
		/IridisSfTb/AxisRxMaster.tData(62) \
		/IridisSfTb/AxisRxMaster.tData(61) \
		/IridisSfTb/AxisRxMaster.tData(60) \
		/IridisSfTb/AxisRxMaster.tData(59) \
		/IridisSfTb/AxisRxMaster.tData(58) \
		/IridisSfTb/AxisRxMaster.tData(57) \
		/IridisSfTb/AxisRxMaster.tData(56) \
		/IridisSfTb/AxisRxMaster.tData(55) \
		/IridisSfTb/AxisRxMaster.tData(54) \
		/IridisSfTb/AxisRxMaster.tData(53) \
		/IridisSfTb/AxisRxMaster.tData(52) \
		/IridisSfTb/AxisRxMaster.tData(51) \
		/IridisSfTb/AxisRxMaster.tData(50) \
		/IridisSfTb/AxisRxMaster.tData(49) \
		/IridisSfTb/AxisRxMaster.tData(48) \
		/IridisSfTb/AxisRxMaster.tData(47) \
		/IridisSfTb/AxisRxMaster.tData(46) \
		/IridisSfTb/AxisRxMaster.tData(45) \
		/IridisSfTb/AxisRxMaster.tData(44) \
		/IridisSfTb/AxisRxMaster.tData(43) \
		/IridisSfTb/AxisRxMaster.tData(42) \
		/IridisSfTb/AxisRxMaster.tData(41) \
		/IridisSfTb/AxisRxMaster.tData(40) \
		/IridisSfTb/AxisRxMaster.tData(39) \
		/IridisSfTb/AxisRxMaster.tData(38) \
		/IridisSfTb/AxisRxMaster.tData(37) \
		/IridisSfTb/AxisRxMaster.tData(36) \
		/IridisSfTb/AxisRxMaster.tData(35) \
		/IridisSfTb/AxisRxMaster.tData(34) \
		/IridisSfTb/AxisRxMaster.tData(33) \
		/IridisSfTb/AxisRxMaster.tData(32) \
		/IridisSfTb/AxisRxMaster.tData(31) \
		/IridisSfTb/AxisRxMaster.tData(30) \
		/IridisSfTb/AxisRxMaster.tData(29) \
		/IridisSfTb/AxisRxMaster.tData(28) \
		/IridisSfTb/AxisRxMaster.tData(27) \
		/IridisSfTb/AxisRxMaster.tData(26) \
		/IridisSfTb/AxisRxMaster.tData(25) \
		/IridisSfTb/AxisRxMaster.tData(24) \
		/IridisSfTb/AxisRxMaster.tData(23) \
		/IridisSfTb/AxisRxMaster.tData(22) \
		/IridisSfTb/AxisRxMaster.tData(21) \
		/IridisSfTb/AxisRxMaster.tData(20) \
		/IridisSfTb/AxisRxMaster.tData(19) \
		/IridisSfTb/AxisRxMaster.tData(18) \
		/IridisSfTb/AxisRxMaster.tData(17) \
		/IridisSfTb/AxisRxMaster.tData(16) \
		/IridisSfTb/AxisRxMaster.tData(15) \
		/IridisSfTb/AxisRxMaster.tData(14) \
		/IridisSfTb/AxisRxMaster.tData(13) \
		/IridisSfTb/AxisRxMaster.tData(12) \
		/IridisSfTb/AxisRxMaster.tData(11) \
		/IridisSfTb/AxisRxMaster.tData(10) \
		/IridisSfTb/AxisRxMaster.tData(9) \
		/IridisSfTb/AxisRxMaster.tData(8) \
		/IridisSfTb/AxisRxMaster.tData(7) \
		/IridisSfTb/AxisRxMaster.tData(6) \
		/IridisSfTb/AxisRxMaster.tData(5) \
		/IridisSfTb/AxisRxMaster.tData(4) \
		/IridisSfTb/AxisRxMaster.tData(3) \
		/IridisSfTb/AxisRxMaster.tData(2) \
		/IridisSfTb/AxisRxMaster.tData(1) \
		/IridisSfTb/AxisRxMaster.tData(0) \
	)
add wave -expand /IridisSfTb/U_IridisRx/r_oCSPFSM ( -child \
	( -unsigned /IridisSfTb/U_IridisRx/r_oCSPFSM.ctr ) \
)
add wave /IridisSfTb/U_IridisRx/U_LinkResyncCtrl/bc0
add wave /IridisSfTb/U_IridisRx/fifoDataOut
wv.cursors.add -time 535744487304fs -name {Default cursor}
wv.cursors.add -time 3ms+3 -name {Cursor 2}
wv.cursors.setactive -name {Cursor 2}
wv.cursors.subcursor.add -time 3089121814ps -name {Cursor 1}
wv.cursors.setactive -name {Cursor 2}
wv.bookmarks.add -time 268694380ps -name EscramberTx-DescramblerRx -zoom 268689573480fs 268705595212fs
wv.bookmarks.add -time 362597050ps -name FirstRun
wv.bookmarks.add -time 357407216ps -name RunState -zoom 357333973800fs 357822255096fs -text {RunState afte the RxAlignment proces (FSM) was completed :) 
}
wv.bookmarks.add -time 269045091ps -name RxAlignProcess -zoom 268068528405fs 270021653595fs
wv.bookmarks.add -time 359381496ps -name {First FFO detected } -zoom 359369288965fs 359491359291fs
wv.zoom.range -from 1669999999998fs -to 3070us
wv.time.unit.auto.set
transcript $curr_transcript

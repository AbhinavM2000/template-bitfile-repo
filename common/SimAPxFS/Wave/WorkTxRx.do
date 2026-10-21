onerror { resume }
set curr_transcript [transcript]
transcript off

add wave /IridisSfTb/iridisSfRxStat
add wave -color 0,0,255 -color_waveform -bold -varray {AxiStreamTxData } \
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
add wave -color 0,0,255 -color_waveform -bold /IridisSfTb/TxMatchFlag
add wave -color 255,20,147 -color_waveform -bold -varray AxiStreamRxData \
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
	/IridisSfTb/AxisRxMaster.tData(0)
add wave -color 255,20,147 -color_waveform -bold /IridisSfTb/RxMatchFlag
add wave -expand -height 25 -color 255,0,0 -color_waveform -bold -vgroup TxPart \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/U_IridisTx/r_oCSPFSM.HdrBuf ) \
	/IridisSfTb/U_IridisTx/r_oCSPFSM.DataBuf \
	/IridisSfTb/U_IridisTx/r_oCSPFSM.CRCVevent \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.crcLatched \
	/IridisSfTb/U_IridisTx/scramblerDin \
	/IridisSfTb/U_IridisTx/scramblerEna \
	/IridisSfTb/U_IridisTx/scramblerDout \
	/IridisSfTb/U_IridisTx/scramblerSBout
add wave -height 27 -color 255,0,0 -color_waveform -vgroup Mgt \
	( -bin -color 255,20,147 -color_waveform -bold /IridisSfTb/mgtTxHeader ) \
	/IridisSfTb/mgtTxData \
	( -bin -color 255,20,147 -color_waveform -bold /IridisSfTb/mgtRxHeader ) \
	/IridisSfTb/mgtRxData \
	/IridisSfTb/r_Err \
	/IridisSfTb/r_Err.ErrorFlag(5) \
	/IridisSfTb/r_Err.ErrorFlag(6) \
	( -color 138,43,226 -color_waveform -bold /IridisSfTb/r_Err.ErrorFlag(1) ) \
	/IridisSfTb/r_Err.ErrorFlag(2) \
	( -height 28 -color 0,128,0 -color_waveform -bold /IridisSfTb/r_Err.ErrorFlag(0) )
add wave -expand -height 25 -color 255,0,0 -color_waveform -bold -vgroup RxPart \
	/IridisSfTb/U_IridisRx/unscramblerDin \
	( -height 17 /IridisSfTb/U_IridisRx/unscramblerDout ) \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/U_IridisRx/RxHeader ) \
	/IridisSfTb/U_IridisRx/RxDataWord \
	/IridisSfTb/U_IridisRx/r_iCSPFSM.HdrTypeBuf \
	/IridisSfTb/U_IridisRx/r_iCSPFSM.CSPCtlCode
add wave /IridisSfTb/AxisRxMaster.tValid
add wave /IridisSfTb/U_IridisRx/r_iCSPFSM.CtlWdPyldBuf
add wave /IridisSfTb/U_IridisRx/r_iCSPFSM.CRCbuffer
add wave -expand -vrecord RxFifoSignals \
	/IridisSfTb/U_IridisRx/U_Fifo/rd_en \
	/IridisSfTb/U_IridisRx/U_Fifo/wr_en \
	/IridisSfTb/U_IridisRx/U_Fifo/din \
	/IridisSfTb/U_IridisRx/U_Fifo/dout
add wave -color 255,20,147 -color_waveform -bold /IridisSfTb/U_IridisRx/ICf2dErr
add wave /IridisSfTb/U_IridisRx/ICd2fErr
add wave /IridisSfTb/U_IridisRx/r_oCSPFSM
add wave -expand -height 27 -color 255,0,0 -color_waveform -bold -vgroup {IndxCorrection } \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/data_word_in \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/r \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/U_IridisRx/U_IndexCorrector/fifoWrite_in ) \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/combined_state_v \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/resync_active_v \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/comparator_v \
	( -color 255,20,147 -color_waveform -bold /IridisSfTb/U_IridisRx/U_IndexCorrector/comb/fifoWrite_out_v ) \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/f2d_error_out_v \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/d2f_error_out_v \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/resync_active_v \
	/IridisSfTb/U_IridisRx/U_IndexCorrector/comb/combined_state_v
add wave /IridisSfTb/U_IridisRx/crcErrCnt
add wave /IridisSfTb/U_IridisTx/r_iCSPFSM
wv.cursors.add -time 230184152ps -name {Default cursor}
wv.cursors.setactive -name {Default cursor}
wv.cursors.subcursor.add -time 230248252ps -name {Cursor 1}
wv.cursors.subcursor.add -time 269815848ps -name {Cursor 2}
wv.cursors.setactive -name {Cursor 2}
wv.cursors.lock true
wv.cursors.setactive -name {Default cursor}
wv.cursors.subcursor.add -time 230401432ps -name {Cursor 3}
wv.cursors.subcursor.add -time 641935336ps -name {Cursor 4}
wv.cursors.setactive -name {Cursor 2}
wv.bookmarks.add -time 504896180ps -name {SingleCtrlHdr } -zoom 504880607704fs 504904640297fs
wv.bookmarks.add -time 504888480ps -name {DoubleCtrlHdr } -zoom 504882392482fs 504912910061fs
wv.zoom.range -from 2525us -to 3025us
wv.time.unit.auto.set
transcript $curr_transcript

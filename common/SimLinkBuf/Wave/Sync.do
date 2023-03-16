onerror { resume }
set curr_transcript [transcript]
transcript off

add wave -expand /IridisSfTb/U_IridisRx/r_iCSPFSM
add wave -expand /IridisSfTb/U_IridisRx/U_LinkResyncCtrl/r
add wave -expand /IridisSfTb/U_IridisRx/r_oCSPFSM ( -child \
	( -unsigned /IridisSfTb/U_IridisRx/r_oCSPFSM.ctr ) \
)
add wave /IridisSfTb/U_IridisRx/U_Fifo/wr_en
add wave /IridisSfTb/U_IridisRx/U_Fifo/rd_en
add wave -varray DataFifoIn \
	/IridisSfTb/U_IridisRx/U_Fifo/din(63) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(62) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(61) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(60) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(59) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(58) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(57) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(56) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(55) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(54) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(53) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(52) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(51) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(50) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(49) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(48) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(47) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(46) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(45) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(44) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(43) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(42) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(41) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(40) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(39) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(38) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(37) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(36) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(35) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(34) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(33) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(32) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(31) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(30) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(29) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(28) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(27) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(26) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(25) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(24) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(23) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(22) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(21) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(20) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(19) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(18) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(17) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(16) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(15) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(14) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(13) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(12) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(11) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(10) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(9) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(8) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(7) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(6) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(5) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(4) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(3) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(2) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(1) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(0)
add wave -varray CtrlFIFOIn \
	/IridisSfTb/U_IridisRx/U_Fifo/din(71) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(70) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(69) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(68) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(67) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(66) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(65) \
	/IridisSfTb/U_IridisRx/U_Fifo/din(64)
add wave /IridisSfTb/U_IridisRx/U_Fifo/dout
add wave /IridisSfTb/U_IridisRx/U_Fifo/underflow
add wave /IridisSfTb/U_IridisRx/U_Fifo/overflow
add wave -expand -vgroup IridisTxSection \
	( -color 0,128,0 -color_waveform -bold -literal /IridisSfTb/U_IridisTx/r_oCSPFSM.HdrBuf ) \
	( -color 0,128,0 -color_waveform -bold -literal /IridisSfTb/U_IridisTx/r_oCSPFSM.DataBuf ) \
	( -color 0,100,0 -color_waveform -bold -literal /IridisSfTb/U_IridisRx/RxDataWord ) \
	( -color 34,139,34 -color_waveform -bold -literal /IridisSfTb/U_IridisRx/RxHeader )
wv.cursors.add -time 3ms+3 -name {Default cursor}
wv.cursors.setactive -name {Default cursor}
wv.zoom.range -from 2999072265585fs -to 3000048828127fs
wv.time.unit.auto.set
transcript $curr_transcript

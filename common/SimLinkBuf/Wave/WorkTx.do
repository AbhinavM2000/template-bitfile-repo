onerror { resume }
set curr_transcript [transcript]
transcript off

add wave -expand /IridisSfTb/iridisSfTxCtrl
add wave -color 255,0,255 -color_waveform /IridisSfTb/r.wrSof
add wave -color 255,0,255 -color_waveform /IridisSfTb/r.wrEoF
add wave /IridisSfTb/r.wrFFO
add wave -expand /IridisSfTb/iridisSfTxStat
add wave /IridisSfTb/U_IridisTx/r_iCSPFSM
add wave -unsigned -varray Fifo72DataBits \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(63) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(62) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(61) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(60) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(59) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(58) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(57) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(56) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(55) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(54) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(53) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(52) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(51) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(50) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(49) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(48) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(47) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(46) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(45) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(44) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(43) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(42) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(41) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(40) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(39) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(38) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(37) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(36) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(35) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(34) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(33) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(32) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(31) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(30) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(29) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(28) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(27) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(26) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(25) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(24) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(23) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(22) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(21) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(20) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(19) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(18) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(17) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(16) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(15) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(14) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(13) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(12) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(11) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(10) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(9) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(8) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(7) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(6) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(5) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(4) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(3) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(2) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(1) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(0)
add wave -varray Fifo72CtrlBits \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(71) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(70) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(69) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(68) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(67) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(66) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(65) \
	/IridisSfTb/U_IridisTx/r_iCSPFSM.fifo72(64)
add wave -expand /IridisSfTb/U_IridisTx/r_oCSPFSM ( -child \
	( -unsigned /IridisSfTb/U_IridisTx/r_oCSPFSM.GearboxCtr ) \
)
add wave /IridisSfTb/U_IridisTx/scramblerDout
add wave /IridisSfTb/U_IridisTx/scramblerEna
add wave -expand -color 255,20,147 -color_waveform -bold /IridisSfTb/U_IridisTx/comb_oCSPFSM/v_WordBuilderState
add wave -color 106,90,205 -color_waveform /IridisSfTb/OrbitStrobe
add wave /IridisSfTb/r.wrFrameCnt
add wave -color 65,105,225 -color_waveform /IridisSfTb/U_IridisTx/fifoEmpty
add wave /IridisSfTb/r.wrBxCnt
add wave /IridisSfTb/U_IridisTx/fifoDataOut
add wave -unsigned -varray TxFiFoOutDataBits \
	/IridisSfTb/U_IridisTx/fifoDataOut(63) \
	/IridisSfTb/U_IridisTx/fifoDataOut(62) \
	/IridisSfTb/U_IridisTx/fifoDataOut(61) \
	/IridisSfTb/U_IridisTx/fifoDataOut(60) \
	/IridisSfTb/U_IridisTx/fifoDataOut(59) \
	/IridisSfTb/U_IridisTx/fifoDataOut(58) \
	/IridisSfTb/U_IridisTx/fifoDataOut(57) \
	/IridisSfTb/U_IridisTx/fifoDataOut(56) \
	/IridisSfTb/U_IridisTx/fifoDataOut(55) \
	/IridisSfTb/U_IridisTx/fifoDataOut(54) \
	/IridisSfTb/U_IridisTx/fifoDataOut(53) \
	/IridisSfTb/U_IridisTx/fifoDataOut(52) \
	/IridisSfTb/U_IridisTx/fifoDataOut(51) \
	/IridisSfTb/U_IridisTx/fifoDataOut(50) \
	/IridisSfTb/U_IridisTx/fifoDataOut(49) \
	/IridisSfTb/U_IridisTx/fifoDataOut(48) \
	/IridisSfTb/U_IridisTx/fifoDataOut(47) \
	/IridisSfTb/U_IridisTx/fifoDataOut(46) \
	/IridisSfTb/U_IridisTx/fifoDataOut(45) \
	/IridisSfTb/U_IridisTx/fifoDataOut(44) \
	/IridisSfTb/U_IridisTx/fifoDataOut(43) \
	/IridisSfTb/U_IridisTx/fifoDataOut(42) \
	/IridisSfTb/U_IridisTx/fifoDataOut(41) \
	/IridisSfTb/U_IridisTx/fifoDataOut(40) \
	/IridisSfTb/U_IridisTx/fifoDataOut(39) \
	/IridisSfTb/U_IridisTx/fifoDataOut(38) \
	/IridisSfTb/U_IridisTx/fifoDataOut(37) \
	/IridisSfTb/U_IridisTx/fifoDataOut(36) \
	/IridisSfTb/U_IridisTx/fifoDataOut(35) \
	/IridisSfTb/U_IridisTx/fifoDataOut(34) \
	/IridisSfTb/U_IridisTx/fifoDataOut(33) \
	/IridisSfTb/U_IridisTx/fifoDataOut(32) \
	/IridisSfTb/U_IridisTx/fifoDataOut(31) \
	/IridisSfTb/U_IridisTx/fifoDataOut(30) \
	/IridisSfTb/U_IridisTx/fifoDataOut(29) \
	/IridisSfTb/U_IridisTx/fifoDataOut(28) \
	/IridisSfTb/U_IridisTx/fifoDataOut(27) \
	/IridisSfTb/U_IridisTx/fifoDataOut(26) \
	/IridisSfTb/U_IridisTx/fifoDataOut(25) \
	/IridisSfTb/U_IridisTx/fifoDataOut(24) \
	/IridisSfTb/U_IridisTx/fifoDataOut(23) \
	/IridisSfTb/U_IridisTx/fifoDataOut(22) \
	/IridisSfTb/U_IridisTx/fifoDataOut(21) \
	/IridisSfTb/U_IridisTx/fifoDataOut(20) \
	/IridisSfTb/U_IridisTx/fifoDataOut(19) \
	/IridisSfTb/U_IridisTx/fifoDataOut(18) \
	/IridisSfTb/U_IridisTx/fifoDataOut(17) \
	/IridisSfTb/U_IridisTx/fifoDataOut(16) \
	/IridisSfTb/U_IridisTx/fifoDataOut(15) \
	/IridisSfTb/U_IridisTx/fifoDataOut(14) \
	/IridisSfTb/U_IridisTx/fifoDataOut(13) \
	/IridisSfTb/U_IridisTx/fifoDataOut(12) \
	/IridisSfTb/U_IridisTx/fifoDataOut(11) \
	/IridisSfTb/U_IridisTx/fifoDataOut(10) \
	/IridisSfTb/U_IridisTx/fifoDataOut(9) \
	/IridisSfTb/U_IridisTx/fifoDataOut(8) \
	/IridisSfTb/U_IridisTx/fifoDataOut(7) \
	/IridisSfTb/U_IridisTx/fifoDataOut(6) \
	/IridisSfTb/U_IridisTx/fifoDataOut(5) \
	/IridisSfTb/U_IridisTx/fifoDataOut(4) \
	/IridisSfTb/U_IridisTx/fifoDataOut(3) \
	/IridisSfTb/U_IridisTx/fifoDataOut(2) \
	/IridisSfTb/U_IridisTx/fifoDataOut(1) \
	/IridisSfTb/U_IridisTx/fifoDataOut(0)
add wave -varray TxFiFoOutCtrlBits \
	/IridisSfTb/U_IridisTx/fifoDataOut(71) \
	/IridisSfTb/U_IridisTx/fifoDataOut(70) \
	/IridisSfTb/U_IridisTx/fifoDataOut(69) \
	/IridisSfTb/U_IridisTx/fifoDataOut(68) \
	( -label TxValid(Idle) /IridisSfTb/U_IridisTx/fifoDataOut(67) ) \
	( -label TxEOF /IridisSfTb/U_IridisTx/fifoDataOut(66) ) \
	( -label TxSOF /IridisSfTb/U_IridisTx/fifoDataOut(65) ) \
	( -label TxFFO /IridisSfTb/U_IridisTx/fifoDataOut(64) )
add wave -expand -vgroup FifoTxStatus \
	/IridisSfTb/U_IridisTx/U_Fifo/din \
	/IridisSfTb/U_IridisTx/U_Fifo/full \
	/IridisSfTb/U_IridisTx/U_Fifo/overflow \
	( -color 199,21,133 -color_waveform -bold /IridisSfTb/U_IridisTx/U_Fifo/wr_en ) \
	/IridisSfTb/U_IridisTx/U_Fifo/empty \
	/IridisSfTb/U_IridisTx/U_Fifo/underflow \
	/IridisSfTb/U_IridisTx/U_Fifo/dout \
	( -unsigned -color 50,205,50 -color_waveform -bold -varray FifoOutData \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(63) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(62) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(61) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(60) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(59) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(58) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(57) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(56) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(55) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(54) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(53) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(52) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(51) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(50) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(49) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(48) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(47) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(46) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(45) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(44) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(43) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(42) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(41) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(40) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(39) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(38) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(37) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(36) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(35) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(34) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(33) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(32) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(31) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(30) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(29) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(28) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(27) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(26) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(25) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(24) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(23) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(22) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(21) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(20) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(19) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(18) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(17) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(16) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(15) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(14) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(13) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(12) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(11) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(10) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(9) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(8) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(7) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(6) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(5) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(4) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(3) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(2) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(1) \
		/IridisSfTb/U_IridisTx/U_Fifo/dout(0) \
	) \
	( -unsigned -color 218,112,214 -bold -varray FifoInData \
		/IridisSfTb/U_IridisTx/U_Fifo/din(63) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(62) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(61) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(60) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(59) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(58) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(57) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(56) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(55) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(54) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(53) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(52) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(51) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(50) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(49) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(48) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(47) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(46) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(45) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(44) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(43) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(42) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(41) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(40) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(39) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(38) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(37) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(36) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(35) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(34) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(33) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(32) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(31) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(30) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(29) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(28) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(27) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(26) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(25) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(24) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(23) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(22) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(21) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(20) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(19) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(18) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(17) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(16) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(15) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(14) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(13) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(12) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(11) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(10) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(9) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(8) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(7) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(6) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(5) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(4) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(3) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(2) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(1) \
		/IridisSfTb/U_IridisTx/U_Fifo/din(0) \
	) \
	( -unsigned -color 123,104,238 -color_waveform -bold /IridisSfTb/r.wrCnt ) \
	/IridisSfTb/U_IridisTx/U_Fifo/rd_en
add wave /IridisSfTb/mgtClk
wv.cursors.add -time 192730752ps -name {Default cursor}
wv.cursors.setactive -name {Default cursor}
wv.cursors.lock true
wv.cursors.add -time 179693812ps -name {Cursor 1}
wv.cursors.setactive -name {Cursor 1}
wv.cursors.lock true
wv.cursors.add -time 192730752ps -name {Cursor 2}
wv.cursors.add -time 192734316ps -name {Cursor 3}
wv.cursors.setactive -name {Cursor 3}
wv.cursors.lock true
wv.cursors.setactive -name {Cursor 2}
wv.bookmarks.add -time 179697370ps -name CRVC -zoom 179677758227fs 179709865773fs
wv.bookmarks.add -time 179239984ps -name FFO -zoom 179238378623fs 179270486169fs
wv.bookmarks.add -time 192730752ps -name Stop_ReadFIfo_Problem -zoom 192719514361fs 192751621907fs
wv.zoom.range -from 192719514361fs -to 192751621907fs
wv.time.unit.auto.set
transcript $curr_transcript

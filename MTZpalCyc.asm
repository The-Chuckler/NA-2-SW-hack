PalCycle_Mz:
		subq.w  #$01, (PalCycle_Timer).w    
		bpl.s   loc_1FE2
		move.w  #$0011, (PalCycle_Timer).w
		lea     (Pal_MzCyc1).l, A0        ; loc_2334
		move.w  (PalCycle_Frame).w, D0
		addq.w  #$02, (PalCycle_Frame).w
		cmpi.w  #$000C, (PalCycle_Frame).w
		bcs.s   loc_1FDA
		move.w  #$0000, (PalCycle_Frame).w
loc_1FDA:
		lea     (Normal_palette_line3+$A).w, A1
		move.w  $00(A0, D0), (A1)
loc_1FE2:
		subq.w  #$01, (PalCycle_Timer2).w
		bpl.s   loc_2016
		move.w  #$0002, (PalCycle_Timer2).w
		lea     (Pal_MzCyc2).l, A0        ; loc_2340
		move.w  (PalCycle_Frame2).w, D0
		addq.w  #$02, (PalCycle_Frame2).w
		cmpi.w  #$0006, (PalCycle_Frame2).w
		bcs.s   loc_200A
		move.w  #$0000, (PalCycle_Frame2).w
loc_200A:
		lea     (Normal_palette_line3+2).w, A1
		move.l  $00(A0, D0), (A1)+
		move.w  $04(A0, D0), (A1)
loc_2016:
		subq.w  #$01, (PalCycle_Timer3).w
		bpl.s   loc_2046
		move.w  #$0009, (PalCycle_Timer3).w
		lea     (Pal_MzCyc3).l, A0        ; loc_234C
		move.w  (PalCycle_Frame3).w, D0
		addq.w  #$02, (PalCycle_Frame3).w
		cmpi.w  #$0014, (PalCycle_Frame3).w
		bcs.s   loc_203E
		move.w  #$0000, (PalCycle_Frame3).w
loc_203E:
		lea     (Normal_palette_line3+$1E).w, A1
		move.w  $00(A0, D0), (A1)
loc_2046:
		rts
; ===========================================================================
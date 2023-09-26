;=============================================================================== 
; Object 0x6D - Metropolis - Floor Harpoon
; [ Begin ]		         
;===============================================================================  
;Obj_0x6D_Harpoon: ; loc_1B720:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1B72E(PC, D0), D1
		jmp     loc_1B72E(PC, D1)
loc_1B72E:
		dc.w    loc_1B732-loc_1B72E
		dc.w    loc_1B76C-loc_1B72E
loc_1B732:
		addq.b  #$02, $0024(A0)
		move.l  #Obj68_MapUnc_1B6DC, $0004(A0) ; loc_1B6DC
		move.w  #$241C, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_13 ; loc_1B7FC
		ori.b   #$04, $0001(A0)
		move.b  #$04, $0019(A0)
		move.b  #$04, $0018(A0)
		move.w  $0008(A0), $0030(A0)
		move.w  $000C(A0), $0032(A0)
		move.b  #$84, $0020(A0)
loc_1B76C:
		bsr.w     loc_1B788
		moveq   #$00, D0
		move.b  $0034(A0), D0
		neg.w   D0
		add.w   $0032(A0), D0
		move.w  D0, $000C(A0)
		move.w  $0030(A0), D0
		bra.w     loc_1B808
loc_1B788:
		tst.w   $003A(A0)
		beq.s   loc_1B794
		subq.w  #$01, $003A(A0)
		rts
loc_1B794:
		tst.w   $0038(A0)
		beq.s   loc_1B7AC
		move.b  (Timer_frames+1).w, D0
		sub.b   $0028(A0), D0
		andi.b  #$7F, D0
		bne.s   loc_1B7EE
		clr.w   $0038(A0)
loc_1B7AC:
		tst.w   $0036(A0)
		beq.s   loc_1B7CE
		subi.w  #$0400, $0034(A0)
		bcc.s   loc_1B7EE
		move.w  #$0000, $0034(A0)
		move.w  #$0000, $0036(A0)
		move.w  #$0001, $0038(A0)
		rts
loc_1B7CE:
		addi.w  #$0400, $0034(A0)
		cmpi.w  #$2000, $0034(A0)
		bcs.s   loc_1B7EE
		move.w  #$2000, $0034(A0)
		move.w  #$0001, $0036(A0)
		move.w  #$0003, $003A(A0)
loc_1B7EE:
		rts
;=============================================================================== 
; Object 0x6D - Metropolis - Floor Harpoon
; [ End ]		         
;===============================================================================  
;=============================================================================== 
; Object 0x69 - Metropolis - Screew Nut
; [ Begin ]		         
;===============================================================================		   
;Obj_0x69_Screw_Nut: ; loc_1B810:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1B81E(PC, D0), D1
		jmp     loc_1B81E(PC, D1)
loc_1B81E:
		dc.w    loc_1B826-loc_1B81E
		dc.w    loc_1B868-loc_1B81E
		dc.w    loc_1B982-loc_1B81E
		dc.w    loc_1B880-loc_1B81E
loc_1B826:
		addq.b  #$02, $0024(A0)
		move.l  #Obj69_MapUnc_1B9A6, $0004(A0) ; loc_1B9A6
		move.w  #$2500, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_14 ; loc_1BA16
		move.b  #$04, $0001(A0)
		move.b  #$20, $0019(A0)
		move.b  #$0B, $0016(A0)
		move.b  #$04, $0018(A0)
		move.w  $000C(A0), $0032(A0)
		move.b  $0028(A0), D0
		andi.w  #$007F, D0
		lsl.w   #$03, D0
		move.w  D0, $0036(A0)
loc_1B868:
		lea     ($FFFFB000).w, A1
		lea     $0038(A0), A4
		moveq   #$03, D6
		bsr.s   loc_1B898
		lea     ($FFFFB040).w, A1
		lea     $003C(A0), A4
		moveq   #$04, D6
		bsr.s   loc_1B898
loc_1B880:
		move.w  #$002B, D1
		move.w  #$000C, D2
		move.w  #$000D, D3
		move.w  $0008(A0), D4
		bsr.w     J_SolidObject_09        ; loc_1BA1C
		bra.w     J_MarkObjGone_10        ; loc_1BA10
loc_1B898:
		btst    D6, $0022(A0)
		bne.s   loc_1B8A0
		clr.b   (A4)
loc_1B8A0:
		moveq   #$00, D0
		move.b  (A4), D0
		move.w  loc_1B8AC(PC, D0), D0
		jmp     loc_1B8AC(PC, D0)
loc_1B8AC:
		dc.w    loc_1B8B2-loc_1B8AC
		dc.w    loc_1B8D2-loc_1B8AC
		dc.w    loc_1B8F4-loc_1B8AC
loc_1B8B2:
		btst    D6, $0022(A0)
		bne.s   loc_1B8BA
		rts
loc_1B8BA:
		addq.b  #$02, (A4)
		move.b  #$00, $0001(A4)
		move.w  $0008(A0), D0
		sub.w   $0008(A1), D0
		bcc.s   loc_1B8D2
		move.b  #$01, $0001(A4)
loc_1B8D2:
		move.w  $0008(A1), D0
		sub.w   $0008(A0), D0
		tst.b   $0001(A4)
		beq.s   loc_1B8E4
		addi.w  #$000F, D0
loc_1B8E4:
		cmpi.w  #$0010, D0
		bcc.s   loc_1B8F2
		move.w  $0008(A0), $0008(A1)
		addq.b  #$02, (A4)
loc_1B8F2:
		rts
loc_1B8F4:
		move.w  $0008(A1), D0
		sub.w   $0008(A0), D0
		bcc.s   loc_1B95A
		add.w   D0, $0034(A0)
		move.w  $0008(A0), $0008(A1)
		move.w  $0034(A0), D0
		asr.w   #$03, D0
		move.w  D0, D1
		asr.w   #$01, D0
		andi.w  #$0003, D0
		move.b  D0, $001A(A0)
		neg.w   D1
		add.w   $0032(A0), D1
		move.w  D1, $000C(A0)
		sub.w   $0032(A0), D1
		move.w  $0036(A0), D0
		cmp.w   D0, D1
		blt.s   loc_1B958
		move.w  D0, D1
		add.w   $0032(A0), D1
		move.w  D1, $000C(A0)
		lsl.w   #$03, D0
		neg.w   D0
		move.w  D0, $0034(A0)
		move.b  #$00, $001A(A0)
		tst.b   $0028(A0)
		bmi.s   loc_1B952
		clr.b   (A4)
		rts
loc_1B952:
		move.b  #$04, $0024(A0)
loc_1B958:
		rts
loc_1B95A:
		add.w   D0, $0034(A0)
		move.w  $0008(A0), $0008(A1)
		move.w  $0034(A0), D0
		asr.w   #$03, D0
		move.w  D0, D1
		asr.w   #$01, D0
		andi.w  #$0003, D0
		move.b  D0, $001A(A0)
		neg.w   D1
		add.w   $0032(A0), D1
		move.w  D1, $000C(A0)
		rts
loc_1B982:
		bsr.w     J_SpeedToPos_09         ; loc_1BA22
		addi.w  #$0038, $0012(A0)
		bsr.w     J_ObjHitFloor_00        ; loc_1BA28
		tst.w   D1
		bpl.w    loc_1B9A2
		add.w   D1, $000C(A0)
		clr.w   $0012(A0)
		addq.b  #$02, $0024(A0)
loc_1B9A2:
		bra.w     loc_1B880     
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj69_MapUnc_1B9A6:	incbin	"mappings/sprite/obj69.bin"
; ===========================================================================
		nop

J_MarkObjGone_10: ; loc_1BA10:
		jmp     MarkObjGone             ; (loc_D2A0)
J_Adjust2PArtPointer_14: ; loc_1BA16:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SolidObject_09: ; loc_1BA1C:
		jmp     SolidObject             ; (loc_F4A0)
J_SpeedToPos_09: ; loc_1BA22:
		jmp     SpeedToPos              ; (loc_D27A)
J_ObjHitFloor_00: ; loc_1BA28:
		jmp     ObjHitFloor             ; (loc_13898)
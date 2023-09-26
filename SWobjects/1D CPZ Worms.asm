;=============================================================================== 
; Object 0x1D - Chemical Plant - Worms
; [ Begin ]		         
;===============================================================================  
;Obj_0x1D_Worms: ; loc_165B0:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_165BE(PC, D0), D1
		jmp     loc_165BE(PC, D1)
loc_165BE:
		dc.w    loc_165D0-loc_165BE
		dc.w    loc_1667E-loc_165BE
		dc.w    loc_1669C-loc_165BE
		dc.w    loc_1667E-loc_165BE
		dc.w    loc_166D0-loc_165BE		 
;loc_165C8:
		dc.w    $FB80, $FB00, $FA00, $F900		  
loc_165D0:
		addq.b  #$02, $0024(A0)
		move.w  #$FB80, $0012(A0)
		moveq   #$00, D1
		move.b  $0028(A0), D1
		move.b  D1, D0
		andi.b  #$0F, D1
		moveq   #$02, D5
		andi.b  #$F0, D0
		beq.s   loc_165F0
		moveq   #$06, D5
loc_165F0:
		move.b  $0022(A0), D4
		moveq   #$00, D2
		move.l  A0, A1
		bra.s   lc_16600
loc_165FA:		
		bsr.w     J_SingleObjLoad2      ; loc_E788
		bne.s   lc_16678
lc_16600:
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		move.b  D5, $0024(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $000C(A0), $000C(A1)
		move.l  #Obj1D_MapUnc_16702, $0004(A1) ; loc_16702
		move.w  #$643C, $0002(A1)
		bsr.w     J_Adjust2PArtPointer2_00 ; loc_16716
		move.b  #$04, $0001(A1)
		move.b  #$03, $0018(A1)
		move.b  #$8B, $0020(A1)
		move.w  $0008(A1), $0038(A1)
		move.w  $000C(A1), $0030(A1)
		move.w  $0012(A0), $0012(A1)
		move.w  $0012(A1), $0034(A1)
		move.b  #$08, $0019(A1)
		move.w  #$0060, $003A(A1)
		move.w  #$000B, $0036(A1)
		andi.b  #$01, D4
		beq.s   lc_16672
		neg.w   $0036(A1)
		neg.w   $003A(A1)
lc_16672:
		move.w  D2, $0032(A1)
		addq.w  #$03, D2
lc_16678:
		dbf    D1, loc_165FA
		rts
loc_1667E:
		subq.w  #$01, $0032(A0)
		bpl.s   loc_16698
		addq.b  #$02, $0024(A0)
		move.w  #$003B, $0032(A0)
		move.w  #$00AE, D0
		jsr     (PlaySound).l             ; loc_14C6
loc_16698:
		bra.w     J_MarkObjGone_02        ; loc_16710
loc_1669C:
		bsr.w     J_SpeedToPos_02         ; loc_1671C
		move.w  $0036(A0), D0
		add.w   D0, $0010(A0)
		addi.w  #$0018, $0012(A0)
		bne.s   loc_166B4
		neg.w   $0036(A0)
loc_166B4:
		move.w  $0030(A0), D0
		cmp.w   $000C(A0), D0
		bhi.s   loc_166CC
		move.w  $0034(A0), $0012(A0)
		clr.w   $0010(A0)
		subq.b  #$02, $0024(A0)
loc_166CC:
		bra.w     J_MarkObjGone_02        ; loc_16710
loc_166D0:
		bsr.w     J_SpeedToPos_02         ; loc_1671C
		addi.w  #$0018, $0012(A0)
		bne.s   loc_166E8
		move.w  $003A(A0), D0
		add.w   $0038(A0), D0
		move.w  D0, $0008(A0)
loc_166E8:
		move.w  $0030(A0), D0
		cmp.w   $000C(A0), D0
		bhi.s   loc_166FE
		move.w  $0034(A0), $0012(A0)
		move.w  $0038(A0), $0008(A0)
loc_166FE:
		bra.w     J_MarkObjGone_02        ; loc_16710
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj1D_MapUnc_16702:	incbin	"mappings/sprite/obj1D.bin"
; ===========================================================================
		nop

J_MarkObjGone_02: ; loc_16710:
		jmp     MarkObjGone             ; (loc_D2A0)
J_Adjust2PArtPointer2_00: ; loc_16716:
		jmp     Adjust2PArtPointer2   ; (loc_DC4C)
J_SpeedToPos_02: ; loc_1671C:
		jmp     SpeedToPos              ; (loc_D27A)   
J_SingleObjLoad2:
		jmp		SingleObjLoad2
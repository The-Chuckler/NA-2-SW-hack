;=============================================================================== 
; Object 0x64 - Metropolis - Pistons 
; [ Begin ]		         
;===============================================================================		  
;Obj_0x64_Pistons: ; loc_1A8B4:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1A8C2(PC, D0), D1
		jmp     loc_1A8C2(PC, D1)
loc_1A8C2:
		dc.w    loc_1A8CE-loc_1A8C2
		dc.w    loc_1A936-loc_1A8C2
loc_1A8C6:
		dc.b    $40, $0C, $40, $01, $10, $20, $40, $01
loc_1A8CE:
		addq.b  #$02, $0024(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		lsr.w   #$02, D0
		andi.w  #$001C, D0
		lea     loc_1A8C6(PC, D0), A3
		move.b  (A3)+, $0019(A0)
		move.b  (A3)+, $002E(A0)
		lsr.w   #$02, D0
		move.b  D0, $001A(A0)
		bne.s   loc_1A8FE
		move.b  #$6C, $0016(A0)
		bset    #$04, $0001(A0)
loc_1A8FE:
		move.l  #Obj64_MapUnc_1A9F0, $0004(A0) ; loc_1A9F0
		move.w  #$2000, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_10 ; loc_1AA68
		ori.b   #$04, $0001(A0)
		move.b  #$04, $0018(A0)
		move.w  $0008(A0), $0034(A0)
		move.w  $000C(A0), $0030(A0)
		moveq   #$00, D0
		move.b  (A3)+, D0
		move.w  D0, $003C(A0)
		andi.b  #$0F, $0028(A0)
loc_1A936:
		move.w  $0008(A0), -(A7)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		add.w   D0, D0
		move.w  loc_1A988(PC, D0), D1
		jsr     loc_1A988(PC, D1)
		move.w  (A7)+, D4
		tst.b   $0001(A0)
		bpl.s   loc_1A96A
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		moveq   #$00, D2
		move.b  $002E(A0), D2
		move.w  D2, D3
		addq.w  #$01, D3
		bsr.w     J_SolidObject_06        ; loc_1AA6E
loc_1A96A:
		move.w  $0034(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   J_DeleteObject_17       ; loc_1A982
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_17: ; loc_1A982:
		jmp     DeleteObject            ; (loc_D3B4)   
loc_1A988:		              
		dc.w    loc_1A98C-loc_1A988
		dc.w    loc_1A98E-loc_1A988
loc_1A98C:
		rts
loc_1A98E:
		tst.b   $0038(A0)
		bne.s   loc_1A9B2
		tst.w   $003A(A0)
		beq.s   loc_1A9A0
		subq.w  #$08, $003A(A0)
		bra.s   lc_1A9D2
loc_1A9A0:
		subq.w  #$01, $0036(A0)
		bpl.s   lc_1A9D2
		move.w  #$003C, $0036(A0)
		move.b  #$01, $0038(A0)
loc_1A9B2:
		move.w  $003A(A0), D0
		cmp.w   $003C(A0), D0
		beq.s   loc_1A9C2
		addq.w  #$08, $003A(A0)
		bra.s   lc_1A9D2
loc_1A9C2:
		subq.w  #$01, $0036(A0)
		bpl.s   lc_1A9D2
		move.w  #$003C, $0036(A0)
		clr.b   $0038(A0)
lc_1A9D2:
		move.w  $003A(A0), D0
		btst    #$00, $0022(A0)
		beq.s   loc_1A9E4
		neg.w   D0
		addi.w  #$0040, D0
loc_1A9E4:
		move.w  $0030(A0), D1
		add.w   D0, D1
		move.w  D1, $000C(A0)
		rts		   
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj64_MapUnc_1A9F0:	incbin	"mappings/sprite/obj64.bin"

;=============================================================================== 
; Object 0x64 - Metropolis - Pistons 
; [ End ]		         
;===============================================================================		  
J_Adjust2PArtPointer_10: ; loc_1AA68:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SolidObject_06: ; loc_1AA6E:
		jmp     SolidObject             ; (loc_F4A0)             
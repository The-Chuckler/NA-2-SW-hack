;=============================================================================== 
; Object 0x7A - Chemical Plant - Platforms - Move horizontally
; [ Begin ]		         
;===============================================================================		     
;Obj_0x7A_Platform_Horizontal: ; loc_1D594:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1D5A2(PC, D0), D1
		jmp     loc_1D5A2(PC, D1)
loc_1D5A2:
		dc.w    loc_1D5BA-loc_1D5A2
		dc.w    loc_1D660-loc_1D5A2
		dc.w    loc_1D6B2-loc_1D5A2
loc_1D5A8:		
		dc.b    $00, $70, $FF, $90, $00, $00, $01, $B0, $FF, $50, $00, $40, $01, $F0, $FF, $80
		dc.b    $00, $80
loc_1D5BA:
		addq.b  #$02, $0024(A0)
		move.w  #$E418, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_1E ; loc_1D73E
		moveq   #$00, D1
		move.b  $0028(A0), D1
		lea     loc_1D5A8(PC, D1), A2
		move.b  (A2)+, D1
		move.l  A0, A1
		bra.s   loc_1D5F6
loc_1D5D8:		
		bsr.w     J_SingleObjLoad2_0A  ; loc_1D738
		bne.s   loc_1D61C
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		move.b  #$04, $0024(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $000C(A0), $000C(A1)
loc_1D5F6:
		move.l  #Obj7A_MapUnc_1D72C, $0004(A1) ; loc_1D72C
		move.w  $0002(A0), $0002(A1)
		move.b  #$04, $0001(A1)
		move.b  #$04, $0018(A1)
		move.b  #$10, $0019(A1)
		move.w  $0008(A1), $0030(A1)
loc_1D61C:
		dbf    D1, loc_1D5D8
		move.l  A0, $003C(A1)
		move.l  A1, $003C(A0)
		cmpi.b  #$0C, $0028(A0)
		bne.s   loc_1D636
		move.b  #$01, $0036(A0)
loc_1D636:
		moveq   #$00, D1
		move.b  (A2)+, D1
		move.w  $0030(A0), D0
		sub.w   D1, D0
		move.w  D0, $0032(A0)
		move.w  D0, $0032(A1)
		add.w   D1, D0
		add.w   D1, D0
		move.w  D0, $0034(A0)
		move.w  D0, $0034(A1)
		move.w  (A2)+, D0
		add.w   D0, $0008(A0)
		move.w  (A2)+, D0
		add.w   D0, $0008(A1)
loc_1D660:
		bsr.s   loc_1D6BC
		move.w  $0032(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bls.s   loc_1D686
		move.w  $0034(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1D68C
loc_1D686:
		jmp     DisplaySprite           ; (loc_D3C2)
loc_1D68C:
		move.l  $003C(A0), A1
		cmpa.l  A0, A1
		beq.s   loc_1D69A
		jsr     (loc_D3B6)
loc_1D69A:
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   J_DeleteObject_20       ; loc_1D6AC
		bclr    #$07, $02(A2, D0)
J_DeleteObject_20: ; loc_1D6AC:
		jmp     DeleteObject            ; (loc_D3B4)
loc_1D6B2:
		bsr.s   loc_1D6BC
		bsr.s   loc_1D706
		jmp     DisplaySprite           ; (loc_D3C2)
loc_1D6BC:
		move.w  $0008(A0), -(A7)
		tst.b   $0036(A0)
		beq.s   loc_1D6DE
		move.w  $0008(A0), D0
		subq.w  #$01, D0
		cmp.w   $0032(A0), D0
		bne.s   loc_1D6D8
		move.b  #$00, $0036(A0)
loc_1D6D8:
		move.w  D0, $0008(A0)
		bra.s   loc_1D6F4
loc_1D6DE:
		move.w  $0008(A0), D0
		addq.w  #$01, D0
		cmp.w   $0034(A0), D0
		bne.s   loc_1D6F0
		move.b  #$01, $0036(A0)
loc_1D6F0:
		move.w  D0, $0008(A0)
loc_1D6F4:
		moveq   #$00, D1
		move.b  $0019(A0), D1
		move.w  #$0008, D3
		move.w  (A7)+, D4
		bsr.w     loc_1D744
		rts
loc_1D706:
		move.l  $003C(A0), A1
		move.w  $0008(A0), D0
		subi.w  #$0010, D0
		move.w  $0008(A1), D2
		addi.w  #$0010, D2
		cmp.w   D0, D2
		bne.s   loc_1D72A
		eori.b  #$01, $0036(A0)
		eori.b  #$01, $0036(A1)
loc_1D72A:
		rts
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj7A_MapUnc_1D72C:	incbin	"mappings/sprite/obj7A.bin"
; ===========================================================================

J_SingleObjLoad2_0A: ; loc_1D738:
		jmp     SingleObjLoad2      ; (loc_E788)
J_Adjust2PArtPointer_1E: ; loc_1D73E:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1D744:
		jmp     (PlatformObject)
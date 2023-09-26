;=============================================================================== 
; Object 0x7B - Chemical Plant - Spring Over Tubes 
; [ Begin ]		         
;===============================================================================		 
;Obj_0x7B_Spring_Tubes: ; loc_1D74C:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1D77C(PC, D0), D1
		jsr     loc_1D77C(PC, D1)
		tst.w   (Two_player_mode).w
		beq.s   loc_1D764
		bra.w     J_DisplaySprite_0D      ; loc_1D964
loc_1D764:
		move.w  $0008(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.w    J_DeleteObject_21       ; loc_1D96A
		bra.w     J_DisplaySprite_0D      ; loc_1D964
loc_1D77C:
		dc.w    loc_1D784-loc_1D77C
		dc.w    loc_1D7BA-loc_1D77C
loc_1D780:
		dc.w    $F000, $F600
loc_1D784:
		addq.b  #$02, $0024(A0)
		move.l  #Obj7B_MapUnc_1D920, $0004(A0) ; loc_1D920
		move.w  #$03E0, $0002(A0)
		ori.b   #$04, $0001(A0)
		move.b  #$10, $0019(A0)
		move.b  #$01, $0018(A0)
		move.b  $0028(A0), D0
		andi.w  #$0002, D0
		move.w  loc_1D780(PC, D0), $0030(A0)
		bsr.w     J_Adjust2PArtPointer_1F ; loc_1D976
loc_1D7BA:
		cmpi.b  #$01, $001A(A0)
		beq.s   loc_1D802
		move.w  #$001B, D1
		move.w  #$0008, D2
		move.w  #$0010, D3
		move.w  $0008(A0), D4
		lea     ($FFFFB000).w, A1
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.w     loc_1D97C
		btst    #$03, $0022(A0)
		beq.s   loc_1D7EA
		bsr.s   loc_1D862
loc_1D7EA:
		movem.l (A7)+, D1-D4
		lea     ($FFFFB040).w, A1
		moveq   #$04, D6
		bsr.w     loc_1D97C
		btst    #$04, $0022(A0)
		beq.s   loc_1D802
		bsr.s   loc_1D862
loc_1D802:
		move.w  $0008(A0), D4
		move.w  D4, D5
		subi.w  #$0010, D4
		addi.w  #$0010, D5
		move.w  $000C(A0), D2
		move.w  D2, D3
		addi.w  #$0030, D3
		move.w  ($FFFFB008).w, D0
		cmp.w   D4, D0
		bcs.s   loc_1D838
		cmp.w   D5, D0
		bcc.s   loc_1D838
		move.w  ($FFFFB00C).w, D0
		cmp.w   D2, D0
		bcs.s   loc_1D838
		cmp.w   D3, D0
		bcc.s   loc_1D838
		move.b  #$02, $001C(A0)
loc_1D838:
		move.w  ($FFFFB048).w, D0
		cmp.w   D4, D0
		bcs.s   loc_1D856
		cmp.w   D5, D0
		bcc.s   loc_1D856
		move.w  ($FFFFB04C).w, D0
		cmp.w   D2, D0
		bcs.s   loc_1D856
		cmp.w   D3, D0
		bcc.s   loc_1D856
		move.b  #$03, $001C(A0)
loc_1D856:
		lea     (loc_1D908).l, A1
		bra.w     J_AnimateSprite_04      ; loc_1D970
		rts
loc_1D862:
		move.w  #$0100, $001C(A0)
		addq.w  #$04, $000C(A1)
		move.w  $0030(A0), $0012(A1)
		bset    #$01, $0022(A1)
		bclr    #$03, $0022(A1)
		move.b  #$10, $001C(A1)
		move.b  #$02, $0024(A1)
		move.b  $0028(A0), D0
		bpl.s   loc_1D896
		move.w  #$0000, $0010(A1)
loc_1D896:
		btst    #$00, D0
		beq.s   loc_1D8D6
		move.w  #$0001, $0014(A1)
		move.b  #$01, $0027(A1)
		move.b  #$00, $001C(A1)
		move.b  #$00, $002C(A1)
		move.b  #$04, $002D(A1)
		btst    #$01, D0
		bne.s   loc_1D8C6
		move.b  #$01, $002C(A1)
loc_1D8C6:
		btst    #$00, $0022(A1)
		beq.s   loc_1D8D6
		neg.b   $0027(A1)
		neg.w   $0014(A1)
loc_1D8D6:
		andi.b  #$0C, D0
		cmpi.b  #$04, D0
		bne.s   loc_1D8EC
		move.b  #$0C, $003E(A1)
		move.b  #$0D, $003F(A1)
loc_1D8EC:
		cmpi.b  #$08, D0
		bne.s   loc_1D8FE
		move.b  #$0E, $003E(A1)
		move.b  #$0F, $003F(A1)
loc_1D8FE:
		move.w  #$00CC, D0
		jmp     (PlaySound).l             ; loc_14C6    
loc_1D908:
		dc.w    loc_1D910-loc_1D908
		dc.w    loc_1D913-loc_1D908
		dc.w    loc_1D917-loc_1D908
		dc.w    loc_1D917-loc_1D908
loc_1D910:
		dc.b    $0F, $00, $FF
loc_1D913:
		dc.b    $00, $03, $FD, $00
loc_1D917:
		dc.b    $05, $01, $02, $02, $02, $04, $FD, $00, $00  
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj7B_MapUnc_1D920:	incbin	"mappings/sprite/obj7B.bin"
; ===========================================================================
		nop

J_DisplaySprite_0D: ; loc_1D964:				
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_21: ; loc_1D96A:
		jmp     DeleteObject            ; (loc_D3B4)
J_AnimateSprite_04: ; loc_1D970:
		jmp     AnimateSprite           ; (loc_D412)
J_Adjust2PArtPointer_1F: ; loc_1D976:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1D97C:
		jmp     (loc_F510)
Camera_X_pos_coarse:	equ		$FFFFF7DA
;=============================================================================== 
; Object 0x42 - Metropolis - Steam Vent 
; [ Begin ]		         
;===============================================================================		  
;Obj_0x42_Steam_Vent: ; loc_1A5CC:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1A5DA(PC, D0), D1
		jmp     loc_1A5DA(PC, D1)
loc_1A5DA:
		dc.w    loc_1A5E0-loc_1A5DA
		dc.w    loc_1A620-loc_1A5DA
		dc.w    loc_1A7CC-loc_1A5DA
loc_1A5E0:
		addq.b  #$02, $0024(A0)
		move.l  #Obj42_MapUnc_1A7FE, $0004(A0) ; loc_1A7FE
		move.w  #$6000, $0002(A0)
		ori.b   #$04, $0001(A0)
		move.b  #$10, $0019(A0)
		move.b  #$04, $0018(A0)
		bsr.w     J_Adjust2PArtPointer_0F ; loc_1A8A8
		move.b  #$07, $001A(A0)
		move.w  $000C(A0), $0034(A0)
		move.w  #$0010, $0036(A0)
		addi.w  #$0010, $000C(A0)
loc_1A620:
		move.w  #$001B, D1
		move.w  #$0010, D2
		move.w  #$0010, D3
		move.w  $0008(A0), D4
		lea     ($FFFFB000).w, A1
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.w     loc_1A8AE
		btst    #$03, $0022(A0)
		beq.s   lc_1A64A
		bsr.w     loc_1A726
lc_1A64A:
		movem.l (A7)+, D1-D4
		lea     ($FFFFB040).w, A1
		moveq   #$04, D6
		bsr.w     loc_1A8AE
		btst    #$04, $0022(A0)
		beq.s   loc_1A664
		bsr.w     loc_1A726
loc_1A664:
		move.b  $0025(A0), D0
		bne.s   loc_1A67C
		subq.w  #$01, $0032(A0)
		bpl.s   loc_1A6E0
		move.w  #$007F, $0032(A0)
		addq.b  #$02, $0025(A0)
		bra.s   loc_1A6E0
loc_1A67C:
		subq.b  #$02, D0
		bne.s   loc_1A6AE
		subq.w  #$08, $0036(A0)
		bne.s   loc_1A6A0
		addq.b  #$02, $0025(A0)
		bsr.s   loc_1A6E4
		addi.w  #$0028, $0008(A1)
		bsr.s   loc_1A6E4
		subi.w  #$0028, $0008(A1)
		bset    #$00, $0001(A1)
loc_1A6A0:
		move.w  $0036(A0), D0
		add.w   $0034(A0), D0
		move.w  D0, $000C(A0)
		bra.s   loc_1A6E0
loc_1A6AE:
		subq.b  #$02, D0
		bne.s   loc_1A6C4
		subq.w  #$01, $0032(A0)
		bpl.s   loc_1A6E0
		move.w  #$007F, $0032(A0)
		addq.b  #$02, $0025(A0)
		bra.s   loc_1A6E0
loc_1A6C4:
		addq.w  #$08, $0036(A0)
		cmpi.w  #$0010, $0036(A0)
		bne.s   loc_1A6D4
		clr.b   $0025(A0)
loc_1A6D4:
		move.w  $0036(A0), D0
		add.w   $0034(A0), D0
		move.w  D0, $000C(A0)
loc_1A6E0:
		bra.w     J_MarkObjGone_0D        ; loc_1A8A2
loc_1A6E4:
		bsr.w     J_SingleObjLoad_04   ; loc_1A89C
		bne.s   loc_1A724
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		addq.b  #$04, $0024(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $0034(A0), $000C(A1)
		move.b  #$07, $001E(A1)
		move.l  $0004(A0), $0004(A1)
		move.w  #$2405, $0002(A1)
		ori.b   #$04, $0001(A1)
		move.b  #$18, $0019(A1)
		move.b  #$04, $0018(A1)
loc_1A724:
		rts
loc_1A726:
		cmpi.b  #$02, $0025(A0)
		beq.s   loc_1A730
		rts
loc_1A730:
		move.w  #$FA00, $0012(A1)
		bset    #$01, $0022(A1)
		bclr    #$03, $0022(A1)
		move.b  #$10, $001C(A1)
		move.b  #$02, $0024(A1)
		move.b  $0028(A0), D0
		bpl.s   loc_1A75A
		move.w  #$0000, $0010(A1)
loc_1A75A:
		btst    #$00, D0
		beq.s   loc_1A79A
		move.w  #$0001, $0014(A1)
		move.b  #$01, $0027(A1)
		move.b  #$00, $001C(A1)
		move.b  #$00, $002C(A1)
		move.b  #$04, $002D(A1)
		btst    #$01, D0
		bne.s   loc_1A78A
		move.b  #$01, $002C(A1)
loc_1A78A:
		btst    #$00, $0022(A1)
		beq.s   loc_1A79A
		neg.b   $0027(A1)
		neg.w   $0014(A1)
loc_1A79A:
		andi.b  #$0C, D0
		cmpi.b  #$04, D0
		bne.s   loc_1A7B0
		move.b  #$0C, $003E(A1)
		move.b  #$0D, $003F(A1)
loc_1A7B0:
		cmpi.b  #$08, D0
		bne.s   loc_1A7C2
		move.b  #$0E, $003E(A1)
		move.b  #$0F, $003F(A1)
loc_1A7C2:
		move.w  #$00CC, D0
		jmp     (PlaySound).l             ; loc_14C6
loc_1A7CC:
		subq.b  #$01, $001E(A0)
		bpl.s   loc_1A7FA
		move.b  #$07, $001E(A0)
		move.b  #$00, $0020(A0)
		addq.b  #$01, $001A(A0)
		cmpi.b  #$02, $001A(A0)
		bne.s   loc_1A7F0
		move.b  #$8B, $0020(A0)
loc_1A7F0:
		cmpi.b  #$07, $001A(A0)
		beq.w    J_DeleteObject_16       ; loc_1A896
loc_1A7FA:
		bra.w     J_DisplaySprite_07      ; loc_1A890
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj42_MapUnc_1A7FE:	incbin	"mappings/sprite/obj42.bin"
; ===========================================================================
		nop

J_DisplaySprite_07: ; loc_1A890:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_16: ; loc_1A896:
		jmp     DeleteObject            ; (loc_D3B4)
J_SingleObjLoad_04: ; loc_1A89C:
		jmp     SingleObjLoad        ; (loc_E772)
J_MarkObjGone_0D: ; loc_1A8A2:
		jmp     MarkObjGone             ; (loc_D2A0)
J_Adjust2PArtPointer_0F: ; loc_1A8A8:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1A8AE:
		jmp     (loc_F510)   
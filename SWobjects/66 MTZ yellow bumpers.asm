;=============================================================================== 
; Object 0x66 - Metropolis - Springs on Walls
; [ Begin ]		         
;===============================================================================		   
;Obj_0x66_Spring_Wall: ; loc_1AEBC:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1AECA(PC, D0), D1
		jmp     loc_1AECA(PC, D1)
loc_1AECA:
		dc.w    loc_1AECE-loc_1AECA
		dc.w    loc_1AF12-loc_1AECA
loc_1AECE:
		addq.b  #$02, $0024(A0)
		move.l  #Obj66_MapUnc_1B084, $0004(A0) ; loc_1B084
		move.w  #$8680, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_12 ; loc_1B0B8
		ori.b   #$04, $0001(A0)
		move.b  #$08, $0019(A0)
		move.b  #$04, $0018(A0)
		move.b  #$40, $0016(A0)
		move.b  $0028(A0), D0
		lsr.b   #$04, D0
		andi.b  #$07, D0
		move.b  D0, $001A(A0)
		beq.s   loc_1AF12
		move.b  #$80, $0016(A0)
loc_1AF12:
		move.w  #$0013, D1
		moveq   #$00, D2
		move.b  $0016(A0), D2
		move.w  D2, D3
		addq.w  #$01, D3
		move.w  $0008(A0), D4
		lea     ($FFFFB000).w, A1
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.w     loc_1B0BE
		cmpi.b  #$01, D4
		bne.s   loc_1AF5A
		btst    #$01, $0022(A1)
		beq.s   loc_1AF5A
		move.b  $0022(A0), D1
		move.w  $0008(A0), D0
		sub.w   $0008(A1), D0
		bcs.s   loc_1AF52
		eori.b  #$01, D1
loc_1AF52:
		andi.b  #$01, D1
		bne.s   loc_1AF5A
		bsr.s   loc_1AFB0
loc_1AF5A:
		movem.l (A7)+, D1-D4
		lea     ($FFFFB040).w, A1
		moveq   #$04, D6
		bsr.w     loc_1B0BE
		cmpi.b  #$01, D4
		bne.s   loc_1AF90
		btst    #$01, $0022(A1)
		beq.s   loc_1AF90
		move.b  $0022(A0), D1
		move.w  $0008(A0), D0
		sub.w   $0008(A1), D0
		bcs.s   loc_1AF88
		eori.b  #$01, D1
loc_1AF88:
		andi.b  #$01, D1
		bne.s   loc_1AF90
		bsr.s   loc_1AFB0
loc_1AF90:
		move.w  $0008(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.w    J_DeleteObject_19       ; loc_1B0B2
		tst.w   (Debug_placement_mode).w
		beq.s   loc_1AFAE
		bsr.w     J_DisplaySprite_08      ; loc_1B0AC
loc_1AFAE:
		rts
loc_1AFB0:
		move.w  $0030(A0), $0010(A1)
		move.w  #$F800, $0010(A1)
		move.w  #$F800, $0012(A1)
		bset    #$00, $0022(A1)
		btst    #$00, $0022(A0)
		bne.s   loc_1AFDA
		bclr    #$00, $0022(A1)
		neg.w   $0010(A1)
loc_1AFDA:
		move.w  #$000F, $002E(A1)
		move.w  $0010(A1), $0014(A1)
		btst    #$02, $0022(A1)
		bne.s   loc_1AFF4
		move.b  #$00, $001C(A1)
loc_1AFF4:
		move.b  $0028(A0), D0
		bpl.s   loc_1B000
		move.w  #$0000, $0012(A1)
loc_1B000:
		btst    #$00, D0
		beq.s   loc_1B040
		move.w  #$0001, $0014(A1)
		move.b  #$01, $0027(A1)
		move.b  #$00, $001C(A1)
		move.b  #$01, $002C(A1)
		move.b  #$08, $002D(A1)
		btst    #$01, D0
		bne.s   loc_1B030
		move.b  #$03, $002C(A1)
loc_1B030:
		btst    #$00, $0022(A1)
		beq.s   loc_1B040
		neg.b   $0027(A1)
		neg.w   $0014(A1)
loc_1B040:
		andi.b  #$0C, D0
		cmpi.b  #$04, D0
		bne.s   loc_1B056
		move.b  #$0C, $003E(A1)
		move.b  #$0D, $003F(A1)
loc_1B056:
		cmpi.b  #$08, D0
		bne.s   loc_1B068
		move.b  #$0E, $003E(A1)
		move.b  #$0F, $003F(A1)
loc_1B068:
		bclr    #$05, $0022(A0)
		bclr    #$06, $0022(A0)
		bclr    #$05, $0022(A1)
		move.w  #$00CC, D0
		jmp     (PlaySound).l             ; loc_14C6
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj66_MapUnc_1B084:	incbin	"mappings/sprite/obj66.bin"

;=============================================================================== 
; Object 0x66 - Metropolis - Springs on Walls
; [ End ]		         
;===============================================================================  
J_DisplaySprite_08: ; loc_1B0AC:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_19: ; loc_1B0B2:
		jmp     DeleteObject            ; (loc_D3B4)
J_Adjust2PArtPointer_12: ; loc_1B0B8:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1B0BE:
		jmp     (loc_F510)		  
;=============================================================================== 
; Object 0x70 - Metropolis - Rotating Gears
; [ Begin ]		         
;===============================================================================		     
;Obj_0x70_Rotating_Gears: ; loc_1C850:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1C85E(PC, D0), D1
		jmp     loc_1C85E(PC, D1)
loc_1C85E:
		dc.w    loc_1C862-loc_1C85E
		dc.w    loc_1C8E2-loc_1C85E
loc_1C862:
		moveq   #$07, D1
		moveq   #$00, D4
		lea     (loc_1C9B6).l, A2
		move.l  A0, A1
		move.w  $0008(A0), D2
		move.w  $000C(A0), D3
		bset    #$07, $0022(A0)
		bra.s   loc_1C884
loc_1C87E:		
		bsr.w     J_SingleObjLoad2_07  ; loc_1CBB8
		bne.s   loc_1C8DE
loc_1C884:
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		addq.b  #$02, $0024(A1)
		move.l  #Obj70_MapUnc_1CA16, $0004(A1) ; loc_1CA16
		move.w  #$6378, $0002(A1)
		bsr.w     J_Adjust2PArtPointer2_01 ; loc_1CBBE
		move.b  #$04, $0001(A1)
		move.b  #$04, $0018(A1)
		move.b  #$10, $0019(A1)
		move.w  D2, $0032(A1)
		move.w  D3, $0030(A1)
		move.b  (A2)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, $0008(A1)
		move.b  (A2)+, D0
		ext.w   D0
		add.w   D3, D0
		move.w  D0, $000C(A1)
		move.b  (A2)+, $001A(A1)
		move.w  D4, $0034(A1)
		addq.w  #$03, D4
		move.b  $0022(A0), $0022(A1)
loc_1C8DE:
		dbf    D1, loc_1C87E
loc_1C8E2:
		move.w  $0008(A0), -(A7)
		move.b  (Timer_frames+1).w, D0
		move.b  D0, D1
		andi.w  #$000F, D0
		bne.s   loc_1C95A
		move.w  $0036(A0), D1
		btst    #$00, $0022(A0)
		beq.s   loc_1C914
		subi.w  #$0018, D1
		bcc.s   loc_1C932
		moveq   #$48, D1
		subq.w  #$03, $0034(A0)
		bcc.s   loc_1C932
		move.w  #$0015, $0034(A0)
		bra.s   loc_1C932
loc_1C914:
		addi.w  #$0018, D1
		cmpi.w  #$0060, D1
		bcs.s   loc_1C932
		moveq   #$00, D1
		addq.w  #$03, $0034(A0)
		cmpi.w  #$0018, $0034(A0)
		bcs.s   loc_1C932
		move.w  #$0000, $0034(A0)
loc_1C932:
		move.w  D1, $0036(A0)
		add.w   $0034(A0), D1
		lea     loc_1C9B6(PC, D1), A1
		move.b  (A1)+, D0
		ext.w   D0
		add.w   $0032(A0), D0
		move.w  D0, $0008(A0)
		move.b  (A1)+, D0
		ext.w   D0
		add.w   $0030(A0), D0
		move.w  D0, $000C(A0)
		move.b  (A1)+, $001A(A0)
loc_1C95A:
		move.b  $001A(A0), D0
		add.w   D0, D0
		andi.w  #$001E, D0
		moveq   #$00, D1
		moveq   #$00, D2
		move.b  loc_1C996(PC, D0), D1
		move.b  loc_1C997(PC, D0), D2
		move.w  D2, D3
		move.w  (A7)+, D4
		bsr.w     J_SolidObject_0D        ; loc_1CBC4
		move.w  $0032(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   J_DeleteObject_1E       ; loc_1C990
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_1E: ; loc_1C990:
		jmp     DeleteObject            ; (loc_D3B4)   

loc_1C996:		  
		dc.b    $10
loc_1C997:
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $0C, $10
		dc.b    $08, $10, $0C, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
loc_1C9B6:
		dc.b    $00, $B8, $00, $32, $CE, $04, $48, $00, $08, $32, $32, $0C, $00, $48, $10, $CE
		dc.b    $32, $14, $B8, $00, $18, $CE, $CE, $1C, $0D, $B8, $01, $3F, $DA, $05, $48, $0C
		dc.b    $09, $27, $3C, $0D, $F3, $48, $11, $C1, $26, $15, $B8, $F4, $19, $D9, $C4, $1D
		dc.b    $19, $BC, $02, $46, $E9, $06, $46, $17, $0A, $19, $44, $0E, $E7, $44, $12, $BA
		dc.b    $17, $16, $BA, $E9, $1A, $E7, $BC, $1E, $27, $C4, $03, $48, $F4, $07, $3F, $26
		dc.b    $0B, $0D, $48, $0F, $D9, $3C, $13, $B8, $0C, $17, $C1, $DA, $1B, $F3, $B8, $1F
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj70_MapUnc_1CA16:	incbin	"mappings/sprite/obj70.bin"
; ===========================================================================
		nop

J_SingleObjLoad2_07: ; loc_1CBB8:
		jmp     SingleObjLoad2      ; (loc_E788)
J_Adjust2PArtPointer2_01: ; loc_1CBBE:
		jmp     Adjust2PArtPointer2   ; (loc_DC4C)
J_SolidObject_0D: ; loc_1CBC4:
		jmp     SolidObject             ; (loc_F4A0)  
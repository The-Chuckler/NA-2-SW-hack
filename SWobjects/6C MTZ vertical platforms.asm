;=============================================================================== 
; Object 0x6C - Moving platforms - clockwise
; [ Begin ]		         
;===============================================================================		  
;Obj_0x6C_Mz_Moving_Platforms: ; loc_1BF6C:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1BF94(PC, D0), D1
		jsr     loc_1BF94(PC, D1)
		move.w  $0030(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1BF90
		bra.w     J_DisplaySprite_0A      ; loc_1C2C0
loc_1BF90:
		bra.w     J_DeleteObject_1A       ; loc_1C2C6
loc_1BF94:
		dc.w    loc_1BF98-loc_1BF94
		dc.w    loc_1C0A0-loc_1BF94
loc_1BF98:
		move.b  $0028(A0), D0
		bmi.w    loc_1C04A
		addq.b  #$02, $0024(A0)
		move.l  #Obj6C_MapUnc_1C2AA, $0004(A0) ; loc_1C2AA
		move.w  #$63F9, $0002(A0)
		ori.b   #$04, $0001(A0)
		move.b  #$10, $0019(A0)
		move.b  #$04, $0018(A0)
		bsr.w     J_Adjust2PArtPointer_17 ; loc_1C2D2
		move.b  #$00, $001A(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		move.w  D0, D1
		lsr.w   #$03, D0
		andi.w  #$001E, D0
		lea     loc_1C18A(PC), A2
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, $0038(A0)
		move.l  A2, $003C(A0)
		andi.w  #$000F, D1
		lsl.w   #$02, D1
		move.b  D1, $0038(A0)
		move.b  #$04, $003A(A0)
		btst    #$00, $0022(A0)
		beq.s   loc_1C02A
		neg.b   $003A(A0)
		moveq   #$00, D1
		move.b  $0038(A0), D1
		add.b   $003A(A0), D1
		cmp.b   $0039(A0), D1
		bcs.s   loc_1C026
		move.b  D1, D0
		moveq   #$00, D1
		tst.b   D0
		bpl.s   loc_1C026
		move.b  $0039(A0), D1
		subq.b  #$04, D1
loc_1C026:
		move.b  D1, $0038(A0)
loc_1C02A:
		move.w  $00(A2, D1), D0
		add.w   $0030(A0), D0
		move.w  D0, $0034(A0)
		move.w  $02(A2, D1), D0
		add.w   $0032(A0), D0
		move.w  D0, $0036(A0)
		bsr.w     loc_1C112
		bra.w     loc_1C0A0
loc_1C04A:
		andi.w  #$007F, D0
		add.w   D0, D0
		lea     (loc_1C20E).l, A2    
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, D1
		move.l  A0, A1
		move.w  $0008(A0), D2
		move.w  $000C(A0), D3
		bra.s   loc_1C06E
loc_1C068:		
		bsr.w     J_SingleObjLoad_05   ; loc_1C2CC
		bne.s   loc_1C098
loc_1C06E:
		move.b  #$6C, 0(A1);_move.b  #$6C, 0(A1)
		move.w  (A2)+, D0
		add.w   D2, D0
		move.w  D0, $0008(A1)
		move.w  (A2)+, D0
		add.w   D3, D0
		move.w  D0, $000C(A1)
		move.w  D2, $0030(A1)
		move.w  D3, $0032(A1)
		move.w  (A2)+, D0
		move.b  D0, $0028(A1)
		move.b  $0022(A0), $0022(A1)
loc_1C098:
		dbf    D1, loc_1C068
		addq.l  #$04, A7
		rts
loc_1C0A0:
		move.w  $0008(A0), -(A7)
		bsr.w     loc_1C0B6
		moveq   #$00, D1
		move.b  $0019(A0), D1
		moveq   #$08, D3
		move.w  (A7)+, D4
		bra.w     loc_1C2D8
loc_1C0B6:
		move.w  $0008(A0), D0
		cmp.w   $0034(A0), D0
		bne.s   loc_1C10C
		move.w  $000C(A0), D0
		cmp.w   $0036(A0), D0
		bne.s   loc_1C10C
		moveq   #$00, D1
		move.b  $0038(A0), D1
		add.b   $003A(A0), D1
		cmp.b   $0039(A0), D1
		bcs.s   loc_1C0E8
		move.b  D1, D0
		moveq   #$00, D1
		tst.b   D0
		bpl.s   loc_1C0E8
		move.b  $0039(A0), D1
		subq.b  #$04, D1
loc_1C0E8:
		move.b  D1, $0038(A0)
		move.l  $003C(A0), A1
		move.w  $00(A1, D1), D0
		add.w   $0030(A0), D0
		move.w  D0, $0034(A0)
		move.w  $02(A1, D1), D0
		add.w   $0032(A0), D0
		move.w  D0, $0036(A0)
		bsr.w     loc_1C112
loc_1C10C:
		bsr.w     J_SpeedToPos_0A         ; loc_1C2DE
		rts
loc_1C112:
		moveq   #$00, D0
		move.w  #$FF00, D2
		move.w  $0008(A0), D0
		sub.w   $0034(A0), D0
		bcc.s   loc_1C126
		neg.w   D0
		neg.w   D2
loc_1C126:
		moveq   #$00, D1
		move.w  #$FF00, D3
		move.w  $000C(A0), D1
		sub.w   $0036(A0), D1
		bcc.s   loc_1C13A
		neg.w   D1
		neg.w   D3
loc_1C13A:
		cmp.w   D0, D1
		bcs.s   loc_1C164
		move.w  $0008(A0), D0
		sub.w   $0034(A0), D0
		beq.s   loc_1C150
		ext.l   D0
		asl.l   #$08, D0
		divs.w  D1, D0
		neg.w   D0
loc_1C150:
		move.w  D0, $0010(A0)
		move.w  D3, $0012(A0)
		swap  D0
		move.w  D0, $000A(A0)
		clr.w   $000E(A0)
		rts
loc_1C164:
		move.w  $000C(A0), D1
		sub.w   $0036(A0), D1
		beq.s   loc_1C176
		ext.l   D1
		asl.l   #$08, D1
		divs.w  D0, D1
		neg.w   D1
loc_1C176:
		move.w  D1, $0012(A0)
		move.w  D2, $0010(A0)
		swap  D1
		move.w  D1, $000E(A0)
		clr.w   $000A(A0)
		rts    
loc_1C18A:
		dc.w    loc_1C190-loc_1C18A
		dc.w    loc_1C1BA-loc_1C18A
		dc.w    loc_1C1E4-loc_1C18A
loc_1C190:
		dc.w    $0028
		dc.b    $00, $00, $00, $00, $FF, $EA, $00, $0A, $FF, $E0, $00, $20, $FF, $E0, $00, $E0
		dc.b    $FF, $EA, $00, $F6, $00, $00, $01, $00, $00, $16, $00, $F6, $00, $20, $00, $E0
		dc.b    $00, $20, $00, $20, $00, $16, $00, $0A
loc_1C1BA:
		dc.w    $0028
		dc.b    $00, $00, $00, $00, $FF, $EA, $00, $0A, $FF, $E0, $00, $20, $FF, $E0, $01, $60
		dc.b    $FF, $EA, $01, $76, $00, $00, $01, $80, $00, $16, $01, $76, $00, $20, $01, $60
		dc.b    $00, $20, $00, $20, $00, $16, $00, $0A
loc_1C1E4:
		dc.w    $0028
		dc.b    $00, $00, $00, $00, $FF, $EA, $00, $0A, $FF, $E0, $00, $20, $FF, $E0, $01, $E0
		dc.b    $FF, $EA, $01, $F6, $00, $00, $02, $00, $00, $16, $01, $F6, $00, $20, $01, $E0
		dc.b    $00, $20, $00, $20, $00, $16, $00, $0A		
loc_1C20E: 
		dc.w    loc_1C214-loc_1C20E
		dc.w    loc_1C246-loc_1C20E
		dc.w    loc_1C278-loc_1C20E
loc_1C214:
		dc.w    $0007
		dc.b    $00, $00, $00, $00, $00, $01, $FF, $E0, $00, $3A, $00, $03, $FF, $E0, $00, $80
		dc.b    $00, $03, $FF, $E0, $00, $C6, $00, $03, $00, $00, $01, $00, $00, $06, $00, $20
		dc.b    $00, $C6, $00, $08, $00, $20, $00, $80, $00, $08, $00, $20, $00, $3A, $00, $08  
loc_1C246:
		dc.w    $0007
		dc.b    $00, $00, $00, $00, $00, $11, $FF, $E0, $00, $5A, $00, $13, $FF, $E0, $00, $C0
		dc.b    $00, $13, $FF, $E0, $01, $26, $00, $13, $00, $00, $01, $80, $00, $16, $00, $20
		dc.b    $01, $26, $00, $18, $00, $20, $00, $C0, $00, $18, $00, $20, $00, $5A, $00, $18		
loc_1C278:
		dc.w    $0007
		dc.b    $00, $00, $00, $00, $00, $21, $FF, $E0, $00, $7A, $00, $23, $FF, $E0, $01, $00
		dc.b    $00, $23, $FF, $E0, $01, $86, $00, $23, $00, $00, $02, $00, $00, $26, $00, $20
		dc.b    $01, $86, $00, $28, $00, $20, $01, $00, $00, $28, $00, $20, $00, $7A, $00, $28
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj6C_MapUnc_1C2AA:	incbin	"mappings/sprite/obj6C.bin"
; ===========================================================================
		nop

J_DisplaySprite_0A: ; loc_1C2C0:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_1A: ; loc_1C2C6:
		jmp     DeleteObject            ; (loc_D3B4)
J_SingleObjLoad_05: ; loc_1C2CC:
		jmp     SingleObjLoad        ; (loc_E772)
J_Adjust2PArtPointer_17: ; loc_1C2D2:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1C2D8:
		jmp     (PlatformObject)
J_SpeedToPos_0A: ; loc_1C2DE:
		jmp     SpeedToPos              ; (loc_D27A)    
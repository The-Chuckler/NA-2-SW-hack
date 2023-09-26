;=============================================================================== 
; Object 0x67 - Metropolis - Teleport Attributes
; [ Begin ]		         
;===============================================================================		    
;Obj_0x67_Teleport_Attributes: ; loc_1B0C4:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1B0EC(PC, D0), D1
		jsr     loc_1B0EC(PC, D1)
		move.b  $002C(A0), D0
		add.b   $0036(A0), D0
		beq.w    loc_1B518
		lea     (loc_1B4BA).l, A1
		bsr.w     J_AnimateSprite_03      ; loc_1B512
		bra.w     J_DisplaySprite_09      ; loc_1B50C
loc_1B0EC:
		dc.w    loc_1B0F0-loc_1B0EC
		dc.w    loc_1B114-loc_1B0EC
loc_1B0F0:
		addq.b  #$02, $0024(A0)
		move.l  #Teleport_Attributes_Mappings, $0004(A0) ; loc_1B4D4
		move.w  #$633C, $0002(A0)
		ori.b   #$04, $0001(A0)
		move.b  #$10, $0019(A0)
		move.b  #$05, $0018(A0)
loc_1B114:
		lea     ($FFFFB000).w, A1
		lea     $002C(A0), A4
		bsr.s   loc_1B126
		lea     ($FFFFB040).w, A1
		lea     $0036(A0), A4
loc_1B126:
		moveq   #$00, D0
		move.b  (A4), D0
		move.w  loc_1B132(PC, D0), D0
		jmp     loc_1B132(PC, D0)
loc_1B132:
		dc.w    loc_1B138-loc_1B132
		dc.w    loc_1B1C8-loc_1B132
		dc.w    loc_1B1FC-loc_1B132
loc_1B138:
		tst.w   (Debug_placement_mode).w
		bne.w    loc_1B1C6
		move.w  $0008(A1), D0
		sub.w   $0008(A0), D0
		addq.w  #$03, D0
		btst    #$00, $0022(A0)
		beq.s   loc_1B156
		addi.w  #$000A, D0
loc_1B156:
		cmpi.w  #$0010, D0
		bcc.s   loc_1B1C6
		move.w  $000C(A1), D1
		sub.w   $000C(A0), D1
		addi.w  #$0020, D1
		cmpi.w  #$0040, D1
		bcc.s   loc_1B1C6
		tst.b   $002A(A1)
		bne.s   loc_1B1C6
		addq.b  #$02, (A4)
		move.b  #$81, $002A(A1)
		move.b  #$02, $001C(A1)
		move.w  #$0800, $0014(A1)
		move.w  #$0000, $0010(A1)
		move.w  #$0000, $0012(A1)
		bclr    #$05, $0022(A0)
		bclr    #$05, $0022(A1)
		bset    #$01, $0022(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $000C(A0), $000C(A1)
		clr.b   $0001(A4)
		move.w  #$00BE, D0
		jsr     (PlaySound).l             ; loc_14C6
		move.w  #$0100, $001C(A0)
loc_1B1C6:
		rts
loc_1B1C8:
		move.b  $0001(A4), D0
		addq.b  #$02, $0001(A4)
		jsr    (CalcSine).l		; loc_320A
		asr.w   #$05, D0
		move.w  $000C(A0), D2
		sub.w   D0, D2
		move.w  D2, $000C(A1)
		cmpi.b  #$80, $0001(A4)
		bne.s   loc_1B1FA
		bsr.w     loc_1B278
		addq.b  #$02, (A4)
		move.w  #$00BC, D0
		jsr     (PlaySound).l             ; loc_14C6
loc_1B1FA:
		rts
loc_1B1FC:
		subq.b  #$01, $0002(A4)
		bpl.s   loc_1B230
		move.l  $0006(A4), A2
		move.w  (A2)+, D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		move.w  D5, $000C(A1)
		tst.b   $0028(A0)
		bpl.s   loc_1B21A
		subq.w  #$08, A2
loc_1B21A:
		move.l  A2, $0006(A4)
		subq.w  #$04, $0004(A4)
		beq.s   loc_1B256
		move.w  (A2)+, D4
		move.w  (A2)+, D5
		move.w  #$1000, D2
		bra.w     loc_1B2DC
loc_1B230:
		move.l  $0008(A1), D2
		move.l  $000C(A1), D3
		move.w  $0010(A1), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  $0012(A1), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, $0008(A1)
		move.l  D3, $000C(A1)
		rts
loc_1B256:
		andi.w  #$07FF, $000C(A1)
		clr.b   (A4)
		clr.b   $002A(A1)
		btst    #$04, $0028(A0)
		bne.s   loc_1B276
		move.w  #$0000, $0010(A1)
		move.w  #$0000, $0012(A1)
loc_1B276:
		rts
loc_1B278:
		move.b  $0028(A0), D0
		bpl.s   loc_1B2AC
		neg.b   D0
		andi.w  #$000F, D0
		add.w   D0, D0
		lea     (loc_1B35A).l, A2
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, D0
		subq.w  #$04, D0
		move.w  D0, $0004(A4)
		lea     $00(A2, D0), A2
		move.w  (A2)+, D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		move.w  D5, $000C(A1)
		subq.w  #$08, A2
		bra.s   loc_1B2D0
loc_1B2AC:
		andi.w  #$000F, D0
		add.w   D0, D0
		lea     (loc_1B35A).l, A2
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, $0004(A4)
		subq.w  #$04, $0004(A4)
		move.w  (A2)+, D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		move.w  D5, $000C(A1)
loc_1B2D0:
		move.l  A2, $0006(A4)
		move.w  (A2)+, D4
		move.w  (A2)+, D5
		move.w  #$1000, D2
loc_1B2DC:
		moveq   #$00, D0
		move.w  D2, D3
		move.w  D4, D0
		sub.w   $0008(A1), D0
		bge.s   loc_1B2EC
		neg.w   D0
		neg.w   D2
loc_1B2EC:
		moveq   #$00, D1
		move.w  D5, D1
		sub.w   $000C(A1), D1
		bge.s   loc_1B2FA
		neg.w   D1
		neg.w   D3
loc_1B2FA:
		cmp.w   D0, D1
		bcs.s   loc_1B32C
		moveq   #$00, D1
		move.w  D5, D1
		sub.w   $000C(A1), D1
		swap  D1
		divs.w  D3, D1
		moveq   #$00, D0
		move.w  D4, D0
		sub.w   $0008(A1), D0
		beq.s   loc_1B318
		swap  D0
		divs.w  D1, D0
loc_1B318:
		move.w  D0, $0010(A1)
		move.w  D3, $0012(A1)
		tst.w   D1
		bpl.s   loc_1B326
		neg.w   D1
loc_1B326:
		move.w  D1, $0002(A4)
		rts
loc_1B32C:
		moveq   #$00, D0
		move.w  D4, D0
		sub.w   $0008(A1), D0
		swap  D0
		divs.w  D2, D0
		moveq   #$00, D1
		move.w  D5, D1
		sub.w   $000C(A1), D1
		beq.s   loc_1B346
		swap  D1
		divs.w  D0, D1
loc_1B346:
		move.w  D1, $0012(A1)
		move.w  D2, $0010(A1)
		tst.w   D0
		bpl.s   lc_1B354
		neg.w   D0
lc_1B354:
		move.w  D0, $0002(A4)
		rts
loc_1B35A:
		dc.w    loc_1B37A-loc_1B35A
		dc.w    loc_1B394-loc_1B35A
		dc.w    loc_1B39E-loc_1B35A
		dc.w    loc_1B3A8-loc_1B35A
		dc.w    loc_1B3B2-loc_1B35A
		dc.w    loc_1B3BC-loc_1B35A
		dc.w    loc_1B3C6-loc_1B35A
		dc.w    lc_1B3D0-loc_1B35A
		dc.w    loc_1B3EA-loc_1B35A
		dc.w    loc_1B404-loc_1B35A
		dc.w    loc_1B41E-loc_1B35A
		dc.w    loc_1B438-loc_1B35A
		dc.w    loc_1B452-loc_1B35A
		dc.w    loc_1B46C-loc_1B35A
		dc.w    loc_1B486-loc_1B35A
		dc.w    loc_1B4A0-loc_1B35A
loc_1B37A:
		dc.w    $0018
		dc.b    $07, $28, $02, $70, $06, $D0, $02, $70, $06, $C0, $02, $88, $06, $C0, $03, $E0
		dc.b    $06, $D0, $03, $F0, $07, $28, $03, $F0
loc_1B394:
		dc.w    $0008
		dc.b    $0B, $D8, $05, $F0, $0E, $00, $05, $F0
loc_1B39E:
		dc.w    $0008
		dc.b    $0C, $58, $03, $70, $0E, $00, $03, $70
loc_1B3A8:
		dc.w    $0008
		dc.b    $13, $D8, $01, $F0, $15, $80, $01, $F0
loc_1B3B2:
		dc.w    $0008
		dc.b    $05, $D8, $03, $70, $07, $80, $03, $70
loc_1B3BC:
		dc.w    $0008
		dc.b    $05, $D8, $05, $F0, $07, $00, $05, $F0
loc_1B3C6:
		dc.w    $0008
		dc.b    $0B, $A8, $07, $70, $08, $80, $07, $70
lc_1B3D0:
		dc.w    $0018
		dc.b    $0B, $D8, $01, $F0, $0C, $30, $01, $F0, $0C, $40, $01, $E0, $0C, $40, $00, $C0
		dc.b    $0C, $50, $00, $B0, $0C, $A8, $00, $B0
loc_1B3EA:
		dc.w    $0018
		dc.b    $14, $D8, $04, $B0, $15, $30, $04, $B0, $15, $40, $04, $C0, $15, $40, $05, $A0
		dc.b    $15, $30, $05, $B0, $14, $D8, $05, $B0
loc_1B404:
		dc.w    $0018
		dc.b    $17, $28, $03, $30, $15, $D0, $03, $30, $15, $C0, $03, $20, $15, $C0, $02, $40
		dc.b    $15, $D0, $02, $30, $16, $28, $02, $30
loc_1B41E:
		dc.w    $0018
		dc.b    $0F, $D8, $03, $B0, $10, $30, $03, $B0, $10, $40, $03, $A0, $10, $40, $02, $C0
		dc.b    $10, $50, $02, $B0, $10, $A8, $02, $B0
loc_1B438:
		dc.w    $0018
		dc.b    $0F, $D8, $04, $B0, $10, $B0, $04, $B0, $10, $C0, $04, $A0, $10, $C0, $03, $C0
		dc.b    $10, $D0, $03, $B0, $11, $28, $03, $B0
loc_1B452:
		dc.w    $0018
		dc.b    $1E, $58, $01, $B0, $1F, $30, $01, $B0, $1F, $40, $01, $C0, $1F, $40, $02, $A0
		dc.b    $1F, $50, $02, $B0, $20, $A8, $02, $B0
loc_1B46C:
		dc.w    $0018
		dc.b    $20, $A8, $04, $70, $20, $50, $04, $70, $20, $40, $04, $80, $20, $40, $05, $A0
		dc.b    $20, $50, $05, $B0, $20, $A8, $05, $B0
loc_1B486:
		dc.w    $0018
		dc.b    $22, $58, $05, $B0, $23, $30, $05, $B0, $23, $40, $05, $A0, $23, $40, $04, $C0
		dc.b    $23, $50, $04, $B0, $23, $A8, $04, $B0
loc_1B4A0:
		dc.w    $0018
		dc.b    $22, $D8, $02, $B0, $23, $30, $02, $B0, $23, $40, $02, $C0, $23, $40, $04, $60
		dc.b    $23, $30, $04, $70, $22, $D8, $04, $70		
loc_1B4BA:		 
		dc.w    loc_1B4BE-loc_1B4BA
		dc.w    loc_1B4C1-loc_1B4BA
loc_1B4BE:
		dc.b    $1F, $00, $FF
loc_1B4C1:
		dc.b    $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $00, $01, $00
		dc.b    $FE, $02, $00   
Teleport_Attributes_Mappings:
loc_1B4D4:
		dc.w    loc_1B4D8-loc_1B4D4
		dc.w    loc_1B4DA-loc_1B4D4
loc_1B4D8:
		dc.w    $0000
loc_1B4DA:
		dc.w    $0006
		dc.l    $E0050000, $0000FFEC, $E0050000, $0000FFF8
		dc.l    $F0050000, $0000FFEC, $F0050000, $0000FFF8
		dc.l    $00050000, $0000FFEC, $00050000, $0000FFF8		             
;=============================================================================== 
; Object 0x67 - Metropolis - Teleport Attributes
; [ End ]		         
;===============================================================================               
J_DisplaySprite_09: ; loc_1B50C:
		jmp     DisplaySprite           ; (loc_D3C2)
J_AnimateSprite_03: ; loc_1B512:
		jmp     AnimateSprite           ; (loc_D412)
loc_1B518:
		jmp     (loc_D30C)
;=============================================================================== 
; Object 0x19 - Oil Ocean - Elevators
; [ Begin ]		         
;===============================================================================  
;Obj_0x19_Elevator: ; loc_1621C:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1622A(PC, D0), D1
		jmp     loc_1622A(PC, D1)
loc_1622A:
		dc.w    loc_16238-loc_1622A
		dc.w    loc_162A0-loc_1622A
loc_1622E		
		dc.b    $20, $00, $18, $01, $20, $02, $40, $03, $30, $04
loc_16238:
		addq.b  #$02, $0024(A0)
		move.l  #Obj19_MapUnc_16412, $0004(A0) ; loc_16412
		move.w  #$63A0, $0002(A0)
		cmpi.b  #9, (Current_Zone).w;#oil_ocean_zone, (Current_Zone).w
		bne.s   loc_16258
		move.w  #$6300, $0002(A0)
loc_16258:
		bsr.w     J_Adjust2PArtPointer_02 ; loc_1645C
		move.b  #$04, $0001(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		lsr.w   #$03, D0
		andi.w  #$001E, D0
		lea     loc_1622E(PC, D0), A2
		move.b  (A2)+, $0019(A0)
		move.b  (A2)+, $001A(A0)
		move.b  #$04, $0018(A0)
		move.w  $0008(A0), $0030(A0)
		move.w  $000C(A0), $0032(A0)
		andi.b  #$0F, $0028(A0)
		cmpi.b  #$07, $0028(A0)
		bne.s   loc_162A0
		subi.w  #$00C0, $000C(A0)
loc_162A0:
		move.w  $0008(A0), -(A7)
		bsr.w     loc_162D0
		moveq   #$00, D1
		move.b  $0019(A0), D1
		move.w  #$0010, D3
		move.w  (A7)+, D4
		bsr.w     J_PlatformObject
		move.w  $0030(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.w    J_DeleteObject_0C       ; loc_16456
		bra.w     J_DisplaySprite_01      ; loc_16450
loc_162D0:
		moveq   #$00, D0
		move.b  $0028(A0), D0
		andi.w  #$000F, D0
		add.w   D0, D0
		move.w  loc_162E4(PC, D0), D1
		jmp     loc_162E4(PC, D1)
loc_162E4:
		dc.w    loc_16304-loc_162E4
		dc.w    loc_1630E-loc_162E4
		dc.w    loc_1632E-loc_162E4
		dc.w    loc_1634E-loc_162E4
		dc.w    loc_1635E-loc_162E4
		dc.w    loc_1637E-loc_162E4
		dc.w    loc_16380-loc_162E4
		dc.w    loc_16380-loc_162E4
		dc.w    loc_1639C-loc_162E4
		dc.w    loc_1639C-loc_162E4
		dc.w    loc_1639C-loc_162E4
		dc.w    loc_1639C-loc_162E4
		dc.w    loc_163D6-loc_162E4
		dc.w    loc_163D6-loc_162E4
		dc.w    loc_163D6-loc_162E4
		dc.w    loc_163D6-loc_162E4
loc_16304:
		move.b  (Oscillating_Data+8).w, D0
		move.w  #$0040, D1
		bra.s   loc_16316
loc_1630E:
		move.b  (Oscillating_Data+$C).w, D0
		move.w  #$0060, D1
loc_16316:
		btst    #$00, $0022(A0)
		beq.s   loc_16322
		neg.w   D0
		add.w   D1, D0
loc_16322:
		move.w  $0030(A0), D1
		sub.w   D0, D1
		move.w  D1, $0008(A0)
		rts
loc_1632E:
		move.b  (Oscillating_Data+$1C).w, D0
		move.w  #$0080, D1
		btst    #$00, $0022(A0)
		beq.s   loc_16342
		neg.w   D0
		add.w   D1, D0
loc_16342:
		move.w  $0032(A0), D1
		sub.w   D0, D1
		move.w  D1, $000C(A0)
		rts
loc_1634E:
		move.b  $0022(A0), D0
		andi.b  #$18, D0
		beq.s   loc_1635C
		addq.b  #$01, $0028(A0)
loc_1635C:
		rts
loc_1635E:
		bsr.w     J_SpeedToPos_01         ; loc_16462
		moveq   #$08, D1
		move.w  $0032(A0), D0
		subi.w  #$0060, D0
		cmp.w   $000C(A0), D0
		bcc.s   loc_16374
		neg.w   D1
loc_16374:
		add.w   D1, $0012(A0)
		bne.s   loc_1637E
		addq.b  #$01, $0028(A0)
loc_1637E:
		rts
loc_16380:
		bsr.w     J_SpeedToPos_01         ; loc_16462
		moveq   #$08, D1
		move.w  $0032(A0), D0
		subi.w  #$0060, D0
		cmp.w   $000C(A0), D0
		bcc.s   loc_16396
		neg.w   D1
loc_16396:
		add.w   D1, $0012(A0)
		rts
loc_1639C:
		move.b  (Oscillating_Data+$38).w, D1
		subi.b  #$40, D1
		ext.w   D1
		move.b  (Oscillating_Data+$3C).w, D2
		subi.b  #$40, D2
		ext.w   D2
		btst    #$02, D0
		beq.s   loc_163BA
		neg.w   D1
		neg.w   D2
loc_163BA:
		btst    #$01, D0
		beq.s   loc_163C4
		neg.w   D1
		exg.l   D1, D2
loc_163C4:
		add.w   $0030(A0), D1
		move.w  D1, $0008(A0)
		add.w   $0032(A0), D2
		move.w  D2, $000C(A0)
		rts
loc_163D6:
		move.b  (Oscillating_Data+$38).w, D1
		subi.b  #$40, D1
		ext.w   D1
		move.b  (Oscillating_Data+$3C).w, D2
		subi.b  #$40, D2
		ext.w   D2
		btst    #$02, D0
		beq.s   loc_163F4
		neg.w   D1
		neg.w   D2
loc_163F4:
		btst    #$01, D0
		beq.s   loc_163FE
		neg.w   D1
		exg.l   D1, D2
loc_163FE:
		neg.w   D1
		add.w   $0030(A0), D1
		move.w  D1, $0008(A0)
		add.w   $0032(A0), D2
		move.w  D2, $000C(A0)
		rts
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj19_MapUnc_16412:	dc.w wrd_154AE-Obj19_MapUnc_16412 ; DATA XREF: ROM:000152D8o
					; ROM:Map_Obj19o ...
wrd_154AE:	dc.w 2			; DATA XREF: ROM:Map_Obj19o
		dc.w $F00F,    0,    0,$FFE0; 0
		dc.w $F00F, $800, $800,	   0; 4;	incbin	"mappings/sprite/obj19.bin"
; ===========================================================================
		nop

J_DisplaySprite_01: ; loc_16450:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_0C: ; loc_16456:
		jmp     DeleteObject            ; (loc_D3B4)
J_Adjust2PArtPointer_02: ; loc_1645C:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SpeedToPos_01: ; loc_16462:
		jmp     SpeedToPos              ; (loc_D27A)   
J_PlatformObject:
		jmp		PlatformObject
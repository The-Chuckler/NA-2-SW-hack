;=============================================================================== 
; Object 0x65 - Metropolis - Platform / Platform Over Gears
; [ Begin ]		         
;===============================================================================		 
;Obj_0x65_Platform: ; loc_1AA74:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1AA82(PC, D0), D1
		jmp     loc_1AA82(PC, D1)
loc_1AA82:
		dc.w    loc_1AA9A-loc_1AA82
		dc.w    loc_1ABB0-loc_1AA82
		dc.w    loc_1AE08-loc_1AA82
		dc.w    loc_1AE26-loc_1AA82
loc_1AA8A:
		dc.b    $40, $0C, $80, $01, $20, $0C, $40, $03, $10, $10, $20, $00, $40, $0C, $80, $07
loc_1AA9A:
		addq.b  #$02, $0024(A0)
		move.l  #Obj65_MapUnc_1AE2C, $0004(A0) ; loc_1AE2C
		move.w  #$6000, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_11 ; loc_1AEB0
		ori.b   #$04, $0001(A0)
		move.b  #$04, $0018(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		lsr.w   #$02, D0
		andi.w  #$001C, D0
		lea     loc_1AA8A(PC, D0), A3
		move.b  (A3)+, $0019(A0)
		move.b  (A3)+, $0016(A0)
		lsr.w   #$02, D0
		move.b  D0, $001A(A0)
		cmpi.b  #$01, D0
		bne.s   loc_1AAE6
		bset    #$07, $0022(A0)
loc_1AAE6:
		cmpi.b  #$02, D0
		bne.s   loc_1AB02
		addq.b  #$04, $0024(A0)
		move.l  #Obj65_MapUnc_1AE68, $0004(A0) ; loc_1AE68
		move.w  #$655F, $0002(A0)
		bra.w     loc_1AE26
loc_1AB02:
		move.w  $0008(A0), $0034(A0)
		move.w  $000C(A0), $0030(A0)
		moveq   #$00, D0
		move.b  (A3)+, D0
		move.w  D0, $003C(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		bpl.w    loc_1ABAA
		andi.b  #$0F, D0
		move.b  D0, $003E(A0)
		move.b  (A3), $0028(A0)
		cmpi.b  #$07, (A3)
		bne.s   loc_1AB38
		move.w  $003C(A0), $003A(A0)
loc_1AB38:
		bsr.w     J_SingleObjLoad2_04  ; loc_1AEAA
		bne.s   loc_1AB98
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		addq.b  #$04, $0024(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $000C(A0), $000C(A1)
		addi.w  #$FFB4, $0008(A1)
		addi.w  #$0014, $000C(A1)
		btst    #$00, $0022(A0)
		bne.s   loc_1AB74
		subi.w  #$FFE8, $0008(A1)
		bset    #$00, $0001(A1)
loc_1AB74:
		move.l  #Obj65_MapUnc_1AE68, $0004(A1) ; loc_1AE68
		move.w  #$655F, $0002(A1)
		ori.b   #$04, $0001(A1)
		move.b  #$10, $0019(A1)
		move.b  #$04, $0018(A1)
		move.l  A0, $003C(A1)
loc_1AB98:
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   loc_1ABAA
		bclr    #$07, $02(A2, D0)
loc_1ABAA:
		andi.b  #$0F, $0028(A0)
loc_1ABB0:
		move.w  $0008(A0), -(A7)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		add.w   D0, D0
		move.w  loc_1AC0E(PC, D0), D1
		jsr     loc_1AC0E(PC, D1)
		move.w  (A7)+, D4
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		moveq   #$00, D2
		move.b  $0016(A0), D2
		move.w  D2, D3
		addq.w  #$01, D3
		bsr.w     J_SolidObject_07        ; loc_1AEB6
		move.w  $0034(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1ABF6
		jmp     DisplaySprite           ; (loc_D3C2)
loc_1ABF6:
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   J_DeleteObject_18       ; loc_1AC08
		bclr    #$07, $02(A2, D0)
J_DeleteObject_18: ; loc_1AC08:
		jmp     DeleteObject            ; (loc_D3B4)
loc_1AC0E:
		dc.w    loc_1AC1E-loc_1AC0E
		dc.w    loc_1AC34-loc_1AC0E
		dc.w    loc_1ACC0-loc_1AC0E
		dc.w    loc_1AD1C-loc_1AC0E
		dc.w    loc_1ADC0-loc_1AC0E
		dc.w    loc_1ADCE-loc_1AC0E
		dc.w    loc_1AC20-loc_1AC0E
		dc.w    loc_1ACA0-loc_1AC0E
loc_1AC1E:
		rts
loc_1AC20:
		tst.b   $0038(A0)
		bne.s   loc_1AC32
		subq.w  #$01, $0036(A0)
		bne.s   loc_1AC60
		move.b  #$01, $0038(A0)
loc_1AC32:
		bra.s   loc_1AC52
loc_1AC34:
		tst.b   $0038(A0)
		bne.s   loc_1AC52
		lea     (ButtonVine_Trigger).w, A2
		moveq   #$00, D0
		move.b  $003E(A0), D0
		btst    #$00, $00(A2, D0)
		beq.s   loc_1AC60
		move.b  #$01, $0038(A0)
loc_1AC52:
		move.w  $003C(A0), D0
		cmp.w   $003A(A0), D0
		beq.s   loc_1AC7E
		addq.w  #$02, $003A(A0)
loc_1AC60:
		move.w  $003A(A0), D0
		btst    #$00, $0022(A0)
		beq.s   loc_1AC72
		neg.w   D0
		addi.w  #$0080, D0
loc_1AC72:
		move.w  $0034(A0), D1
		sub.w   D0, D1
		move.w  D1, $0008(A0)
		rts
loc_1AC7E:
		addq.b  #$01, $0028(A0)
		move.w  #$00B4, $0036(A0)
		clr.b   $0038(A0)
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   loc_1AC60
		bset    #$00, $02(A2, D0)
		bra.s   loc_1AC60
loc_1ACA0:
		tst.b   $0038(A0)
		bne.s   loc_1ACBE
		lea     (ButtonVine_Trigger).w, A2
		moveq   #$00, D0
		move.b  $003E(A0), D0
		btst    #$00, $00(A2, D0)
		beq.s   loc_1ACDC
		move.b  #$01, $0038(A0)
loc_1ACBE:
		bra.s   loc_1ACD2
loc_1ACC0:
		tst.b   $0038(A0)
		bne.s   loc_1ACD2
		subq.w  #$01, $0036(A0)
		bne.s   loc_1ACDC
		move.b  #$01, $0038(A0)
loc_1ACD2:
		tst.w   $003A(A0)
		beq.s   loc_1ACFA
		subq.w  #$02, $003A(A0)
loc_1ACDC:
		move.w  $003A(A0), D0
		btst    #$00, $0022(A0)
		beq.s   loc_1ACEE
		neg.w   D0
		addi.w  #$0080, D0
loc_1ACEE:
		move.w  $0034(A0), D1
		sub.w   D0, D1
		move.w  D1, $0008(A0)
		rts
loc_1ACFA:
		subq.b  #$01, $0028(A0)
		move.w  #$00B4, $0036(A0)
		clr.b   $0038(A0)
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   loc_1ACDC
		bclr    #$00, $02(A2, D0)
		bra.s   loc_1ACDC
loc_1AD1C:
		move.w  $0034(A0), D4
		move.w  D4, D5
		btst    #$00, $0022(A0)
		bne.s   loc_1AD34
		subi.w  #$0020, D4
		addi.w  #$0060, D5
		bra.s   loc_1AD3C
loc_1AD34:
		subi.w  #$00A0, D4
		subi.w  #$0020, D5
loc_1AD3C:
		move.w  $000C(A0), D2
		move.w  D2, D3
		subi.w  #$0010, D2
		addi.w  #$0040, D3
		moveq   #$00, D1
		move.w  ($FFFFB008).w, D0
		cmp.w   D4, D0
		bcs.s   loc_1AD66
		cmp.w   D5, D0
		bcc.s   loc_1AD66
		move.w  ($FFFFB00C).w, D0
		cmp.w   D2, D0
		bcs.s   loc_1AD66
		cmp.w   D3, D0
		bcc.s   loc_1AD66
		moveq   #$01, D1
loc_1AD66:
		move.w  ($FFFFB048).w, D0
		cmp.w   D4, D0
		bcs.s   loc_1AD80
		cmp.w   D5, D0
		bcc.s   loc_1AD80
		move.w  ($FFFFB04C).w, D0
		cmp.w   D2, D0
		bcs.s   loc_1AD80
		cmp.w   D3, D0
		bcc.s   loc_1AD80
		moveq   #$01, D1
loc_1AD80:
		tst.b   D1
		beq.s   loc_1AD96
		move.w  $003C(A0), D0
		cmp.w   $003A(A0), D0
		beq.s   loc_1ADBE
		addi.w  #$0010, $003A(A0)
		bra.s   loc_1ADA2
loc_1AD96:
		tst.w   $003A(A0)
		beq.s   loc_1ADA2
		subi.w  #$0010, $003A(A0)
loc_1ADA2:
		move.w  $003A(A0), D0
		btst    #$00, $0022(A0)
		beq.s   loc_1ADB4
		neg.w   D0
		addi.w  #$0040, D0
loc_1ADB4:
		move.w  $0034(A0), D1
		sub.w   D0, D1
		move.w  D1, $0008(A0)
loc_1ADBE:
		rts
loc_1ADC0:
		btst    #$03, $0022(A0)
		beq.s   loc_1ADCC
		addq.b  #$01, $0028(A0)
loc_1ADCC:
		rts
loc_1ADCE:
		tst.b   $0038(A0)
		bne.s   loc_1ADE8
		addq.w  #$02, $0008(A0)
		cmpi.w  #$1B40, $0008(A0)
		bne.s   loc_1ADFA
		move.b  #$01, $0038(A0)
		bra.s   loc_1ADFA
loc_1ADE8:
		subq.w  #$02, $0008(A0)
		cmpi.w  #$1800, $0008(A0)
		bne.s   loc_1ADFA
		move.b  #$00, $0038(A0)
loc_1ADFA:
		move.w  $0008(A0), $0034(A0)
		move.w  $0008(A0), (MTZ_Platform_Cog_X).w
		rts
loc_1AE08:
		move.l  $003C(A0), A1
		move.w  $003A(A1), D0
loc_1AE10:		
		andi.w  #$0007, D0
		move.b  loc_1AE1E(PC, D0), $001A(A0)
		bra.w     J_MarkObjGone_0E        ; loc_1AEA4    
loc_1AE1E:
		dc.b    $00, $00, $02, $02, $02, $01, $01, $01
loc_1AE26:
		move.w  (MTZ_Platform_Cog_X).w, D0
		bra.s   loc_1AE10  
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
;Obj65_MapUnc_1AE2C:	incbin	"mappings/sprite/obj65_a.bin"
;Obj65_MapUnc_1AE68:	incbin	"mappings/sprite/obj65_b.bin"

;=============================================================================== 
; Object 0x65 - Metropolis - Platform Over Gears
; [ End ]		         
;===============================================================================		  
J_MarkObjGone_0E: ; loc_1AEA4:
		jmp     MarkObjGone             ; (loc_D2A0)
J_SingleObjLoad2_04: ; loc_1AEAA:
		jmp     SingleObjLoad2      ; (loc_E788)
J_Adjust2PArtPointer_11: ; loc_1AEB0:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SolidObject_07: ; loc_1AEB6:
		jmp     SolidObject             ; (loc_F4A0)     
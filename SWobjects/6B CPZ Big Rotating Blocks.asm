;=============================================================================== 
; Object 0x6B - Metropolis Platforms / Chemical Plant - Block
; [ Begin ]		         
;===============================================================================   
;Obj_0x6B_Mz_Platform: ; Obj_0x6B_Block: ; loc_1BCEC:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1BCFA(PC, D0), D1
		jmp     loc_1BCFA(PC, D1)
loc_1BCFA:
		dc.w    loc_1BD06-loc_1BCFA
		dc.w    loc_1BD88-loc_1BCFA
loc_1BCFE:
		dc.b    $20, $0C, $01, $00, $10, $10, $00, $00
loc_1BD06:
		addq.b  #$02, $0024(A0)
		move.l  #Obj65_MapUnc_1AE2C, $0004(A0) ; loc_1AE2C
		move.w  #$6000, $0002(A0)
		cmpi.b  #2, (Current_Zone).w;#chemical_plant_zone, (Current_Zone).w
		bne.s   loc_1BD2E
		move.l  #Obj6B_MapUnc_1BF4A, $0004(A0)       ; loc_1BF4A
		move.w  #$6418, $0002(A0)
loc_1BD2E:
		bsr.w     J_Adjust2PArtPointer_16 ; loc_1BF58
		move.b  #$04, $0001(A0)
		move.b  #$03, $0018(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		lsr.w   #$02, D0
		andi.w  #$001C, D0
		lea     loc_1BCFE(PC, D0), A2
		move.b  (A2)+, $0019(A0)
		move.b  (A2)+, $0016(A0)
		move.b  (A2)+, $001A(A0)
		move.w  $0008(A0), $0034(A0)
		move.w  $000C(A0), $0030(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		andi.w  #$000F, D0
		subq.w  #$08, D0
		bcs.s   loc_1BD88
		lsl.w   #$02, D0
		lea     (Oscillating_Data+$2A).w, A2
		lea     $00(A2, D0), A2
		tst.w   (A2)
		bpl.s   loc_1BD88
		bchg    #0, $0022(A0)
loc_1BD88:
		move.w  $0008(A0), -(A7)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		andi.w  #$000F, D0
		add.w   D0, D0
		move.w  loc_1BDC8(PC, D0), D1
		jsr     loc_1BDC8(PC, D1)
		move.w  (A7)+, D4
		tst.b   $0001(A0)
		bpl.s   loc_1BDC0
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		moveq   #$00, D2
		move.b  $0016(A0), D2
		move.w  D2, D3
		addq.w  #$01, D3
		bsr.w     J_SolidObject_0B        ; loc_1BF5E
loc_1BDC0:
		move.w  $0034(A0), D0
		bra.w     loc_1BF64
loc_1BDC8:
		dc.w    loc_1BDE0-loc_1BDC8
		dc.w    loc_1BDE2-loc_1BDC8
		dc.w    loc_1BDEE-loc_1BDC8
		dc.w    loc_1BE10-loc_1BDC8
		dc.w    loc_1BE1C-loc_1BDC8
		dc.w    loc_1BE3E-loc_1BDC8
		dc.w    loc_1BE5C-loc_1BDC8
		dc.w    loc_1BDE0-loc_1BDC8
		dc.w    loc_1BE8A-loc_1BDC8
		dc.w    loc_1BE9C-loc_1BDC8
		dc.w    loc_1BEAC-loc_1BDC8
		dc.w    loc_1BEBC-loc_1BDC8
loc_1BDE0:
		rts
loc_1BDE2:
		move.w  #$0040, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+8).w, D0
		bra.s   loc_1BDF8
loc_1BDEE:
		move.w  #$0080, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+$1C).w, D0
loc_1BDF8:
		btst    #$00, $0022(A0)
		beq.s   loc_1BE04
		neg.w   D0
		add.w   D1, D0
loc_1BE04:
		move.w  $0034(A0), D1
		sub.w   D0, D1
		move.w  D1, $0008(A0)
		rts
loc_1BE10:
		move.w  #$0040, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+8).w, D0
		bra.s   loc_1BE26
loc_1BE1C:
		move.w  #$0080, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+$1C).w, D0
loc_1BE26:
		btst    #$00, $0022(A0)
		beq.s   loc_1BE32
		neg.w   D0
		add.w   D1, D0
loc_1BE32:
		move.w  $0030(A0), D1
		sub.w   D0, D1
		move.w  D1, $000C(A0)
		rts
loc_1BE3E:
		move.b  (Oscillating_Data).w, D0
		lsr.w   #$01, D0
		add.w   $0030(A0), D0
		move.w  D0, $000C(A0)
		move.b  $0022(A0), D1
		andi.b  #$18, D1
		beq.s   loc_1BE5A
		addq.b  #$01, $0028(A0)
loc_1BE5A:
		rts
loc_1BE5C:
		move.l  $000C(A0), D3
		move.w  $0012(A0), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D3, $000C(A0)
		addi.w  #$0008, $0012(A0)
		move.w  (Camera_Max_Y_pos_now).w, D0
		addi.w  #$00E0, D0
		cmp.w   $000C(A0), D0
		bcc.s   loc_1BE88
		move.b  #$00, $0028(A0)
loc_1BE88:
		rts
loc_1BE8A:
		move.w  #$0010, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+$28).w, D0
		lsr.w   #$01, D0
		move.w  (Oscillating_Data+$2A).w, D3
		bra.s   loc_1BECA
loc_1BE9C:
		move.w  #$0030, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+$2C).w, D0
		move.w  (Oscillating_Data+$2E).w, D3
		bra.s   loc_1BECA
loc_1BEAC:
		move.w  #$0050, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+$30).w, D0
		move.w  (Oscillating_Data+$32).w, D3
		bra.s   loc_1BECA
loc_1BEBC:
		move.w  #$0070, D1
		moveq   #$00, D0
		move.b  (Oscillating_Data+$34).w, D0
		move.w  (Oscillating_Data+$36).w, D3
loc_1BECA:
		tst.w   D3
		bne.s   loc_1BED8
		addq.b  #$01, $0022(A0)
		andi.b  #$03, $0022(A0)
loc_1BED8:
		move.b  $0022(A0), D2
		andi.b  #$03, D2
		bne.s   loc_1BEF8
		sub.w   D1, D0
		add.w   $0034(A0), D0
		move.w  D0, $0008(A0)
		neg.w   D1
		add.w   $0030(A0), D1
		move.w  D1, $000C(A0)
		rts
loc_1BEF8:
		subq.b  #$01, D2
		bne.s   loc_1BF16
		subq.w  #$01, D1
		sub.w   D1, D0
		neg.w   D0
		add.w   $0030(A0), D0
		move.w  D0, $000C(A0)
		addq.w  #$01, D1
		add.w   $0034(A0), D1
		move.w  D1, $0008(A0)
		rts
loc_1BF16:
		subq.b  #$01, D2
		bne.s   loc_1BF34
		subq.w  #$01, D1
		sub.w   D1, D0
		neg.w   D0
		add.w   $0034(A0), D0
		move.w  D0, $0008(A0)
		addq.w  #$01, D1
		add.w   $0030(A0), D1
		move.w  D1, $000C(A0)
		rts
loc_1BF34:
		sub.w   D1, D0
		add.w   $0030(A0), D0
		move.w  D0, $000C(A0)
		neg.w   D1
		add.w   $0034(A0), D1
		move.w  D1, $0008(A0)
		rts 
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
;Obj6B_MapUnc_1BF4A:	BINCLUDE	"mappings/sprite/obj6B.bin"
; ===========================================================================
		nop

J_Adjust2PArtPointer_16: ; loc_1BF58:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SolidObject_0B: ; loc_1BF5E:
		jmp     SolidObject             ; (loc_F4A0)
loc_1BF64:
		jmp     (loc_D2D8)    
;		dc.w    $0000		   ; Filler      
Obj65_MapUnc_1AE2C:	incbin	"mappings/sprite/obj65_a.bin"
Obj65_MapUnc_1AE68:	incbin	"mappings/sprite/obj65_b.bin"
Camera_Max_Y_pos_now:	equ		$FFFFEECE
Oscillating_Data:	equ	$FFFFFE60
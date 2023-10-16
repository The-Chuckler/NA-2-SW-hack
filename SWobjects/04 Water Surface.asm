; ---------------------------------------------------------------------------
; Object 04 - Surface of the water - water surface
; ---------------------------------------------------------------------------
; Sprite_15090: Obj_0x04:
;Obj04:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	Obj04_Index(pc,d0.w),d1
		jmp	Obj04_Index(pc,d1.w)
; ===========================================================================
; off_1509E:
Obj04_Index:;	offsetTable
		dc.w	Obj04_Init-Obj04_Index;		offsetTableEntry.w Obj04_Init
		dc.w	Obj04_Action-Obj04_Index;offsetTableEntry.w Obj04_Action
		dc.w	Obj04_Action2-Obj04_Index;offsetTableEntry.w Obj04_Action2
; ===========================================================================
; loc_150A4:
Obj04_Init:
		addq.b	#2,$24(a0)	; => Obj04_Action
		move.l	#Obj04_MapUnc_151C2,4(a0)
		move.w	#$8400,2(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,1(a0)
		move.b	#$80,$19(a0)
		move.w	8(a0),$30(a0)
		cmpi.b	#$A,(Current_Zone);.w#neo_green_hill_zone,(Current_Zone).w
		bne.s	Obj04_Action
		addq.b	#2,$24(a0)	; => Obj04_Action2
		move.l	#Obj04_MapUnc_152B2,4(a0)
		bra.w	Obj04_Action2
; ===========================================================================
; loc_150E4:
Obj04_Action:
		move.w	(WaterHeight).w,d1;(Water_Level_1).w,d1
		move.w	d1,$C(a0)
		tst.b	$32(a0)
		bne.s	Obj04_Animate
		btst	#7,(Ctrl_1_Press).w	; is the Start button pressed?
		beq.s	Obj04_Display		; if not, branch
		addq.b	#3,$1A(a0)		; use different frames
		move.b	#1,$32(a0)		; stop animation
		bra.s	Obj04_Display
; ===========================================================================
; loc_15106:
Obj04_Animate:
		tst.w	($FFFFF63A).w;(Game_paused).w		; if the game paused?
		bne.s	Obj04_Display		; if yes, branch
		move.b	#0,$32(a0)		; resume animation
		subq.b	#3,$1A(a0)		; use normal frames
; loc_15116:
Obj04_Display:
		lea	(Ani_obj04).l,a1
		moveq	#0,d1
		move.b	$1B(a0),d1
		move.b	(a1,d1.w),$1A(a0)
		addq.b	#1,$1B(a0)
		andi.b	#$3F,$1B(a0)
		bra.w	J_DisplaySprite_00
; ===========================================================================
; water sprite animation 'script' (custom format for this object)
; byte_15136:
Ani_obj04:	dc.b	0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1
		dc.b	1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
		dc.b	2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1
		dc.b	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
		even
; ===========================================================================
; loc_15176:
Obj04_Action2:
		move.w	(WaterHeight).w,d1;move.w	(Water_Level_1).w,d1
		move.w	d1,$C(a0)
		tst.b	$32(a0)
		bne.s	Obj04_Animate2
		btst	#7,(Ctrl_1_Press).w	; is the Start button pressed?
		beq.s	loc_151A8		; if not, branch
		addq.b	#2,$1A(a0)		; use different frames
		move.b	#1,$32(a0)		; stop animation
		bra.s	loc_151BE
; ===========================================================================
; loc_15198:
Obj04_Animate2:
		tst.w	($FFFFF63A).w;(Game_paused).w		; is the game paused?
		bne.s	loc_151BE		; if yes, branch
		move.b	#0,$32(a0)		; resume animation
		subq.b	#2,$1A(a0)		; use normal frames

loc_151A8:
		subq.b	#1,$1E(a0)
		bpl.s	loc_151BE
		move.b	#5,$1E(a0)
		addq.b	#1,$1A(a0)
		andi.b	#1,$1A(a0)

loc_151BE:
		bra.w	J_DisplaySprite_00
; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj04_MapUnc_151C2:	incbin	"mappings/sprite/obj04_a.bin"
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj04_MapUnc_152B2:	incbin	"mappings/sprite/obj04_b.bin"
J_DisplaySprite_00: ; loc_15720:
		jmp     DisplaySprite           ; loc_D3C2
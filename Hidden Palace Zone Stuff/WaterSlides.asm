WaterSlides:
	lea	(MainCharacter).w,a1 ; a1=character
	move.b	(Ctrl_1_Held_Logical).w,d2
	bsr.s	+
	lea	(Sidekick).w,a1 ; a1=character
	move.b	(Ctrl_2_Held_Logical).w,d2
+
	btst	#1,status(a1)
	bne.s	+
	move.w	y_pos(a1),d0
	add.w	d0,d0
	andi.w	#$F00,d0
	move.w	x_pos(a1),d1
	lsr.w	#7,d1
	andi.w	#$7F,d1
	add.w	d1,d0
	lea	(Level_Layout).w,a2
	move.b	(a2,d0.w),d0
	lea	WaterSlides_Chunks_End(pc),a2

	moveq	#WaterSlides_Chunks_End-WaterSlides_Chunks-1,d1
-	cmp.b	-(a2),d0
	dbeq	d1,-

	beq.s	WaterSlides_4712
+
    if status_sec_isSliding = 7
	tst.b	status_secondary(a1)
	bpl.s	+	; rts
    else
	btst	#status_sec_isSliding,status_secondary(a1)
	beq.s	+	; rts
    endif
	move.w	#5,move_lock(a1)
	andi.b	#(~status_sec_isSliding_mask)&$FF,status_secondary(a1)
+	rts
; ===========================================================================

WaterSlides_4712:
	lea	(WaterSlides_Speeds).l,a2
	move.b	(a2,d1.w),d0
	beq.s	WaterSlides_476E
	move.b	inertia(a1),d1
	tst.b	d0
	bpl.s	+
	cmp.b	d0,d1
	ble.s	++
	subi.w	#$40,inertia(a1)
	bra.s	++
; ===========================================================================
+
	cmp.b	d0,d1
	bge.s	+
	addi.w	#$40,inertia(a1)
+
	bclr	#0,status(a1)
	tst.b	d1
	bpl.s	+
	bset	#0,status(a1)
+
	move.b	#AniIDSonAni_Slide,anim(a1)
	ori.b	#status_sec_isSliding_mask,status_secondary(a1)
	move.b	(Vint_runcount+3).w,d0
	andi.b	#$1F,d0
	bne.s	+	; rts
	move.w	#SndID_OilSlide,d0
	jsr	(PlaySound).l
+
	rts
; ===========================================================================

WaterSlides_476E:
	move.w	#4,d1
	move.w	inertia(a1),d0
	btst	#button_left,d2
	beq.s	+
	move.b	#AniIDSonAni_Walk,anim(a1)
	bset	#0,status(a1)
	sub.w	d1,d0
	tst.w	d0
	bpl.s	+
	sub.w	d1,d0
+
	btst	#button_right,d2
	beq.s	+
	move.b	#AniIDSonAni_Walk,anim(a1)
	bclr	#0,status(a1)
	add.w	d1,d0
	tst.w	d0
	bmi.s	+
	add.w	d1,d0
+
	move.w	#4,d1
	tst.w	d0
	beq.s	+++
	bmi.s	++
	sub.w	d1,d0
	bhi.s	+
	move.w	#0,d0
	move.b	#AniIDSonAni_Wait,anim(a1)
+	bra.s	++
; ===========================================================================
+
	add.w	d1,d0
	bhi.s	+
	move.w	#0,d0
	move.b	#AniIDSonAni_Wait,anim(a1)
+
	move.w	d0,inertia(a1)
	ori.b	#status_sec_isSliding_mask,status_secondary(a1)
	rts
; End of function WaterSlides

; ===========================================================================
WaterSlides_Speeds:
	dc.b  10, 10, 10, 10, 10, 10, 10
; These are the IDs of the chunks where Sonic and Tails will slide
WaterSlides_Chunks:
	dc.b $60,$61,$62,$63,$64,$72,$73
WaterSlides_Chunks_End:
	even
LevelSelect_TextLoad:			; CODE XREF: ROM:000034DEp
					; LevelSelect_Controls+44p ...
		lea	(LevelSelect_Text).l,a1
		lea	(vdp_data_port).l,a6
		move.l	#$608C0003,d4;#$62100003,d4
		move.w	#$8680,d3
		moveq	#$16,d1;#$14,d1

loc_3794:				; CODE XREF: LevelSelect_TextLoad+26j
		move.l	d4,4(a6)
		bsr.w	sub_381C
		addi.l	#$800000,d4
		dbf	d1,loc_3794
		moveq	#0,d0
		move.w	($FFFFFF82).w,d0
		move.w	d0,d1
		move.l	#$62100003,d4
		lsl.w	#7,d0
		swap	d0
		add.l	d0,d4
		lea	(LevelSelect_Text).l,a1
		lsl.w	#3,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		adda.w	d1,a1
		move.w	#$C680,d3
		move.l	d4,4(a6)
		bsr.w	sub_381C
		move.w	#$8680,d3
		cmpi.w	#$14,($FFFFFF82).w
		bne.s	loc_37E6
		move.w	#$C680,d3

loc_37E6:				; CODE XREF: LevelSelect_TextLoad+64j
		move.l	#$6C300003,(vdp_control_port).l
		move.w	($FFFFFF84).w,d0
		addi.w	#$80,d0	; '€'
		move.b	d0,d2
		lsr.b	#4,d0
		bsr.w	sub_3808
		move.b	d2,d0
		bsr.w	sub_3808
		rts
; End of function LevelSelect_TextLoad
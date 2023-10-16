;Sonic_CheckSpindash:
		tst.b	$39(a0)
		bne.s	Sonic_UpdateSpindash
		cmpi.b	#8,$1C(a0)
		bne.s	locret_10394
		move.b	($FFFFF603).w,d0
		andi.b	#$70,d0
		beq.w	locret_10394
		move.b	#9,$1C(a0)
		move.w	#$BE,d0
		jsr	(PlaySound_Special).l
		addq.l	#4,sp
		move.b	#1,$39(a0)

locret_10394:
		rts
; ===========================================================================
; loc_10396:
Sonic_UpdateSpindash:
		move.b	($FFFFF602).w,d0
		btst	#1,d0
		bne.s	Sonic_ChargingSpindash

		; unleash the charged spindash and start rolling quickly:
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)
		addq.w	#5,$C(a0)	; add the difference between Sonic's rolling and standing heights
		move.b	#0,$39(a0)
		move.w	#$2000,($FFFFEED0).w
		move.w	#$800,$14(a0)
		btst	#0,$22(a0)
		beq.s	loc_103D4
		neg.w	$14(a0)

loc_103D4:
		bset	#2,$22(a0)
		rts
; ===========================================================================
; loc_103DC:
Sonic_ChargingSpindash:
		move.b	($FFFFF603).w,d0
		andi.b	#$70,d0	
		beq.w	loc_103EA
		nop

loc_103EA:
		addq.l	#4,sp
		rts
; End of function Sonic_CheckSpindash
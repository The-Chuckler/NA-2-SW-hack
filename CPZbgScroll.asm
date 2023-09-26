		move.w	($FFFFEEB0).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.w	($FFFFEEB2).w,d5
		ext.l	d5
		asl.l	#6,d5
		bsr.w	ScrollBlock1
		move.w	($FFFFEE0C).w,($FFFFF618).w
		lea	($FFFFE000).w,a1
		move.w	#$DF,d1	; 'ß'
		move.w	($FFFFEE00).w,d0
		neg.w	d0
		swap	d0
		move.w	($FFFFEE08).w,d0
		neg.w	d0
;		move.l	d0,(a1)+
;		dbf	d1,loc_6026
;		rts
;This is just the basic NA scrolling cause i don't wanna fix the sw one
;loc_6110:				; CODE XREF: Deform_TitleScreen+66j
; ===========================================================================
; ----------------------------------------------------------------------------
; Object 4F - Dinobot from HPZ
; ----------------------------------------------------------------------------

Obj4F:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	loc_28E76(pc,d0),d1
		jmp	loc_28E76(pc,d1)
loc_28E76:
		dc.w	loc_28E7C-loc_28E76
		dc.w	loc_28ED2-loc_28E76
		dc.w	loc_28F74-loc_28E76
loc_28E7C:
		move.l	#Dinobot_Mappings,4(a0) 
		move.w	#make_art_tile(ArtTile_ArtNem_Dinobot,0,0),art_tile(a0) 
		move.b	#4,1(a0)
		move.b	#4,$18(a0)
		move.b	#$10,$19(a0)
		move.b	#$10,$16(a0)
		move.b	#6,$17(a0)
		move.b	#$C,$20(a0)
		bsr	loc_28FBE
		jsr	ObjCheckFloorDist	
		tst.w	d1
		bpl.s	loc_28ED0
		add.w	d1,$C(a0)
		move.w	#0,$12(a0)
		addq.b	#2,$24(a0)
		bchg	#0,$22(a0)
loc_28ED0:
		rts
loc_28ED2:
		moveq	#0,d0
		move.b	$25(a0),d0
		move.w	loc_28F18(pc,d0),d1
		jsr	loc_28F18(pc,d1)
		lea	(Dinobot_Animate_Data),a1 
		bsr	loc_28FB8
		move.w	8(a0),d0
		and.w	#$FF80,d0
		sub.w	($FFFFF7DA).w,d0
		cmp.w	#$280,d0
		bhi	loc_28F02
		bra	loc_28FAC
loc_28F02:
		lea	($FFFFFC00).w,a2
		moveq	#0,d0
		move.b	$23(a0),d0
		beq.s	loc_28F14
		bclr	#7,2(a2,d0)
loc_28F14:
		bra	loc_28FB2
loc_28F18:
		dc.w	loc_28F1C-loc_28F18
		dc.w	loc_28F40-loc_28F18
loc_28F1C:
		subq.w	#1,$30(a0)
		bpl.s	loc_28F3E
		addq.b	#2,$25(a0)
		move.w	#$FF80,$10(a0)
		move.b	#1,$1C(a0)
		bchg	#0,$22(a0)
		bne.s	loc_28F3E
		neg.w	$10(a0)
loc_28F3E:
		rts
loc_28F40:
		bsr	loc_28FC4
		jsr	ObjCheckFloorDist	
		cmp.w	#$FFF8,d1
		blt.s	loc_28F5C
		cmp.w	#$C,d1
		bge.s	loc_28F5C
		add.w	d1,$C(a0)
		rts
loc_28F5C:
		subq.b	#2,$25(a0)
		move.w	#$3B,$30(a0)
		move.w	#0,$10(a0)
		move.b	#0,$1C(a0)
		rts
loc_28F74:
		bra	loc_28FB2
;-------------------------------------------------------------------------------
Dinobot_Animate_Data: 
		dc.w	loc_28F7C-Dinobot_Animate_Data
		dc.w	loc_28F7F-Dinobot_Animate_Data
loc_28F7C:
		dc.b	9,1,$FF
loc_28F7F:
		dc.b	9,0,1,2,1,$FF,$0	
;-------------------------------------------------------------------------------	
Dinobot_Mappings: 
		dc.w	loc_28F8C-Dinobot_Mappings
		dc.w	loc_28F96-Dinobot_Mappings
		dc.w	loc_28FA0-Dinobot_Mappings
loc_28F8C:
		dc.w	$1
		dc.l	$F00F0000,$FFF0
loc_28F96:
		dc.w	$1
		dc.l	$F00F0010,$8FFF0
loc_28FA0:
		dc.w	$1
		dc.l	$F00F0020,$10FFF0
                	
                cnop	0,4 ; Filler 
loc_28FAC:
		jmp	(DisplaySprite).l 
loc_28FB2:
		jmp	(DeleteObject).l 
loc_28FB8:
		jmp	(AnimateSprite).l
loc_28FBE:
		jmp	(ObjectMoveAndFall).l 
loc_28FC4:
		jmp	(ObjectMove).l 
		cnop	0,4 ; Filler
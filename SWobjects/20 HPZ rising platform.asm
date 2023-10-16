; ===========================================================================
; ----------------------------------------------------------------------------
; Object 62 - Floating Platform from Hidden Palace Zone (new)
; ----------------------------------------------------------------------------
Obj62:
	moveq	#0,d0
	move.b	routine(a0),d0
	move.w	Obj62_Index(pc,d0.w),d1
	jmp	Obj62_Index(pc,d1.w)
; ===========================================================================
; off_2032A
Obj62_Index:;	offsetTable
		dc.w	Obj62_Init-Obj62_Index
		dc.w	Obj62_Main-Obj62_Index
;		offsetTableEntry.w Obj62_Init	; 0
;		offsetTableEntry.w Obj62_Main	; 2
; ===========================================================================
; loc_2032E:
Obj62_Init:
	addq.b	#2,routine(a0)
	move.l	#Obj62_MapUnc_20382,mappings(a0)
	move.w  $5384, $0002(A0);#$2374, $0002(A0);#$8680, $0002(A0);	move.w	#make_art_tile(ArtTile_ArtNem_Hpz_Unknown_Platform,0,0),art_tile(a0);$2384 seems right, or something replacing 2
	jsr	(Adjust2PArtPointer).l;, JmpToUP_Adjust2PArtPointer;was jsrto
	move.b	#4,render_flags(a0)
	move.b	#$2B,width_pixels(a0)
	move.b	#4,priority(a0)
	move.w	X_pos(a0),$30(a0);objoff_30(a0)
	move.w	y_pos(a0),$32(a0);objoff_32(a0)
	move.b	#$2B,width_pixels(a0)

; loc_20356:
Obj62_Main:
	move.w	x_pos(a0),-(sp)

	move.w	objoff_32(a0),d0
	cmp.w		y_pos(a0),d0
	bcs.s	Idunno1;+

	move.w	($FFFFF646).w,d0;(WaterHeight).w,d0;(Water_Level_1).w,d0
	cmp.w		y_pos(a0),d0
	bcs.s	Idunno1;+
	add.w		#$1,y_pos(a0)
	sub.l		#$8000,X_pos(a0)
Idunno1:;+
	move.w	($FFFFF646).w,d0;(WaterHeight).w,d0;(Water_Level_1).w,d0
	cmp.w		y_pos(a0),d0
	bhi.s	Idunno2;+
	sub.w		#$1,y_pos(a0)
	add.l		#$8000,X_pos(a0)
Idunno2:;+
	moveq	#0,d1
	move.b	width_pixels(a0),d1
	move.w	#$C,d3
	move.w	(sp)+,d4
	jsr	(PlatformObject).l;, JmpToUP_PlatformObject;was jsrto

	move.w	x_pos(a0),d0
	andi.w	#$FF80,d0
	sub.w	(Camera_X_pos_coarse).w,d0
	cmpi.w	#$280,d0
	bhi.w	JmpToUP_DeleteObject
	jmp	(DisplaySprite).l;, JmpToUP_DisplaySprite;was jmpto
; ===========================================================================
; -------------------------------------------------------------------------------
; sprite mappings (unused)
; -------------------------------------------------------------------------------
Obj62_MapUnc_20382:	incbin "mappings/sprite/UP_HPZ.bin"
; ===========================================================================

;    if gameRevision<2
;	nop
 ;   endif

;    if ~~removeJmpTos
JmpToUP_DisplaySprite: 
	jmp	(DisplaySprite).l
JmpToUP_DeleteObject: 
	jmp	(DeleteObject).l
JmpToUP_Adjust2PArtPointer: 
	jmp	(Adjust2PArtPointer).l
JmpToUP_PlatformObject: 
	jmp	(PlatformObject).l

;	align 4
;    else
;JmpToUP_DeleteObject 
;	jmp	(DeleteObject).l
;    endif
objoff_32:	equ	$32;	=	$32
X_pos:	equ	$0008
x_pos:	equ	$0008
y_pos:	equ	$000C
priority:	equ	$0018
mappings:	equ	$0004
width_pixels:	equ	$0019
render_flags:	equ	$0001
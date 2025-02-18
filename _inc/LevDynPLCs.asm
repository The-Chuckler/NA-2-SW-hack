; ---------------------------------------------------------------------------
; Subroutine to animate stage art
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; DynamicArtCues:
AniArt_Load:
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		add.w	d0,d0
		add.w	d0,d0
		move.w	DynArtCue_Index+2(pc,d0.w),d1
		lea	DynArtCue_Index(pc,d1.w),a2
		move.w	DynArtCue_Index(pc,d0.w),d0
		jmp	DynArtCue_Index(pc,d0.w)
; ---------------------------------------------------------------------------
;		rts
; End of function AniArt_Load

; ---------------------------------------------------------------------------
; ZONE ANIMATION PROCEDURES AND SCRIPTS
;
; Each zone gets two entries in this jump table. The first entry points to the
; zone's animation procedure (usually Dynamic_Null, AKA none). The second points
; to the zone's animation script.
;
; Seems like stage IDs were already being shifted, since listings for $07-$0F
; can be found, alongside HPZ's art listed from $08 (its ID in the final).
; ---------------------------------------------------------------------------
DynArtCue_Index:
		dc.w Dynamic_NullGHZ-DynArtCue_Index,AnimCue_EHZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_MTZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Normal-DynArtCue_Index,AnimCue_EHZ-DynArtCue_Index
		dc.w Dynamic_Normal-DynArtCue_Index,AnimCue_HPZ-DynArtCue_Index
		dc.w Dynamic_Normal-DynArtCue_Index,AnimCue_EHZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index; new cnz one
;		dc.w Dynamic_Normal-DynArtCue_Index,AnimCue_HPZ-DynArtCue_Index; for cnz... for some reason
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
		dc.w Dynamic_Null-DynArtCue_Index,AnimCue_CPZ-DynArtCue_Index
; ===========================================================================

Dynamic_Null:
		rts
; ===========================================================================

Dynamic_NullGHZ:
		rts
; ===========================================================================

Dynamic_Normal:
		lea	(Anim_Counters).w,a3
		move.w	(a2)+,d6	; Get number of scripts in list

loc_1AACA:
		subq.b	#1,(a3)		; Tick down frame duration
		bpl.s	loc_1AB10	; If frame isn't over, move on to next script

		moveq	#0,d0
		move.b	1(a3),d0	; Get current frame
		cmp.b	6(a2),d0	; Have we processed the last frame in the script?
		bcs.s	loc_1AAE0
		moveq	#0,d0		; If so, reset to first frame
		move.b	d0,1(a3)

loc_1AAE0:
		addq.b	#1,1(a3)	; Consider this frame processed; set counter to next frame
		move.b	(a2),(a3)	; Set frame duration to global duration value
		bpl.s	loc_1AAEE
		; If script uses per-frame durations, use those instead
		add.w	d0,d0
		move.b	9(a2,d0.w),(a3)	; Set frame duration to current frame's duration value

loc_1AAEE:
		; Prepare for DMA transfer
		; Get relative address of frame's art
		move.b	8(a2,d0.w),d0	; Get tile ID
		lsl.w	#5,d0		; Turn it into an offset
		; Get VRAM destination address
		move.w	4(a2),d2
		; Get ROM source address
		move.l	(a2),d1		; Get start address of animated tile art
		andi.l	#$FFFFFF,d1
		add.l	d0,d1		; Offset into art, to get the address of new frame
		; Get size of art to be transferred
		moveq	#0,d3
		move.b	7(a2),d3
		lsl.w	#4,d3		; Turn it into actual size (in words)
		; Use d1, d2 and d3 to queue art for transfer
		jsr	(QueueDMATransfer).l

loc_1AB10:
		move.b	6(a2),d0	; Get total size of frame data
		tst.b	(a2)		; Is per-frame duration data present?
		bpl.s	loc_1AB1A	; If not, keep the current size; it's correct
		add.b	d0,d0		; Double size to account for the additional frame duration data

loc_1AB1A:
		addq.b	#1,d0
		andi.w	#$FE,d0		; Round to next even address, if it isn't already
		lea	8(a2,d0.w),a2	; Advance to next script in list
		addq.w	#2,a3		; Advance to next script's slot in a3 (usually Anim_Counters)
		dbf	d6,loc_1AACA
		rts
; ===========================================================================
AnimCue_EHZ:	dc.w 4
		dc.l Art_EHZFlower1+$FF000000
		dc.w $7280
		dc.b 6
		dc.b 2
		dc.b   0,$7F		; 0
		dc.b   2,$13		; 2
		dc.b   0,  7		; 4
		dc.b   2,  7		; 6
		dc.b   0,  7		; 8
		dc.b   2,  7		; 10
		dc.l Art_EHZFlower2+$FF000000
		dc.w $72C0
		dc.b 8
		dc.b 2
		dc.b   2,$7F		; 0
		dc.b   0, $B		; 2
		dc.b   2, $B		; 4
		dc.b   0, $B		; 6
		dc.b   2,  5		; 8
		dc.b   0,  5		; 10
		dc.b   2,  5		; 12
		dc.b   0,  5		; 14
		dc.l Art_EHZFlower3+$7000000
		dc.w $7300
		dc.b 2
		dc.b 2
		dc.b   0,  2		; 0
		dc.l Art_EHZFlower4+$FF000000
		dc.w $7340
		dc.b 8
		dc.b 2
		dc.b   0,$7F		; 0
		dc.b   2,  7		; 2
		dc.b   0,  7		; 4
		dc.b   2,  7		; 6
		dc.b   0,  7		; 8
		dc.b   2, $B		; 10
		dc.b   0, $B		; 12
		dc.b   2, $B		; 14
		dc.l Art_EHZFlower5+$1000000
		dc.w $7380
		dc.b 6
		dc.b 2
		dc.b   0,  2		; 0
		dc.b   4,  6		; 2
		dc.b   4,  2		; 4

AnimCue_HPZ:	dc.w 2
		dc.l Art_HPZGlowingBall+$8000000
		dc.w $5D00
		dc.b 6	;06
		dc.b 8	;08 in acelasi nr. in sw.
		dc.b   0,  0		; 0;00 cu 00
		dc.b   8,$10		; 2;08 cu 10
		dc.b $10,  8		; 4;10 cu 8
		dc.l Art_HPZGlowingBall+$8000000;ok cre ca am inteles cum vine treaba
		dc.w $5E00
		dc.b 6
		dc.b 8
		dc.b   8,$10		; 0
		dc.b $10,  8		; 2
		dc.b   0,  0		; 4
		dc.l Art_HPZGlowingBall+$8000000
		dc.w $5F00
		dc.b 6
		dc.b 8
		dc.b $10,  8		; 0
		dc.b   0,  0		; 2
		dc.b   8,$10		; 4

; According to leftover resizing code, this was meant for the
; Chemical Plant Zone boss, which symbol tables refer to as "vaccume".
AnimCue_MTZ:
		dc.w    5		   ; Total of Animations
		dc.l    ArtUnc_MTZCylinder;+$8000000     ; loc_2902A
		dc.w    $6980		   ; VRam
		dc.b	8;08
		dc.b	$10;10 = $0810
		dc.b	0,	$10;0010
		dc.b	$20,	$30
		dc.b	$40,	$50
		dc.b	$60,	$70
;		dc.w    $0810		   ; Frames/Tiles
;		dc.w    $0010, $2030, $4050, $6070 ; Frame Load/Frame Time
		dc.l    ($0D<<$18)|ArtUnc_Lava      ; loc_2A02A:
		dc.w    $6800		   ; VRam
		dc.b	6
		dc.b	$C
		dc.b	0,	$C
		dc.b	$18,	$24
		dc.b	$18,	$C
;		dc.w    $060C		   ; Frames/Tiles
;		dc.w    $000C, $1824, $180C     ; Frame Load/Frame Time
		dc.l    ($FF<<$18)|ArtUnc_MTZAnimBack   ; loc_2A06A:
		dc.w    $6B80		   ; VRam
		dc.w    $0406		   ; Frames/Tiles
		dc.w    $0013, $0607, $0C13, $0607 ; Frame Load/Frame Time
		dc.l    ($FF<<$18)|ArtUnc_MTZAnimBack   ; loc_2A06A:
		dc.w    $6C40		   ; VRam
		dc.w    $0406		   ; Frames/Tiles
		dc.w    $0C13, $0607, $0013, $0607 ; Frame Load/Frame Time
		dc.l    ($05<<$18)|ArtUnc_Drills    ; loc_2A86A:
		dc.w    $6D00		   ; VRam
		dc.w    $0408		   ; Frames/Tiles
		dc.w    $0008, $1018            ; Frame Load/Frame Time
		dc.l    ($05<<$18)|ArtUnc_Drills    ; loc_2A86A:
		dc.w    $6E00		   ; VRam
		dc.w    $0408		   ; Frames/Tiles
		dc.w    $0008, $1018            ; Frame Load/Frame Time
;	dc.w	5
;		dc.w    $6980;$0005		   ; Total of Animations
;		dc.l    ArtUnc_MTZCylinder+$8000000     ; loc_2902A
;;		dc.w    $6980		   ; VRam
;		dc.b    6;$0810		   ; Frames/Tiles
;		dc.b    8;$0010, $2030, $4050, $6070 ; Frame Load/Frame Time
;		dc.b   0,  4		; 0
;		dc.l    ($0D<<$18)|ArtUnc_Lava      ; loc_2A02A:
;		dc.w    $6800		   ; VRam
;		dc.w    $060C		   ; Frames/Tiles
;		dc.w    $000C, $1824, $180C     ; Frame Load/Frame Time
;		dc.l    ($FF<<$18)|ArtUnc_MTZAnimBack+$8000000   ; loc_2A06A:
;		dc.w    $6B80		   ; VRam
;		dc.w    $0406		   ; Frames/Tiles
;		dc.w    $0013, $0607, $0C13, $0607 ; Frame Load/Frame Time
;		dc.l    ($FF<<$18)|ArtUnc_MTZAnimBack   ; loc_2A06A:
;		dc.w    $6C40		   ; VRam
;		dc.w    $0406		   ; Frames/Tiles
;		dc.w    $0C13, $0607, $0013, $0607 ; Frame Load/Frame Time
;		dc.l    ($05<<$18)|ArtUnc_Drills    ; loc_2A86A:
;		dc.w    $6D00		   ; VRam
;		dc.w    $0408		   ; Frames/Tiles
;		dc.w    $0008, $1018            ; Frame Load/Frame Time
;		dc.l    ($05<<$18)|ArtUnc_Drills    ; loc_2A86A:
;		dc.w    $6E00		   ; VRam
;		dc.w    $0408		   ; Frames/Tiles
;		dc.w    $0008, $1018            ; Frame Load/Frame Time
AnimCue_CPZ:	dc.w 7
		dc.l Art_UnkZone_1+$7000000
		dc.w $9000
		dc.b 2
		dc.b 4
		dc.b   0,  4		; 0
		dc.l Art_UnkZone_2+$7000000
		dc.w $9080
		dc.b 3
		dc.b 8
		dc.b   0,  8		; 0
		dc.b $10,  0		; 2
		dc.l Art_UnkZone_3+$7000000
		dc.w $9180
		dc.b 4
		dc.b 2
		dc.b   0,  2		; 0
		dc.b   0,  4		; 2
		dc.l Art_UnkZone_4+$B000000
		dc.w $91C0
		dc.b 4
		dc.b 2
		dc.b   0,  2		; 0
		dc.b   4,  2		; 2
		dc.l Art_UnkZone_5+$F000000
		dc.w $9200
		dc.b $A
		dc.b 1
		dc.b   0		; 0
		dc.b   0		; 1
		dc.b   1		; 2
		dc.b   2		; 3
		dc.b   3		; 4
		dc.b   4		; 5
		dc.b   5		; 6
		dc.b   4		; 7
		dc.b   5		; 8
		dc.b   4		; 9
		dc.l Art_UnkZone_6+$3000000
		dc.w $9220
		dc.b 4
		dc.b 4
		dc.b   0,  4		; 0
		dc.b   8,  4		; 2
		dc.l Art_UnkZone_7+$7000000
		dc.w $92A0
		dc.b 6
		dc.b 3
		dc.b   0,  3		; 0
		dc.b   6,  9		; 2
		dc.b  $C, $F		; 4
		dc.l Art_UnkZone_8+$7000000
		dc.w $9300
		dc.b 4
		dc.b 1
		dc.b   0		; 0
		dc.b   1		; 1
		dc.b   2		; 2
		dc.b   3		; 3

; ===========================================================================
; ---------------------------------------------------------------------------
; This seems to be a subroutine that would've shifted the background blocks
; of Chemical Plant Zone once the player reached a certain X position,
; lasting exactly two screens. This can also be found in the final at
; $40200 in the ROM, with the only difference being its level ID, which
; was updated to match Chemical Plant's final ID ($0D instead of 02)
;
; To see the effect for yourself, add a branch to it at the
; start of LoadTilesAsYouMove and change $FFFF7500/$FFFF7D00 to
; $FFFF0000/$FFFF0800 (to make it more visible)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


; sub_1AC1E: ShiftCPZBackground:
		cmpi.b	#2,(Current_Zone).w	; is this Chemical Plant Zone?
		beq.s	loc_1AC28		; if yes, branch

locret_1AC26:
		rts
; ===========================================================================
; this shifts all blocks of the chunks $EA-$ED and $FA-$FD one block to the
; left and the last block in each row (chunk $ED/$FD) to the beginning
; i.e. rotates the blocks to the left by one

loc_1AC28:
		move.w	($FFFFEE00).w,d0
		cmpi.w	#$1940,d0
		bcs.s	locret_1AC26
		cmpi.w	#$1F80,d0
		bcc.s	locret_1AC26
		subq.b	#1,($FFFFF721).w
		bpl.s	locret_1AC26
		move.b	#7,($FFFFF721).w
		move.b	#1,($FFFFF720).w
		lea	($FFFF7500).l,a1
		bsr.s	sub_1AC58
		lea	($FFFF7D00).l,a1

sub_1AC58:
		move.w	#7,d1

loc_1AC5C:
		move.w	(a1),d0
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	$72(a1),(a1)+
		adda.w	#$70,a1
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	$72(a1),(a1)+
		adda.w	#$70,a1
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	$72(a1),(a1)+
		adda.w	#$70,a1
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	2(a1),(a1)+
		move.w	d0,(a1)+
		suba.w	#$180,a1
		dbf	d1,loc_1AC5C
		rts
; End of function ShiftCPZBackground

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load animated blocks
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; LoadMap16Delta:
LoadAnimatedBlocks:
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		add.w	d0,d0
		move.w	AnimPatMaps(pc,d0.w),d0
		lea	AnimPatMaps(pc,d0.w),a0
		tst.w	(a0)
		beq.s	locret_1AD1A
		lea	($FFFF9000).w,a1
		adda.w	(a0)+,a1
		move.w	(a0)+,d1
		tst.w	(Two_player_mode).w
		bne.s	LoadLevelBlocks_2P
; loc_1AD14:
LoadLevelBlocks:
		move.w	(a0)+,(a1)+
		dbf	d1,LoadLevelBlocks

locret_1AD1A:
		rts
; ---------------------------------------------------------------------------
; loc_1AD1C:
LoadLevelBlocks_2P:
		move.w	(a0)+,d0
		move.w	d0,d1
		andi.w	#$F800,d0
		andi.w	#$7FF,d1
		lsr.w	#1,d1
		or.w	d1,d0
		move.w	d0,(a1)+
		dbf	d1,LoadLevelBlocks_2P
		rts
; End of function LoadAnimatedBlocks

; ===========================================================================
; like with the animated stage art, this already lists stages up to $0F and
; includes an entry for the final HPZ level slot, and this time even lists
; CPZ's final level slot
; Map16Delta_Index:
AnimPatMaps:
		dc.w APM_GHZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_CPZ-AnimPatMaps
		dc.w APM_GHZ-AnimPatMaps
		dc.w APM_HPZ-AnimPatMaps
		dc.w APM_GHZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_HPZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_CPZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps
		dc.w APM_LZ-AnimPatMaps

APM_GHZ:	dc.w $1788,  $3B,$4502,$4504,$4503,$4505,$4506,$4508,$4507,$4509,$450A,$450C,$450B,$450D,$450E,$4510
		dc.w $450F,$4511,$4512,$4514,$4513,$4515,$4516,$4518,$4517,$4519,$651A,$651C,$651B,$651D,$651E,$6520
		dc.w $651F,$6521,$439C,$4B9C,$439D,$4B9D,$4158,$439C,$4159,$439D,$4B9C,$4958,$4B9D,$4959,$6394,$6B94
		dc.w $6395,$6B95,$E396,$EB96,$E397,$EB97,$6398,$6B98,$6399,$6B99,$E39A,$EB9A,$E39B,$EB9B

APM_LZ:
Map16Delta_Mz: ; loc_22A40: ; Metropolis 16x16 mappings used by dynamic reload sprites...
		dc.w    $1730 ; Ram Address to start loading ($1730+$FFFF9000)      -> adda.w  (A0)+, A1
		dc.w    $0067 ; Number of words to load in Ram Array ($0000..$0067) -> move.w  (A0)+, D1
		dc.w    $235C, $2B5C, $235D, $2B5D, $235E, $2B5E, $235F, $2B5F
		dc.w    $635A, $635A, $635B, $635B, $6358, $6358, $6359, $6359
		dc.w    $6356, $6356, $6357, $6357, $6354, $6354, $6355, $6355
		dc.w    $6352, $6352, $6353, $6353, $6350, $6350, $6351, $6351
		dc.w    $634E, $634E, $634F, $634F, $634C, $634C, $634D, $634D
		dc.w    $2360, $2B60, $2361, $2B61, $2362, $2B62, $2363, $2B63
		dc.w    $2364, $2B64, $2365, $2B65, $2366, $2B66, $2367, $2B67
		dc.w    $0000, $0000, $4340, $4341, $0000, $0000, $4342, $4343
		dc.w    $4344, $4345, $4348, $4349, $4346, $4347, $434A, $434B
		dc.w    $E35A, $E35A, $E35B, $E35B, $E358, $E358, $E359, $E359
		dc.w    $E356, $E356, $E357, $E357, $E354, $E354, $E355, $E355
		dc.w    $E352, $E352, $E353, $E353, $E350, $E350, $E351, $E351
		dc.w    $E34E, $E34E, $E34F, $E34F, $E34C, $E34C, $E34D, $E34D
;		dc.w	 0, $C80,  $9B,$43A1,$43A2,$43A3,$43A4,$43A5,$43A6,$43A7,$43A8,$43A9,$43AA,$43AB,$43AC,$43AD
;		dc.w $43AE,$43AF,$43B0,$43B1,$43B2,$43B3,$43B4,$43B5,$43B6,$43B7,$43B8,$43B9,$43BA,$43BB,$43BC,$43BD
;		dc.w $43BE,$43BF,$43C0,$43C1,$43C2,$43C3,$43C4,$63A0,$63A0,$63A0,$63A0,$63A0,$63A0,$63A0,$63A0,	   0
;		dc.w	 0,$6340,$6344,	   0,	 0,$6348,$634C,$6341,$6345,$6342,$6346,$6349,$634D,$634A,$634E,$6343
;		dc.w $6347,$4358,$4359,$634B,$634F,$435A,$435B,$6380,$6384,$6381,$6385,$6388,$638C,$6389,$638D,$6382
;		dc.w $6386,$6383,$6387,$638A,$638E,$638B,$638F,$6390,$6394,$6391,$6395,$6398,$639C,$6399,$639D,$6392
;		dc.w $6396,$6393,$6397,$639A,$639E,$639B,$639F,$4378,$4379,$437A,$437B,$437C,$437D,$437E,$437F,$235C
;		dc.w $235D,$235E,$235F,$2360,$2361,$2362,$2363,$2364,$2365,$2366,$2367,$2368,$2369,$236A,$236B,	   0
;		dc.w	 0,$636C,$636D,	   0,	 0,$636E,    0,$636F,$6370,$6371,$6372,$6373,	 0,$6374,    0,$6375
;		dc.w $6376,$4358,$4359,$6377,	 0,$435A,$435B,$C378,$C379,$C37A,$C37B,$C37C,$C37D,$C37E,$C37F

APM_CPZ:	dc.w $17E0,   $F,$43D1,$43D1,$43D1,$43D1,$43D2,$43D2,$43D3,$43D3,$43D4,$43D4,$43D5,$43D5,$43D6,$43D6
		dc.w $43D7,$43D7

APM_HPZ:	dc.w $1710,  $77,$62E8,$62E9,$62EA,$62EB,$62EC,$62ED,$62EE,$62EF,$62F0,$62F1,$62F2,$62F3,$62F4,$62F5
		dc.w $62F6,$62F7,$62F8,$62F9,$62FA,$62FB,$62FC,$62FD,$62FE,$62FF,$42E8,$42E9,$42EA,$42EB,$42EC,$42ED
		dc.w $42EE,$42EF,$42F0,$42F1,$42F2,$42F3,$42F4,$42F5,$42F6,$42F7,$42F8,$42F9,$42FA,$42FB,$42FC,$42FD
		dc.w $42FE,$42FF,    0,$62E8,	 0,$62EA,$62E9,$62EC,$62EB,$62EE,$62ED,	   0,$62EF,    0,    0,$62F0
		dc.w	 0,$62F2,$62F1,$62F4,$62F3,$62F6,$62F5,	   0,$62F7,    0,    0,$62F8,	 0,$62FA,$62F9,$62FC
		dc.w $62FB,$62FE,$62FD,	   0,$62FF,    0,    0,$42E8,	 0,$42EA,$42E9,$42EC,$42EB,$42EE,$42ED,	   0
		dc.w $42EF,    0,    0,$42F0,	 0,$42F2,$42F1,$42F4,$42F3,$42F6,$42F5,	   0,$42F7,    0,    0,$42F8
		dc.w	 0,$42FA,$42F9,$42FC,$42FB,$42FE,$42FD,	   0,$42FF,    0

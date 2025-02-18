; even
; align $8
; even
DynScreenResizeLoad:			; CODE XREF: DeformBGLayer:loc_5B2Ap
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
; 		add.w	d0,d0; multiply by 2 so each zone has one word
		move.w	DynResize_Index(pc,d0.w),d0
		jsr	DynResize_Index(pc,d0.w)
		bra.w DynResizeEvents_Pt2
;		dc.b 0
DynResize_Index:dc.w DynResize_GHZ-DynResize_Index; 0 ;	DATA XREF: ROM:DynResize_Indexo
					; ROM:DynResize_Index+2o ...
		dc.w DynResize_LZ-DynResize_Index; 1
		dc.w DynResize_CPZ-DynResize_Index; 2
		dc.w DynResize_EHZ-DynResize_Index; 3
		dc.w DynResize_HPZ-DynResize_Index; 4
		dc.w DynResize_HTZ-DynResize_Index; 5
		dc.w DynResize_S1Ending-DynResize_Index; 6
		dc.w DynResize_CPZ-DynResize_Index; 6;DynResize_CPZ-DynResize_Index
		dc.w DynResize_CPZ-DynResize_Index; 7
		dc.w DynResize_CPZ-DynResize_Index; 8
		dc.w DynResize_CPZ-DynResize_Index; 9
		dc.w DynResize_CPZ-DynResize_Index; A
		dc.w DynResize_CPZ-DynResize_Index; B
DynResizeEvents_Pt2:
		moveq	#2,d1
		move.w	($FFFFEEC6).w,d0
		sub.w	($FFFFEECE).w,d0
		beq.s	locret_756A
		bcc.s	loc_756C
		neg.w	d1
		move.w	($FFFFEE04).w,d0
		cmp.w	($FFFFEEC6).w,d0
		bls.s	loc_7560
		move.w	d0,($FFFFEECE).w
		andi.w	#$FFFE,($FFFFEECE).w

loc_7560:				; CODE XREF: DynScreenResizeLoad+28j
		add.w	d1,($FFFFEECE).w
		move.b	#1,($FFFFEEDE).w

locret_756A:				; CODE XREF: DynScreenResizeLoad+1Aj
		rts
; ---------------------------------------------------------------------------

loc_756C:				; CODE XREF: DynScreenResizeLoad+1Cj
		move.w	($FFFFEE04).w,d0
		addi.w	#8,d0
		cmp.w	($FFFFEECE).w,d0
		bcs.s	loc_7586
		btst	#1,($FFFFB022).w
		beq.s	loc_7586
		add.w	d1,d1
		add.w	d1,d1

loc_7586:				; CODE XREF: DynScreenResizeLoad+4Cj
					; DynScreenResizeLoad+54j
		add.w	d1,($FFFFEECE).w
		move.b	#1,($FFFFEEDE).w
		rts
; End of function DynScreenResizeLoad
; align $A
 even
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------

DynResize_GHZ:				; DATA XREF: ROM:DynResize_Indexo
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	DynResize_GHZ_Index(pc,d0.w),d0
		jmp	DynResize_GHZ_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_GHZ_Index:dc.w DynResize_GHZ1-DynResize_GHZ_Index; 0
					; DATA XREF: ROM:DynResize_GHZ_Indexo
					; ROM:DynResize_GHZ_Index+2o ...
		dc.w DynResize_GHZ2-DynResize_GHZ_Index; 1
		dc.w DynResize_GHZ3-DynResize_GHZ_Index; 2
; ---------------------------------------------------------------------------

DynResize_GHZ1:				; DATA XREF: ROM:DynResize_GHZ_Indexo
		move.w	#$300,($FFFFEEC6).w
		cmpi.w	#$1780,($FFFFEE00).w
		bcs.s	locret_75CA
		move.w	#$400,($FFFFEEC6).w

locret_75CA:				; CODE XREF: ROM:000075C2j
		rts
; ---------------------------------------------------------------------------

DynResize_GHZ2:				; DATA XREF: ROM:DynResize_GHZ_Indexo
		move.w	#$300,($FFFFEEC6).w
		cmpi.w	#$ED0,($FFFFEE00).w
		bcs.s	locret_75FC
		move.w	#$200,($FFFFEEC6).w
		cmpi.w	#$1600,($FFFFEE00).w
		bcs.s	locret_75FC
		move.w	#$400,($FFFFEEC6).w
		cmpi.w	#$1D60,($FFFFEE00).w
		bcs.s	locret_75FC
		move.w	#$300,($FFFFEEC6).w

locret_75FC:				; CODE XREF: ROM:000075D8j
					; ROM:000075E6j ...
		rts
; ---------------------------------------------------------------------------

DynResize_GHZ3:				; DATA XREF: ROM:DynResize_GHZ_Indexo
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	DynResize_GHZ3_Index(pc,d0.w),d0
		jmp	DynResize_GHZ3_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_GHZ3_Index:dc.w DynResize_GHZ3_Main-DynResize_GHZ3_Index; 0
					; DATA XREF: ROM:DynResize_GHZ3_Indexo
					; ROM:DynResize_GHZ3_Index+2o ...
		dc.w DynResize_GHZ3_Boss-DynResize_GHZ3_Index; 1
		dc.w DynResize_GHZ3_End-DynResize_GHZ3_Index; 2
; ---------------------------------------------------------------------------

DynResize_GHZ3_Main:			; DATA XREF: ROM:DynResize_GHZ3_Indexo
		move.w	#$300,($FFFFEEC6).w
		cmpi.w	#$380,($FFFFEE00).w
		bcs.s	locret_7658
		move.w	#$310,($FFFFEEC6).w
		cmpi.w	#$960,($FFFFEE00).w
		bcs.s	locret_7658
		cmpi.w	#$280,($FFFFEE04).w
		bcs.s	loc_765A
		move.w	#$400,($FFFFEEC6).w
		cmpi.w	#$1380,($FFFFEE00).w
		bcc.s	loc_7650
		move.w	#$4C0,($FFFFEEC6).w
		move.w	#$4C0,($FFFFEECE).w

loc_7650:				; CODE XREF: ROM:00007642j
		cmpi.w	#$1700,($FFFFEE00).w
		bcc.s	loc_765A

locret_7658:				; CODE XREF: ROM:0000761Ej
					; ROM:0000762Cj
		rts
; ---------------------------------------------------------------------------

loc_765A:				; CODE XREF: ROM:00007634j
					; ROM:00007656j
		move.w	#$300,($FFFFEEC6).w
		addq.b	#2,($FFFFEEDF).w
		rts
; ---------------------------------------------------------------------------

DynResize_GHZ3_Boss:			; DATA XREF: ROM:DynResize_GHZ3_Indexo
		cmpi.w	#$960,($FFFFEE00).w
		bcc.s	loc_7672
		subq.b	#2,($FFFFEEDF).w

loc_7672:				; CODE XREF: ROM:0000766Cj
		cmpi.w	#$2960,($FFFFEE00).w
		bcs.s	locret_76AA
		bsr.w	SingleObjLoad
		bne.s	loc_7692
		move.b	#$3D,0(a1) ; '='
		move.w	#$2A60,8(a1)
		move.w	#$280,$C(a1)

loc_7692:				; CODE XREF: ROM:0000767Ej
		move.w	#bgm_Boss,d0
		bsr.w	PlaySound
		move.b	#1,($FFFFF7AA).w
		addq.b	#2,($FFFFEEDF).w
		moveq	#$11,d0
		bra.w	LoadPLC
; ---------------------------------------------------------------------------

locret_76AA:				; CODE XREF: ROM:00007678j
		rts
; ---------------------------------------------------------------------------

DynResize_GHZ3_End:			; DATA XREF: ROM:DynResize_GHZ3_Indexo
		move.w	($FFFFEE00).w,($FFFFEEC8).w
		rts
; ---------------------------------------------------------------------------

DynResize_LZ:				; DATA XREF: ROM:DynResize_Indexo
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	DynResize_LZ_Index(pc,d0.w),d0
		jmp	DynResize_LZ_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_LZ_Index:dc.w	DynResize_LZ_Null-DynResize_LZ_Index; 0
					; DATA XREF: ROM:DynResize_LZ_Indexo
					; ROM:DynResize_LZ_Index+2o ...
		dc.w DynResize_LZ_Null-DynResize_LZ_Index; 1
		dc.w DynResize_LZ3-DynResize_LZ_Index; 2
		dc.w DynResize_LZ4-DynResize_LZ_Index; 3
; ---------------------------------------------------------------------------

DynResize_LZ_Null:			; DATA XREF: ROM:DynResize_LZ_Indexo
		rts
; ---------------------------------------------------------------------------

DynResize_LZ3:				; DATA XREF: ROM:DynResize_LZ_Indexo
		tst.b	($FFFFF7EF).w
		beq.s	loc_76EA
		lea	($FFFF8206).w,a1
		cmpi.b	#7,(a1)
		beq.s	loc_76EA
		move.b	#7,(a1)
		move.w	#$B7,d0	; '·'
		bsr.w	PlaySound_Special

loc_76EA:				; CODE XREF: ROM:000076D2j
					; ROM:000076DCj
		tst.b	($FFFFEEDF).w
		bne.s	locret_7726
		cmpi.w	#$1CA0,($FFFFEE00).w
		bcs.s	locret_7724
		cmpi.w	#$600,($FFFFEE04).w
		bcc.s	locret_7724
		bsr.w	SingleObjLoad
		bne.s	loc_770C
		move.b	#$77,0(a1) ; 'w'

loc_770C:				; CODE XREF: ROM:00007704j
		move.w	#bgm_Boss,d0
		bsr.w	PlaySound
		move.b	#1,($FFFFF7AA).w
		addq.b	#2,($FFFFEEDF).w
		moveq	#$11,d0
		bra.w	LoadPLC
; ---------------------------------------------------------------------------

locret_7724:				; CODE XREF: ROM:000076F6j
					; ROM:000076FEj
		rts
; ---------------------------------------------------------------------------

locret_7726:				; CODE XREF: ROM:000076EEj
		rts
; ---------------------------------------------------------------------------

DynResize_LZ4:				; DATA XREF: ROM:DynResize_LZ_Indexo
		cmpi.w	#$D00,($FFFFEE00).w
		bcs.s	locret_774E
		cmpi.w	#$18,($FFFFB00C).w
		bcc.s	locret_774E
		clr.b	($FFFFFE30).w
		move.w	#1,($FFFFFE02).w
		move.w	#$502,(Current_ZoneAndAct).w
		move.b	#1,($FFFFF7C8).w

locret_774E:				; CODE XREF: ROM:0000772Ej
					; ROM:00007736j
		rts
; ---------------------------------------------------------------------------

DynResize_CPZ:				; DATA XREF: ROM:DynResize_Indexo
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	DynResize_CPZ_Index(pc,d0.w),d0
		jmp	DynResize_CPZ_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_CPZ_Index:dc.w DynResize_CPZ1-DynResize_CPZ_Index
		dc.w DynResize_CPZ2-DynResize_CPZ_Index
		dc.w DynResize_CPZ3-DynResize_CPZ_Index
; ---------------------------------------------------------------------------

DynResize_CPZ1:				; DATA XREF: ROM:DynResize_CPZ_Indexo
		rts
; ---------------------------------------------------------------------------

S1DynResize_MZ1:			; leftover from	Sonic 1
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	off_7776(pc,d0.w),d0
		jmp	off_7776(pc,d0.w)
; ---------------------------------------------------------------------------
off_7776:	dc.w loc_777E-off_7776	; 0 ; DATA XREF: ROM:off_7776o
					; ROM:off_7776+2o ...
		dc.w loc_77AE-off_7776	; 1
		dc.w loc_77F2-off_7776	; 2
		dc.w loc_781C-off_7776	; 3
; ---------------------------------------------------------------------------

loc_777E:				; DATA XREF: ROM:off_7776o
		move.w	#$1D0,($FFFFEEC6).w
		cmpi.w	#$700,($FFFFEE00).w
		bcs.s	locret_77AC
		move.w	#$220,($FFFFEEC6).w
		cmpi.w	#$D00,($FFFFEE00).w
		bcs.s	locret_77AC
		move.w	#$340,($FFFFEEC6).w
		cmpi.w	#$340,($FFFFEE04).w
		bcs.s	locret_77AC
		addq.b	#2,($FFFFEEDF).w

locret_77AC:				; CODE XREF: ROM:0000778Aj
					; ROM:00007798j ...
		rts
; ---------------------------------------------------------------------------

loc_77AE:				; DATA XREF: ROM:off_7776o
		cmpi.w	#$340,($FFFFEE04).w
		bcc.s	loc_77BC
		subq.b	#2,($FFFFEEDF).w
		rts
; ---------------------------------------------------------------------------

loc_77BC:				; CODE XREF: ROM:000077B4j
		move.w	#0,($FFFFEECC).w
		cmpi.w	#$E00,($FFFFEE00).w
		bcc.s	locret_77F0
		move.w	#$340,($FFFFEECC).w
		move.w	#$340,($FFFFEEC6).w
		cmpi.w	#$A90,($FFFFEE00).w
		bcc.s	locret_77F0
		move.w	#$500,($FFFFEEC6).w
		cmpi.w	#$370,($FFFFEE04).w
		bcs.s	locret_77F0
		addq.b	#2,($FFFFEEDF).w

locret_77F0:				; CODE XREF: ROM:000077C8j
					; ROM:000077DCj ...
		rts
; ---------------------------------------------------------------------------

loc_77F2:				; DATA XREF: ROM:off_7776o
		cmpi.w	#$370,($FFFFEE04).w
		bcc.s	loc_7800
		subq.b	#2,($FFFFEEDF).w
		rts
; ---------------------------------------------------------------------------

loc_7800:				; CODE XREF: ROM:000077F8j
		cmpi.w	#$500,($FFFFEE04).w
		bcs.s	locret_781A
		cmpi.w	#$B80,($FFFFEE00).w
		bcs.s	locret_781A
		move.w	#$500,($FFFFEECC).w
		addq.b	#2,($FFFFEEDF).w

locret_781A:				; CODE XREF: ROM:00007806j
					; ROM:0000780Ej
		rts
; ---------------------------------------------------------------------------

loc_781C:				; DATA XREF: ROM:off_7776o
		cmpi.w	#$B80,($FFFFEE00).w
		bcc.s	loc_7832
		cmpi.w	#$340,($FFFFEECC).w
		beq.s	locret_786A
		subq.w	#2,($FFFFEECC).w
		rts
; ---------------------------------------------------------------------------

loc_7832:				; CODE XREF: ROM:00007822j
		cmpi.w	#$500,($FFFFEECC).w
		beq.s	loc_7848
		cmpi.w	#$500,($FFFFEE04).w
		bcs.s	locret_786A
		move.w	#$500,($FFFFEECC).w

loc_7848:				; CODE XREF: ROM:00007838j
		cmpi.w	#$E70,($FFFFEE00).w
		bcs.s	locret_786A
		move.w	#0,($FFFFEECC).w
		move.w	#$500,($FFFFEEC6).w
		cmpi.w	#$1430,($FFFFEE00).w
		bcs.s	locret_786A
		move.w	#$210,($FFFFEEC6).w

locret_786A:				; CODE XREF: ROM:0000782Aj
					; ROM:00007840j ...
		rts
; ---------------------------------------------------------------------------

DynResize_CPZ2:				; DATA XREF: ROM:DynResize_CPZ_Indexo
		rts
; ---------------------------------------------------------------------------

S1DynResize_MZ2:			; leftover from	Sonic 1
		move.w	#$520,($FFFFEEC6).w
		cmpi.w	#$1700,($FFFFEE00).w
		bcs.s	locret_7882
		move.w	#$200,($FFFFEEC6).w

locret_7882:				; CODE XREF: ROM:0000787Aj
		rts
; ===========================================================================

DynResize_CPZ3:
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	off_7892(pc,d0.w),d0
		jmp	off_7892(pc,d0.w)
; ===========================================================================
off_7892:	dc.w DynResize_CPZ3_BossCheck-off_7892
		dc.w DynResize_CPZ3_Null-off_7892
; ===========================================================================

DynResize_CPZ3_BossCheck:
		cmpi.w	#$480,($FFFFEE00).w
		blt.s	DynResize_CPZ3_Null
		cmpi.w	#$740,($FFFFEE00).w
		bgt.s	DynResize_CPZ3_Null
		move.w	($FFFFEECE).w,d0
		cmp.w	($FFFFEE04).w,d0
		bne.s	DynResize_CPZ3_Null
		move.w	#$740,($FFFFEECA).w
		move.w	#$480,($FFFFEEC8).w
		addq.b	#2,($FFFFEEDF).w
		bsr.w	SingleObjLoad
		bne.s	DynResize_CPZ3_Null
		move.b	#$55,0(a1)	; load Obj55 (EHZ boss, likely CPZ boss at one point)
		move.w	#$680,8(a1)
		move.w	#$540,$C(a1)
		moveq	#$11,d0
		bra.w	LoadPLC
; ===========================================================================

DynResize_CPZ3_Null:
		rts

; ---------------------------------------------------------------------------

DynResize_EHZ:				; DATA XREF: ROM:DynResize_Indexo
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	off_78F0(pc,d0.w),d0
		jmp	off_78F0(pc,d0.w)
; ---------------------------------------------------------------------------
off_78F0:	dc.w DynResize_EHZ1-off_78F0 ; DATA XREF: ROM:off_78F0o
					; ROM:000078F2o ...
		dc.w DynResize_EHZ2-off_78F0
		dc.w locret_7980-off_78F0
; ---------------------------------------------------------------------------

DynResize_EHZ1:				; DATA XREF: ROM:off_78F0o
		rts
; ---------------------------------------------------------------------------

DynResize_EHZ2:				; DATA XREF: ROM:000078F2o
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	DynResize_EHZ2_Index(pc,d0.w),d0
		jmp	DynResize_EHZ2_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_EHZ2_Index:dc.w DynResize_EHZ2_01-DynResize_EHZ2_Index
					; DATA XREF: ROM:DynResize_EHZ2_Indexo
					; ROM:00007908o ...
		dc.w DynResize_EHZ2_02-DynResize_EHZ2_Index
		dc.w DynResize_EHZ2_03-DynResize_EHZ2_Index
; ---------------------------------------------------------------------------

DynResize_EHZ2_01:			; DATA XREF: ROM:DynResize_EHZ2_Indexo
		cmpi.w	#$26E0,($FFFFEE00).w
		bcs.s	locret_795A
		move.w	($FFFFEE00).w,($FFFFEEC8).w
		move.w	#$390,($FFFFEEC6).w
		move.w	#$390,($FFFFEECE).w
		addq.b	#2,($FFFFEEDF).w
		bsr.w	SingleObjLoad
		bne.s	loc_7946
		move.b	#$55,(a1) ; 'U'
		move.b	#$81,$28(a1)
		move.w	#$29D0,8(a1)
		move.w	#$426,$C(a1)

loc_7946:				; CODE XREF: ROM:0000792Ej
		move.w	#bgm_Boss,d0
		bsr.w	PlaySound
		move.b	#1,($FFFFF7AA).w
		moveq	#$11,d0
		bra.w	LoadPLC
; ---------------------------------------------------------------------------

locret_795A:				; CODE XREF: ROM:00007912j
		rts
; ---------------------------------------------------------------------------

DynResize_EHZ2_02:			; DATA XREF: ROM:00007908o
		cmpi.w	#$2880,($FFFFEE00).w
		bcs.s	locret_796E
		move.w	#$2880,($FFFFEEC8).w
		addq.b	#2,($FFFFEEDF).w

locret_796E:				; CODE XREF: ROM:00007962j
		rts
; ---------------------------------------------------------------------------

DynResize_EHZ2_03:			; DATA XREF: ROM:0000790Ao
		tst.b	($FFFFF7A7).w
		beq.s	DynResize_EHZ3
;		bsr.w LoadLevelResults
;		even
;		jsr (LoadLevelResults).l
;		even
		move.b	#GameModeID_SegaScreen,(Game_Mode).w

DynResize_EHZ3:				; CODE XREF: ROM:00007974j
		rts
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

locret_7980:				; DATA XREF: ROM:000078F4o
		rts
; ---------------------------------------------------------------------------

S1DynResize_SLZ3:			; leftover from	Sonic 1
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	off_7990(pc,d0.w),d0
		jmp	off_7990(pc,d0.w)
; ---------------------------------------------------------------------------
off_7990:	dc.w loc_7996-off_7990	; DATA XREF: ROM:off_7990o
					; ROM:00007992o ...
		dc.w loc_79AA-off_7990
		dc.w loc_79D6-off_7990
; ---------------------------------------------------------------------------

loc_7996:				; DATA XREF: ROM:off_7990o
		cmpi.w	#$1E70,($FFFFEE00).w
		bcs.s	locret_79A8
		move.w	#$210,($FFFFEEC6).w
		addq.b	#2,($FFFFEEDF).w

locret_79A8:				; CODE XREF: ROM:0000799Cj
		rts
; ---------------------------------------------------------------------------

loc_79AA:				; DATA XREF: ROM:00007992o
		cmpi.w	#$2000,($FFFFEE00).w
		bcs.s	locret_79D4
		bsr.w	SingleObjLoad
		bne.s	loc_79BC
		move.b	#$7A,(a1) ; 'z'

loc_79BC:				; CODE XREF: ROM:000079B6j
		move.w	#bgm_Boss,d0
		bsr.w	PlaySound
		move.b	#1,($FFFFF7AA).w
		addq.b	#2,($FFFFEEDF).w
		moveq	#$11,d0
		bra.w	LoadPLC
; ---------------------------------------------------------------------------

locret_79D4:				; CODE XREF: ROM:000079B0j
		rts
; ---------------------------------------------------------------------------

loc_79D6:				; DATA XREF: ROM:00007994o
		move.w	($FFFFEE00).w,($FFFFEEC8).w
		rts
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

DynResize_HPZ:				; DATA XREF: ROM:DynResize_Indexo
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	DynResize_HPZ_Index(pc,d0.w),d0
		jmp	DynResize_HPZ_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_HPZ_Index:dc.w DynResize_HPZ1-DynResize_HPZ_Index
					; DATA XREF: ROM:DynResize_HPZ_Indexo
					; ROM:000079F2o ...
		dc.w DynResize_HPZ2-DynResize_HPZ_Index
		dc.w DynResize_HPZ3-DynResize_HPZ_Index
; ---------------------------------------------------------------------------

DynResize_HPZ1:				; DATA XREF: ROM:DynResize_HPZ_Indexo
		rts
; ---------------------------------------------------------------------------

DynResize_HPZ2:				; DATA XREF: ROM:000079F2o
		move.w	#$520,($FFFFEEC6).w
		cmpi.w	#$25A0,($FFFFEE00).w
		bcs.s	locret_7A1A
		move.w	#$420,($FFFFEEC6).w
		cmpi.w	#$4D0,($FFFFB00C).w
		bcs.s	locret_7A1A
		move.w	#$520,($FFFFEEC6).w

locret_7A1A:				; CODE XREF: ROM:00007A04j
					; ROM:00007A12j
		rts
; ---------------------------------------------------------------------------

DynResize_HPZ3:				; DATA XREF: ROM:000079F4o
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	DynResize_HPZ3_Index(pc,d0.w),d0
		jmp	DynResize_HPZ3_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_HPZ3_Index:dc.w loc_7A30-DynResize_HPZ3_Index
					; DATA XREF: ROM:DynResize_HPZ3_Indexo
					; ROM:00007A2Co ...
		dc.w loc_7A48-DynResize_HPZ3_Index
		dc.w loc_7A7A-DynResize_HPZ3_Index
; ---------------------------------------------------------------------------

loc_7A30:				; DATA XREF: ROM:DynResize_HPZ3_Indexo
		cmpi.w	#$2AC0,($FFFFEE00).w
		bcs.s	locret_7A46
		bsr.w	SingleObjLoad
		bne.s	locret_7A46
		move.b	#$76,(a1) ; 'v'
		addq.b	#2,($FFFFEEDF).w

locret_7A46:				; CODE XREF: ROM:00007A36j
					; ROM:00007A3Cj
		rts
; ---------------------------------------------------------------------------

loc_7A48:				; DATA XREF: ROM:00007A2Co
		cmpi.w	#$2C00,($FFFFEE00).w
		bcs.s	locret_7A78
		move.w	#$4CC,($FFFFEEC6).w
		bsr.w	SingleObjLoad
		bne.s	loc_7A64
		move.b	#$75,(a1) ; 'u'
		addq.b	#2,($FFFFEEDF).w

loc_7A64:				; CODE XREF: ROM:00007A5Aj
		move.w	#bgm_Boss,d0
		bsr.w	PlaySound
		move.b	#1,($FFFFF7AA).w
		moveq	#$11,d0
		bra.w	LoadPLC
; ---------------------------------------------------------------------------

locret_7A78:				; CODE XREF: ROM:00007A4Ej
		rts
; ---------------------------------------------------------------------------

loc_7A7A:				; DATA XREF: ROM:00007A2Eo
		move.w	($FFFFEE00).w,($FFFFEEC8).w
		rts
; ---------------------------------------------------------------------------

DynResize_HTZ:				; DATA XREF: ROM:DynResize_Indexo
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	DynResize_HTZ_Index(pc,d0.w),d0
		jmp	DynResize_HTZ_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_HTZ_Index:dc.w DynResize_HTZ1-DynResize_HTZ_Index
					; DATA XREF: ROM:DynResize_HTZ_Indexo
					; ROM:00007A94o ...
		dc.w DynResize_HTZ2-DynResize_HTZ_Index
		dc.w DynResize_HTZ3-DynResize_HTZ_Index
; ---------------------------------------------------------------------------

DynResize_HTZ1:				; DATA XREF: ROM:DynResize_HTZ_Indexo
		move.w	#$720,($FFFFEEC6).w
		cmpi.w	#$1880,($FFFFEE00).w
		bcs.s	locret_7ABA
		move.w	#$620,($FFFFEEC6).w
		cmpi.w	#$2000,($FFFFEE00).w
		bcs.s	locret_7ABA
		move.w	#$2A0,($FFFFEEC6).w

locret_7ABA:				; CODE XREF: ROM:00007AA4j
					; ROM:00007AB2j
		rts
; ---------------------------------------------------------------------------

DynResize_HTZ2:				; DATA XREF: ROM:00007A94o
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	DynResize_HTZ2_Index(pc,d0.w),d0
		jmp	DynResize_HTZ2_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_HTZ2_Index:dc.w loc_7AD2-DynResize_HTZ2_Index
					; DATA XREF: ROM:DynResize_HTZ2_Indexo
					; ROM:00007ACCo ...
		dc.w loc_7AF4-DynResize_HTZ2_Index
		dc.w loc_7B12-DynResize_HTZ2_Index
		dc.w loc_7B30-DynResize_HTZ2_Index
; ---------------------------------------------------------------------------

loc_7AD2:				; DATA XREF: ROM:DynResize_HTZ2_Indexo
		move.w	#$800,($FFFFEEC6).w
		cmpi.w	#$1800,($FFFFEE00).w
		bcs.s	locret_7AF2
		move.w	#$510,($FFFFEEC6).w
		cmpi.w	#$1E00,($FFFFEE00).w
		bcs.s	locret_7AF2
		addq.b	#2,($FFFFEEDF).w

locret_7AF2:				; CODE XREF: ROM:00007ADEj
					; ROM:00007AECj
		rts
; ---------------------------------------------------------------------------

loc_7AF4:				; DATA XREF: ROM:00007ACCo
		cmpi.w	#$1EB0,($FFFFEE00).w
		bcs.s	locret_7B10
		bsr.w	SingleObjLoad
		bne.s	locret_7B10
		move.b	#$83,(a1)
		addq.b	#2,($FFFFEEDF).w
		moveq	#$1E,d0
		bra.w	LoadPLC
; ---------------------------------------------------------------------------

locret_7B10:				; CODE XREF: ROM:00007AFAj
					; ROM:00007B00j
		rts
; ---------------------------------------------------------------------------

loc_7B12:				; DATA XREF: ROM:00007ACEo
		cmpi.w	#$1F60,($FFFFEE00).w
		bcs.s	loc_7B2E
		bsr.w	SingleObjLoad
		bne.s	loc_7B28
		move.b	#$82,(a1)
		addq.b	#2,($FFFFEEDF).w

loc_7B28:				; CODE XREF: ROM:00007B1Ej
		move.b	#1,($FFFFF7AA).w

loc_7B2E:				; CODE XREF: ROM:00007B18j
		bra.s	loc_7B3A
; ---------------------------------------------------------------------------

loc_7B30:				; DATA XREF: ROM:00007AD0o
		cmpi.w	#$2050,($FFFFEE00).w
		bcs.s	loc_7B3A
		rts
; ---------------------------------------------------------------------------

loc_7B3A:				; CODE XREF: ROM:loc_7B2Ej
					; ROM:00007B36j ...
		move.w	($FFFFEE00).w,($FFFFEEC8).w
		rts
; ---------------------------------------------------------------------------

DynResize_HTZ3:				; DATA XREF: ROM:00007A96o
		moveq	#0,d0
		move.b	($FFFFEEDF).w,d0
		move.w	DynResize_HTZ3_Index(pc,d0.w),d0
		jmp	DynResize_HTZ3_Index(pc,d0.w)
; ---------------------------------------------------------------------------
DynResize_HTZ3_Index:dc.w loc_7B5A-DynResize_HTZ3_Index
					; DATA XREF: ROM:DynResize_HTZ3_Indexo
					; ROM:00007B52o ...
		dc.w loc_7B6E-DynResize_HTZ3_Index
		dc.w loc_7B8C-DynResize_HTZ3_Index
		dc.w locret_7B9A-DynResize_HTZ3_Index
		dc.w loc_7B9C-DynResize_HTZ3_Index
; ---------------------------------------------------------------------------

loc_7B5A:				; DATA XREF: ROM:DynResize_HTZ3_Indexo
		cmpi.w	#$2148,($FFFFEE00).w
		bcs.s	loc_7B6C
		addq.b	#2,($FFFFEEDF).w
		moveq	#$1F,d0
		bsr.w	LoadPLC

loc_7B6C:				; CODE XREF: ROM:00007B60j
		bra.s	loc_7B3A
; ---------------------------------------------------------------------------

loc_7B6E:				; DATA XREF: ROM:00007B52o
		cmpi.w	#$2300,($FFFFEE00).w
		bcs.s	loc_7B8A
		bsr.w	SingleObjLoad
		bne.s	loc_7B8A
		move.b	#$85,(a1)
		addq.b	#2,($FFFFEEDF).w
		move.b	#1,($FFFFF7AA).w

loc_7B8A:				; CODE XREF: ROM:00007B74j
					; ROM:00007B7Aj
		bra.s	loc_7B3A
; ---------------------------------------------------------------------------

loc_7B8C:				; DATA XREF: ROM:00007B54o
		cmpi.w	#$2450,($FFFFEE00).w
		bcs.s	loc_7B98
		addq.b	#2,($FFFFEEDF).w

loc_7B98:				; CODE XREF: ROM:00007B92j
		bra.s	loc_7B3A
; ---------------------------------------------------------------------------

locret_7B9A:				; DATA XREF: ROM:00007B56o
		rts
; ---------------------------------------------------------------------------

loc_7B9C:				; DATA XREF: ROM:00007B58o
		bra.s	loc_7B3A
; ---------------------------------------------------------------------------

;DynResize_S1Ending:			; DATA XREF: ROM:DynResize_Indexo
;		rts
; ---------------------------------------------------------------------------
DynResize_S1Ending:			; DATA XREF: ROM:DynResize_Indexo
		rts
loc_7FC8:
; ---------------------------------------------------------------------------
; Alpha Beta Zone sequence dynamic screen resizing (empty)
; ---------------------------------------------------------------------------

Resize_ABZ:				; XREF: Resize_Index
		moveq	#0,d0
		move.b	($FFFFFE11).w,d0
		add.w	d0,d0
		move.w	Resize_ABZx(pc,d0.w),d0
		jmp	Resize_ABZx(pc,d0.w)
; ===========================================================================
Resize_ABZx:	dc.w Resize_ABZ1-Resize_ABZx
		dc.w Resize_ABZ2-Resize_ABZx
		dc.w Resize_ABZ3-Resize_ABZx
; ===========================================================================
Resize_ABZ1:
		rts
; ===========================================================================
Resize_ABZ2:
		rts
; ===========================================================================
Resize_ABZ3:
		rts
; ===========================================================================
loc_7FCA:
		rts
loc_7FCC:
		rts
loc_7FCE:
		rts
DynResize_CNz: ; loc_7FD0:
		rts
DynResize_CPz: ;loc_7FD2:
		rts
DynResize_GCz: ;loc_7FD4:
		rts
DynResize_NGHz: ;loc_7FD6:
		rts
DynResize_DEz: ;loc_7FD8:
		rts

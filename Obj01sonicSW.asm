; ---------------------------------------------------------------------------
; Object 01 - Sonic
; ---------------------------------------------------------------------------            
; Sprite_FC48: Obj_0x01_Sonic:
Obj01:
		tst.w	(Debug_placement_mode).w; is Debug Mode being used?
		beq.s	Obj01_Normal		; if not, branch
		jmp	(DebugMode).l
; ---------------------------------------------------------------------------
; loc_FC54: Sonic_Normal:
Obj01_Normal:
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	Obj01_Index(pc,d0.w),d1
		jmp	Obj01_Index(pc,d1)
; ===========================================================================
; loc_FC62: Sonic_Index:
Obj01_Index:	offsetTable
		offsetTableEntry.w Obj01_Init
		offsetTableEntry.w Obj01_Control
		offsetTableEntry.w Obj01_Hurt
		offsetTableEntry.w Obj01_Dead
		offsetTableEntry.w Obj01_Gone
; ===========================================================================
; loc_FC6C: Sonic_Main:
Obj01_Init:
		addq.b	#2,$24(a0)	; => Obj01_Control
		move.b	#$13,$16(a0)	; this sets Sonic's collision height (2*pixels)
		move.b	#9,$17(a0)
		move.l	#MapUnc_Sonic,4(a0)
		move.w	#$780,2(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#2,$18(a0)
		move.b	#$18,$19(a0)
		move.b	#4,1(a0)
		move.w	#$600,(Sonic_top_speed).w	; set Sonic's top speed
		move.w	#$C,(Sonic_acceleration).w	; set Sonic's acceleration
		move.w	#$80,(Sonic_deceleration).w	; set Sonic's deceleration
		move.b	#$C,$3E(a0)
		move.b	#$D,$3F(a0)
		move.b	#0,$2C(a0)
		move.b	#4,$2D(a0)
		move.w	#0,(Sonic_Pos_Record_Index).w
		move.w	#$3F,d2

loc_FCD4:
		bsr.w	Sonic_RecordPos
		move.w	#0,(a1,d0.w)
		dbf	d2,loc_FCD4

; ---------------------------------------------------------------------------
; Normal state for Sonic
; ---------------------------------------------------------------------------
; loc_FCE2: Sonic_Control:
Obj01_Control:
		tst.w	(Debug_mode_flag).w		; is Debug Mode enabled?
		beq.s	loc_FCFC			; if not, branch
		btst	#4,(Ctrl_1_Press).w		; is button B pressed?
		beq.s	loc_FCFC			; if not, branch
		move.w	#1,(Debug_placement_mode).w	; change Sonic into a ring/item
		clr.b	(Control_Locked).w		; unlock control
		rts
; -----------------------------------------------------------------------

loc_FCFC:
		tst.b	(Control_Locked).w	; are controls locked?
		bne.s	loc_FD08		; if yes, branch
		move.w	(Ctrl_1).w,(Ctrl_1_Logical).w	; copy new held buttons to enable joypad control

loc_FD08:
		btst	#0,$2A(a0)		; is Sonic interacting with another object that holds him in place or controls his movement somehow?
		bne.s	Obj01_ControlsLock	; if yes, branch
		moveq	#0,d0
		move.b	$22(a0),d0
		andi.w	#6,d0
		move.w	Obj01_Modes(pc,d0.w),d1
		jsr	Obj01_Modes(pc,d1)	; run Sonic's movement code
; loc_FD22: Sonic_ControlsLock:
Obj01_ControlsLock:
		bsr.s	Sonic_Display
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Water
		move.b	(Primary_Angle).w,$36(a0)
		move.b	(Secondary_Angle).w,$37(a0)
		tst.b	(WindTunnel_flag).w
		beq.s	loc_FD4A
		tst.b	$1C(a0)
		bne.s	loc_FD4A
		move.b	$1D(a0),$1C(a0)

loc_FD4A:
		bsr.w	Sonic_Animate
		tst.b	$2A(a0)
		bmi.s	loc_FD5A
		jsr	(TouchResponse).l

loc_FD5A:
		bra.w	LoadSonicDynPLC
; ===========================================================================
; loc_FD5E:
Obj01_Modes:	offsetTable
		offsetTableEntry.w Obj01_MdNormal	; 0 - not airborne or rolling
		offsetTableEntry.w Obj01_MdAir		; 2 - airborne
		offsetTableEntry.w Obj01_MdRoll		; 4 - rolling
		offsetTableEntry.w Obj01_MdJump		; 6 - jumping
; ===========================================================================
; byte_FD66:
Sonic_MusicList:	zoneOrderedTable 1,1
	zoneTableEntry.b	MusID_GHZ	; GHZ
	zoneTableEntry.b	MusID_GHZ	; OWZ
	zoneTableEntry.b	MusID_MTZ	; WZ
	zoneTableEntry.b	MusID_SSZ	; SSZ
	zoneTableEntry.b	MusID_MTZ	; MTZ
	zoneTableEntry.b	MusID_MTZ	; MTZ2
	zoneTableEntry.b	MusID_BOZ	; BLZ
	zoneTableEntry.b	MusID_HTZ	; HTZ
	zoneTableEntry.b	MusID_HPZ	; HPZ
	zoneTableEntry.b	MusID_RWZ	; RWZ
	zoneTableEntry.b	MusID_OOZ	; OOZ
	zoneTableEntry.b	MusID_DHZ	; DHZ
	zoneTableEntry.b	MusID_CNZ	; CNZ
	zoneTableEntry.b	MusID_CPZ	; CPZ
	zoneTableEntry.b	MusID_CPZ	; GCZ
	zoneTableEntry.b	MusID_NGHZ	; NGHZ
	; no *proper* entry for DEZ, so it instead uses the alignment to play sound $08
	;zoneTableEntry.b	MusID_DEZ	; DEZ
    zoneTableEnd
	even

; ===========================================================================

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FD76:
Sonic_Display:
		move.w	$30(a0),d0
		beq.s	Obj01_Display
		subq.w	#1,$30(a0)
		lsr.w	#3,d0
		bcc.s	Obj01_ChkInvin
; loc_FD84:
Obj01_Display:
		jsr	(DisplaySprite).l
; loc_FD8A:
Obj01_ChkInvin:	; Checks if Sonic has run out of invincibility frames
		tst.b	(Invincibility).w
		beq.s	Obj01_ChkShoes
		tst.w	$32(a0)
		beq.s	Obj01_ChkShoes
		subq.w	#1,$32(a0)
		bne.s	Obj01_ChkShoes
		tst.b	(Current_Boss_ID).w
		bne.s	Obj01_RmvInvin
		cmpi.w	#$C,(Current_Air).w
		bcs.s	Obj01_RmvInvin
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		lea	Sonic_MusicList(pc),a1
		move.b	(a1,d0.w),d0
		jsr	(PlayMusic).l
; loc_FDBE:
Obj01_RmvInvin:
		move.b	#0,(Invincibility).w
; loc_FDC4:
Obj01_ChkShoes:	; Checks if Sonic should still have the speed shoes
		tst.b	(Speed_shoes).w
		beq.s	Obj01_ExitChk
		tst.w	$34(a0)
		beq.s	Obj01_ExitChk
		subq.w	#1,$34(a0)
		bne.s	Obj01_ExitChk
		move.w	#$600,(Sonic_top_speed).w
		move.w	#$C,(Sonic_acceleration).w
		move.w	#$80,(Sonic_deceleration).w
		move.b	#0,(Speed_shoes).w
		move.w	#$FC,d0		; restore music tempo
		jmp	(PlayMusic).l
; return_FDF8:
Obj01_ExitChk:
		rts
; End of subroutine Sonic_Display
		  
; ---------------------------------------------------------------------------
; Subroutine to record Sonic's previous positions for invincibility stars
; and input/status flags for Tails' AI to follow
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FDFA: CopySonicMovesForTails:
Sonic_RecordPos:
		move.w	(Sonic_Pos_Record_Index).w,d0
		lea	(Sonic_Pos_Record_Buf).w,a1
		lea	(a1,d0.w),a1
		move.w	8(a0),(a1)+
		move.w	$C(a0),(a1)+
		addq.b	#4,(Sonic_Pos_Record_Index+1).w
		lea	(Sonic_Stat_Record_Buf).w,a1
		move.w	(Ctrl_1).w,(a1,d0.w)
		rts
; End of function Sonic_RecordPos

; ---------------------------------------------------------------------------
; Seemingly an earlier subroutine to copy Sonic's status flags for Tails' AI,
; also presnet in the Nick Arcade prototype
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FE1E: Unused_RecordPos:
		move.w	(unk_EEE0).w,d0
		subq.b	#4,d0
		lea	(unk_E600).w,a1
		lea	(a1,d0.w),a2
		move.w	8(a0),d1
		swap	d1
		move.w	$C(a0),d1
		cmp.l	(a2),d1
		beq.s	return_FE4C
		addq.b	#4,d0
		lea	(a1,d0.w),a2
		move.w	8(a0),(a2)+
		move.w	$C(a0),(a2)
		addq.b	#4,(unk_EEE0+1).w

return_FE4C:
		rts
; End of function Unused_RecordPos

; ---------------------------------------------------------------------------
; Subroutine for Sonic when he's underwater
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FE4E:
Sonic_Water:
		tst.b	(Water_flag).w		; is this a water level?
		bne.s	Obj01_InWater		; if not, branch

return_FE54:
		rts
; ---------------------------------------------------------------------------
; loc_FE56: Sonic_InLevelWithWater:
Obj01_InWater:
		move.w	(Water_Level_1).w,d0
		cmp.w	$C(a0),d0		; is Sonic underwater?
		bge.s	Obj01_OutWater		; if not, branch

		bset	#6,$22(a0)		; set underwater flag
		bne.s	return_FE54		; if already underwater, branch

		bsr.w	ResumeMusic
		move.b	#$A,($FFFFB340).w	; load Obj0A (Sonic's breathing bubbles) at $FFFFB340
		move.b	#$81,($FFFFB368).w
		move.w	#$300,(Sonic_top_speed).w
		move.w	#6,(Sonic_acceleration).w
		move.w	#$40,(Sonic_deceleration).w
		asr.w	$10(a0)
		asr.w	$12(a0)			; memory operands can only be shifted one bit at a time
		asr.w	$12(a0)
		beq.s	return_FE54
		move.b	#8,($FFFFB300).w	; load Obj08 (splash animation) at $FFFFB300
		move.w	#$AA,d0			; splash sound
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------
; loc_FEA8: Sonic_NotInWater:
Obj01_OutWater:
		bclr	#6,$22(a0)	; clear underwater flag
		beq.s	return_FE54	; if already cleared, branch
		bsr.w	ResumeMusic
		move.w	#$600,(Sonic_top_speed).w
		move.w	#$C,(Sonic_acceleration).w
		move.w	#$80,(Sonic_deceleration).w
		asl.w	$12(a0)
		beq.w	return_FE54
		move.b	#8,($FFFFB300).w	; load Obj08 (splash animation) at $FFFFB300
		cmpi.w	#$F000,$12(a0)
		bgt.s	loc_FEE2
		move.w	#$F000,$12(a0)		; limit upwards y-velocity when exiting out of water

loc_FEE2:
		move.w	#$AA,d0			; splash sound
		jmp	(PlaySound).l
; End of subroutine Sonic_Water

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of subroutine Obj01_MdNormal
; Called if Sonic is neither airborne nor rolling this frame
; ---------------------------------------------------------------------------
; loc_FEEC: Sonic_MdNormal:
Obj01_MdNormal:
		bsr.w	Sonic_CheckSpindash
		bsr.w	Sonic_Jump
		bsr.w	Sonic_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	Sonic_Roll
		bsr.w	Sonic_LevelBound
		jsr	(SpeedToPos).l
		bsr.w	AnglePos
		bsr.w	Sonic_SlopeRepel
		rts
; End of subroutine Obj01_MdNormal

; ===========================================================================
; Start of subroutine Obj01_MdAir
; Called if Sonic is airborne, but not in a ball (thus, probably not jumping)
; loc_FF14: Sonic_MdJump
Obj01_MdAir:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Sonic_LevelBound
		jsr	(ObjectFall).l
		btst	#6,$22(a0)	; is Sonic underwater?
		beq.s	loc_FF34	; if not, branch
		subi.w	#$28,$12(a0)	; reduce gravity by $28 ($38-$28=$10)

loc_FF34:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_DoLevelCollision
		rts
; End of subroutine Obj01_MdAir

; ===========================================================================
; Start of subroutine Obj01_MdRoll
; Called if Sonic is in a ball, but not airborne (thus, probably rolling)
; loc_FF3E: Sonic_MdRoll:
Obj01_MdRoll:
		bsr.w	Sonic_Jump
		bsr.w	Sonic_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Sonic_LevelBound
		jsr	(SpeedToPos).l
		bsr.w	AnglePos
		bsr.w	Sonic_SlopeRepel
		rts
; End of subroutine Obj01_MdRoll

; ===========================================================================
; Start of subroutine Obj01_MdJump (an Obj01_MdAir clone)
; Called if Sonic is in a ball and airborne (he could be jumping but not necessarily)
; loc_FF5E: Sonic_MdJump2:
Obj01_MdJump:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Sonic_LevelBound
		jsr	(ObjectFall).l
		btst	#6,$22(a0)	; is Sonic underwater?
		beq.s	loc_FF7E	; if not, branch
		subi.w	#$28,$12(a0)	; reduce gravity by $28 ($38-$28=$10)

loc_FF7E:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_DoLevelCollision
		rts
; End of subroutine Obj01_MdJump

; ---------------------------------------------------------------------------
; Subroutine to make Sonic walk/run
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FF88:
Sonic_Move:
		move.w	(Sonic_top_speed).w,d6
		move.w	(Sonic_acceleration).w,d5
		move.w	(Sonic_deceleration).w,d4

		tst.b	(Sliding_flag).w		; is Sonic sliding?
		bne.w	Obj01_Traction			; if yes, branch
		tst.w	$2E(a0)				; is Sonic's controls locked?
		bne.w	Obj01_UpdateSpeedOnGround	; if yes, branch
		btst	#2,(Ctrl_1_Held_Logical).w	; is left being pressed?
		beq.s	Obj01_NotLeft			; if not, branch
		bsr.w	Sonic_MoveLeft
; loc_FFB0:
Obj01_NotLeft:
		btst	#3,(Ctrl_1_Held_Logical).w	; is right being pressed?
		beq.s	Obj01_NotRight		; if not, branch
		bsr.w	Sonic_MoveRight
; loc_FFBC:
Obj01_NotRight:
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0				; is Sonic on a slope?
		bne.w	Obj01_UpdateSpeedOnGround	; if yes, branch
		tst.w	$14(a0)				; is Sonic moving?
		bne.w	Obj01_UpdateSpeedOnGround	; if yes, branch
		bclr	#5,$22(a0)
		move.b	#5,$1C(a0)	; use "standing" animation
		; check how close/far Sonic is from the edge
		btst	#3,$22(a0)	; is Sonic on the edge?
		beq.s	Sonic_Balance	; if yes, branch
		moveq	#0,d0
		move.b	$3D(a0),d0
		lsl.w	#6,d0
		lea	($FFFFB000).w,a1
		lea	(a1,d0.w),a1
		tst.b	$22(a1)
		bmi.s	Sonic_LookUp
		moveq	#0,d1
		move.b	$19(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#4,d2
		add.w	8(a0),d1
		sub.w	8(a1),d1
		cmpi.w	#4,d1
		blt.s	Sonic_BalanceOnObjLeft
		cmp.w	d2,d1
		bge.s	Sonic_BalanceOnObjRight
		bra.s	Sonic_LookUp
; ===========================================================================
; loc_1001E:
Sonic_Balance:
		jsr	(ChkFloorEdge).l
		cmpi.w	#$C,d1
		blt.s	Sonic_LookUp
		cmpi.b	#3,$36(a0)
		bne.s	loc_1003A
; loc_10032:
Sonic_BalanceOnObjRight:
		bclr	#0,$22(a0)
		bra.s	loc_10048

loc_1003A:
		cmpi.b	#3,$37(a0)
		bne.s	Sonic_LookUp
; loc_10042:
Sonic_BalanceOnObjLeft:		
		bset	#0,$22(a0)

loc_10048:		
		move.b	#6,$1C(a0)
		bra.s	Obj01_UpdateSpeedOnGround
; ===========================================================================
; loc_10050:
Sonic_LookUp:
		btst	#0,(Ctrl_1_Held_Logical).w	; is up being pressed?
		beq.s	Sonic_Duck		; if not, branch
		move.b	#7,$1C(a0)		; use "looking up" animation
		bra.s	Obj01_UpdateSpeedOnGround
; ===========================================================================
; loc_10060:
Sonic_Duck:
		btst	#1,(Ctrl_1_Held_Logical).w	; is down being pressed?
		beq.s	Obj01_UpdateSpeedOnGround	; if not, branch
		move.b	#8,$1C(a0)		; use "ducking" animation
; ===========================================================================
; ---------------------------------------------------------------------------
; updates Sonic's speed on the ground
; ---------------------------------------------------------------------------
; sub_1006E:
Obj01_UpdateSpeedOnGround:
		move.b	(Ctrl_1_Held_Logical).w,d0
		andi.b	#$C,d0
		bne.s	Obj01_Traction
		move.w	$14(a0),d0
		beq.s	Obj01_Traction
		bmi.s	Obj01_SettleLeft

; slow down when facing right and not pressing a direction
; Obj01_SettleRight:
		sub.w	d5,d0
		bcc.s	loc_10088
		move.w	#0,d0

loc_10088:
		move.w	d0,$14(a0)
		bra.s	Obj01_Traction
; ---------------------------------------------------------------------------
; slow down when facing left and not pressing a direction
; loc_1008E:
Obj01_SettleLeft:
		add.w	d5,d0
		bcc.s	loc_10096
		move.w	#0,d0

loc_10096:
		move.w	d0,$14(a0)

; increase or decrease speed on the ground
; loc_1009A:
Obj01_Traction:
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d1
		asr.l	#8,d1
		move.w	d1,$10(a0)
		muls.w	$14(a0),d0
		asr.l	#8,d0
		move.w	d0,$12(a0)

; stops Sonic from running through walls that meet the ground
; loc_100B8:
Obj01_CheckWallsOnGround:
		move.b	$26(a0),d0
		addi.b	#$40,d0
		bmi.s	loc_10128
		move.b	#$40,d1		; rotate 90 degress clockwise
		tst.w	$14(a0)		; is Sonic moving?
		beq.s	loc_10128	; if not, branch
		bmi.s	loc_100D0	; if negative, branch
		neg.w	d1		; rotate COUNTER-clockwise

loc_100D0:
		move.b	$26(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	Sonic_WalkSpeed
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	loc_10128
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_10124
		cmpi.b	#$40,d0
		beq.s	loc_10112
		cmpi.b	#$80,d0
		beq.s	loc_1010C
		add.w	d1,$10(a0)
		bset	#5,$22(a0)
		move.w	#0,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_1010C:
		sub.w	d1,$12(a0)
		rts
; ---------------------------------------------------------------------------

loc_10112:
		sub.w	d1,$10(a0)
		bset	#5,$22(a0)
		move.w	#0,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_10124:
		add.w	d1,$12(a0)
; ---------------------------------------------------------------------------

loc_10128:
		rts
; End of subroutine Sonic_Move    


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1012A:
Sonic_MoveLeft:
		move.w	$14(a0),d0
		beq.s	loc_10132	; is Sonic starting to move to the right?
		bpl.s	Sonic_TurnLeft	; if not, branch

loc_10132:
		bset	#0,$22(a0)
		bne.s	loc_10146
		bclr	#5,$22(a0)
		move.b	#1,$1D(a0)	; force walking animation to restart if it's already in-progress

loc_10146:
		sub.w	d5,d0		; add acceleration to the left
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0		; compare new speed with top speed
		bgt.s	loc_10158	; if new speed is less than the maximum, branch
		add.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d1,d0		; compare speed with top speed
		ble.s	loc_10158	; if speed was already greater than the maximum, branch
		move.w	d1,d0		; limit speed on ground going left

loc_10158:
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)	; use walking animation
		rts
; ---------------------------------------------------------------------------
; loc_10164:
Sonic_TurnLeft:
		sub.w	d4,d0
		bcc.s	loc_1016C
		move.w	#-$80,d0

loc_1016C:
		move.w	d0,$14(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	return_1019A
		cmpi.w	#$400,d0             
		blt.s	return_1019A
		move.b	#$D,$1C(a0)	; use "stopping" animation
		bclr	#0,$22(a0)
		move.w	#$A4,d0
		jsr	(PlaySound).l

return_1019A:
		rts
; End of subroutine Sonic_MoveLeft


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1019C:
Sonic_MoveRight:
		move.w	$14(a0),d0
		bmi.s	Sonic_TurnRight	; if Sonic is already moving to the left, branch
		bclr	#0,$22(a0)
		beq.s	loc_101B6
		bclr	#5,$22(a0)
		move.b	#1,$1D(a0)	; force walking animation to restart if it's already in-progress

loc_101B6:
		add.w	d5,d0		; add acceleration to the right
		cmp.w	d6,d0		; compare new speed with top speed
		blt.s	loc_101C4	; if new speed is less than the maximum, branch
		sub.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d6,d0		; compare speed with top speed
		bge.s	loc_101C4	; if speed was already greater than the maximum, branch
		move.w	d6,d0		; limit speed on ground going right

loc_101C4:
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)	; use walking animation
		rts
; ---------------------------------------------------------------------------
; loc_101D0:
Sonic_TurnRight:
		add.w	d4,d0
		bcc.s	loc_101D8
		move.w	#$80,d0

loc_101D8:
		move.w	d0,$14(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	return_10206
		cmpi.w	#-$400,d0
		bgt.s	return_10206
		move.b	#$D,$1C(a0)	; use "stopping" animation
		bset	#0,$22(a0)
		move.w	#$A4,d0
		jsr	(PlaySound).l

return_10206:
		rts
; End of subroutine Sonic_MoveRight

; ---------------------------------------------------------------------------
; Subroutine to change Sonic's speed as he rolls
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10208:
Sonic_RollSpeed:
		move.w	(Sonic_top_speed).w,d6
		asl.w	#1,d6
		move.w	(Sonic_acceleration).w,d5
		asr.w	#1,d5	; natural roll deceleration = 1/2 normal acceleration
		; These two lines are unchanged from Sonic 1, the final would replace
		; them with "move.w #$20,d4", which made Sonic decelerate much faster
		; underwater, but they forgot to apply the change to Tails
		move.w	(Sonic_deceleration).w,d4
		asr.w	#2,d4
		tst.b	(Sliding_flag).w
		bne.w	Sonic_SetRollSpeeds
		tst.w	$2E(a0)
		bne.s	Sonic_ApplyRollSpeed
		btst	#2,(Ctrl_1_Held_Logical).w	; is left being pressed?
		beq.s	loc_10234		; if not, branch
		bsr.w	Sonic_RollLeft

loc_10234:
		btst	#3,(Ctrl_1_Held_Logical).w	; is right being pressed?
		beq.s	Sonic_ApplyRollSpeed	; if not, branch
		bsr.w	Sonic_RollRight
; loc_10240:
Sonic_ApplyRollSpeed:
		move.w	$14(a0),d0
		beq.s	Sonic_CheckRollStop
		bmi.s	Sonic_ApplyRollSpeedLeft

; Sonic_ApplyRollSpeedRight:
		sub.w	d5,d0
		bcc.s	loc_10250
		move.w	#0,d0

loc_10250:
		move.w	d0,$14(a0)
		bra.s	Sonic_CheckRollStop
; ---------------------------------------------------------------------------
; loc_10256:
Sonic_ApplyRollSpeedLeft:
		add.w	d5,d0
		bcc.s	loc_1025E
		move.w	#0,d0

loc_1025E:
		move.w	d0,$14(a0)
; loc_10262:
Sonic_CheckRollStop:
		tst.w	$14(a0)
		bne.s	Sonic_SetRollSpeeds
		bclr	#2,$22(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.b	#5,$1C(a0)
		subq.w	#5,$C(a0)
; ---------------------------------------------------------------------------
; loc_10284:
Sonic_SetRollSpeeds:
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d0
		asr.l	#8,d0
		move.w	d0,$12(a0)	; set y velocity based on $14 and angle
		muls.w	$14(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_102A8
		move.w	#$1000,d1	; limit Sonic's speed rolling right

loc_102A8:
		cmpi.w	#-$1000,d1
		bge.s	loc_102B2
		move.w	#-$1000,d1	; limit Sonic's speed rolling left

loc_102B2:
		move.w	d1,$10(a0)	; set x velocity based on $14 and angle
		bra.w	Obj01_CheckWallsOnGround
; End of function Sonic_RollSpeed


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_102BA:
Sonic_RollLeft:
		move.w	$14(a0),d0
		beq.s	+
		bpl.s	Sonic_BrakeRollingRight
+
		bset	#0,$22(a0)
		move.b	#2,$1C(a0)	; use "rolling" animation
		rts
; ---------------------------------------------------------------------------
; loc_102D0:
Sonic_BrakeRollingRight:
		sub.w	d4,d0		; reduce rightward rolling speed
		bcc.s	loc_102D8
		move.w	#$FF80,d0

loc_102D8:
		move.w	d0,$14(a0)
		rts
; End of function Sonic_RollLeft


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_102DE:
Sonic_RollRight:
		move.w	$14(a0),d0
		bmi.s	Sonic_BrakeRollingLeft
		bclr	#0,$22(a0)
		move.b	#2,$1C(a0)	; use "rolling" animation
		rts
; ---------------------------------------------------------------------------
; loc_102F2:
Sonic_BrakeRollingLeft:
		add.w	d4,d0		; reduce leftward rolling speed
		bcc.s	+
		move.w	#$80,d0
+
		move.w	d0,$14(a0)
		rts
; End of subroutine Sonic_RollRight

; ---------------------------------------------------------------------------
; Subroutine for moving Sonic left or right when he's in the air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10300:
Sonic_ChgJumpDir:
		move.w	(Sonic_top_speed).w,d6
		move.w	(Sonic_acceleration).w,d5
		asl.w	#1,d5
		btst	#4,$22(a0)		; did Sonic jump from rolling?
		bne.s	Obj01_Jump_ResetScr	; if yes, branch to skip midair control
		move.w	$10(a0),d0
		btst	#2,(Ctrl_1_Held_Logical).w
		beq.s	+	; if not holding left, branch

		bset	#0,$22(a0)
		sub.w	d5,d0	; add acceleration to the left
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0	; compare new speed with top speed
		bgt.s	+	; if new speed is less than the maximum, branch
		move.w	d1,d0	; limit speed in air going left, even if Sonic was already going faster (speed limit/cap)
+
		btst	#3,(Ctrl_1_Held_Logical).w
		beq.s	+	; if not holding right, branch

		bclr	#0,$22(a0)
		add.w	d5,d0	; accelerate right in the air
		cmp.w	d6,d0	; compare new speed to top speed
		blt.s	+	; if new speed is less than maximum, branch
		move.w	d6,d0	; limit speed in air going right, even if Sonic was already going faster (speed limit/cap)
; Obj01_JumpMove:
+		move.w	d0,$10(a0)

; loc_1034A: Obj01_ResetScr2:
Obj01_Jump_ResetScr:
		cmpi.w	#$60,(Camera_Y_pos_bias).w	; is screen in its default position?
		beq.s	Sonic_JumpPeakDecelerate	; if yes, branch
		bcc.s	+			; depending on the sign of the difference,
		addq.w	#4,(Camera_Y_pos_bias).w	; either add 2
+		subq.w  #2,(Camera_Y_pos_bias).w	; or subtract 2

; loc_1035C:
Sonic_JumpPeakDecelerate:
		cmpi.w	#-$400,$12(a0)	; is Sonic moving faster than -$400 upwards?
		bcs.s	return_1038A	; if yes, branch
		move.w	$10(a0),d0
		move.w	d0,d1
		asr.w	#5,d1		; d1 = x_velocity / 32
		beq.s	return_1038A	; return of d1 is 0
		bmi.s	Sonic_JumpPeakDecelerateLeft	; branch if moving left

; Sonic_JumpPeakDecelerateRight:
		sub.w	d1,d0	; reduce x velocity by d1
		bcc.s	+
		move.w	#0,d0
+
		move.w	d0,$10(a0)
		rts
;-------------------------------------------------------------
; loc_1037E:
Sonic_JumpPeakDecelerateLeft:
		sub.w	d1,d0	; reduce x velocity by d1
		bcs.s	+
		move.w	#0,d0
+
		move.w  d0,$10(a0)

return_1038A:
		rts
; End of subroutine Sonic_ChgJumpDir

; ---------------------------------------------------------------------------
; Subroutine to prevent Sonic from leaving the boundaries of a level
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1038C: Sonic_LevelBoundaries:
Sonic_LevelBound:
		move.l	8(a0),d1
		move.w	$10(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(Camera_Min_X_pos).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0		; has Sonic touched the left boundary?
		bhi.s	Sonic_Boundary_Sides	; if yes, branch
		move.w	(Camera_Max_X_pos).w,d0
		addi.w	#320-24,d0	; screen width - Sonic's width_pixels
		tst.b	(Current_Boss_ID).w
		bne.s	loc_103BA
		addi.w	#$40,d0

loc_103BA:
		cmp.w	d1,d0		; has Sonic touched the right boundary?
		bls.s	Sonic_Boundary_Sides	; if yes, branch
; loc_103BE:
Sonic_Boundary_CheckBottom:
		move.w	(Camera_Max_Y_pos_now).w,d0
		addi.w	#$E0,d0
		cmp.w	$C(a0),d0
		blt.s	Sonic_Boundary_Bottom
		rts
; ===========================================================================
; loc_103CE:
Sonic_Boundary_Bottom:
		bra.w	JmpTo_KillSonic
; ---------------------------------------------------------------------------
; Leftover from Sonic 1, which would transport the player to SBZ3/LZ4 upon
; reaching a certain position; its ID is different, for whatever reason
		cmpi.w	#death_egg_zone_act_2,(Current_ZoneAndAct).w	; is it DEZ2?
		bne.w	JmpTo_KillSonic			; if not, branch
		cmpi.w	#$2000,($FFFFB008).w		; is Sonic beyond x position $2000?
		bcs.w	JmpTo_KillSonic			; if not, branch
		clr.b	(Last_star_pole_hit).w
		move.w	#1,(Level_Inactive_flag).w
		move.w	#labyrinth_zone_act_4,(Current_ZoneAndAct).w	; restart in OWZ4
		rts
; ===========================================================================
; loc_103F8:
Sonic_Boundary_Sides:
		move.w	d0,8(a0)
		move.w	#0,$A(a0)
		move.w	#0,$10(a0)
		move.w	#0,$14(a0)
		bra.s	Sonic_Boundary_CheckBottom
; End of function Sonic_LevelBound

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to start rolling when he's moving
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10410:
Sonic_Roll:
		tst.b	(Sliding_flag).w
		bne.s	Obj01_NoRoll
		move.w	$14(a0),d0
		bpl.s	loc_1041E
		neg.w	d0

loc_1041E:
		cmpi.w	#$80,d0		; is Sonic moving at $80 speed or faster?
		bcs.s	Obj01_NoRoll	; if not, branch
		move.b	(Ctrl_1_Held_Logical).w,d0
		andi.b	#$C,d0		; is left/right being pressed?
		bne.s	Obj01_NoRoll	; if yes, branch
		btst	#1,(Ctrl_1_Held_Logical).w	; is down being pressed?
		bne.s	Obj01_ChkRoll	; if yes, branch
; return_10436: Sonic_NoRoll:
Obj01_NoRoll:
		rts
; ---------------------------------------------------------------------------
; loc_10438:
Obj01_ChkRoll:
		btst	#2,$22(a0)
		beq.s	Obj01_DoRoll
		rts
; ---------------------------------------------------------------------------
; loc_10442: Sonic_DoRoll:
Obj01_DoRoll:
		bset	#2,$22(a0)
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)	; use "rolling" animation
		addq.w	#5,$C(a0)
		move.w	#$BE,d0
		jsr	(PlaySound).l	; play rolling sound
		tst.w	$14(a0)
		bne.s	return_10474
		move.w	#$200,$14(a0)

return_10474:
		rts
; End of function Sonic_Roll

; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to jump
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10476:
Sonic_Jump:
		move.b	(Ctrl_1_Press_Logical).w,d0
		andi.b	#$70,d0		; is A, B or C pressed?
		beq.w	return_1051A	; if not, branch
		moveq	#0,d0
		move.b	$26(a0),d0
		addi.b	#$80,d0
		bsr.w	loc_136F2
		cmpi.w	#6,d1		; does Sonic have enough room to jump?
		blt.w	return_1051A	; if not, branch
		move.w	#$680,d2
		btst	#6,$22(a0)	; is Sonic underwater?
		beq.s	+		; if not, branch
		move.w	#$380,d2	; reduce jump speed
+
		moveq	#0,d0
		move.b	$26(a0),d0
		subi.b	#$40,d0
		jsr	(CalcSine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,$10(a0)	; make Sonic jump (in X... this adds nothing on level ground)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,$12(a0)	; make Sonic jump (in Y)
		bset	#1,$22(a0)
		bclr	#5,$22(a0)
		addq.l	#4,sp
		move.b	#1,$3C(a0)
		clr.b	$38(a0)
		move.w	#$A0,d0
		jsr	(PlaySound).l	; play jumping sound
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		btst	#2,$22(a0)
		bne.s	Sonic_RollJump
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)	; use "jumping" animation
		bset	#2,$22(a0)
		addq.w	#5,$C(a0)

return_1051A:
		rts
; ---------------------------------------------------------------------------
; loc_1051C:
Sonic_RollJump:
		bset	#4,$22(a0)	; set the rolling+jumping flag
		rts
; End of function Sonic_Jump

; ---------------------------------------------------------------------------
; Subroutine letting Sonic control the height of the jump
; when the jump button is released
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10524:
Sonic_JumpHeight:
		tst.b	$3C(A0)		; is Sonic jumping?
		beq.s	Sonic_UpVelCap	; if not, branch

		move.w	#-$400,d1
		btst	#6,$22(a0)	; is Sonic underwater?
		beq.s	loc_1053A	; if not, branch
		move.w	#-$200,d1

loc_1053A:
		cmp.w	$12(a0),d1	; is Sonic going up faster than d1?
		ble.s	return_1054E	; if not, branch
		move.b	(Ctrl_1_Held_Logical).w,d0
		andi.b	#$70,d0		; is A/B/C pressed?
		bne.s	return_1054E	; if yes, branch
		move.w	d1,$12(a0)	; immediately reduce Sonic's upward speed to d1

return_1054E:
		rts  
; ---------------------------------------------------------------------------
; loc_10550:
Sonic_UpVelCap:
		cmpi.w	#-$FC0,$12(a0)	; is Sonic moving up really fast?
		bge.s	return_1055E	; if not, branch
		move.w	#-$FC0,$12(a0)	; cap upward speed

return_1055E:
		rts
; End of subroutine Sonic_JumpHeight
		  
; ---------------------------------------------------------------------------
; Subroutine to check for starting to charge a spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10560: Sonic_Spindash:
Sonic_CheckSpindash:
		tst.b	$39(a0)
		bne.s	Sonic_UpdateSpindash
		cmpi.b	#8,$1C(a0)
		bne.s	return_10592
		move.b	(Ctrl_1_Press_Logical).w,d0
		andi.b	#$70,d0
		beq.w	return_10592
		move.b	#9,$1C(a0)
		move.w	#$BE,d0
		jsr	(PlaySound).l
		addq.l	#4,sp
		move.b	#1,$39(a0)

return_10592:
		rts
; ===========================================================================
; loc_10594:
Sonic_UpdateSpindash:
		move.b	(Ctrl_1_Held_Logical).w,d0
		btst	#1,d0
		bne.s	Sonic_ChargingSpindash

		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)
		addq.w	#5,$C(a0)
		move.b	#0,$39(a0)
		move.w	#$2000,(Horiz_scroll_delay_val).w
		move.w	#$800,$14(a0)
		btst	#0,$22(a0)
		beq.s	loc_105D2
		neg.w	$14(a0)

loc_105D2:
		bset	#2,$22(a0)
		rts
; ===========================================================================
; loc_105DA:
Sonic_ChargingSpindash:
		move.b	(Ctrl_1_Press_Logical).w,d0
		andi.b	#$70,d0
		beq.w	loc_105E8
		nop

loc_105E8:
		addq.l  #4,sp
		rts
; End of function Sonic_CheckSpindash

; ---------------------------------------------------------------------------
; Subroutine to slow Sonic walking up a slope
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_105EC:
Sonic_SlopeResist:
		move.b	$26(a0),d0
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bcc.s	return_10620
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	$14(a0)
		beq.s	return_10620
		bmi.s	loc_1061C
		tst.w	d0
		beq.s	return_1061A
		add.w	d0,$14(a0)

return_1061A:
		rts
; ---------------------------------------------------------------------------

loc_1061C:
		add.w	d0,$14(a0)

return_10620:
		rts
; End of subroutine Sonic_SlopeResist

; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope while he's rolling
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10622:
Sonic_RollRepel:
		move.b	$26(a0),d0
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bcc.s	return_1065C
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	$14(a0)
		bmi.s	loc_10652
		tst.w	d0
		bpl.s	loc_1064C
		asr.l	#2,d0

loc_1064C:
		add.w	d0,$14(a0)
		rts
; ===========================================================================

loc_10652:
		tst.w	d0
		bmi.s	loc_10658
		asr.l	#2,d0

loc_10658:
		add.w	d0,$14(a0)

return_1065C:
		rts
; End of function Sonic_RollRepel

; ---------------------------------------------------------------------------
; Subroutine to push Sonic down a slope
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1065E:
Sonic_SlopeRepel:
		nop
		tst.b	$38(a0)
		bne.s	return_10698
		tst.w	$2E(a0)
		bne.s	loc_1069A
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	return_10698
		move.w	$14(a0),d0
		bpl.s	+
		neg.w	d0
+
		cmpi.w	#$280,d0
		bcc.s	return_10698
		clr.w	$14(a0)
		bset	#1,$22(a0)
		move.w	#$1E,$2E(a0)

return_10698:
		rts
; ===========================================================================

loc_1069A:
		subq.w	#1,$2E(a0)
		rts
; End of function Sonic_SlopeRepel

; ---------------------------------------------------------------------------
; Subroutine to return Sonic's angle to 0 as he jumps
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_106A0:
Sonic_JumpAngle:
		move.b	$26(a0),d0	; get Sonic's angle
		beq.s	Sonic_JumpFlip	; if already 0, branch
		bpl.s	loc_106B0	; if higher than 0, branch

		addq.b	#2,d0		; increase angle
		bcc.s	BranchTo_Sonic_JumpAngleSet
		moveq	#0,d0
; loc_106AE:
BranchTo_Sonic_JumpAngleSet:
		bra.s	Sonic_JumpAngleSet
; ===========================================================================

loc_106B0:
		subq.b	#2,d0		; decrease angle
		bcc.s	Sonic_JumpAngleSet
		moveq	#0,d0
; loc_106B6:
Sonic_JumpAngleSet:
		move.b	d0,$26(a0)
; End of function Sonic_JumpAngle
	; continue straight to Sonic_JumpFlip

; ---------------------------------------------------------------------------
; Updates Sonic's secondary angle if he's tumbling
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_106BA:
Sonic_JumpFlip:
		move.b	$27(a0),d0
		beq.s	return_106FE
		tst.w	$14(a0)
		bmi.s	Sonic_JumpLeftFlip
; loc_106C6:
Sonic_JumpRightFlip:
		move.b	$2D(a0),d1
		add.b	d1,d0
		bcc.s	BranchTo_Sonic_JumpFlipSet
		subq.b	#1,$2C(a0)
		bcc.s	BranchTo_Sonic_JumpFlipSet
		move.b	#0,$2C(a0)
		moveq	#0,d0
; loc_106DC:
BranchTo_Sonic_JumpFlipSet:
		bra.s   Sonic_JumpFlipSet
; ===========================================================================
; loc_106DE:
Sonic_JumpLeftFlip:
		tst.b	$29(a0)
		bne.s	Sonic_JumpRightFlip
		move.b	$2D(a0),d1
		sub.b	d1,d0
		bcc.s	Sonic_JumpFlipSet
		subq.b	#1,$2C(a0)
		bcc.s	Sonic_JumpFlipSet
		move.b	#0,$2C(a0)
		moveq	#0,d0
; loc_106FA:
Sonic_JumpFlipSet:
		move.b	d0,$27(a0)

return_106FE:		
		rts
; End of function Sonic_JumpAngle

; ---------------------------------------------------------------------------
; Subroutine for Sonic to interact with the floor and walls when he's in the air
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10700: Sonic_Floor:
Sonic_DoLevelCollision:
		move.l	#Primary_Collision,(Collision_addr).w
		cmpi.b	#$C,$3E(a0)
		beq.s	loc_10718
		move.l	#Secondary_Collision,(Collision_addr).w

loc_10718:
		move.b	$3F(a0),d5
		move.w	$10(a0),d1
		move.w	$12(a0),d2
		jsr	(CalcAngle).l
		move.b	d0,$2B(a0)
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	Sonic_HitLeftWall
		cmpi.b	#$80,d0
		beq.w	Sonic_HitCeilingAndWalls
		cmpi.b	#$C0,d0
		beq.w	loc_108AA
		bsr.w	Sonic_HitWall
		tst.w	d1
		bpl.s	loc_10760
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_10760:
		bsr.w	loc_1397A
		tst.w	d1
		bpl.s	loc_10772
		add.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_10772:
		bsr.w	loc_13736
		tst.w	d1
		bpl.s	return_107EA
		move.b	$12(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_1078A
		cmp.b	d2,d0
		blt.s	return_107EA

loc_1078A:
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Sonic_ResetOnFloor
		move.b	#0,$1C(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_107C8
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	loc_107BA
		asr.w	$12(a0)
		bra.s	loc_107DC
; ===========================================================================

loc_107BA:
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)
		rts
; ===========================================================================

loc_107C8:
		move.w	#0,$10(a0)	; stop Sonic since he hit a wall
		cmpi.w	#$FC0,$12(a0)
		ble.s	loc_107DC
		move.w	#$FC0,$12(a0)

loc_107DC:
		move.w	$12(a0),$14(a0)
		tst.b	d3
		bpl.s	return_107EA
		neg.w	$14(a0)

return_107EA:
		rts
; ===========================================================================
; loc_107EC:
Sonic_HitLeftWall:
		bsr.w	Sonic_HitWall
		tst.w	d1
		bpl.s	Sonic_HitCeiling
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)
		move.w	$12(a0),$14(a0)
		rts
; ===========================================================================
; loc_10806:
Sonic_HitCeiling:
		bsr.w	Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	Sonic_HitFloor
		sub.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	return_1081E
		move.w	#0,$12(a0)

return_1081E:
		rts
; ===========================================================================
; loc_10820:
Sonic_HitFloor:
		tst.w	$12(a0)
		bmi.s	return_1084C
		bsr.w	loc_13736
		tst.w	d1
		bpl.s	return_1084C
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Sonic_ResetOnFloor
		move.b	#0,$1C(a0)
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)

return_1084C:
		rts
; ===========================================================================
; loc_1084E:
Sonic_HitCeilingAndWalls:
		bsr.w	Sonic_HitWall
		tst.w	d1
		bpl.s	loc_10860
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_10860:
		bsr.w     loc_1397A
		tst.w   D1
		bpl.s   loc_10872
		add.w   D1, $0008(A0)
		move.w  #$0000, $0010(A0)
loc_10872:
		bsr.w     Sonic_DontRunOnWalls    ; loc_139CC
		tst.w   D1
		bpl.s   loc_108A8
		sub.w   D1, $000C(A0)
		move.b  D3, D0
		addi.b  #$20, D0
		andi.b  #$40, D0
		bne.s   loc_10892
		move.w  #$0000, $0012(A0)
		rts
loc_10892:
		move.b  D3, $0026(A0)
		bsr.w     Sonic_ResetOnFloor      ; loc_1090C
		move.w  $0012(A0), $0014(A0)
		tst.b   D3
		bpl.s   loc_108A8
		neg.w   $0014(A0)
loc_108A8:
		rts
loc_108AA:
		bsr.w     loc_1397A
		tst.w   D1
		bpl.s   loc_108C4
		add.w   D1, $0008(A0)
		move.w  #$0000, $0010(A0)
		move.w  $0012(A0), $0014(A0)
		rts
loc_108C4:
		bsr.w     Sonic_DontRunOnWalls    ; loc_139CC
		tst.w   D1
		bpl.s   loc_108DE
		sub.w   D1, $000C(A0)
		tst.w   $0012(A0)
		bpl.s   loc_108DC
		move.w  #$0000, $0012(A0)
loc_108DC:
		rts
loc_108DE:
		tst.w   $0012(A0)
		bmi.s   loc_1090A
		bsr.w     loc_13736
		tst.w   D1
		bpl.s   loc_1090A
		add.w   D1, $000C(A0)
		move.b  D3, $0026(A0)
		bsr.w     Sonic_ResetOnFloor      ; loc_1090C
		move.b  #$00, $001C(A0)
		move.w  #$0000, $0012(A0)
		move.w  $0010(A0), $0014(A0)
loc_1090A:
		rts
; End of function Sonic_DoLevelCollision

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to reset Sonic's mode when he lands on the floor
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1090C:
Sonic_ResetOnFloor:
		btst	#4,$22(a0)
		beq.s	loc_1091A
		nop
		nop
		nop

loc_1091A:
		bclr	#5,$22(a0)
		bclr	#1,$22(a0)
		bclr	#4,$22(a0)
		btst	#2,$22(a0)
		beq.s	loc_10950
		bclr	#2,$22(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.b	#0,$1C(a0)
		subq.w	#5,$C(a0)

loc_10950:
		move.b	#0,$3C(a0)
		move.w	#0,(Chain_Bonus_counter).w
		move.b	#0,$27(a0)
		move.b	#0,$29(a0)
		rts
; End of function Sonic_ResetOnFloor

; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic when he gets hurt
; ---------------------------------------------------------------------------
; loc_1096A: Sonic_Hurt:
Obj01_Hurt:
		tst.b	$25(a0)
		bmi.w	Sonic_HurtInstantRecover
		jsr	(SpeedToPos).l
		addi.w	#$30,$12(a0)
		btst	#6,$22(a0)
		beq.s	loc_1098C
		subi.w	#$20,$12(a0)

loc_1098C:		    
		bsr.w	Sonic_HurtStop
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate
		bsr.w	LoadSonicDynPLC
		jmp	(DisplaySprite).l
; ===========================================================================
; loc_109A6:
Sonic_HurtStop:
		move.w	(Camera_Max_Y_pos_now).w,d0
		addi.w	#$E0,d0
		cmp.w	$C(a0),d0
		bcs.w	JmpTo_KillSonic
		bsr.w	Sonic_DoLevelCollision
		btst	#1,$22(a0)
		bne.s	+	; rts
		moveq	#0,d0
		move.w	d0,$12(a0)
		move.w	d0,$10(a0)
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)
		subq.b	#2,$24(a0)
		move.w	#$78,$30(a0)
+
		rts
; End of function Obj01_Hurt

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to make Sonic recover control after getting hit but before landing
; ---------------------------------------------------------------------------
; loc_109E2:
Sonic_HurtInstantRecover:
		subq.b	#2,$24(a0)
		move.b	#0,$25(a0)
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate
		bsr.w	LoadSonicDynPLC
		jmp	(DisplaySprite).l
; End of function Sonic_HurtInstantRecover

; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic when he dies
; ---------------------------------------------------------------------------
; loc_109FE: Sonic_Death:
Obj01_Dead:
		bsr.w	CheckGameOver
		jsr	(ObjectFall).l
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate
		bsr.w	LoadSonicDynPLC
		jmp	(DisplaySprite).l

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10A1A: Sonic_GameOver:
CheckGameOver:
		move.w	(Camera_Max_Y_pos_now).w,d0
		addi.w	#$100,d0
		cmp.w	$C(a0),d0
		bcc.w	return_10A9C
		move.w	#-$38,$12(a0)
		addq.b	#2,$24(a0)
		clr.b	(Update_HUD_timer).w
		addq.b	#1,(Update_HUD_lives).w
		subq.b	#1,(Life_count).w
		bne.s	Obj01_ResetLevel
		move.w	#0,$3A(a0)
		move.b	#$39,($FFFFB080).w
		move.b	#$39,($FFFFB0C0).w		 
		move.b	#1,($FFFFB0DA).w
		clr.b	(Time_Over_flag).w
; loc_10A5E:
Obj01_Finished:
		move.w	#MusID_GameOver,d0
		jsr	(PlayMusic).l
		moveq	#3,d0
		jmp	(LoadPLC).l
; End of function CheckGameOver

; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic when the level is restarted
; ---------------------------------------------------------------------------
; loc_10A70:
Obj01_ResetLevel:
		move.w	#$3C,$3A(a0)
		tst.b	(Time_Over_flag).w
		beq.s	return_10A9C
		move.w	#0,$3A(a0)
		move.b	#$39,($FFFFB080).w
		move.b	#$39,($FFFFB0C0).w
		move.b	#2,($FFFFB09A).w
		move.b	#3,($FFFFB0DA).w
		bra.s	Obj01_Finished

return_10A9C:
		rts
; End of function Obj01_ResetLevel

; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic when he's offscreen and waiting for the level to restart
; ---------------------------------------------------------------------------
; loc_10A9E: Sonic_ResetLevel:
Obj01_Gone:
		tst.w	$3A(a0)
		beq.s	+
		subq.w	#1,$3A(a0)
		bne.s	+
		move.w	#1,(Level_Inactive_flag).w
+
		rts
; End of function Obj01_Gone

;=============================================================================== 
; Sub Routine Sonic_Animate
; [ Begin ]		         
;===============================================================================		  
Sonic_Animate: ; loc_10AB2:
		lea     (Sonic_AnimateData).l, A1 ; loc_10CB4
		moveq   #$00, D0
		move.b  $001C(A0), D0
		cmp.b   $001D(A0), D0
		beq.s   loc_10ADA
		move.b  D0, $001D(A0)
		move.b  #$00, $001B(A0)
		move.b  #$00, $001E(A0)
		bclr    #$05, $0022(A0)
loc_10ADA:
		add.w   D0, D0
		adda.w  $00(A1, D0), A1
		move.b  (A1), D0
		bmi.s   loc_10B4A
		move.b  $0022(A0), D1
		andi.b  #$01, D1
		andi.b  #$FC, $0001(A0)
		or.b    D1, $0001(A0)
		subq.b  #$01, $001E(A0) 
		bpl.s   loc_10B18
		move.b  D0, $001E(A0)             
loc_10B00:		
		moveq   #$00, D1
		move.b  $001B(A0), D1
		move.b  $01(A1, D1), D0
		cmpi.b  #$F0, D0
		bcc.s   loc_10B1A
loc_10B10:		
		move.b  D0, $001A(A0)
		addq.b  #$01, $001B(A0)
loc_10B18:		
		rts
loc_10B1A:
		addq.b  #$01, D0
		bne.s   loc_10B2A
		move.b  #$00, $001B(A0)
		move.b  $0001(A1), D0
		bra.s   loc_10B10
loc_10B2A:
		addq.b  #$01, D0
		bne.s   loc_10B3E
		move.b  $02(A1, D1), D0
		sub.b   D0, $001B(A0)
		sub.b   D0, D1
		move.b  $01(A1, D1), D0
		bra.s   loc_10B10
loc_10B3E:
		addq.b  #$01, D0
		bne.s   loc_10B48
		move.b  $02(A1, D1), $001C(A0)
loc_10B48: 
		rts            
loc_10B4A: 
		subq.b  #$01, $001E(A0)
		bpl.s   loc_10B18
		addq.b  #$01, D0
		bne.w     loc_10C3E
		moveq   #$00, D0
		move.b  $0027(A0), D0
		bne.w     loc_10BD8
		moveq   #$00, D1
		move.b  $0026(A0), D0
		move.b  $0022(A0), D2
		andi.b  #$01, D2
		bne.s   loc_10B72
		not.b  d0
loc_10B72:
		addi.b  #$10, D0
		bpl.s   loc_10B7A
		moveq   #$03, D1
loc_10B7A:
		andi.b  #$FC, $0001(A0)
		eor.b   D1, D2
		or.b    D2, $0001(A0)
		btst    #$05, $0022(A0)
		bne.w    loc_10C82
		lsr.b   #$04, D0
		andi.b  #$06, D0
		move.w  $0014(A0), D2
		bpl.s   loc_10B9E
		neg.w   D2
loc_10B9E:
		lea     (Sonic_Animate_Run).l, A1 ; loc_10D00
		cmpi.w  #$0600, D2
		bcc.s   loc_10BB0
		lea     (Sonic_Animate_Walk).l, A1 ; loc_10CF2
loc_10BB0:
		move.b  D0, D1
		lsr.b   #$01, D1
		add.b   D1, D0
		add.b   D0, D0
		add.b   D0, D0
		move.b  D0, D3
		neg.w   D2
		addi.w  #$0800, D2
		bpl.s   loc_10BC6
		moveq   #$00, D2
loc_10BC6:
		lsr.w   #$08, D2
		lsr.w   #$01, D2
		move.b  D2, $001E(A0)
		bsr.w     loc_10B00
		add.b   D3, $001A(A0)
		rts    
loc_10BD8:
		move.b  $0027(A0), D0
		moveq   #$00, D1
		move.b  $0022(A0), D2
		andi.b  #$01, D2
		bne.s   loc_10C06
		andi.b  #$FC, $0001(A0)
		addi.b  #$0B, D0
		divu.w  #$0016, D0
		addi.b  #$9B, D0
		move.b  D0, $001A(A0)
		move.b  #$00, $001E(A0)
		rts
loc_10C06:
		andi.b  #$FC, $0001(A0)
		tst.b   $0029(A0)
		beq.s   loc_10C1E
		ori.b   #$01, $0001(A0)
		addi.b  #$0B, D0
		bra.s   loc_10C2A
loc_10C1E:
		ori.b   #$03, $0001(A0)
		neg.b   D0
		addi.b  #$8F, D0
loc_10C2A:
		divu.w  #$0016, D0
		addi.b  #$9B, D0
		move.b  D0, $001A(A0)
		move.b  #$00, $001E(A0)
		rts 
loc_10C3E:
		addq.b  #$01, D0
		bne.s   loc_10C82
		move.w  $0014(A0), D2
		bpl.s   loc_10C4A
		neg.w   D2
loc_10C4A:
		lea     (Sonic_Animate_Roll2).l, A1 ; loc_10D18
		cmpi.w  #$0600, D2
		bcc.s   loc_10C5C
		lea     (Sonic_Animate_Roll).l, A1 ; loc_10D0E
loc_10C5C:
		neg.w   D2
		addi.w  #$0400, D2
		bpl.s   loc_10C66
		moveq   #$00, D2
loc_10C66:
		lsr.w   #$08, D2
		move.b  D2, $001E(A0)
		move.b  $0022(A0), D1
		andi.b  #$01, D1
		andi.b  #$FC, $0001(A0)
		or.b    D1, $0001(A0)
		bra.w     loc_10B00
loc_10C82:		
		move.w  $0014(A0), D2
		bmi.s   loc_10C8A
		neg.w   D2
loc_10C8A:
		addi.w  #$0800, D2
		bpl.s   loc_10C92
		moveq   #$00, D2
loc_10C92:
		lsr.w   #$06, D2
		move.b  D2, $001E(A0)
		lea     (Sonic_Animate_Push).l, A1 ; loc_10D22
		move.b  $0022(A0), D1
		andi.b  #$01, D1
		andi.b  #$FC, $0001(A0)
		or.b    D1, $0001(A0)
		bra.w     loc_10B00				 
Sonic_AnimateData: ; loc_10CB4:
		dc.w    Sonic_Animate_Walk-Sonic_AnimateData        ; loc_10CF2
		dc.w    Sonic_Animate_Run-Sonic_AnimateData         ; loc_10D00
		dc.w    Sonic_Animate_Roll-Sonic_AnimateData        ; loc_10D0E
		dc.w    Sonic_Animate_Roll2-Sonic_AnimateData       ; loc_10D18 
		dc.w    Sonic_Animate_Push-Sonic_AnimateData        ; loc_10D22
		dc.w    Sonic_Animate_Wait-Sonic_AnimateData        ; loc_10D30
		dc.w    Sonic_Animate_Balance-Sonic_AnimateData     ; loc_10D59
		dc.w    Sonic_Animate_LookUp-Sonic_AnimateData      ; loc_10D5D
		dc.w    Sonic_Animate_Duck-Sonic_AnimateData        ; loc_10D62
		dc.w    Sonic_Animate_Spindash-Sonic_AnimateData    ; loc_10D67
		dc.w    Sonic_Animate_WallRecoil1-Sonic_AnimateData ; loc_10D74
		dc.w    Sonic_Animate_WallRecoil2-Sonic_AnimateData ; loc_10D77
		dc.w    Sonic_Animate_0x0C-Sonic_AnimateData        ; loc_10D7D
		dc.w    Sonic_Animate_Stop-Sonic_AnimateData        ; loc_10D81
		dc.w    Sonic_Animate_Float1-Sonic_AnimateData      ; loc_10D8C
		dc.w    Sonic_Animate_Float2-Sonic_AnimateData      ; loc_10D90
		dc.w    Sonic_Animate_0x10-Sonic_AnimateData        ; loc_10D97
		dc.w    Sonic_Animate_S1LzHang-Sonic_AnimateData    ; loc_10D9B
		dc.w    Sonic_Animate_Unused_0x12-Sonic_AnimateData ; loc_10D9F
		dc.w    Sonic_Animate_Unused_0x13-Sonic_AnimateData ; loc_10DA5
		dc.w    Sonic_Animate_Unused_0x14-Sonic_AnimateData ; loc_10DAA
		dc.w    Sonic_Animate_Bubble-Sonic_AnimateData      ; loc_10DAD
		dc.w    Sonic_Animate_Death1-Sonic_AnimateData      ; loc_10DB4
		dc.w    Sonic_Animate_Drown-Sonic_AnimateData       ; loc_10DB7
		dc.w    Sonic_Animate_Death2-Sonic_AnimateData      ; loc_10DBA
		dc.w    Sonic_Animate_Unused_0x19-Sonic_AnimateData ; loc_10DBD
		dc.w    Sonic_Animate_Hurt-Sonic_AnimateData        ; loc_10DC6
		dc.w    Sonic_Animate_S1LzSlide-Sonic_AnimateData   ; loc_10DC9
		dc.w    Sonic_Animate_0x1C-Sonic_AnimateData        ; loc_10DCD
		dc.w    Sonic_Animate_Float3-Sonic_AnimateData      ; loc_10DD1
		dc.w    Sonic_Animate_0x1E-Sonic_AnimateData        ; loc_10DD8
Sonic_Animate_Walk: ; loc_10CF2:
		dc.b    $FF, $10, $11, $12, $13, $14, $15, $16, $17, $0C, $0D, $0E, $0F, $FF
Sonic_Animate_Run: ; loc_10D00:
		dc.b    $FF, $3C, $3D, $3E, $3F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
Sonic_Animate_Roll: ; loc_10D0E:
		dc.b    $FE, $6C, $70, $6D, $70, $6E, $70, $6F, $70, $FF
Sonic_Animate_Roll2: ; loc_10D18:
		dc.b    $FE, $6C, $70, $6D, $70, $6E, $70, $6F, $70, $FF
Sonic_Animate_Push: ; loc_10D22:
		dc.b    $FD, $77, $78, $79, $7A, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
Sonic_Animate_Wait: ; loc_10D30:		
		dc.b    $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
		dc.b    $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02
		dc.b    $03, $03, $03, $04, $04, $05, $05, $FE, $04
Sonic_Animate_Balance: ; loc_10D59:		 
		dc.b    $07, $89, $8A, $FF
Sonic_Animate_LookUp: ; loc_10D5D:		
		dc.b    $05, $06, $07, $FE, $01
Sonic_Animate_Duck: ; loc_10D62:		  
		dc.b    $05, $7F, $80, $FE, $01
Sonic_Animate_Spindash: ; loc_10D67:		
		dc.b    $00, $71, $72, $71, $73, $71, $74, $71, $75, $71, $76, $71, $FF 
Sonic_Animate_WallRecoil1: ; loc_10D74:		
		dc.b    $3F, $82, $FF
Sonic_Animate_WallRecoil2: ; loc_10D77:
		dc.b    $07, $08, $08, $09, $FD, $05
Sonic_Animate_0x0C: ; loc_10D7D:		
		dc.b    $07, $09, $FD, $05
Sonic_Animate_Stop: ; loc_10D81:		 
		dc.b    $03, $81, $82, $83, $84, $85, $86, $87, $88, $FE, $02
Sonic_Animate_Float1: ; loc_10D8C:		 
		dc.b    $07, $94, $96, $FF
Sonic_Animate_Float2: ; loc_10D90:		
		dc.b    $07, $91, $92, $93, $94, $95, $FF
Sonic_Animate_0x10: ; loc_10D97:		
		dc.b    $2F, $7E, $FD, $00
Sonic_Animate_S1LzHang: ; loc_10D9B:		
		dc.b    $05, $8F, $90, $FF
Sonic_Animate_Unused_0x12: ; loc_10D9F:		
		dc.b    $0F, $43, $43, $43, $FE, $01
Sonic_Animate_Unused_0x13: ; loc_10DA5:		
		dc.b    $0F, $43, $44, $FE, $01
Sonic_Animate_Unused_0x14: ; loc_10DAA:		
		dc.b    $3F, $49, $FF
Sonic_Animate_Bubble: ; loc_10DAD:		 
		dc.b    $0B, $97, $97, $12, $13, $FD, $00
Sonic_Animate_Death1: ; loc_10DB4:		 
		dc.b    $20, $9A, $FF
Sonic_Animate_Drown: ; loc_10DB7:		
		dc.b    $20, $99, $FF
Sonic_Animate_Death2: ; loc_10DBA:		 
		dc.b    $20, $98, $FF
Sonic_Animate_Unused_0x19: ; loc_10DBD: 
		dc.b    $03, $4E, $4F, $50, $51, $52, $00, $FE, $01
Sonic_Animate_Hurt: ; loc_10DC6:		
		dc.b    $40, $8D, $FF
Sonic_Animate_S1LzSlide: ; loc_10DC9:		  
		dc.b    $09, $8D, $8E, $FF
Sonic_Animate_0x1C: ; loc_10DCD:		
		dc.b    $77, $00, $FD, $00
Sonic_Animate_Float3: ; loc_10DD1:		
		dc.b    $03, $91, $92, $93, $94, $95, $FF
Sonic_Animate_0x1E: ; loc_10DD8:		
		dc.b    $03, $3C, $FD, $00
;=============================================================================== 
; Sub Routine Sonic_Animate
; [ End ]		         
;===============================================================================
		   
; ---------------------------------------------------------------------------
; Sonic pattern loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_10DDC: Load_Sonic_Dynamic_PLC:
LoadSonicDynPLC:
		moveq	#0,d0
		move.b	$1A(a0),d0
		cmp.b	(Sonic_LastLoadedDPLC).w,d0
		beq.s	return_10E2E
		move.b	d0,(Sonic_LastLoadedDPLC).w
		lea	(MapRUnc_Sonic).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	return_10E2E
		move.w	#$F000,d4
; loc_10E02:
SPLC_ReadEntry:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		addi.l	#ArtUnc_Sonic,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,SPLC_ReadEntry

return_10E2E:
		rts
; End of function LoadSonicDynPLC

; ===========================================================================
; loc_10E30:
JmpTo_KillSonic:	; JmpTo
		jmp	(KillSonic).l

		align 4

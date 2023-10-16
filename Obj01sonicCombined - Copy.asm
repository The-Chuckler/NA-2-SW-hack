; ---------------------------------------------------------------------------
; Object 01 - Sonic
; ---------------------------------------------------------------------------

Obj01:
		tst.w	(Debug_placement_mode).w	; is debug mode being used?
		beq.s	Obj01_Normal			; if not, branch
		jmp	(DebugMode).l
; ===========================================================================

Obj01_Normal:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Obj01_Index(pc,d0.w),d1
		jmp	Obj01_Index(pc,d1.w)
; ===========================================================================
Obj01_Index:	dc.w Obj01_Init-Obj01_Index		; 0
		dc.w Obj01_Control-Obj01_Index		; 2
		dc.w Obj01_Hurt-Obj01_Index		; 4
		dc.w Obj01_Dead-Obj01_Index		; 6
		dc.w Obj01_ResetLevel-Obj01_Index	; 8
; ===========================================================================
; Obj01_Main:
Obj01_Init:
		addq.b	#2,routine(a0)	; => Obj01_Control
		move.b	#$13,$16(a0)	; this sets Sonic's collision height (2*pixels)
		move.b	#9,$17(a0)
		move.l	#Map_Sonic,4(a0)
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

loc_FA88:
		bsr.w	Sonic_RecordPos
		move.w	#0,(a1,d0.w)
		dbf	d2,loc_FA88

; ---------------------------------------------------------------------------
; Normal state for Sonic
; ---------------------------------------------------------------------------

Obj01_Control:
		tst.w	(Debug_mode_flag).w		; is debug cheat enabled?
		beq.s	loc_FAB0			; if not, branch
		btst	#4,($FFFFF605).w		; is button B pressed?
		beq.s	loc_FAB0			; if not, branch
		move.w	#1,(Debug_placement_mode).w	; change Sonic into ring/item
		clr.b	($FFFFF7CC).w			; unlock control
		rts
; -----------------------------------------------------------------------
loc_FAB0:
		tst.b	($FFFFF7CC).w		; are controls locked?
		bne.s	loc_FABC		; if yes, branch
		move.w	($FFFFF604).w,($FFFFF602).w	; copy new held buttons, to enable joypad

loc_FABC:
		btst	#0,$2A(a0);($FFFFF7C8).w	; is Sonic interacting with another object that holds him in place or controls his movement somehow?
		bne.s	Obj01_ControlsLock	; if yes, branch to skip Sonic's control
		moveq	#0,d0
		move.b	$22(a0),d0
		andi.w	#6,d0
		move.w	Obj01_Modes(pc,d0.w),d1
		jsr	Obj01_Modes(pc,d1.w)	; run Sonic's movement control code

Obj01_ControlsLock:
		bsr.s	Sonic_Display
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Water
		move.b	($FFFFF768).w,$36(a0)
		move.b	($FFFFF76A).w,$37(a0)
		tst.b	($FFFFF7C7).w
		beq.s	loc_FAFE
		tst.b	$1C(a0)
		bne.s	loc_FAFE
		move.b	$1D(a0),$1C(a0)

loc_FAFE:
		bsr.w	Sonic_Animate
		tst.b	($FFFFF7C8).w
		bmi.s	loc_FB0E
		jsr	TouchResponse

loc_FB0E:
		bra.w	LoadSonicDynPLC

; ===========================================================================
; secondary states under state Obj01_Control
Obj01_Modes:	dc.w Obj01_MdNormal-Obj01_Modes
		dc.w Obj01_MdAir-Obj01_Modes
		dc.w Obj01_MdRoll-Obj01_Modes
		dc.w Obj01_MdJump-Obj01_Modes

MusicList_Sonic:dc.b bgm_GHZ
		dc.b bgm_LZ
		dc.b bgm_MZ
		dc.b bgm_SLZ
		dc.b bgm_SYZ
		dc.b bgm_SBZ
;		dc.b bgm_MZ
; ===========================================================================

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Display:
		move.w	$30(a0),d0
		beq.s	Obj01_Display
		subq.w	#1,$30(a0)
		lsr.w	#3,d0
		bcc.s	Obj01_ChkInvin
; loc_FB2E:
Obj01_Display:
		jsr	(DisplaySprite).l
; loc_FB34:
Obj01_ChkInvin:		; Checks if invincibility has expired and (should) disables it if it has
		tst.b	($FFFFFE2D).w
		beq.s	Obj01_ChkShoes
		tst.w	$32(a0)
		beq.s	Obj01_ChkShoes
		bra.s	Obj01_ChkShoes
; ===========================================================================
; Strange that they disabled the invincibility timer for this build,
; a leftover debugging feature?
		subq.w	#1,$32(a0)
		bne.s	Obj01_ChkShoes
		tst.b	($FFFFF7AA).w
		bne.s	Obj01_RmvInvin
		cmpi.w	#$C,($FFFFFE14).w
		bcs.s	Obj01_RmvInvin
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		cmpi.w	#$103,(Current_ZoneAndAct).w
		bne.s	loc_FB66
		moveq	#5,d0

loc_FB66:
		lea	MusicList_Sonic(pc),a1
		move.b	(a1,d0.w),d0
		jsr	(PlaySound).l
; loc_FB74:
Obj01_RmvInvin:
		move.b	#0,($FFFFFE2D).w
; loc_FB7A:
Obj01_ChkShoes:	; Checks if Speed Shoes have expired and disables them if they have.
		tst.b	($FFFFFE2E).w
		beq.s	Obj01_ExitChk
		tst.w	$34(a0)
		beq.s	Obj01_ExitChk
		subq.w	#1,$34(a0)
		bne.s	Obj01_ExitChk
		move.w	#$600,(Sonic_top_speed).w
		move.w	#$C,(Sonic_acceleration).w
		move.w	#$80,(Sonic_deceleration).w
		move.b	#0,($FFFFFE2E).w
		move.w	#$E3,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------
; locret_FBAE:
Obj01_ExitChk:
		rts
; End of function Sonic_Display


; ---------------------------------------------------------------------------
; Subroutine to record Sonic's previous positions for invincibility stars
; and input/status flags for Tails' AI to follow
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FBB2: CopySonicMovesForTails:
Sonic_RecordPos:
		move.w	(Sonic_Pos_Record_Index).w,d0
		lea	(Sonic_Pos_Record_Buf).w,a1
		lea	(a1,d0.w),a1
		move.w	8(a0),(a1)+
		move.w	$C(a0),(a1)+
		addq.b	#4,(Sonic_Pos_Record_Index+1).w

		lea	(Sonic_Stat_Record_Buf).w,a1
		move.w	($FFFFF604).w,(a1,d0.w)
		rts
; End of function Sonic_RecordPos

; ===========================================================================
; ---------------------------------------------------------------------------
; Seemingly an earlier subroutine to copy Sonic's status flags for Tails' AI
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Unused_RecordPos:
		move.w	($FFFFEEE0).w,d0
		subq.b	#4,d0
		lea	(Tails_Pos_Record_Buf).w,a1
		lea	(a1,d0.w),a2
		move.w	8(a0),d1
		swap	d1
		move.w	$C(a0),d1
		cmp.l	(a2),d1
		beq.s	locret_FC02
		addq.b	#4,d0
		lea	(a1,d0.w),a2
		move.w	8(a0),(a2)+
		move.w	$C(a0),(a2)
		addq.b	#4,($FFFFEEE1).w

locret_FC02:
		rts
; End of subroutine Unused_RecordPos


; ---------------------------------------------------------------------------
; Subroutine for Sonic when he's underwater
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_FC06:
Sonic_Water:
		tst.b	(Water_flag).w
		bne.s	Obj01_InWater

locret_FC0A:
		rts
; ---------------------------------------------------------------------------
; loc_FC0E: Obj01_InLevelWithWater:
Obj01_InWater:
		move.w	($FFFFF646).w,d0
		cmp.w	$C(a0),d0	; is Sonic above water?
		bge.s	Obj01_OutWater	; if yes, branch

		bset	#6,$22(a0)	; set underwater flag
		bne.s	locret_FC0A	; if already underwater, branch

		bsr.w	ResumeMusic
		move.b	#$A,($FFFFB340).w	; load Obj0A (sonic's breathing bubbles) at $FFFFB340
		move.b	#$81,($FFFFB368).w
		move.w	#$300,(Sonic_top_speed).w
		move.w	#6,(Sonic_acceleration).w
		move.w	#$40,(Sonic_deceleration).w
		asr	$10(a0)
		asr	$12(a0)	; memory oprands can only be shifted one at a time
		asr	$12(a0)
		beq.s	locret_FC0A
		move.b	#8,($FFFFB300).w	; splash animation
		move.w	#$AA,d0			; splash sound
		jmp	(PlaySound_Special).l

; ---------------------------------------------------------------------------
; Obj01_NotInWater:
Obj01_OutWater:
		bclr	#6,$22(a0)	; unset underwater flag
		beq.s	locret_FC0A	; if already unset, branch

		bsr.w	ResumeMusic
		move.w	#$600,(Sonic_top_speed).w
		move.w	#$C,(Sonic_acceleration).w
		move.w	#$80,(Sonic_deceleration).w
		asl	$12(a0)
		beq.w	locret_FC0A
		move.b	#8,($FFFFB300).w	; splash animation
		cmpi.w	#$F000,$12(a0)
		bgt.s	loc_FC98
		move.w	#$F000,$12(a0)	; limit upward y velocity exiting the water

loc_FC98:
		move.w	#$AA,d0		; splash sound
		jmp	(PlaySound_Special).l
; End of function Sonic_Water

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of subroutine Obj01_MdNormal
; Called if Sonic is neither airborne nor rolling this frame
; ---------------------------------------------------------------------------

Obj01_MdNormal:
		bsr.w	Sonic_CheckSpindash
		bsr.w	Sonic_Jump
		bsr.w	Sonic_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	Sonic_Roll
		bsr.w	Sonic_LevelBound
		jsr	(ObjectMove).l
		bsr.w	AnglePos
		bsr.w	Sonic_SlopeRepel
		rts
; End of subroutine Obj01_MdNormal

; ===========================================================================
; Start of subroutine Obj01_MdAir
; Called if Sonic is airborne, but not in a ball (thus, probably not jumping)
; Obj01_MdJump:
Obj01_MdAir:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Sonic_LevelBound
		jsr	(ObjectMoveAndFall).l
		btst	#6,$22(a0)	; is Sonic underwater?
		beq.s	loc_FCEA	; if not, branch
		subi.w	#$28,$12(a0)	; reduce gravity by $28 ($38-$28=$10)

loc_FCEA:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_DoLevelCollision
		rts
; End of subroutine Obj01_MdAir

; ===========================================================================
; Start of subroutine Obj01_MdRoll
; Called if Sonic is in a ball, but not airborne (thus, probably rolling)

Obj01_MdRoll:
		bsr.w	Sonic_Jump
		bsr.w	Sonic_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Sonic_LevelBound
		jsr	(ObjectMove).l
		bsr.w	AnglePos
		bsr.w	Sonic_SlopeRepel
		rts
; End of subroutine Obj01_MdRoll

; ===========================================================================
; Start of subroutine Obj01_MdJump
; Called if Sonic is in a ball and airborne (he could be jumping but not necessarily)
; Notes: This is identical to Obj01_MdAir, at least at this outer level.
;        Why they gave it a separate copy of the code, I don't know.
; Obj01_MdJump2:
Obj01_MdJump:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_ChgJumpDir
		bsr.w	Sonic_LevelBound
		jsr	(ObjectMoveAndFall).l
		btst	#6,$22(a0)	; is Sonic underwater?
		beq.s	loc_FD34	; if not, branch
		subi.w	#$28,$12(a0)	; reduce gravity by $28 ($38-$28=$10)

loc_FD34:
		bsr.w	Sonic_JumpAngle
		bsr.w	Sonic_DoLevelCollision
		rts
; End of subroutine Obj01_MdJump


; ---------------------------------------------------------------------------
; Subroutine to make Sonic walk/run
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Move:
		move.w	(Sonic_top_speed).w,d6
		move.w	(Sonic_acceleration).w,d5
		move.w	(Sonic_deceleration).w,d4
		tst.b	($FFFFF7CA).w
		bne.w	Obj01_Traction
		tst.w	$2E(a0)
		bne.w	Obj01_UpdateSpeedOnGround
		btst	#2,($FFFFF602).w	; is left being pressed?
		beq.s	loc_FD66		; if not, branch
		bsr.w	Sonic_MoveLeft

loc_FD66:
		btst	#3,($FFFFF602).w	; is right being pressed?
		beq.s	loc_FD72		; if not, branch
		bsr.w	Sonic_MoveRight

loc_FD72:
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0				; is Sonic on a slope?
		bne.w	Obj01_UpdateSpeedOnGround	; if yes, branch
		tst.w	$14(a0)				; is Sonic moving?
		bne.w	Obj01_UpdateSpeedOnGround	; if yes, branch
		bclr	#5,$22(a0)
		cmpi.b	#$B,$1C(a0)	; use "standing" animation
		beq.s	loc_FD9E
		move.b	#5,$1C(a0)

loc_FD9E:
		btst	#3,$22(a0)
		beq.s	Sonic_Balance
		moveq	#0,d0
		move.b	$3D(a0),d0
		lsl.w	#6,d0
		lea	($FFFFB000).w,a1	; a1=character
		lea	(a1,d0.w),a1		; a1=object
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
		blt.s	loc_FE00
		cmp.w	d2,d1
		bge.s	loc_FDF0
		bra.s	Sonic_LookUp
; ---------------------------------------------------------------------------

Sonic_Balance:
		jsr	(ChkFloorEdge).l
		cmpi.w	#$C,d1
		blt.s	Sonic_LookUp
		cmpi.b	#3,$36(a0)
		bne.s	loc_FDF8

loc_FDF0:
		bclr	#0,$22(a0)
		bra.s	loc_FE06
; ---------------------------------------------------------------------------

loc_FDF8:
		cmpi.b	#3,$37(a0)
		bne.s	Sonic_LookUp

loc_FE00:
		bset	#0,$22(a0)

loc_FE06:
		move.b	#6,$1C(a0)
		bra.s	Obj01_UpdateSpeedOnGround
; ---------------------------------------------------------------------------

Sonic_LookUp:
		btst	#0,($FFFFF602).w	; is up being pressed?
		beq.s	Sonic_Duck		; if not, branch
		move.b	#7,$1C(a0)		; use "looking up" animation
		bra.s	Obj01_UpdateSpeedOnGround
; ---------------------------------------------------------------------------

Sonic_Duck:
		btst	#1,($FFFFF602).w		; is down being pressed?
		beq.s	Obj01_UpdateSpeedOnGround	; if not, branch
		move.b	#8,$1C(a0)			; use "ducking" animation

; ---------------------------------------------------------------------------
; updates Sonic's speed on the ground
; ---------------------------------------------------------------------------
; loc_FE2C:
Obj01_UpdateSpeedOnGround:
		move.b	($FFFFF602).w,d0
		andi.b	#$C,d0		; is left/right being pressed?
		bne.s	Obj01_Traction	; if yes, branch
		move.w	$14(a0),d0
		beq.s	Obj01_Traction
		bmi.s	Obj01_SettleLeft

; slow down when facing right and not pressing a direction
; Obj01_SettleRight:
		sub.w	d5,d0
		bcc.s	loc_FE46
		move.w	#0,d0

loc_FE46:
		move.w	d0,$14(a0)
		bra.s	Obj01_Traction
; ---------------------------------------------------------------------------
; slow down when facing left and not pressing a direction
; loc_FE4C:
Obj01_SettleLeft:
		add.w	d5,d0
		bcc.s	loc_FE54
		move.w	#0,d0

loc_FE54:
		move.w	d0,$14(a0)

; increase or decrease speed on the ground
; loc_FE58:
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
; loc_FE76:
Obj01_CheckWallsOnGround:
		move.b	$26(a0),d0
		addi.b	#$40,d0
		bmi.s	locret_FEF6
		move.b	#$40,d1		; rotate 90 degress clockwise
		tst.w	$14(a0)		; check if Sonic's moving
		beq.s	locret_FEF6	; if not, branch
		bmi.s	loc_FE8E	; if negative, branch
		neg.w	d1		; rotate counterclockwise

loc_FE8E:
		move.b	$26(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	CalcRoomInFront
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_FEF6
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_FEF2
		cmpi.b	#$40,d0
		beq.s	loc_FED8
		cmpi.b	#$80,d0
		beq.s	loc_FED2
		cmpi.w	#$600,$10(a0)		; is Sonic at max speed?
		bge.s	Sonic_WallRecoil	; if yes, branch
		add.w	d1,$10(a0)
		bset	#5,$22(a0)
		move.w	#0,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_FED2:
		sub.w	d1,$12(a0)
		rts
; ---------------------------------------------------------------------------

loc_FED8:
		cmpi.w	#$FA00,$10(a0)		; is Sonic at max speed?
		ble.s	Sonic_WallRecoil	; if yes, branch
		sub.w	d1,$10(a0)
		bset	#5,$22(a0)
		move.w	#0,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_FEF2:
		add.w	d1,$12(a0)

locret_FEF6:
		rts

; ---------------------------------------------------------------------------
; Subroutine to recoil Sonic off a wall if moving a top speed
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_WallRecoil:
		move.b	#4,routine(a0)
		bsr.w	Sonic_ResetOnFloor
		bset	#1,$22(a0)
		move.w	#-$200,d0
		tst.w	$10(a0)
		bpl.s	Sonic_WallRecoil_Right
		neg.w	d0

Sonic_WallRecoil_Right:
		move.w	d0,$10(a0)
		move.w	#-$400,$12(a0)
		move.w	#0,$14(a0)
		move.b	#$A,$1C(a0)
		move.b	#1,$25(a0)
		move.w	#$A3,d0
		jsr	(PlaySound_Special).l
		rts
; End of function Sonic_Move


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_MoveLeft:
		move.w	$14(a0),d0
		beq.s	loc_FF44
		bpl.s	Sonic_TurnLeft

loc_FF44:
		bset	#0,$22(a0)
		bne.s	loc_FF58
		bclr	#5,$22(a0)
		move.b	#1,$1D(a0)

loc_FF58:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_FF64
		add.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d1,d0		; compare speed with top speed
		ble.s	loc_FF64	; if speed was already greater than the maximum, branch
		move.w	d1,d0

loc_FF64:
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)
		rts
; ---------------------------------------------------------------------------
; loc_FF70:
Sonic_TurnLeft:
		sub.w	d4,d0
		bcc.s	loc_FF78
		move.w	#$FF80,d0

loc_FF78:
		move.w	d0,$14(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_FFA6
		cmpi.w	#$400,d0
		blt.s	locret_FFA6
		move.b	#$D,$1C(a0)
		bclr	#0,$22(a0)
		move.w	#$A4,d0
		jsr	(PlaySound_Special).l

locret_FFA6:
		rts
; End of function Sonic_MoveLeft


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_MoveRight:
		move.w	$14(a0),d0
		bmi.s	Sonic_TurnRight
		bclr	#0,$22(a0)
		beq.s	loc_FFC2
		bclr	#5,$22(a0)
		move.b	#1,$1D(a0)

loc_FFC2:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_FFCA
		sub.w	d5,d0		; remove this frame's acceleration change
		cmp.w	d6,d0		; compare speed with top speed
		bge.s	loc_FFCA	; if speed was already greater than the maximum, branch
		move.w	d6,d0

loc_FFCA:
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)
		rts
; ---------------------------------------------------------------------------
; loc_FFD6:
Sonic_TurnRight:
		add.w	d4,d0
		bcc.s	loc_FFDE
		move.w	#$80,d0

loc_FFDE:
		move.w	d0,$14(a0)
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_1000C
		cmpi.w	#$FC00,d0
		bgt.s	locret_1000C
		move.b	#$D,$1C(a0)

loc_FFFC:
		bset	#0,$22(a0)
		move.w	#$A4,d0
		jsr	(PlaySound_Special).l

locret_1000C:
		rts
; End of function Sonic_MoveRight


; =============== S U B	R O U T	I N E =======================================


Sonic_RollSpeed:			; CODE XREF: ROM:0000FCFCp
		move.w	(Sonic_top_speed).w,d6
		asl.w	#1,d6
		move.w	(Sonic_acceleration).w,d5
		asr.w	#1,d5
		move.w	(Sonic_deceleration).w,d4
		asr.w	#2,d4
		tst.b	($FFFFF7CA).w
		bne.w	loc_1008A
		tst.w	$2E(a0)
		bne.s	loc_10046
		btst	#2,($FFFFF602).w
		beq.s	loc_1003A
		bsr.w	Sonic_RollLeft

loc_1003A:				; CODE XREF: Sonic_RollSpeed+26j
		btst	#3,($FFFFF602).w
		beq.s	loc_10046
		bsr.w	Sonic_RollRight

loc_10046:				; CODE XREF: Sonic_RollSpeed+1Ej
					; Sonic_RollSpeed+32j
		move.w	$14(a0),d0
		beq.s	loc_10068
		bmi.s	loc_1005C
		sub.w	d5,d0
		bcc.s	loc_10056
		move.w	#0,d0

loc_10056:				; CODE XREF: Sonic_RollSpeed+42j
		move.w	d0,$14(a0)
		bra.s	loc_10068
; ---------------------------------------------------------------------------

loc_1005C:				; CODE XREF: Sonic_RollSpeed+3Ej
		add.w	d5,d0
		bcc.s	loc_10064
		move.w	#0,d0

loc_10064:				; CODE XREF: Sonic_RollSpeed+50j
		move.w	d0,$14(a0)

loc_10068:				; CODE XREF: Sonic_RollSpeed+3Cj
					; Sonic_RollSpeed+4Cj
		tst.w	$14(a0)
		bne.s	loc_1008A
		bclr	#2,$22(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.b	#5,$1C(a0)
		subq.w	#5,$C(a0)

loc_1008A:				; CODE XREF: Sonic_RollSpeed+16j
					; Sonic_RollSpeed+5Ej
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d0
		asr.l	#8,d0
		move.w	d0,$12(a0)
		muls.w	$14(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_100AE
		move.w	#$1000,d1

loc_100AE:				; CODE XREF: Sonic_RollSpeed+9Aj
		cmpi.w	#$F000,d1
		bge.s	loc_100B8
		move.w	#$F000,d1

loc_100B8:				; CODE XREF: Sonic_RollSpeed+A4j
		move.w	d1,$10(a0)
		bra.w	Obj01_CheckWallsOnGround
; End of function Sonic_RollSpeed


; =============== S U B	R O U T	I N E =======================================


Sonic_RollLeft:				; CODE XREF: Sonic_RollSpeed+28p
		move.w	$14(a0),d0
		beq.s	loc_100C8
		bpl.s	loc_100D6

loc_100C8:				; CODE XREF: Sonic_RollLeft+4j
		bset	#0,$22(a0)
		move.b	#2,$1C(a0)
		rts
; ---------------------------------------------------------------------------

loc_100D6:				; CODE XREF: Sonic_RollLeft+6j
		sub.w	d4,d0
		bcc.s	loc_100DE
		move.w	#$FF80,d0

loc_100DE:				; CODE XREF: Sonic_RollLeft+18j
		move.w	d0,$14(a0)
		rts
; End of function Sonic_RollLeft


; =============== S U B	R O U T	I N E =======================================


Sonic_RollRight:			; CODE XREF: Sonic_RollSpeed+34p
		move.w	$14(a0),d0
		bmi.s	loc_100F8
		bclr	#0,$22(a0)
		move.b	#2,$1C(a0)
		rts
; ---------------------------------------------------------------------------

loc_100F8:				; CODE XREF: Sonic_RollRight+4j
		add.w	d4,d0
		bcc.s	loc_10100
		move.w	#$80,d0	; '€'

loc_10100:				; CODE XREF: Sonic_RollRight+16j
		move.w	d0,$14(a0)
		rts
; End of function Sonic_RollRight


; =============== S U B	R O U T	I N E =======================================


Sonic_ChgJumpDir:			; CODE XREF: ROM:0000FCCEp
					; ROM:0000FD18p
		move.w	(Sonic_top_speed).w,d6
		move.w	(Sonic_acceleration).w,d5
		asl.w	#1,d5
		btst	#4,$22(a0)
		bne.s	loc_10150
		move.w	$10(a0),d0
		btst	#2,($FFFFF602).w
		beq.s	loc_10136
		bset	#0,$22(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_10136
		add.w	d5,d0		; +++ remove this frame's acceleration change
		cmp.w	d1,d0		; +++ compare speed with top speed
		ble.s	loc_10136	; +++ if speed was already greater than the maximum, branch
		move.w	d1,d0

loc_10136:				; CODE XREF: Sonic_ChgJumpDir+1Cj
					; Sonic_ChgJumpDir+2Cj
		btst	#3,($FFFFF602).w
		beq.s	loc_1014C
		bclr	#0,$22(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_1014C
		sub.w	d5,d0		; +++ remove this frame's acceleration change
		cmp.w	d6,d0		; +++ compare speed with top speed
		bge.s	loc_1014C;Obj01_JumpMove	; +++ if speed was already greater than the maximum, branch
		move.w	d6,d0

loc_1014C:				; CODE XREF: Sonic_ChgJumpDir+36j
					; Sonic_ChgJumpDir+42j
		move.w	d0,$10(a0)

loc_10150:				; CODE XREF: Sonic_ChgJumpDir+10j
		cmpi.w	#$60,($FFFFEED8).w ; '`'
		beq.s	loc_10162
		bcc.s	loc_1015E
		addq.w	#4,($FFFFEED8).w

loc_1015E:				; CODE XREF: Sonic_ChgJumpDir+52j
		subq.w	#2,($FFFFEED8).w

loc_10162:				; CODE XREF: Sonic_ChgJumpDir+50j
		cmpi.w	#$FC00,$12(a0)
		bcs.s	locret_10190
		move.w	$10(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_10190
		bmi.s	loc_10184
		sub.w	d1,d0
		bcc.s	loc_1017E
		move.w	#0,d0

loc_1017E:; Obj01_JumpMove:				; CODE XREF: Sonic_ChgJumpDir+72j
		move.w	d0,$10(a0)
		rts
; ---------------------------------------------------------------------------

loc_10184:				; CODE XREF: Sonic_ChgJumpDir+6Ej
		sub.w	d1,d0
		bcs.s	loc_1018C
		move.w	#0,d0

loc_1018C:				; CODE XREF: Sonic_ChgJumpDir+80j
		move.w	d0,$10(a0)

locret_10190:				; CODE XREF: Sonic_ChgJumpDir+62j
					; Sonic_ChgJumpDir+6Cj
		rts
; End of function Sonic_ChgJumpDir


; =============== S U B	R O U T	I N E =======================================

; Sonic_LevelBoundaries:
Sonic_LevelBound:
		move.l	8(a0),d1
		move.w	$10(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	($FFFFEEC8).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0
		bhi.s	loc_101FA
		move.w	($FFFFEECA).w,d0
		addi.w	#$128,d0
		tst.b	($FFFFF7AA).w
		bne.s	loc_101C0
		addi.w	#$40,d0	; '@'

loc_101C0:				; CODE XREF: Sonic_LevelBound+28j
		cmp.w	d1,d0
		bls.s	loc_101FA

loc_101C4:				; CODE XREF: Sonic_LevelBound+7Ej
		move.w	($FFFFEECE).w,d0
		addi.w	#$E0,d0	; 'à'
		cmp.w	$C(a0),d0
		blt.s	loc_101D4
		rts
; ---------------------------------------------------------------------------

loc_101D4:				; CODE XREF: Sonic_LevelBound+3Ej
		cmpi.w	#$501,(Current_ZoneAndAct).w
		bne.w	JmpTo_KillSonic
		cmpi.w	#$2000,($FFFFB008).w
		bcs.w	JmpTo_KillSonic
		clr.b	($FFFFFE30).w
		move.w	#1,($FFFFFE02).w
		move.w	#$103,(Current_ZoneAndAct).w
		rts
; ---------------------------------------------------------------------------

loc_101FA:				; CODE XREF: Sonic_LevelBound+1Aj
					; Sonic_LevelBound+30j
		move.w	d0,8(a0)
		move.w	#0,$A(a0)
		move.w	#0,$10(a0)
		move.w	#0,$14(a0)
		bra.s	loc_101C4
; End of function Sonic_LevelBound


; =============== S U B	R O U T	I N E =======================================


Sonic_Roll:				; CODE XREF: ROM:0000FCB2p
		tst.b	($FFFFF7CA).w
		bne.s	Obj01_NoRoll
		move.w	$14(a0),d0
		bpl.s	loc_10220
		neg.w	d0

loc_10220:				; CODE XREF: Sonic_Roll+Aj
		cmpi.w	#$80,d0	; '€'
		bcs.s	Obj01_NoRoll
		move.b	($FFFFF602).w,d0
		andi.b	#$C,d0
		bne.s	Obj01_NoRoll
		btst	#1,($FFFFF602).w
		bne.s	loc_1023A

Obj01_NoRoll:				; CODE XREF: Sonic_Roll+4j
					; Sonic_Roll+12j ...
		rts
; ---------------------------------------------------------------------------

loc_1023A:				; CODE XREF: Sonic_Roll+24j
		btst	#2,$22(a0)
		beq.s	Obj01_DoRoll
		rts
; ---------------------------------------------------------------------------

Obj01_DoRoll:				; CODE XREF: Sonic_Roll+2Ej
		bset	#2,$22(a0)
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)
		addq.w	#5,$C(a0)
		move.w	#$BE,d0	; '¾'
		jsr	(PlaySound_Special).l
		tst.w	$14(a0)
		bne.s	locret_10276
		move.w	#$200,$14(a0)

locret_10276:				; CODE XREF: Sonic_Roll+5Cj
		rts
; End of function Sonic_Roll


; =============== S U B	R O U T	I N E =======================================


Sonic_Jump:				; CODE XREF: ROM:0000FCA6p
					; ROM:Obj01_MdRollp
		move.b	($FFFFF603).w,d0
		andi.b	#$70,d0	; 'p'
		beq.w	locret_1031C
		moveq	#0,d0
		move.b	$26(a0),d0
		addi.b	#$80,d0
		bsr.w	sub_13102
		cmpi.w	#6,d1
		blt.w	locret_1031C
		move.w	#$680,d2
		btst	#6,$22(a0)
		beq.s	loc_102AA
		move.w	#$380,d2

loc_102AA:				; CODE XREF: Sonic_Jump+2Cj
		moveq	#0,d0
		move.b	$26(a0),d0
		subi.b	#$40,d0	; '@'
		jsr	(CalcSine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,$10(a0)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,$12(a0)
		bset	#1,$22(a0)
		bclr	#5,$22(a0)
		addq.l	#4,sp
		move.b	#1,$3C(a0)
		clr.b	$38(a0)
		move.w	#$A0,d0	; ' '
		jsr	(PlaySound_Special).l
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		btst	#2,$22(a0)
		bne.s	loc_1031E
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)
		bset	#2,$22(a0)
		addq.w	#5,$C(a0)

locret_1031C:				; CODE XREF: Sonic_Jump+8j
					; Sonic_Jump+1Ej
		rts
; ---------------------------------------------------------------------------

loc_1031E:				; CODE XREF: Sonic_Jump+86j
		bset	#4,$22(a0)
		rts
; End of function Sonic_Jump


; =============== S U B	R O U T	I N E =======================================


Sonic_JumpHeight:			; CODE XREF: ROM:Obj01_MdJumpp
					; ROM:Obj01_MdJump2p
		tst.b	$3C(a0)
		beq.s	loc_10352
		move.w	#$FC00,d1
		btst	#6,$22(a0)
		beq.s	loc_1033C
		move.w	#$FE00,d1

loc_1033C:				; CODE XREF: Sonic_JumpHeight+10j
		cmp.w	$12(a0),d1
		ble.s	locret_10350
		move.b	($FFFFF602).w,d0
		andi.b	#$70,d0	; 'p'
		bne.s	locret_10350
		move.w	d1,$12(a0)

locret_10350:				; CODE XREF: Sonic_JumpHeight+1Aj
					; Sonic_JumpHeight+24j
		rts
; ---------------------------------------------------------------------------

loc_10352:				; CODE XREF: Sonic_JumpHeight+4j
		cmpi.w	#$F040,$12(a0)
		bge.s	locret_10360
		move.w	#$F040,$12(a0)

locret_10360:				; CODE XREF: Sonic_JumpHeight+32j
		rts
; End of function Sonic_JumpHeight

; ---------------------------------------------------------------------------
; Subroutine to check for starting to charge a spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Sonic_Spindash:
Sonic_CheckSpindash:
		include	"SonicSpinDash.asm";include	"SonicSpinDashOld.asm"


; =============== S U B	R O U T	I N E =======================================


Sonic_SlopeResist:			; CODE XREF: ROM:0000FCAAp
		move.b	$26(a0),d0
		addi.b	#$60,d0	; '`'
		cmpi.b	#$C0,d0
		bcc.s	locret_10422
		move.b	$26(a0),d0

loc_10400:
		jsr	(CalcSine).l
		muls.w	#$20,d0	; ' '
		asr.l	#8,d0
		tst.w	$14(a0)
		beq.s	locret_10422
		bmi.s	loc_1041E
		tst.w	d0
		beq.s	locret_1041C
		add.w	d0,$14(a0)

locret_1041C:				; CODE XREF: Sonic_SlopeResist+28j
		rts
; ---------------------------------------------------------------------------

loc_1041E:				; CODE XREF: Sonic_SlopeResist+24j
		add.w	d0,$14(a0)

locret_10422:				; CODE XREF: Sonic_SlopeResist+Cj
					; Sonic_SlopeResist+22j
		rts
; End of function Sonic_SlopeResist


; =============== S U B	R O U T	I N E =======================================


Sonic_RollRepel:			; CODE XREF: ROM:0000FCF8p
		move.b	$26(a0),d0
		addi.b	#$60,d0	; '`'
		cmpi.b	#$C0,d0
		bcc.s	locret_1045E
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	#$50,d0	; 'P'
		asr.l	#8,d0
		tst.w	$14(a0)
		bmi.s	loc_10454
		tst.w	d0
		bpl.s	loc_1044E
		asr.l	#2,d0

loc_1044E:				; CODE XREF: Sonic_RollRepel+26j
		add.w	d0,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_10454:				; CODE XREF: Sonic_RollRepel+22j
		tst.w	d0
		bmi.s	loc_1045A
		asr.l	#2,d0

loc_1045A:				; CODE XREF: Sonic_RollRepel+32j
		add.w	d0,$14(a0)

locret_1045E:				; CODE XREF: Sonic_RollRepel+Cj
		rts
; End of function Sonic_RollRepel


; =============== S U B	R O U T	I N E =======================================


Sonic_SlopeRepel:			; CODE XREF: ROM:0000FCC4p
					; ROM:0000FD0Ep
		nop
		tst.b	$38(a0)
		bne.s	locret_1049A
		tst.w	$2E(a0)
		bne.s	loc_1049C
		move.b	$26(a0),d0
		addi.b	#$20,d0	; ' '
		andi.b	#$C0,d0
		beq.s	locret_1049A
		move.w	$14(a0),d0
		bpl.s	loc_10484
		neg.w	d0

loc_10484:				; CODE XREF: Sonic_SlopeRepel+20j
		cmpi.w	#$280,d0
		bcc.s	locret_1049A
		clr.w	$14(a0)
		bset	#1,$22(a0)
		move.w	#$1E,$2E(a0)

locret_1049A:				; CODE XREF: Sonic_SlopeRepel+6j
					; Sonic_SlopeRepel+1Aj	...
		rts
; ---------------------------------------------------------------------------

loc_1049C:				; CODE XREF: Sonic_SlopeRepel+Cj
		subq.w	#1,$2E(a0)
		rts
; End of function Sonic_SlopeRepel


; =============== S U B	R O U T	I N E =======================================


Sonic_JumpAngle:			; CODE XREF: ROM:loc_FCEAp
					; ROM:loc_FD34p
		move.b	$26(a0),d0
		beq.s	loc_104BC
		bpl.s	loc_104B2
		addq.b	#2,d0
		bcc.s	loc_104B0
		moveq	#0,d0

loc_104B0:				; CODE XREF: Sonic_JumpAngle+Aj
		bra.s	loc_104B8
; ---------------------------------------------------------------------------

loc_104B2:				; CODE XREF: Sonic_JumpAngle+6j
		subq.b	#2,d0
		bcc.s	loc_104B8
		moveq	#0,d0

loc_104B8:				; CODE XREF: Sonic_JumpAngle:loc_104B0j
					; Sonic_JumpAngle+12j
		move.b	d0,$26(a0)

loc_104BC:				; CODE XREF: Sonic_JumpAngle+4j
		move.b	$27(a0),d0
		beq.s	locret_104FA
		tst.w	$14(a0)
		bmi.s	loc_104E0
		move.b	$2D(a0),d1
		add.b	d1,d0
		bcc.s	loc_104DE
		subq.b	#1,$2C(a0)
		bcc.s	loc_104DE
		move.b	#0,$2C(a0)
		moveq	#0,d0

loc_104DE:				; CODE XREF: Sonic_JumpAngle+2Cj
					; Sonic_JumpAngle+32j
		bra.s	loc_104F6
; ---------------------------------------------------------------------------

loc_104E0:				; CODE XREF: Sonic_JumpAngle+24j
		move.b	$2D(a0),d1
		sub.b	d1,d0
		bcc.s	loc_104F6
		subq.b	#1,$2C(a0)
		bcc.s	loc_104F6
		move.b	#0,$2C(a0)
		moveq	#0,d0

loc_104F6:				; CODE XREF: Sonic_JumpAngle:loc_104DEj
					; Sonic_JumpAngle+44j ...
		move.b	d0,$27(a0)

locret_104FA:				; CODE XREF: Sonic_JumpAngle+1Ej
		rts
; End of function Sonic_JumpAngle


; =============== S U B	R O U T	I N E =======================================

; Sonic_Floor:
Sonic_DoLevelCollision:
		move.l	#$FFFFD000,($FFFFF796).w
		cmpi.b	#$C,$3E(a0)
		beq.s	loc_10514
		move.l	#$FFFFD600,($FFFFF796).w

loc_10514:				; CODE XREF: Sonic_DoLevelCollision+Ej
		move.b	$3F(a0),d5
		move.w	$10(a0),d1
		move.w	$12(a0),d2
		jsr	(CalcAngle).l
		subi.b	#$20,d0	; ' '
		andi.b	#$C0,d0
		cmpi.b	#$40,d0	; '@'
		beq.w	loc_105E4
		cmpi.b	#$80,d0
		beq.w	loc_10646
		cmpi.b	#$C0,d0
		beq.w	loc_106A2
		bsr.w	Sonic_HitWall
		tst.w	d1
		bpl.s	loc_10558
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_10558:				; CODE XREF: Sonic_DoLevelCollision+50j
		bsr.w	sub_132EE
		tst.w	d1
		bpl.s	loc_1056A
		add.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_1056A:				; CODE XREF: Sonic_DoLevelCollision+62j
		bsr.w	loc_13146
		tst.w	d1
		bpl.s	locret_105E2
		move.b	$12(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_10582
		cmp.b	d2,d0
		blt.s	locret_105E2

loc_10582:				; CODE XREF: Sonic_DoLevelCollision+80j
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Sonic_ResetOnFloor
		move.b	#0,$1C(a0)
		move.b	d3,d0
		addi.b	#$20,d0	; ' '
		andi.b	#$40,d0	; '@'
		bne.s	loc_105C0
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0	; ' '
		beq.s	loc_105B2
		asr	$12(a0)
		bra.s	loc_105D4
; ---------------------------------------------------------------------------

loc_105B2:				; CODE XREF: Sonic_DoLevelCollision+AEj
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_105C0:				; CODE XREF: Sonic_DoLevelCollision+A2j
		move.w	#0,$10(a0)
		cmpi.w	#$FC0,$12(a0)
		ble.s	loc_105D4
		move.w	#$FC0,$12(a0)

loc_105D4:				; CODE XREF: Sonic_DoLevelCollision+B4j
					; Sonic_DoLevelCollision+D0j
		move.w	$12(a0),$14(a0)
		tst.b	d3
		bpl.s	locret_105E2
		neg.w	$14(a0)

locret_105E2:				; CODE XREF: Sonic_DoLevelCollision+74j
					; Sonic_DoLevelCollision+84j ...
		rts
; ---------------------------------------------------------------------------

loc_105E4:				; CODE XREF: Sonic_DoLevelCollision+36j
		bsr.w	Sonic_HitWall
		tst.w	d1
		bpl.s	loc_105FE
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)
		move.w	$12(a0),$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_105FE:				; CODE XREF: Sonic_DoLevelCollision+EEj
		bsr.w	Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	loc_10618
		sub.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	locret_10616
		move.w	#0,$12(a0)

locret_10616:				; CODE XREF: Sonic_DoLevelCollision+112j
		rts
; ---------------------------------------------------------------------------

loc_10618:				; CODE XREF: Sonic_DoLevelCollision+108j
		tst.w	$12(a0)
		bmi.s	locret_10644
		bsr.w	loc_13146
		tst.w	d1
		bpl.s	locret_10644
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Sonic_ResetOnFloor
		move.b	#0,$1C(a0)
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)

locret_10644:				; CODE XREF: Sonic_DoLevelCollision+120j
					; Sonic_DoLevelCollision+128j
		rts
; ---------------------------------------------------------------------------

loc_10646:				; CODE XREF: Sonic_DoLevelCollision+3Ej
		bsr.w	Sonic_HitWall
		tst.w	d1
		bpl.s	loc_10658
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_10658:				; CODE XREF: Sonic_DoLevelCollision+150j
		bsr.w	sub_132EE
		tst.w	d1
		bpl.s	loc_1066A
		add.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_1066A:				; CODE XREF: Sonic_DoLevelCollision+162j
		bsr.w	Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	locret_106A0
		sub.w	d1,$C(a0)
		move.b	d3,d0
		addi.b	#$20,d0	; ' '
		andi.b	#$40,d0	; '@'
		bne.s	loc_1068A
		move.w	#0,$12(a0)
		rts
; ---------------------------------------------------------------------------

loc_1068A:				; CODE XREF: Sonic_DoLevelCollision+184j
		move.b	d3,$26(a0)
		bsr.w	Sonic_ResetOnFloor
		move.w	$12(a0),$14(a0)
		tst.b	d3
		bpl.s	locret_106A0
		neg.w	$14(a0)

locret_106A0:				; CODE XREF: Sonic_DoLevelCollision+174j
					; Sonic_DoLevelCollision+19Ej
		rts
; ---------------------------------------------------------------------------

loc_106A2:				; CODE XREF: Sonic_DoLevelCollision+46j
		bsr.w	sub_132EE
		tst.w	d1
		bpl.s	loc_106BC
		add.w	d1,8(a0)
		move.w	#0,$10(a0)
		move.w	$12(a0),$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_106BC:				; CODE XREF: Sonic_DoLevelCollision+1ACj
		bsr.w	Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	loc_106D6
		sub.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	locret_106D4
		move.w	#0,$12(a0)

locret_106D4:				; CODE XREF: Sonic_DoLevelCollision+1D0j
		rts
; ---------------------------------------------------------------------------

loc_106D6:				; CODE XREF: Sonic_DoLevelCollision+1C6j
		tst.w	$12(a0)
		bmi.s	locret_10702
		bsr.w	loc_13146
		tst.w	d1
		bpl.s	locret_10702
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Sonic_ResetOnFloor
		move.b	#0,$1C(a0)
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)

locret_10702:				; CODE XREF: Sonic_DoLevelCollision+1DEj
					; Sonic_DoLevelCollision+1E6j
		rts
; End of function Sonic_DoLevelCollision


; =============== S U B	R O U T	I N E =======================================


Sonic_ResetOnFloor:			; CODE XREF: RideObject_SetRide+54p
					; Sonic_Move+1C0p ...
		btst	#4,$22(a0)
		beq.s	loc_10712
		nop
		nop
		nop

loc_10712:				; CODE XREF: Sonic_ResetOnFloor+6j
		bclr	#5,$22(a0)
		bclr	#1,$22(a0)
		bclr	#4,$22(a0)
		btst	#2,$22(a0)
		beq.s	loc_10748
		bclr	#2,$22(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.b	#0,$1C(a0)
		subq.w	#5,$C(a0)

loc_10748:				; CODE XREF: Sonic_ResetOnFloor+26j
		move.b	#0,$3C(a0)
		move.w	#0,($FFFFF7D0).w
		move.b	#0,$27(a0)
		rts
; End of function Sonic_ResetOnFloor

; ---------------------------------------------------------------------------

Obj01_Hurt:				; DATA XREF: ROM:0000FA1Ao
		tst.b	$25(a0)
		bmi.w	loc_107E8
		jsr	ObjectMove
		addi.w	#$30,$12(a0) ; '0'
		btst	#6,$22(a0)
		beq.s	loc_1077E
		subi.w	#$20,$12(a0) ; ' '

loc_1077E:				; CODE XREF: ROM:00010776j
		bsr.w	Sonic_HurtStop
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate
		bsr.w	LoadSonicDynPLC
		jmp	DisplaySprite

; =============== S U B	R O U T	I N E =======================================


Sonic_HurtStop:				; CODE XREF: ROM:loc_1077Ep
		move.w	($FFFFEECE).w,d0
		addi.w	#$E0,d0	; 'à'
		cmp.w	$C(a0),d0
		bcs.w	JmpTo_KillSonic
		bsr.w	Sonic_DoLevelCollision
		btst	#1,$22(a0)
		bne.s	locret_107E6
		moveq	#0,d0
		move.w	d0,$12(a0)
		move.w	d0,$10(a0)
		move.w	d0,$14(a0)
		tst.b	$25(a0)
		beq.s	loc_107D6
		move.b	#$FF,$25(a0)
		move.b	#$B,$1C(a0)
		rts
; ---------------------------------------------------------------------------

loc_107D6:				; CODE XREF: Sonic_HurtStop+2Ej
		move.b	#0,$1C(a0)
		subq.b	#2,routine(a0)
		move.w	#$78,$30(a0) ; 'x'

locret_107E6:				; CODE XREF: Sonic_HurtStop+1Aj
		rts
; End of function Sonic_HurtStop

; ---------------------------------------------------------------------------

loc_107E8:				; CODE XREF: ROM:00010760j
		cmpi.b	#$B,$1C(a0)
		bne.s	loc_107FA
		move.b	($FFFFF605).w,d0
		andi.b	#$7F,d0	; ''
		beq.s	loc_10804

loc_107FA:				; CODE XREF: ROM:000107EEj
		subq.b	#2,routine(a0)
		move.b	#0,$25(a0)

loc_10804:				; CODE XREF: ROM:000107F8j
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate
		bsr.w	LoadSonicDynPLC
		jmp	DisplaySprite
; ---------------------------------------------------------------------------
; Obj01_Death:
Obj01_Dead:				; DATA XREF: ROM:0000FA1Co
		bsr.w	Sonic_GameOver
		jsr	ObjectMoveAndFall
		bsr.w	Sonic_RecordPos
		bsr.w	Sonic_Animate
		bsr.w	LoadSonicDynPLC
		jmp	DisplaySprite

; =============== S U B	R O U T	I N E =======================================


Sonic_GameOver:				; CODE XREF: ROM:Obj01_Deadp
		move.w	($FFFFEECE).w,d0
		addi.w	#$100,d0
		cmp.w	$C(a0),d0
		bcc.w	locret_108B4
		move.w	#$FFC8,$12(a0)
		addq.b	#2,routine(a0)
		clr.b	($FFFFFE1E).w
		addq.b	#1,($FFFFFE1C).w
		subq.b	#1,($FFFFFE12).w
		bne.s	loc_10888
		move.w	#0,$3A(a0)
		move.b	#$39,($FFFFB080).w ; '9'
		move.b	#$39,($FFFFB0C0).w ; '9'
		move.b	#1,($FFFFB0DA).w
		clr.b	($FFFFFE1A).w

loc_10876:				; CODE XREF: Sonic_GameOver+80j
		move.w	#$8F,d0	; ''
		jsr	(PlaySound).l
		moveq	#3,d0
		jmp	(LoadPLC).l
; ---------------------------------------------------------------------------

loc_10888:				; CODE XREF: Sonic_GameOver+26j
		move.w	#$3C,$3A(a0) ; '<'
		tst.b	($FFFFFE1A).w
		beq.s	locret_108B4
		move.w	#0,$3A(a0)
		move.b	#$39,($FFFFB080).w ; '9'
		move.b	#$39,($FFFFB0C0).w ; '9'
		move.b	#2,($FFFFB09A).w
		move.b	#3,($FFFFB0DA).w
		bra.s	loc_10876
; ---------------------------------------------------------------------------

locret_108B4:				; CODE XREF: Sonic_GameOver+Cj
					; Sonic_GameOver+60j
		rts
; End of function Sonic_GameOver

; ---------------------------------------------------------------------------

Obj01_ResetLevel:			; DATA XREF: ROM:0000FA1Eo
		tst.w	$3A(a0)
		beq.s	locret_108C8
		subq.w	#1,$3A(a0)
		bne.s	locret_108C8
		move.w	#1,($FFFFFE02).w

locret_108C8:				; CODE XREF: ROM:000108BAj
					; ROM:000108C0j
		rts

; =============== S U B	R O U T	I N E =======================================


Sonic_Animate:				; CODE XREF: ROM:loc_FAFEp
					; ROM:0001078Ap ...

; FUNCTION CHUNK AT 0001095C SIZE 0000015E BYTES

		lea	(SonicAniData).l,a1
		moveq	#0,d0
		move.b	$1C(a0),d0
		cmp.b	$1D(a0),d0
		beq.s	loc_108EC
		move.b	d0,$1D(a0)
		move.b	#0,$1B(a0)
		move.b	#0,$1E(a0)

loc_108EC:				; CODE XREF: Sonic_Animate+10j
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_1095C
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		subq.b	#1,$1E(a0)
		bpl.s	locret_1092A
		move.b	d0,$1E(a0)
; End of function Sonic_Animate


; =============== S U B	R O U T	I N E =======================================


sub_10912:				; CODE XREF: Sonic_Animate+116p
					; Sonic_Animate+1BAj ...
		moveq	#0,d1
		move.b	$1B(a0),d1
		move.b	1(a1,d1.w),d0
		cmpi.b	#$F0,d0
		bcc.s	loc_1092C

loc_10922:				; CODE XREF: sub_10912+28j
					; sub_10912+3Cj
		move.b	d0,$1A(a0)
		addq.b	#1,$1B(a0)

locret_1092A:				; CODE XREF: Sonic_Animate+42j
					; Sonic_Animate+96j
		rts
; ---------------------------------------------------------------------------

loc_1092C:				; CODE XREF: sub_10912+Ej
		addq.b	#1,d0
		bne.s	loc_1093C
		move.b	#0,$1B(a0)
		move.b	1(a1),d0
		bra.s	loc_10922
; ---------------------------------------------------------------------------

loc_1093C:				; CODE XREF: sub_10912+1Cj
		addq.b	#1,d0
		bne.s	loc_10950
		move.b	2(a1,d1.w),d0
		sub.b	d0,$1B(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_10922
; ---------------------------------------------------------------------------

loc_10950:				; CODE XREF: sub_10912+2Cj
		addq.b	#1,d0
		bne.s	locret_1095A
		move.b	2(a1,d1.w),$1C(a0)

locret_1095A:				; CODE XREF: sub_10912+40j
		rts
; End of function sub_10912

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Sonic_Animate

loc_1095C:				; CODE XREF: Sonic_Animate+2Aj
		subq.b	#1,$1E(a0)
		bpl.s	locret_1092A
		addq.b	#1,d0
		bne.w	loc_10A44
		moveq	#0,d0
		move.b	$27(a0),d0
		bne.w	loc_109EA
		moveq	#0,d1
		move.b	$26(a0),d0
		move.b	$22(a0),d2
		andi.b	#1,d2
		bne.s	loc_10984
		not.b	d0

loc_10984:				; CODE XREF: Sonic_Animate+B6j
		addi.b	#$10,d0
		bpl.s	loc_1098C
		moveq	#3,d1

loc_1098C:				; CODE XREF: Sonic_Animate+BEj
		andi.b	#$FC,1(a0)
		eor.b	d1,d2
		or.b	d2,1(a0)
		btst	#5,$22(a0)
		bne.w	loc_10A88
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	$14(a0),d2
		bpl.s	loc_109B0
		neg.w	d2

loc_109B0:				; CODE XREF: Sonic_Animate+E2j
		lea	(SonicAni_Run).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_109C2
		lea	(SonicAni_Walk).l,a1

loc_109C2:				; CODE XREF: Sonic_Animate+F0j
		move.b	d0,d1
		lsr.b	#1,d1
		add.b	d1,d0
		add.b	d0,d0
		add.b	d0,d0
		move.b	d0,d3
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_109D8
		moveq	#0,d2

loc_109D8:				; CODE XREF: Sonic_Animate+10Aj
		lsr.w	#8,d2
		lsr.w	#1,d2
		move.b	d2,$1E(a0)
		bsr.w	sub_10912
		add.b	d3,$1A(a0)
		rts
; ---------------------------------------------------------------------------

loc_109EA:				; CODE XREF: Sonic_Animate+A4j
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$22(a0),d2
		andi.b	#1,d2
		bne.s	loc_10A1E
		andi.b	#$FC,1(a0)
		moveq	#0,d2
		or.b	d2,1(a0)
		addi.b	#$B,d0
		divu.w	#$16,d0
		addi.b	#$9B,d0
		move.b	d0,$1A(a0)
		move.b	#0,$1E(a0)
		rts
; ---------------------------------------------------------------------------

loc_10A1E:				; CODE XREF: Sonic_Animate+12Ej
		moveq	#3,d2
		andi.b	#$FC,1(a0)
		or.b	d2,1(a0)
		neg.b	d0
		addi.b	#$8F,d0
		divu.w	#$16,d0
		addi.b	#$9B,d0
		move.b	d0,$1A(a0)
		move.b	#0,$1E(a0)
		rts
; ---------------------------------------------------------------------------

loc_10A44:				; CODE XREF: Sonic_Animate+9Aj
		addq.b	#1,d0
		bne.s	loc_10A88
		move.w	$14(a0),d2
		bpl.s	loc_10A50
		neg.w	d2

loc_10A50:				; CODE XREF: Sonic_Animate+182j
		lea	(SonicAni_Roll2).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_10A62
		lea	(SonicAni_Roll).l,a1

loc_10A62:				; CODE XREF: Sonic_Animate+190j
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_10A6C
		moveq	#0,d2

loc_10A6C:				; CODE XREF: Sonic_Animate+19Ej
		lsr.w	#8,d2
		move.b	d2,$1E(a0)
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		bra.w	sub_10912
; ---------------------------------------------------------------------------

loc_10A88:				; CODE XREF: Sonic_Animate+D4j
					; Sonic_Animate+17Cj
		move.w	$14(a0),d2
		bmi.s	loc_10A90
		neg.w	d2

loc_10A90:				; CODE XREF: Sonic_Animate+1C2j
		addi.w	#$800,d2
		bpl.s	loc_10A98
		moveq	#0,d2

loc_10A98:				; CODE XREF: Sonic_Animate+1CAj
		lsr.w	#6,d2
		move.b	d2,$1E(a0)
		lea	(SonicAni_Push).l,a1
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		bra.w	sub_10912
; End of function Sonic_Animate
; ===========================================================================
; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------
SonicAniData:	dc.w SonicAni_Walk-SonicAniData
		dc.w SonicAni_Run-SonicAniData
		dc.w SonicAni_Roll-SonicAniData
		dc.w SonicAni_Roll2-SonicAniData
		dc.w SonicAni_Push-SonicAniData
		dc.w SonicAni_Wait-SonicAniData
		dc.w SonicAni_Balance-SonicAniData
		dc.w SonicAni_LookUp-SonicAniData
		dc.w SonicAni_Duck-SonicAniData
		dc.w SonicAni_Spindash-SonicAniData
		dc.w SonicAni_WallRecoil1-SonicAniData
		dc.w SonicAni_WallRecoil2-SonicAniData
		dc.w SonicAni_0C-SonicAniData
		dc.w SonicAni_Stop-SonicAniData
		dc.w SonicAni_Float1-SonicAniData
		dc.w SonicAni_Float2-SonicAniData
		dc.w SonicAni_10-SonicAniData
		dc.w SonicAni_S1LZHang-SonicAniData
		dc.w SonicAni_Unused12-SonicAniData
		dc.w SonicAni_Unused13-SonicAniData
		dc.w SonicAni_Unused14-SonicAniData
		dc.w SonicAni_Bubble-SonicAniData
		dc.w SonicAni_Death1-SonicAniData
		dc.w SonicAni_Drown-SonicAniData
		dc.w SonicAni_Death2-SonicAniData
		dc.w SonicAni_Unused19-SonicAniData
		dc.w SonicAni_Hurt-SonicAniData
		dc.w SonicAni_S1LZSlide-SonicAniData
		dc.w SonicAni_1C-SonicAniData
		dc.w SonicAni_Float3-SonicAniData
		dc.w SonicAni_1E-SonicAniData
SonicAni_Walk:		dc.b $FF,$10,$11,$12,$13,$14,$15,$16,$17, $C, $D, $E, $F,$FF
SonicAni_Run:		dc.b $FF,$3C,$3D,$3E,$3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SonicAni_Roll:		dc.b $FE,$6C,$70,$6D,$70,$6E,$70,$6F,$70,$FF
SonicAni_Roll2:		dc.b $FE,$6C,$70,$6D,$70,$6E,$70,$6F,$70,$FF
SonicAni_Push:		dc.b $FD,$77,$78,$79,$7A,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
SonicAni_Wait:		dc.b   7,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
			dc.b   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2
			dc.b   3,  3,  3,  4,  4,  5,  5,$FE,  4
SonicAni_Balance:	dc.b	7,$89,$8A,$FF
SonicAni_LookUp:	dc.b   5,  6,  7,$FE,  1
SonicAni_Duck:		dc.b   5,$7F,$80,$FE,  1
SonicAni_Spindash:	dc.b	 0,$71,$72,$71,$73,$71,$74,$71,$75,$71,$76,$71,$FF
SonicAni_WallRecoil1:	dc.b $3F,$82,$FF
SonicAni_WallRecoil2:	dc.b   7, 8, 8, 9,$FD,	5
SonicAni_0C:		dc.b   7,  9,$FD,  5
SonicAni_Stop:		dc.b   3,$81,$82,$83,$84,$85,$86,$87,$88,$FE,  2
SonicAni_Float1:	dc.b   7,$94,$96,$FF
SonicAni_Float2:	dc.b   7,$91,$92,$93,$94,$95,$FF
SonicAni_10:		dc.b $2F,$7E,$FD,  0
SonicAni_S1LZHang:	dc.b	 5,$8F,$90,$FF
SonicAni_Unused12:	dc.b	$F,$43,$43,$43,$FE,  1
SonicAni_Unused13:	dc.b	$F,$43,$44,$FE,	 1
SonicAni_Unused14:	dc.b $3F,$49,$FF
SonicAni_Bubble:	dc.b  $B,$97,$97,$12,$13,$FD,  0
SonicAni_Death1:	dc.b $20,$9A,$FF
SonicAni_Drown:		dc.b $20,$99,$FF
SonicAni_Death2:	dc.b $20,$98,$FF
SonicAni_Unused19:	dc.b	 3,$4E,$4F,$50,$51,$52,	 0,$FE,	 1
SonicAni_Hurt:		dc.b $40,$8D,$FF
SonicAni_S1LZSlide:	dc.b	  9,$8D,$8E,$FF
SonicAni_1C:		dc.b $77,  0,$FD,  0
SonicAni_Float3:	dc.b   3,$91,$92,$93,$94,$95,$FF
SonicAni_1E:		dc.b   3,$3C,$FD,  0
	even

; ---------------------------------------------------------------------------
; Sonic pattern loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


LoadSonicDynPLC:
		moveq	#0,d0
		move.b	$1A(a0),d0
		cmp.b	(Sonic_LastLoadedDPLC).w,d0
		beq.s	locret_10C34
		move.b	d0,(Sonic_LastLoadedDPLC).w
		lea	(SonicDynPLC).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_10C34
		move.w	#$F000,d4
; loc_10C08:
SPLC_ReadEntry:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		addi.l	#Art_Sonic,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,SPLC_ReadEntry

locret_10C34:
		rts
; End of function LoadSonicDynPLC

; ===========================================================================
		nop

JmpTo_KillSonic:	; JmpTo
		jmp	(KillSonic).l

		align 4

; ===========================================================================
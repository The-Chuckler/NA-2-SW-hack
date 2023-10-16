;=============================================================================== 
; Object 0x75 - Dust Hill - Spikeball with chain
; [ Begin ]		         
;===============================================================================		
Obj_0x75_Spikeball_Chain: ; loc_1CE48:
		btst    #$06, $0001(A0)
		bne.w    loc_1CE60
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1CE68(PC, D0), D1
		jmp     loc_1CE68(PC, D1)
loc_1CE60:
		move.w  #$0280, D0
		bra.w     J_DisplaySprite_Param_00  ; loc_1D040
loc_1CE68:
		dc.w    loc_1CE6E-loc_1CE68
		dc.w    loc_1CF4A-loc_1CE68
		dc.w    loc_1CFEC-loc_1CE68
loc_1CE6E:
		addq.b  #$02, $0024(A0)
		move.l  #Obj75_MapUnc_1D00A, $0004(A0) ; loc_1D00A
		move.w  #$2000, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_1B ; loc_1D064
		move.b  #$04, $0001(A0)
		move.b  #$05, $0018(A0)
		move.b  #$10, $0019(A0)
		move.w  $0008(A0), $0030(A0)
		move.w  $000C(A0), $0032(A0)
		move.b  $0028(A0), D1
		move.b  D1, D0
		andi.w  #$000F, D1
		andi.b  #$F0, D0
		ext.w   D0
		asl.w   #$03, D0
		move.w  D0, $0034(A0)
		move.b  $0022(A0), D0
		ror.b   #$02, D0
		andi.b  #$C0, D0
		move.b  D0, $0026(A0)
		cmpi.b  #$0F, D1
		bne.s   loc_1CEDE
		addq.b  #$02, $0024(A0)
		move.b  #$04, $0018(A0)
		move.b  #$02, $001A(A0)
		rts
loc_1CEDE:
		move.b  #$9A, $0020(A0)
		bsr.w     J_SingleObjLoad2_08  ; loc_1D05E
		bne.s   loc_1CF4A
		_move.b  0(A0), 0(A1)
		move.l  $0004(A0), $0004(A1)
		move.w  $0002(A0), $0002(A1)
		move.b  #$04, $0001(A1)
		bset    #$06, $0001(A1)
		move.b  #$40, $000E(A1)
		move.w  $0008(A0), D2
		move.w  $000C(A0), D3
		move.b  D1, $000F(A1)
		subq.w  #$01, D1
		lea     $0010(A1), A2
loc_1CF20:		
		move.w  D2, (A2)+
		move.w  D3, (A2)+
		move.w  #$0001, (A2)+
		dbf    D1, loc_1CF20
		move.w  D2, $0008(A1)
		move.w  D3, $000C(A1)
		move.b  #$00, $000B(A1)
		move.l  A1, $003C(A0)
		move.b  #$40, $0014(A1)
		bset    #$04, $0001(A1)
loc_1CF4A:
		move.w  $0034(A0), D0
		add.w   D0, $0026(A0)
		move.b  $0026(A0), D0
		bsr.w     JmpTo4_CalcSine
		move.w  $0032(A0), D2
		move.w  $0030(A0), D3
		moveq   #$00, D6
		move.l  $003C(A0), A1
		move.b  $000F(A1), D6
		subq.w  #$01, D6
		bcs.s   loc_1CFBE
		asl.w   #$04, D0
		ext.l   D0
		asl.l   #$08, D0
		asl.w   #$04, D1
		ext.l   D1
		asl.l   #$08, D1
		moveq   #$00, D4
		moveq   #$00, D5
		lea     $0010(A1), A2
loc_1CF84:		
		movem.l D4/D5, -(A7)
		swap  D4
		swap  D5
		add.w   D2, D4
		add.w   D3, D5
		move.w  D5, (A2)+
		move.w  D4, (A2)+
		movem.l (A7)+, D4/D5
		add.l   D0, D4
		add.l   D1, D5
		addq.w  #$02, A2
		dbf    D6, loc_1CF84
		swap  D4
		swap  D5
		add.w   D2, D4
		add.w   D3, D5
		move.w  D5, $0008(A0)
		move.w  D4, $000C(A0)
		move.w  $0028(A1), $0008(A1)
		move.w  $002A(A1), $000C(A1)
loc_1CFBE:
		tst.w   (Two_player_mode).w
		beq.s   loc_1CFC8
		bra.w     J_DisplaySprite_0C      ; loc_1D046
loc_1CFC8:
		move.w  $0030(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.w    loc_1CFE0
		bra.w     J_DisplaySprite_0C      ; loc_1D046
loc_1CFE0:
		move.l  $003C(A0), A1
		bsr.w     loc_1D058
		bra.w     J_DeleteObject_1F       ; loc_1D04C
loc_1CFEC:
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		move.w  #$0010, D2
		move.w  #$0011, D3
		move.w  $0008(A0), D4
		bsr.w     J_SolidObject_0F        ; loc_1D070
		bra.w     J_MarkObjGone_11        ; loc_1D052   
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj75_MapUnc_1D00A:	BINCLUDE	"mappings/sprite/obj75.bin"
; ============================================================================
		nop

J_DisplaySprite_Param_00: ; loc_1D040:		               
		jmp     DisplaySprite_Param     ; (loc_D3FE)
J_DisplaySprite_0C: ; loc_1D046:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_1F: ; loc_1D04C:
		jmp     DeleteObject            ; (loc_D3B4)
J_MarkObjGone_11: ; loc_1D052:
		jmp     MarkObjGone             ; (loc_D2A0)
loc_1D058:
		jmp     (loc_D3B6)
J_SingleObjLoad2_08: ; loc_1D05E:
		jmp     SingleObjLoad2      ; (loc_E788)
J_Adjust2PArtPointer_1B: ; loc_1D064:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
; loc_1D06A:
JmpTo4_CalcSine:
		jmp	(CalcSine).l
J_SolidObject_0F: ; loc_1D070:
		jmp     SolidObject             ; (loc_F4A0)     
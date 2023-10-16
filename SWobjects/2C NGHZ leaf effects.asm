;=============================================================================== 
; Object 0x2C - Neo Green Hill - Leaves
; [ Begin ]		         
;===============================================================================		  
;Obj_0x2C_Leaves: ; loc_1A0C4:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1A0D2(PC, D0), D1
		jmp     loc_1A0D2(PC, D1)
loc_1A0D2:
		dc.w    lc_1A0DC-loc_1A0D2
		dc.w    loc_1A112-loc_1A0D2
		dc.w    loc_1A234-loc_1A0D2
loc_1A0D8:
		dc.b    $D6, $D4, $D5, $00
lc_1A0DC:
		addq.b  #$02, $0024(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		move.b  loc_1A0D8(PC, D0), $0020(A0)
		move.l  #Lava_Attributes_Mappings, $0004(A0) ; loc_15612
		move.w  #$8680, $0002(A0)
		move.b  #$84, $0001(A0)
		move.b  #$80, $0019(A0)
		move.b  #$04, $0018(A0)
		move.b  $0028(A0), $001A(A0)
loc_1A112:
		move.w  $0008(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.w    J_DeleteObject_15       ; loc_1A2F2
		tst.w   (Debug_placement_mode).w
		beq.s   loc_1A130
		bsr.w     J_DisplaySprite_06      ; loc_1A2EC
loc_1A130:
		move.b  $0021(A0), D0
		beq.s   loc_1A16C
		move.b  (Timer_frames+1).w, D0
		andi.w  #$000F, D0
		bne.s   loc_1A150
		lea     ($FFFFB000).w, A2
		bclr    #$00, $0021(A0)
		beq.s   loc_1A168
		bsr.s   loc_1A16E
		bra.s   loc_1A168
loc_1A150:
		addi.w  #$0008, D0
		andi.w  #$000F, D0
		bne.s   loc_1A168
		lea     ($FFFFB040).w, A2
		bclr    #$01, $0021(A0)
		beq.s   loc_1A168
		bsr.s   loc_1A16E
loc_1A168:
		clr.b   $0021(A0)
loc_1A16C:
		rts
loc_1A16E:
		move.w  $0010(A2), D0
		bpl.s   loc_1A176
		neg.w   D0
loc_1A176:
		cmpi.w  #$0200, D0
		bcc.s   loc_1A18A
		move.w  $0012(A2), D0
		bpl.s   loc_1A184
		neg.w   D0
loc_1A184:
		cmpi.w  #$0200, D0
		bcs.s   loc_1A16C
loc_1A18A:
		lea     (loc_1A224).l, A3
		moveq   #$03, D6
loc_1A192:		
		bsr.w     J_SingleObjLoad_03   ; loc_1A2F8
		bne.w    loc_1A21E
		move.b  #$2C, 0(A1);_move.b  #$2C, 0(A1)
		move.b  #$04, $0024(A1)
		move.w  $0008(A2), $0008(A1)
		move.w  $000C(A2), $000C(A1)
		bsr.w     loc_1A2FE
		andi.w  #$000F, D0
		subq.w  #$08, D0
		add.w   D0, $0008(A1)
		swap  D0
		andi.w  #$000F, D0
		subq.w  #$08, D0
		add.w   D0, $000C(A1)
		move.w  (A3)+, $0010(A1)
		move.w  (A3)+, $0012(A1)
		btst    #$00, $0022(A2)
		beq.s   loc_1A1E0
		neg.w   $0010(A1)
loc_1A1E0:
		move.w  $0008(A1), $0030(A1)
		move.w  $000C(A1), $0034(A1)
		andi.b  #$01, D0
		move.b  D0, $001A(A1)
		move.l  #Leaves_Mappings, $0004(A1) ; loc_1A2BC
		move.w  #$E410, $0002(A1)
		move.b  #$84, $0001(A1)
		move.b  #$08, $0019(A1)
		move.b  #$01, $0018(A1)
		move.b  #$04, $0038(A1)
		move.b  D1, $0026(A0)
loc_1A21E:
		dbf    D6, loc_1A192
		rts  
loc_1A224:
		dc.w    $FF80, $FF80, $00C0, $FFC0, $FF40, $0040, $0080, $0080
loc_1A234:
		move.b  $0038(A0), D0
		add.b   D0, $0026(A0)
		add.b   (Vint_runcount+3).w, D0
		andi.w  #$001F, D0
		bne.s   loc_1A252
		add.b   D7, D0
		andi.b  #$01, D0
		beq.s   loc_1A252
		neg.b   $0038(A0)
loc_1A252:
		move.l  $0030(A0), D2
		move.l  $0034(A0), D3
		move.w  $0010(A0), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  $0012(A0), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, $0030(A0)
		move.l  D3, $0034(A0)
		swap  D2
		andi.w  #$0003, D3
		addq.w  #$04, D3
		add.w   D3, $0012(A0)
		move.b  $0026(A0), D0
		bsr.w     JmpTo3_CalcSine
		asr.w   #$06, D0
		add.w   $0030(A0), D0
		move.w  D0, $0008(A0)
		asr.w   #$06, D1
		add.w   $0034(A0), D1
		move.w  D1, $000C(A0)
		subq.b  #$01, $001E(A0)
		bpl.s   loc_1A2B0
		move.b  #$0B, $001E(A0)
		bchg    #1, $001A(A0)
loc_1A2B0:
		tst.b   $0001(A0)
		bpl.w    J_DeleteObject_15       ; loc_1A2F2
		bra.w     J_DisplaySprite_06      ; loc_1A2EC
Leaves_Mappings:		
loc_1A2BC:
		dc.w    loc_1A2C4-loc_1A2BC
		dc.w    loc_1A2CE-loc_1A2BC
		dc.w    loc_1A2D8-loc_1A2BC
		dc.w    loc_1A2E2-loc_1A2BC
loc_1A2C4:
		dc.w    $0001
		dc.l    $FC000000, $0000FFFC
loc_1A2CE:
		dc.w    $0001
		dc.l    $FC040001, $0000FFF8
loc_1A2D8:
		dc.w    $0001
		dc.l    $FC040003, $0001FFF8
loc_1A2E2:
		dc.w    $0001
		dc.l    $FC040005, $0002FFF8		            
;=============================================================================== 
; Object 0x2C - Neo Green Hill - Leaves
; [ End ]		         
;===============================================================================		   
J_DisplaySprite_06: ; loc_1A2EC:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_15: ; loc_1A2F2:
		jmp     DeleteObject            ; (loc_D3B4)
J_SingleObjLoad_03: ; loc_1A2F8:
		jmp     SingleObjLoad        ; (loc_E772)
loc_1A2FE:
		jmp     (PseudoRandomNumber).l      ; loc_31E4
JmpTo3_CalcSine:
		jmp	(CalcSine).l
Lava_Attributes_Mappings:		
loc_15612:
		dc.w    loc_15618-loc_15612
		dc.w    loc_15618-loc_15612
		dc.w    loc_15618-loc_15612
loc_15618:
		dc.w    $0000
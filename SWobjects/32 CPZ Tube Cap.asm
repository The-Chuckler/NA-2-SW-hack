;=============================================================================== 
; Object 0x32 - Rock - Hill Top / Tunel Obstacule - Chemical Plant
; [ Begin ]		         
;=============================================================================== 
;Obj_0x32_Breakable_Obstacule: ; loc_1768A:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_17698(PC, D0), D1
		jmp     loc_17698(PC, D1)
loc_17698:
		dc.w    loc_1769E-loc_17698
		dc.w    loc_176F2-loc_17698
		dc.w    loc_177DA-loc_17698
loc_1769E:
		addq.b  #$02, $0024(A0)
		move.l  #Obj32_MapUnc_179C2, $0004(A0) ; loc_179C2
		move.w  #$43B2, $0002(A0)
		move.b  #$18, $0019(A0)
		move.l  #loc_177F0, $003C(A0)
		cmpi.b  #2, (Current_Zone).w;#chemical_plant_zone, (Current_Zone).w
		bne.s   loc_176E2
		move.l  #Obj32_MapUnc_179F6, $0004(A0) ; loc_179F6
		move.w  #$6430, $0002(A0)
		move.b  #$10, $0019(A0)
		move.l  #loc_17808, $003C(A0)
loc_176E2:
		bsr.w     J_Adjust2PArtPointer_05 ; loc_17A34
		move.b  #$04, $0001(A0)
		move.b  #$04, $0018(A0)
loc_176F2:
		move.w  (Chain_Bonus_counter).w, $0038(A0)
		move.b  ($FFFFB01C).w, $0032(A0)
		move.b  ($FFFFB05C).w, $0033(A0)
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		move.w  #$0010, D2
		move.w  #$0011, D3
		move.w  $0008(A0), D4
		bsr.w     J_SolidObject_00        ; loc_17A40
		move.b  $0022(A0), D0
		andi.b  #$18, D0
		bne.s   loc_1772C
loc_17728:		
		bra.w     J_MarkObjGone_04        ; loc_17A2E
loc_1772C:
		cmpi.b  #$18, D0
		bne.s   loc_1775A
		cmpi.b  #$02, $0032(A0)
		beq.s   loc_17742
		cmpi.b  #$02, $0033(A0)
		bne.s   loc_17728
loc_17742:
		lea     ($FFFFB000).w, A1
		move.b  $0032(A0), D0
		bsr.s   lc_17772
		lea     ($FFFFB040).w, A1
		move.b  $0033(A0), D0
		bsr.s   lc_17772
		bra.w     loc_177C2
loc_1775A:
		move.b  D0, D1
		andi.b  #$08, D1
		beq.s   loc_177AA
		cmpi.b  #$02, $0032(A0)
		bne.s   loc_17728
		lea     ($FFFFB000).w, A1
		bsr.s   loc_17778
		bra.s   loc_177C2
lc_17772:
		cmpi.b  #$02, D0
		bne.s   loc_17796
loc_17778:
		bset    #$02, $0022(A1)
		move.b  #$0E, $0016(A1)
		move.b  #$07, $0017(A1)
		move.b  #$02, $001C(A1)
		move.w  #$FD00, $0012(A1)
loc_17796:
		bset    #$01, $0022(A1)
		bclr    #$03, $0022(A1)
		move.b  #$02, $0024(A1)
		rts
loc_177AA:
		andi.b  #$10, D0
		beq.w    loc_17728
		cmpi.b  #$02, $0033(A0)
		bne.w    loc_17728
		lea     ($FFFFB040).w, A1
		bsr.s   loc_17778
loc_177C2:
		move.w  $0038(A0), (Chain_Bonus_counter).w
		andi.b  #$E7, $0022(A0)
		move.l  $003C(A0), A4
		bsr.w     loc_17A3A
		bsr.w     loc_17818
loc_177DA:
		bsr.w     J_SpeedToPos_04         ; loc_17A46
		addi.w  #$0018, $0012(A0)
		tst.b   $0001(A0)
		bpl.w    J_DeleteObject_0E       ; loc_17A22
		bra.w     J_DisplaySprite_02      ; loc_17A1C
loc_177F0:
		dc.w    $FE00, $FE00, $0000, $FD80, $0200, $FE00, $FE40, $FE40
		dc.w    $0000, $FE00, $01C0, $FE40
loc_17808:
		dc.w    $FF00, $FE00, $0100, $FE00, $FF40, $FE40, $00C0, $FE40		
;=============================================================================== 
; Object 0x32 - Rock - Hill Top / Tunel Obstacule - Chemical Plant
; [ End ]		         
;===============================================================================      
loc_17818:
		bsr.w     J_SingleObjLoad_00   ; loc_17A28
		bne.s   loc_17860
		move.b  #$29, 0(A1);_move.b  #$29, 0(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $000C(A0), $000C(A1)
		move.w  (Chain_Bonus_counter).w, D2
		addq.w  #$02, (Chain_Bonus_counter).w
		cmpi.w  #$0006, D2
		bcs.s   loc_17840
		moveq   #$06, D2
loc_17840:
		moveq   #$00, D0
		move.w  loc_17862(PC, D2), D0
		cmpi.w  #$0020, (Chain_Bonus_counter).w
		bcs.s   lc_17854
		move.w  #$03E8, D0
		moveq   #$0A, D2
lc_17854:
		jsr     AddPoints               ; (loc_22FD0)
		lsr.w   #$01, D2
		move.b  D2, $001A(A1)
loc_17860:
		rts
loc_17862:
		dc.w    $000A, $0014, $0032, $0064
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; Sprite mappings - Obj32
; ---------------------------------------------------------------------------
Obj32_MapUnc_179C2:	incbin	"mappings/sprite/obj32_HTZ.bin"	; HTZ rock
Obj32_MapUnc_179F6:	incbin	"mappings/sprite/obj32_CPZ.bin" ; CPZ tube cover
; ===========================================================================
		nop

J_DisplaySprite_02: ; loc_17A1C:
		jmp     DisplaySprite           ; (loc_D3C2)
J_DeleteObject_0E: ; loc_17A22:
		jmp     DeleteObject            ; (loc_D3B4)
J_SingleObjLoad_00: ; loc_17A28:
		jmp     SingleObjLoad        ; (loc_E772)
J_MarkObjGone_04: ; loc_17A2E:
		jmp     MarkObjGone             ; (loc_D2A0)
J_Adjust2PArtPointer_05: ; loc_17A34:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_17A3A:
		jmp     (BreakObjectToPieces)
J_SolidObject_00: ; loc_17A40:
		jmp     SolidObject             ; (loc_F4A0)
J_SpeedToPos_04: ; loc_17A46:
		jmp     SpeedToPos              ; (loc_D27A) 
Chain_Bonus_counter:		equ		$FFFFF7D0
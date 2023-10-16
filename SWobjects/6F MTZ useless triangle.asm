;=============================================================================== 
; Object 0x6F - Metropolis - Parallelogram Elevators
; [ Begin ]		         
;===============================================================================		    
;Obj_Ox6F_Parallelogram_Elevator: ; loc_1C4F8:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1C506(PC, D0), D1
		jmp     loc_1C506(PC, D1)
loc_1C506:
		dc.w    loc_1C50A-loc_1C506
		dc.w    loc_1C570-loc_1C506
loc_1C50A:
		addq.b  #$02, $0024(A0)
		move.l  #Obj6F_MapUnc_1C7BE, $0004(A0) ; loc_1C7BE
		move.w  #$653F, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_19 ; loc_1C844
		ori.b   #$04, $0001(A0)
		move.b  #$04, $0018(A0)
		move.b  #$80, $0019(A0)
		move.b  #$20, $0016(A0)
		move.w  $0008(A0), $0032(A0)
		move.w  $000C(A0), $0030(A0)
		move.b  $0028(A0), D0
		lsr.w   #$03, D0
		andi.w  #$000E, D0
		lea     (loc_1C632).l, A1
		move.w  $00(A1, D0), D0
		lea     $00(A1, D0), A1
		move.l  A1, $003C(A0)
		bsr.w     loc_1C604
		bset    #$07, $0022(A0)
		andi.b  #$0F, $0028(A0)
loc_1C570:
		move.w  $0008(A0), -(A7)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		add.w   D0, D0
		move.w  loc_1C5DA(PC, D0), D1
		jsr     loc_1C5DA(PC, D1)
		move.w  (A7)+, D4
		moveq   #$00, D1
		move.b  $0019(A0), D1
		lea     (loc_1C6BE).l, A2
		bsr.w     loc_1C84A
		move.w  $0008(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1C5AE
		jmp     DisplaySprite           ; (loc_D3C2)
loc_1C5AE:
		move.w  $0032(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1C5C2
		rts
loc_1C5C2:
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   J_DeleteObject_1D       ; loc_1C5D4
		bclr    #$07, $02(A2, D0)
J_DeleteObject_1D: ; loc_1C5D4:
		jmp     DeleteObject            ; (loc_D3B4)
loc_1C5DA:
		dc.w    loc_1C5E0-loc_1C5DA
		dc.w    loc_1C5E2-loc_1C5DA
		dc.w    loc_1C5F2-loc_1C5DA
loc_1C5E0:
		rts
loc_1C5E2:
		move.b  $0022(A0), D0
		andi.b  #$18, D0
		beq.s   loc_1C5F0
		addq.b  #$01, $0028(A0)
loc_1C5F0:
		rts
loc_1C5F2:
		jsr     SpeedToPos              ; (loc_D27A)
		subq.w  #$01, $0034(A0)
		bne.s   loc_1C602
		bsr.w     loc_1C604
loc_1C602:
		rts
loc_1C604:
		moveq   #$00, D0
		move.b  $0038(A0), D0
		move.l  $003C(A0), A1
		move.w  (A1)+, D1
		lea     $00(A1, D0), A1
		move.w  (A1)+, $0010(A0)
		move.w  (A1)+, $0012(A0)
		move.w  (A1)+, $0034(A0)
		addq.b  #$06, $0038(A0)
		cmp.b   $0038(A0), D1
		bhi.s   loc_1C630
		move.b  #$00, $0038(A0)
loc_1C630:
		rts   
loc_1C632:
		dc.w    loc_1C63C-loc_1C632
		dc.w    loc_1C64A-loc_1C632
		dc.w    loc_1C658-loc_1C632
		dc.w    loc_1C672-loc_1C632
		dc.w    loc_1C6A4-loc_1C632
loc_1C63C:
		dc.w    $000C
		dc.b    $01, $00, $FF, $80, $01, $00, $FF, $00, $00, $80, $01, $00
loc_1C64A:
		dc.w    $000C
		dc.b    $01, $00, $FF, $80, $01, $80, $FF, $00, $00, $80, $01, $80
loc_1C658:
		dc.w    $0018
		dc.b    $FF, $00, $00, $80, $00, $80, $FF, $00, $00, $00, $01, $80, $01, $00, $FF, $80
		dc.b    $00, $80, $01, $00, $00, $00, $01, $80
loc_1C672:
		dc.w    $0030
		dc.b    $01, $00, $FF, $80, $02, $00, $01, $00, $00, $00, $01, $00, $FF, $00, $00, $80
		dc.b    $01, $00, $01, $00, $00, $00, $01, $80, $FF, $00, $00, $00, $01, $80, $01, $00
		dc.b    $FF, $80, $01, $00, $FF, $00, $00, $00, $01, $00, $FF, $00, $00, $80, $02, $00
loc_1C6A4:
		dc.w    $0018
		dc.b    $FF, $00, $00, $80, $01, $80, $01, $00, $00, $00, $02, $00, $FF, $00, $00, $00
		dc.b    $02, $00, $01, $00, $FF, $80, $01, $80  
loc_1C6BE:
		dc.w    $E101, $E202, $E303, $E404, $E505, $E606, $E707, $E808
		dc.w    $E909, $EA0A, $EB0B, $EC0C, $ED0D, $EE0E, $EF0F, $F010
		dc.w    $F111, $F212, $F313, $F414, $F515, $F616, $F717, $F818
		dc.w    $F919, $FA1A, $FB1B, $FC1C, $FD1D, $FE1E, $FF1F, $0020
		dc.w    $0121, $0222, $0323, $0424, $0525, $0626, $0727, $0828
		dc.w    $0929, $0A2A, $0B2B, $0C2C, $0D2D, $0E2E, $0F2F, $1030
		dc.w    $1131, $1232, $1333, $1434, $1535, $1636, $1737, $1838
		dc.w    $1939, $1A3A, $1B3B, $1C3C, $1D3D, $1E3E, $1F3F, $2040
		dc.w    $2040, $203F, $203E, $203D, $203C, $203B, $203A, $2039
		dc.w    $2038, $2037, $2036, $2035, $2034, $2033, $2032, $2031
		dc.w    $2030, $202F, $202E, $202D, $202C, $202B, $202A, $2029
		dc.w    $2028, $2027, $2026, $2025, $2024, $2023, $2022, $2021
		dc.w    $2020, $201F, $201E, $201D, $201C, $201B, $201A, $2019
		dc.w    $2018, $2017, $2016, $2015, $2014, $2013, $2012, $2011
		dc.w    $2010, $200F, $200E, $200D, $200C, $200B, $200A, $2009
		dc.w    $2008, $2007, $2006, $2005, $2004, $2003, $2002, $2001   
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj6F_MapUnc_1C7BE:	incbin	"mappings/sprite/obj6F.bin"
; ===========================================================================
		nop

J_Adjust2PArtPointer_19: ; loc_1C844:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1C84A:
		jmp     (loc_F59E)   
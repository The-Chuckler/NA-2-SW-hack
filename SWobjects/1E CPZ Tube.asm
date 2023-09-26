;=============================================================================== 
; Object 0x1E - Chemical Plant - Tube Attributes
; [ Begin ]		         
;===============================================================================		  
;Obj_0x1E_Tube_Attributes: ; loc_16724:
		moveq   #$00, D0
		move.b  routine(A0), D0
		move.w  loc_16740(PC, D0), D1
		jsr     loc_16740(PC, D1)
		move.b  $002C(A0), D0
		add.b   $0036(A0), D0
		beq.w    loc_1716C
		rts
loc_16740:
		dc.w    loc_1674A-loc_16740
		dc.w    loc_1675E-loc_16740
loc_16744:		
		dc.w    $00A0, $0100, $0120
loc_1674A:
		addq.b  #$02, routine(A0)
		move.b  $0028(A0), D0
		add.w   D0, D0
		andi.w  #$0006, D0
		move.w  loc_16744(PC, D0), $002A(A0)
loc_1675E:
		lea     ($FFFFB000).w, A1
		lea     $002C(A0), A4
		bsr.s   loc_16770
		lea     ($FFFFB040).w, A1
		lea     $0036(A0), A4
loc_16770:
		moveq   #$00, D0
		move.b  (A4), D0
		move.w  loc_1677C(PC, D0), D0
		jmp     loc_1677C(PC, D0)
loc_1677C:
		dc.w    loc_16784-loc_1677C
		dc.w    loc_16898-loc_1677C
		dc.w    loc_1697C-loc_1677C
		dc.w    loc_169E8-loc_1677C
loc_16784:
		tst.w   (Debug_placement_mode).w
		bne.w    loc_16896
		move.w  $002A(A0), D2
		move.w  $0008(A1), D0
		sub.w   $0008(A0), D0
		cmp.w   D2, D0
		bcc.w    loc_16896
		move.w  $000C(A1), D1
		sub.w   $000C(A0), D1
		cmpi.w  #$0080, D1
		bcc.w    loc_16896
		moveq   #$00, D3
		cmpi.w  #$00A0, D2
		beq.s   loc_167C6
		moveq   #$08, D3
		cmpi.w  #$0120, D2
		beq.s   loc_167C6
		moveq   #$04, D3
		neg.w   D0
		addi.w  #$0100, D0
loc_167C6:
		cmpi.w  #$0080, D0
		bcs.s   loc_167FC
		moveq   #$00, D2
		move.b  $0028(A0), D0
		lsr.w   #$02, D0
		andi.w  #$000F, D0
		move.b  loc_167EC(PC, D0), D2
		cmpi.b  #$02, D2
loc_167E0:
		bne.s   loc_16806
		move.b  (Timer_frames).w, D2
		andi.b  #$01, D2
		bra.s   loc_16806
loc_167EC:
		dc.b    $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $02, $00, $01, $02, $01
loc_167FC:
		moveq   #$02, D2
		cmpi.w  #$0040, D1
		bcc.s   loc_16806
		moveq   #$03, D2
loc_16806:
		move.b  D2, $0001(A4)
		add.w   D3, D2
		add.w   D2, D2
		andi.w  #$001E, D2
		lea     loc_16AFE(PC), A2
		adda.w  $00(A2, D2), A2
		move.w  (A2)+, $0004(A4)
		subq.w  #$04, $0004(A4)
		move.w  (A2)+, D4
		add.w   $0008(A0), D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		add.w   $000C(A0), D5
		move.w  D5, $000C(A1)
		move.l  A2, $0006(A4)
		move.w  (A2)+, D4
		add.w   $0008(A0), D4
loc_16840:
		move.w  (A2)+, D5
		add.w   $000C(A0), D5
		addq.b  #$02, (A4)
		move.b  #$81, $002A(A1)
		move.b  #$02, $001C(A1)
		move.w  #$0800, $0014(A1)
		move.w  #$0000, $0010(A1)
loc_16860:
		move.w  #$0000, $0012(A1)
		bclr    #$05, $0022(A0)
		bclr    #$05, $0022(A1)
		bset    #$01, $0022(A1)
		move.b  #$00, $003C(A1)
		bclr    #$07, $0002(A1)
		move.w  #$0800, D2
		bsr.w     loc_16A80
		move.w  #$00BE, D0
		jsr     (PlaySound).l             ; loc_14C6
loc_16896:
		rts
loc_16898:
		subq.b  #$01, $0002(A4)
		bpl.s   loc_168DC
		move.l  $0006(A4), A2
		move.w  (A2)+, D4
		add.w   $0008(A0), D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		add.w   $000C(A0), D5
		move.w  D5, $000C(A1)
		tst.b   $0001(A4)
		bpl.s   loc_168BE
		subq.w  #$08, A2
loc_168BE:
		move.l  A2, $0006(A4)
		subq.w  #$04, $0004(A4)
		beq.s   loc_16902
		move.w  (A2)+, D4
		add.w   $0008(A0), D4
		move.w  (A2)+, D5
		add.w   $000C(A0), D5
		move.w  #$0800, D2
		bra.w     loc_16A80
loc_168DC:
		move.l  $0008(A1), D2
		move.l  $000C(A1), D3
		move.w  $0010(A1), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  $0012(A1), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, $0008(A1)
		move.l  D3, $000C(A1)
		rts
loc_16902:
		cmpi.b  #$04, $0001(A4)
		bcc.s   loc_16924
		move.b  $0028(A0), D0
		andi.w  #$00FC, D0
		add.b   $0001(A4), D0
		move.b  #$04, $0001(A4)
		move.b  loc_1693C(PC, D0), D0
		bne.w    loc_16A10
loc_16924:
		andi.w  #$07FF, $000C(A1)
		move.b  #$06, (A4)
		clr.b   $002A(A1)
		move.w  #$00BC, D0
		jmp     (PlaySound).l             ; loc_14C6
loc_1693C:
		dc.b    $02, $01, $00, $00, $FF, $03, $00, $00, $04, $FE, $00, $00, $FD, $FC, $00, $00
		dc.b    $FB, $FB, $00, $00, $07, $06, $00, $00, $F9, $FA, $00, $00, $08, $09, $00, $00
		dc.b    $F8, $F7, $00, $00, $0B, $0A, $00, $00, $0C, $00, $00, $00, $F5, $F6, $00, $00
		dc.b    $F4, $00, $00, $00, $00, $0D, $00, $00, $F3, $0E, $00, $00, $00, $F2, $00, $00
loc_1697C:
		subq.b  #$01, $0002(A4)
		bpl.s   loc_169B0
		move.l  $0006(A4), A2
		move.w  (A2)+, D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		move.w  D5, $000C(A1)
		tst.b   $0001(A4)
		bpl.s   loc_1699A
		subq.w  #$08, A2
loc_1699A:
		move.l  A2, $0006(A4)
		subq.w  #$04, $0004(A4)
		beq.s   loc_169D6
		move.w  (A2)+, D4
		move.w  (A2)+, D5
		move.w  #$0800, D2
		bra.w     loc_16A80
loc_169B0:
		move.l  $0008(A1), D2
		move.l  $000C(A1), D3
		move.w  $0010(A1), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  $0012(A1), D0
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, $0008(A1)
		move.l  D3, $000C(A1)
		rts
loc_169D6:
		andi.w  #$07FF, $000C(A1)
		clr.b   (A4)
		move.w  #$00BC, D0
		jmp     (PlaySound).l             ; loc_14C6
loc_169E8:
		move.w  $002A(A0), D2
		move.w  $0008(A1), D0
		sub.w   $0008(A0), D0
		cmp.w   D2, D0
		bcc.w    loc_16A0C
		move.w  $000C(A1), D1
		sub.w   $000C(A0), D1
		cmpi.w  #$0080, D1
		bcc.w    loc_16A0C
		rts
loc_16A0C:
		clr.b   (A4)
		rts
loc_16A10:
		bpl.s   loc_16A42
		neg.b   D0
		move.b  #$FC, $0001(A4)
		add.w   D0, D0
		lea     (loc_17006).l, A2
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, D0
		subq.w  #$04, D0
		move.w  D0, $0004(A4)
		lea     $00(A2, D0), A2
		move.w  (A2)+, D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		move.w  D5, $000C(A1)
		subq.w  #$08, A2
		bra.s   loc_16A62
loc_16A42:
		add.w   D0, D0
		lea     (loc_17006).l, A2
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, $0004(A4)
		subq.w  #$04, $0004(A4)
		move.w  (A2)+, D4
		move.w  D4, $0008(A1)
		move.w  (A2)+, D5
		move.w  D5, $000C(A1)
loc_16A62:
		move.l  A2, $0006(A4)
		move.w  (A2)+, D4
		move.w  (A2)+, D5
		move.w  #$0800, D2
		bsr.w     loc_16A80
		move.w  #$00BE, D0
		jsr     (PlaySound).l             ; loc_14C6
		addq.b  #$02, (A4)
		rts
loc_16A80:
		moveq   #$00, D0
		move.w  D2, D3
		move.w  D4, D0
		sub.w   $0008(A1), D0
		bge.s   loc_16A90
		neg.w   D0
		neg.w   D2
loc_16A90:
		moveq   #$00, D1
		move.w  D5, D1
		sub.w   $000C(A1), D1
		bge.s   loc_16A9E
		neg.w   D1
		neg.w   D3
loc_16A9E:
		cmp.w   D0, D1
		bcs.s   loc_16AD0
		moveq   #$00, D1
		move.w  D5, D1
		sub.w   $000C(A1), D1
		swap  D1
		divs.w  D3, D1
		moveq   #$00, D0
		move.w  D4, D0
		sub.w   $0008(A1), D0
		beq.s   loc_16ABC
		swap  D0
		divs.w  D1, D0
loc_16ABC:
		move.w  D0, $0010(A1)
		move.w  D3, $0012(A1)
		tst.w   D1
		bpl.s   loc_16ACA
		neg.w   D1
loc_16ACA:
		move.w  D1, $0002(A4)
		rts
loc_16AD0:
		moveq   #$00, D0
		move.w  D4, D0
		sub.w   $0008(A1), D0
		swap  D0
		divs.w  D2, D0
		moveq   #$00, D1
		move.w  D5, D1
		sub.w   $000C(A1), D1
		beq.s   loc_16AEA
		swap  D1
		divs.w  D0, D1
loc_16AEA:
		move.w  D1, $0012(A1)
		move.w  D2, $0010(A1)
		tst.w   D0
		bpl.s   loc_16AF8
		neg.w   D0
loc_16AF8:
		move.w  D0, $0002(A4)
		rts
loc_16AFE:              
		dc.w    loc_16B16-loc_16AFE
		dc.w    loc_16B8C-loc_16AFE
		dc.w    loc_16BEA-loc_16AFE
		dc.w    loc_16C60-loc_16AFE
		dc.w    loc_16CBE-loc_16AFE
		dc.w    lc_16D30-loc_16AFE
		dc.w    loc_16D8E-loc_16AFE
		dc.w    loc_16E00-loc_16AFE
		dc.w    loc_16E5E-loc_16AFE
		dc.w    loc_16ED4-loc_16AFE
		dc.w    loc_16F32-loc_16AFE
		dc.w    loc_16FA8-loc_16AFE
loc_16B16:
		dc.w    $0074
		dc.w    $0090, $0010, $0090, $0070, $0040, $0070, $0035, $006F
		dc.w    $0028, $006A, $001E, $0062, $0015, $0058, $0011, $004A
		dc.w    $0010, $0040, $0011, $0035, $0015, $0027, $001E, $001E
		dc.w    $0028, $0015, $0035, $0011, $0040, $0010, $0050, $0010
		dc.w    $005E, $0012, $0068, $0018, $006D, $0024, $0070, $0030
		dc.w    $006D, $003D, $0068, $0048, $005E, $004E, $0050, $0050
		dc.w    $0030, $0050, $0022, $0052, $0017, $005A, $0011, $0063
		dc.w    $0010, $0070 
loc_16B8C:
		dc.w    $005C
		dc.w    $0090, $0010, $0090, $0070, $0040, $0070, $002E, $006E
		dc.w    $001D, $0062, $0013, $0053, $0010, $0040, $0013, $002D
		dc.w    $001D, $001E, $002E, $0013, $0040, $0010, $0058, $0010
		dc.w    $0064, $0014, $006C, $001A, $0070, $0028, $006C, $0036
		dc.w    $0064, $003C, $0058, $0040, $004B, $003D, $0040, $0038
		dc.w    $0036, $0032, $0028, $0030, $0010, $0030
loc_16BEA:
		dc.w    $0074
		dc.w    $0010, $0070, $0011, $0063, $0017, $005A, $0022, $0052
		dc.w    $0030, $0050, $0050, $0050, $005E, $004E, $0068, $0048
		dc.w    $006D, $003D, $0070, $0030, $006D, $0024, $0068, $0018
		dc.w    $005E, $0012, $0050, $0010, $0040, $0010, $0035, $0011
		dc.w    $0028, $0015, $001E, $001E, $0015, $0027, $0011, $0035
		dc.w    $0010, $0040, $0011, $004A, $0015, $0058, $001E, $0062
		dc.w    $0028, $006A, $0035, $006F, $0040, $0070, $0090, $0070
		dc.w    $0090, $0010
loc_16C60:
		dc.w    $005C
		dc.w    $0010, $0030, $0028, $0030, $0036, $0032, $0040, $0038
		dc.w    $004B, $003D, $0058, $0040, $0064, $003C, $006C, $0036
		dc.w    $0070, $0028, $006C, $001A, $0064, $0014, $0058, $0010
		dc.w    $0040, $0010, $002E, $0013, $001D, $001E, $0013, $002D
		dc.w    $0010, $0040, $0013, $0053, $001D, $0062, $002E, $006E
		dc.w    $0040, $0070, $0090, $0070, $0090, $0010
loc_16CBE:
		dc.w    $0070
		dc.w    $0010, $0010, $0010, $0070, $00C0, $0070, $00CA, $006F
		dc.w    $00D4, $006C, $00DB, $0068, $00E3, $0062, $00E8, $005A
		dc.w    $00ED, $0052, $00EF, $0048, $00F0, $0040, $00EF, $0036
		dc.w    $00ED, $002E, $00E8, $0026, $00E3, $001E, $00DB, $0017
		dc.w    $00D4, $0014, $00CA, $0012, $00C0, $0010, $00B7, $0011
		dc.w    $00AF, $0012, $00A6, $0017, $009E, $001E, $0097, $0026
		dc.w    $0093, $002E, $0091, $0036, $0090, $0040, $0090, $0070		  
lc_16D30:
		dc.w    $005C
		dc.w    $0010, $0010, $0010, $0070, $00C0, $0070, $00D2, $006E
		dc.w    $00E3, $0062, $00ED, $0053, $00F0, $0040, $00ED, $002D
		dc.w    $00E3, $001E, $00D2, $0013, $00C0, $0010, $00A8, $0010
		dc.w    $009C, $0014, $0094, $001A, $0090, $0028, $0094, $0036
		dc.w    $009C, $003C, $00A8, $0040, $00B5, $003D, $00C0, $0038
		dc.w    $00CA, $0032, $00D8, $0030, $00F0, $0030
loc_16D8E:
		dc.w    $0070
		dc.w    $0090, $0070, $0090, $0040, $0091, $0036, $0093, $002E
		dc.w    $0097, $0026, $009E, $001E, $00A6, $0017, $00AF, $0012
		dc.w    $00B7, $0011, $00C0, $0010, $00CA, $0012, $00D4, $0014
		dc.w    $00DB, $0017, $00E3, $001E, $00E8, $0026, $00ED, $002E
		dc.w    $00EF, $0036, $00F0, $0040, $00EF, $0048, $00ED, $0052
		dc.w    $00E8, $005A, $00E3, $0062, $00DB, $0068, $00D4, $006C
		dc.w    $00CA, $006F, $00C0, $0070, $0010, $0070, $0010, $0010		
loc_16E00:
		dc.w    $005C
		dc.w    $00F0, $0030, $00D8, $0030, $00CA, $0032, $00C0, $0038
		dc.w    $00B5, $003D, $00A8, $0040, $009C, $003C, $0094, $0036
		dc.w    $0090, $0028, $0094, $001A, $009C, $0014, $00A8, $0010
		dc.w    $00C0, $0010, $00D2, $0013, $00E3, $001E, $00ED, $002D
		dc.w    $00F0, $0040, $00ED, $0053, $00E3, $0062, $00D2, $006E
		dc.w    $00C0, $0070, $0010, $0070, $0010, $0010
loc_16E5E:
		dc.w    $0074
		dc.w    $0110, $0010, $0110, $0070, $0040, $0070, $0035, $006F
		dc.w    $0028, $006A, $001E, $0062, $0015, $0058, $0011, $004A
		dc.w    $0010, $0040, $0011, $0035, $0015, $0027, $001E, $001E
		dc.w    $0028, $0015, $0035, $0011, $0040, $0010, $0050, $0010
		dc.w    $005E, $0012, $0068, $0018, $006D, $0024, $0070, $0030
		dc.w    $006D, $003D, $0068, $0048, $005E, $004E, $0050, $0050
		dc.w    $0030, $0050, $0022, $0052, $0017, $005A, $0011, $0063
		dc.w    $0010, $0070
loc_16ED4:
		dc.w    $005C
		dc.w    $0110, $0010, $0110, $0070, $0040, $0070, $002E, $006E
		dc.w    $001D, $0062, $0013, $0053, $0010, $0040, $0013, $002D
		dc.w    $001D, $001E, $002E, $0013, $0040, $0010, $0058, $0010
		dc.w    $0064, $0014, $006C, $001A, $0070, $0028, $006C, $0036
		dc.w    $0064, $003C, $0058, $0040, $004B, $003D, $0040, $0038
		dc.w    $0036, $0032, $0028, $0030, $0010, $0030
loc_16F32:
		dc.w    $0074
		dc.w    $0010, $0070, $0011, $0063, $0017, $005A, $0022, $0052
		dc.w    $0030, $0050, $0050, $0050, $005E, $004E, $0068, $0048
		dc.w    $006D, $003D, $0070, $0030, $006D, $0024, $0068, $0018
		dc.w    $005E, $0012, $0050, $0010, $0040, $0010, $0035, $0011
		dc.w    $0028, $0015, $001E, $001E, $0015, $0027, $0011, $0035
		dc.w    $0010, $0040, $0011, $004A, $0015, $0058, $001E, $0062
		dc.w    $0028, $006A, $0035, $006F, $0040, $0070, $0110, $0070
		dc.w    $0110, $0010
loc_16FA8:
		dc.w    $005C
		dc.w    $0010, $0030, $0028, $0030, $0036, $0032, $0040, $0038
		dc.w    $004B, $003D, $0058, $0040, $0064, $003C, $006C, $0036
		dc.w    $0070, $0028, $006C, $001A, $0064, $0014, $0058, $0010
		dc.w    $0040, $0010, $002E, $0013, $001D, $001E, $0013, $002D
		dc.w    $0010, $0040, $0013, $0053, $001D, $0062, $002E, $006E
		dc.w    $0040, $0070, $0110, $0070, $0110, $0010
loc_17006:
		dc.w    loc_17024-loc_17006
		dc.w    loc_17024-loc_17006
		dc.w    loc_1703A-loc_17006
		dc.w    loc_17064-loc_17006
		dc.w    loc_1707A-loc_17006
		dc.w    loc_17090-loc_17006
		dc.w    loc_170A6-loc_17006
		dc.w    loc_170B8-loc_17006
		dc.w    loc_170D2-loc_17006
		dc.w    loc_170EC-loc_17006
		dc.w    loc_170FE-loc_17006
		dc.w    loc_17110-loc_17006
		dc.w    loc_1712A-loc_17006
		dc.w    loc_17140-loc_17006
		dc.w    loc_1714E-loc_17006
loc_17024:
		dc.w    $0014
		dc.w    $0790, $03B0, $0710, $03B0, $0710, $06B0, $0A90, $06B0
		dc.w    $0A90, $0670
loc_1703A:
		dc.w    $0028
		dc.w    $0790, $03F0, $0790, $04B0, $0A00, $04B0, $0C10, $04B0
		dc.w    $0C10, $0330, $0D90, $0330, $0D90, $01B0, $0F10, $01B0
		dc.w    $0F10, $02B0, $0F90, $02B0
loc_17064:
		dc.w    $0014
		dc.w    $0AF0, $0630, $0E90, $0630, $0E90, $06B0, $0F90, $06B0
		dc.w    $0F90, $0670
loc_1707A:
		dc.w    $0014
		dc.w    $0F90, $02F0, $0F90, $04B0, $0F10, $04B0, $0F10, $0630
		dc.w    $0F90, $0630
loc_17090:
		dc.w    $0014
		dc.w    $1410, $0530, $1190, $0530, $1190, $06B0, $1410, $06B0
		dc.w    $1410, $0570
loc_170A6:
		dc.w    $0010
		dc.w    $1AF0, $0530, $1B90, $0530, $1B90, $0330, $1E10, $0330
loc_170B8:
		dc.w    $0018
		dc.w    $1A90, $0570, $1A90, $05B0, $1C10, $05B0, $1C10, $0430
		dc.w    $1E10, $0430, $1E10, $0370
loc_170D2:
		dc.w    $0018
		dc.w    $2490, $0370, $2490, $03D0, $2390, $03D0, $2390, $05D0
		dc.w    $2510, $05D0, $2510, $0570
loc_170EC:
		dc.w    $0010
		dc.w    $24F0, $0330, $2590, $0330, $2590, $0530, $2570, $0530
loc_170FE:
		dc.w    $0010
		dc.w    $0310, $0330, $0290, $0330, $0290, $0230, $0490, $0230
loc_17110:
		dc.w    $0018
		dc.w    $0310, $0370, $0310, $03B0, $0410, $03B0, $0410, $02B0
		dc.w    $0490, $02B0, $0490, $0270
loc_1712A:
		dc.w    $0014
		dc.w    $0490, $06F0, $0490, $0730, $0690, $0730, $0890, $0730
		dc.w    $0890, $06F0
loc_17140:
		dc.w    $000C
		dc.w    $0BF0, $0330, $0D90, $0330, $0D90, $02F0
loc_1714E:
		dc.w    $001C
		dc.w    $0D90, $02B0, $0C90, $02B0, $0C90, $00B0, $0E80, $00B0
		dc.w    $1110, $00B0, $1110, $0230, $10F0, $0230 
;=============================================================================== 
; Object 0x1E - Chemical Plant - Tube Attributes
; [ End ]		         
;===============================================================================		   
loc_1716C:
		jmp     (loc_D30C) 
		dc.w    $0           ; Filler  
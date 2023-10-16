;=============================================================================== 
; Object 0x07 - 
; [ Begin ]		         
;===============================================================================  
;Obj_0x07: ; loc_180D0:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_180DE(PC, D0), D1
		jmp     loc_180DE(PC, D1)
loc_180DE:		
		dc.w    loc_180E2-loc_180DE
		dc.w    loc_18104-loc_180DE   
loc_180E2:
		addq.b  #$02, $0024(A0)
		move.w  #$0758, $000C(A0)
		move.b  #$20, $0019(A0)
		move.w  $000C(A0), $0030(A0)
		move.b  #$30, $0038(A0)
		bset    #$07, $0022(A0)
loc_18104:
		lea     ($FFFFB000).w, A1
		moveq   #$08, D1
		move.b  $0022(A0), D0
		and.b   D1, D0
		bne.s   loc_18120
		cmpi.b  #$30, $0038(A0)
		beq.s   loc_1812A
		addq.b  #$01, $0038(A0)
		bra.s   loc_1812A
loc_18120:
		tst.b   $0038(A0)
		beq.s   loc_1817E
		subq.b  #$01, $0038(A0)
loc_1812A:
		moveq   #$20, D1
		moveq   #$00, D3
		move.b  $0038(A0), D3
		moveq   #$03, D6
		move.w  $0008(A1), D4
		move.w  D4, $0008(A0)
		bsr.w     loc_1819A
		lea     ($FFFFB040).w, A1
		moveq   #$10, D1
		move.b  $0022(A0), D0
		and.b   D1, D0
		bne.s   loc_1815C
		cmpi.b  #$30, $003A(A0)
		beq.s   loc_18166
		addq.b  #$01, $003A(A0)
		bra.s   loc_18166
loc_1815C:
		tst.b   $003A(A0)
		beq.s   loc_1817E
		subq.b  #$01, $003A(A0)
loc_18166:
		moveq   #$20, D1
		moveq   #$00, D3
		move.b  $003A(A0), D3
		moveq   #$04, D6
		move.w  $0008(A1), D4
		move.w  D4, $0008(A0)
		bsr.w     loc_1819A
		rts
loc_1817E:
		not.b  D1
		and.b   D1, $0022(A0)
		move.l  A0, -(A7)
		move.l  A0, A2
		move.l  A1, A0
		bsr.w     J_KillSonic_01          ; loc_18194
		move.l  (A7)+, A0
		rts
;=============================================================================== 
; Object 0x07 - 
; [ End ]		         
;===============================================================================		  
		nop		             ; Filler            
J_KillSonic_01: ; loc_18194:
		jmp     KillSonic               ; (loc_21422)
loc_1819A:
		jmp     (loc_F99A)
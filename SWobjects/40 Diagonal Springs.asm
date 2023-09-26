;=============================================================================== 
; Object 0x40 - Chemical Plant / Neo Green Hill - Springs 
; [ Begin ]		         
;===============================================================================  
;Obj_0x40_Diagonal_Springs: ; loc_1A30C:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1A31E(PC, D0), D1
		jsr     loc_1A31E(PC, D1)
		bra.w     J_MarkObjGone_0C        ; loc_1A5B4
loc_1A31E:
		dc.w    loc_1A328-loc_1A31E
		dc.w    loc_1A364-loc_1A31E
loc_1A322:
		dc.w    $FC00, $F600, $F800
loc_1A328:
		addq.b  #$02, $0024(A0)
		move.l  #Obj40_MapUnc_1A58A, $0004(A0) ; loc_1A58A
		move.w  #$0440, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_0E ; loc_1A5C0
		ori.b   #$04, $0001(A0)
		move.b  #$1C, $0019(A0)
		move.b  #$04, $0018(A0)
		bset    #$07, $0022(A0)
		move.b  $0028(A0), D0
		andi.w  #$0002, D0
		move.w  loc_1A322(PC, D0), $0030(A0)
loc_1A364:
		lea     (loc_1A57E).l, A1
		bsr.w     J_AnimateSprite_02      ; loc_1A5BA
		move.w  #$0027, D1
		move.w  #$0008, D2
		move.w  $0008(A0), D4
		lea     loc_1A52E(PC), A2
		tst.b   $001A(A0)
		beq.s   loc_1A388
		lea     loc_1A556(PC), A2
loc_1A388:
		lea     ($FFFFB000).w, A1
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.w     loc_1A5C6
		btst    #$03, $0022(A0)
		beq.s   loc_1A3A0
		bsr.s   loc_1A3BA
loc_1A3A0:
		movem.l (A7)+, D1-D4
		lea     ($FFFFB040).w, A1
		moveq   #$04, D6
		bsr.w     loc_1A5C6
		btst    #$04, $0022(A0)
		beq.s   loc_1A3B8
		bsr.s   loc_1A3BA
loc_1A3B8:
		rts
loc_1A3BA:
		btst    #$00, $0022(A0)
		bne.s   loc_1A3D2
		move.w  $0008(A0), D0
		subi.w  #$0010, D0
		cmp.w   $0008(A1), D0
		bcs.s   loc_1A3E2
		rts
loc_1A3D2:
		move.w  $0008(A0), D0
		addi.w  #$0010, D0
		cmp.w   $0008(A1), D0
		bcc.s   loc_1A3E2
		rts
loc_1A3E2:
		cmpi.b  #$01, $001C(A0)
		beq.s   loc_1A3F2
		move.w  #$0100, $001C(A0)
		rts
loc_1A3F2:
		tst.b   $001A(A0)
		beq.s   loc_1A3FA
		rts
loc_1A3FA:
		move.w  $0008(A0), D0
		subi.w  #$001C, D0
		sub.w   $0008(A1), D0
		neg.w   D0
		btst    #$00, $0022(A0)
		beq.s   loc_1A416
		not.w  D0
		addi.w  #$0027, D0
loc_1A416:
		tst.w   D0
		bpl.s   lc_1A41C
		moveq   #$00, D0
lc_1A41C:
		lea     (loc_1A4E6).l, A3
		move.b  $00(A3, D0), D0
		move.w  #$FC00, $0012(A1)
		sub.b   D0, $0012(A1)
		bset    #$00, $0022(A1)
		btst    #$00, $0022(A0)
		bne.s   loc_1A446
		bclr    #$00, $0022(A1)
		neg.b   D0
loc_1A446:
		move.w  $0010(A1), D1
		bpl.s   loc_1A44E
		neg.w   D1
loc_1A44E:
		cmpi.w  #$0400, D1
		bcs.s   loc_1A458
		sub.b   D0, $0010(A1)
loc_1A458:
		bset    #$01, $0022(A1)
		bclr    #$03, $0022(A1)
		move.b  #$10, $001C(A1)
		move.b  #$02, $0024(A1)
		move.b  $0028(A0), D0
		btst    #$00, D0
		beq.s   loc_1A4B4
		move.w  #$0001, $0014(A1)
		move.b  #$01, $0027(A1)
		move.b  #$00, $001C(A1)
		move.b  #$01, $002C(A1)
		move.b  #$08, $002D(A1)
		btst    #$01, D0
		bne.s   lc_1A4A4
		move.b  #$03, $002C(A1)
lc_1A4A4:
		btst    #$00, $0022(A1)
		beq.s   loc_1A4B4
		neg.b   $0027(A1)
		neg.w   $0014(A1)
loc_1A4B4:
		andi.b  #$0C, D0
		cmpi.b  #$04, D0
		bne.s   loc_1A4CA
		move.b  #$0C, $003E(A1)
		move.b  #$0D, $003F(A1)
loc_1A4CA:
		cmpi.b  #$08, D0
		bne.s   lc_1A4DC
		move.b  #$0E, $003E(A1)
		move.b  #$0F, $003F(A1)
lc_1A4DC:
		move.w  #$00CC, D0
		jmp     (PlaySound).l             ; loc_14C6   
loc_1A4E6:
		dc.b    $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
		dc.b    $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01
		dc.b    $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02
		dc.b    $03, $03, $03, $03, $03, $03, $04, $04, $00, $00, $00, $00, $00, $00, $00, $00
		dc.b    $00, $00, $00, $00, $00, $00, $00, $00   
loc_1A52E:
		dc.b    $08, $08, $08, $08, $08, $08, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $10
		dc.b    $11, $12, $13, $14, $14, $15, $15, $16, $17, $18, $18, $18, $18, $18, $18, $18
		dc.b    $18, $18, $18, $18, $18, $18, $18, $18      
loc_1A556:
		dc.b    $08, $08, $08, $08, $08, $08, $08, $09, $0A, $0B, $0C, $0C, $0C, $0C, $0D, $0D
		dc.b    $0D, $0D, $0D, $0D, $0E, $0E, $0F, $0F, $10, $10, $10, $10, $0F, $0F, $0E, $0E
		dc.b    $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D		
loc_1A57E:
		dc.w    loc_1A582-loc_1A57E
		dc.w    loc_1A585-loc_1A57E
loc_1A582:
		dc.b    $0F, $00, $FF
loc_1A585:
		dc.b    $03, $01, $00, $FD, $00 
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj40_MapUnc_1A58A:	incbin	"mappings/sprite/obj40.bin"
; ===========================================================================
		nop

J_MarkObjGone_0C: ; loc_1A5B4:
		jmp     MarkObjGone             ; (loc_D2A0)
J_AnimateSprite_02: ; loc_1A5BA:
		jmp     AnimateSprite           ; (loc_D412)
J_Adjust2PArtPointer_0E: ; loc_1A5C0:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
loc_1A5C6:
		jmp     (loc_F562)
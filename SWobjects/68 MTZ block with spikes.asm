;=============================================================================== 
; Object 0x68 - Metropolis - Block with Arrow
; [ Begin ]		         
;===============================================================================		    
;Obj_0x68_Block_Arrow: ; loc_1B520:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1B52E(PC, D0), D1
		jmp     loc_1B52E(PC, D1)
loc_1B52E:
		dc.w    loc_1B534-loc_1B52E
		dc.w    loc_1B5D6-loc_1B52E
		dc.w    loc_1B5EE-loc_1B52E
loc_1B534:
		addq.b  #$02, $0024(A0)
		move.l  #Obj68_MapUnc_1B6DC, $0004(A0) ; loc_1B6DC
		move.w  #$6414, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_13 ; loc_1B7FC
		move.b  #$04, $0001(A0)
		move.b  #$10, $0019(A0)
		move.b  #$04, $0018(A0)
		bsr.w     J_SingleObjLoad2_05  ; loc_1B7F6
		bne.s   loc_1B5D0
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		addq.b  #$04, $0024(A1)
		move.w  $0008(A0), $0008(A1)
		move.w  $000C(A0), $000C(A1)
		move.w  $0008(A1), $0030(A1)
		move.w  $000C(A1), $0032(A1)
		move.l  $0004(A0), $0004(A1)
		move.w  #$241C, $0002(A1)
		ori.b   #$04, $0001(A1)
		move.b  #$10, $0019(A1)
		move.b  #$04, $0018(A1)
		move.w  (Timer_frames).w, D0
		lsr.w   #$06, D0
		move.w  D0, D1
		andi.w  #$0001, D0
		move.w  D0, $0036(A1)
		lsr.w   #$01, D1
		add.b   $0028(A0), D1
		andi.w  #$0003, D1
		move.b  D1, $0025(A1)
		move.b  D1, $001A(A1)
		lea     (loc_1B6D8).l, A2
		move.b  $00(A2, D1), $0020(A1)
loc_1B5D0:
		move.b  #$04, $001A(A0)
loc_1B5D6:
		move.w  #$001B, D1
		move.w  #$0010, D2
		move.w  #$0011, D3
		move.w  $0008(A0), D4
		bsr.w     J_SolidObject_08        ; loc_1B802
		bra.w     J_MarkObjGone_0F        ; loc_1B7F0
loc_1B5EE:
		bsr.w     lc_1B656
		moveq   #$00, D0
		move.b  $0025(A0), D0
		add.w   D0, D0
		move.w  loc_1B60A(PC, D0), D1
		jsr     loc_1B60A(PC, D1)
		move.w  $0030(A0), D0
		bra.w     loc_1B808
loc_1B60A:
		dc.w    loc_1B612-loc_1B60A
		dc.w    loc_1B624-loc_1B60A
		dc.w    loc_1B634-loc_1B60A
		dc.w    lc_1B644-loc_1B60A
loc_1B612:
		moveq   #$00, D0
		move.b  $0034(A0), D0
		neg.w   D0
		add.w   $0032(A0), D0
		move.w  D0, $000C(A0)
		rts
loc_1B624:
		moveq   #$00, D0
		move.b  $0034(A0), D0
		add.w   $0030(A0), D0
		move.w  D0, $0008(A0)
		rts
loc_1B634:
		moveq   #$00, D0
		move.b  $0034(A0), D0
		add.w   $0032(A0), D0
		move.w  D0, $000C(A0)
		rts
lc_1B644:
		moveq   #$00, D0
		move.b  $0034(A0), D0
		neg.w   D0
		add.w   $0030(A0), D0
		move.w  D0, $0008(A0)
		rts
lc_1B656:
		tst.w   $0038(A0)
		beq.s   loc_1B67A
		move.b  (Timer_frames+1).w, D0
		andi.b  #$3F, D0
		bne.s   loc_1B6D6
		clr.w   $0038(A0)
		tst.b   $0001(A0)
		bpl.s   loc_1B67A
		move.w  #$00B6, D0
		jsr     (PlaySound).l             ; loc_14C6
loc_1B67A:
		tst.w   $0036(A0)
		beq.s   loc_1B6B6
		subi.w  #$0800, $0034(A0)
		bcc.s   loc_1B6D6
		move.w  #$0000, $0034(A0)
		move.w  #$0000, $0036(A0)
		move.w  #$0001, $0038(A0)
		addq.b  #$01, $0025(A0)
		andi.b  #$03, $0025(A0)
		moveq   #$00, D0
		move.b  $0025(A0), D0
		move.b  D0, $001A(A0)
		move.b  loc_1B6D8(PC, D0), $0020(A0)
		rts
loc_1B6B6:
		addi.w  #$0800, $0034(A0)
		cmpi.w  #$2000, $0034(A0)
		bcs.s   loc_1B6D6
		move.w  #$2000, $0034(A0)
		move.w  #$0001, $0036(A0)
		move.w  #$0001, $0038(A0)
loc_1B6D6:
		rts
loc_1B6D8:
		dc.b    $84, $A6, $84, $A6  
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj68_MapUnc_1B6DC:	incbin	"mappings/sprite/obj68.bin"
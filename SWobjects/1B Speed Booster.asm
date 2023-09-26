;=============================================================================== 
; Object 0x1B - Chemical Plant - Speed Booster
; [ Begin ]		         
;===============================================================================		  
;Obj_0x1B_Speed_Booster: ; loc_16468:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_16476(PC, D0), D1
		jmp     loc_16476(PC, D1)
loc_16476:
		dc.w    loc_1647E-loc_16476
		dc.w    loc_164B4-loc_16476		 
loc_1647A:
		dc.w    $1000, $0A00
loc_1647E:
		addq.b  #$02, $0024(A0)
		move.l  #Obj1B_MapUnc_1658A, $0004(A0) ; loc_1658A
		move.w  #$E39C, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_03 ; loc_165AA
		ori.b   #$04, $0001(A0)
		move.b  #$20, $0019(A0)
		move.b  #$01, $0018(A0)
		move.b  $0028(A0), D0
		andi.w  #$0002, D0
		move.w  loc_1647A(PC, D0), $0030(A0)
loc_164B4:
		move.b  (Timer_frames+1).w, D0
		andi.b  #$02, D0
		move.b  D0, $001A(A0)
		move.w  $0008(A0), D0
		move.w  D0, D1
		subi.w  #$0010, D0
		addi.w  #$0010, D1
		move.w  $000C(A0), D2
		move.w  D2, D3
		subi.w  #$0010, D2
		addi.w  #$0010, D3
		lea     ($FFFFB000).w, A1
		btst    #$01, $0022(A1)
		bne.s   loc_16510
		move.w  $0008(A1), D4
		cmp.w   D0, D4
		bcs.w    loc_16510
		cmp.w   D1, D4
		bcc.w    loc_16510
		move.w  $000C(A1), D4
		cmp.w   D2, D4
		bcs.w    loc_16510
		cmp.w   D3, D4
		bcc.w    loc_16510
		move.w  D0, -(A7)
		bsr.w     loc_16544
		move.w  (A7)+, D0
loc_16510:
		lea     ($FFFFB040).w, A1
		btst    #$01, $0022(A1)
		bne.s   loc_16540
		move.w  $0008(A1), D4
		cmp.w   D0, D4
		bcs.w    loc_16540
		cmp.w   D1, D4
		bcc.w    loc_16540
		move.w  $000C(A1), D4
		cmp.w   D2, D4
		bcs.w    loc_16540
		cmp.w   D3, D4
		bcc.w    loc_16540
		bsr.w     loc_16544
loc_16540:
		bra.w     J_MarkObjGone_01        ; loc_165A4
loc_16544:
		move.w  $0030(A0), $0010(A1)
		bclr    #$00, $0022(A1)
		btst    #$00, $0022(A0)
		beq.s   loc_16562
		bset    #$00, $0022(A1)
		neg.w   $0010(A1)
loc_16562:
		move.w  #$000F, $002E(A1)
		move.w  $0010(A1), $0014(A1)
		bclr    #$05, $0022(A0)
		bclr    #$06, $0022(A0)
		bclr    #$05, $0022(A1)
		move.w  #$00CC, D0
		jmp     (PlaySound).l             ; loc_14C6
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj1B_MapUnc_1658A:	incbin	"mappings/sprite/obj1B.bin"
; ===========================================================================
J_MarkObjGone_01: ; loc_165A4:
		jmp     MarkObjGone             ; (loc_D2A0)
J_Adjust2PArtPointer_03: ; loc_165AA:
		jmp     Adjust2PArtPointer     ; (loc_DC30)   
Timer_frames:	equ	$FFFFFE04; Or this minus one, idk for sure, so it might be $FFFFFE04
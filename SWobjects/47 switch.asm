;=============================================================================== 
; Object 0x47 - Switch - Oil Ocean / Dust Hill
; [ Begin ]		         
;===============================================================================		  
;Obj_0x47_Switch: ; loc_18D9C:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_18DAA(PC, D0), D1
		jmp     loc_18DAA(PC, D1)  
loc_18DAA:		  
		dc.w    loc_18DAE-loc_18DAA
		dc.w    loc_18DDA-loc_18DAA
loc_18DAE:
		addq.b  #$02, $0024(A0)
		move.l  #Obj47_MapUnc_18E3E, $0004(A0) ; loc_18E3E
		move.w  #$0424, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_09 ; loc_18E6A
		move.b  #$04, $0001(A0)
		move.b  #$10, $0019(A0)
		move.b  #$04, $0018(A0)
		addq.w  #$04, $000C(A0)
loc_18DDA:
		tst.b   $0001(A0)
		bpl.s   lc_18E3A
		move.w  #$001B, D1
		move.w  #$0004, D2
		move.w  #$0005, D3
		move.w  $0008(A0), D4
		bsr.w     J_SolidObject_03        ; loc_18E70
		move.b  #$00, $001A(A0)
		move.b  $0028(A0), D0
		andi.w  #$000F, D0
		lea     (ButtonVine_Trigger).w, A3
		lea     $00(A3, D0), A3
		moveq   #$00, D3
		btst    #$06, $0028(A0)
		beq.s   loc_18E16
		moveq   #$07, D3
loc_18E16:
		move.b  $0022(A0), D0
		andi.b  #$18, D0
		bne.s   loc_18E24
		bclr    D3, (A3)
		bra.s   lc_18E3A
loc_18E24:
		tst.b   (A3)
		bne.s   loc_18E32
		move.w  #$00CD, D0
		jsr     (PlaySound).l             ; loc_14C6
loc_18E32:
		bset    D3, (A3)
		move.b  #$01, $001A(A0)
lc_18E3A:
		bra.w     J_MarkObjGone_07        ; loc_18E64 
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj47_MapUnc_18E3E:	incbin	"mappings/sprite/obj47.bin"
; ===========================================================================
		nop

J_MarkObjGone_07: ; loc_18E64:
		jmp     MarkObjGone             ; (loc_D2A0)
J_Adjust2PArtPointer_09 ; loc_18E6A:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SolidObject_03: ; loc_18E70:
		jmp     SolidObject             ; (loc_F4A0)
ButtonVine_Trigger:		equ		$FFFFF7E0;F0;ds.b	$10
;=============================================================================== 
; Object 0x72 - Metropolis - Conveyor Belt Attributes
; [ Begin ]		         
;===============================================================================		   
;Obj_0x72_Conveyor_Belt_Attributes: ; loc_1CBCC:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1CBDA(PC, D0), D1
		jmp     loc_1CBDA(PC, D1)
loc_1CBDA:
		dc.w    loc_1CBDE-loc_1CBDA
		dc.w    loc_1CBFE-loc_1CBDA
loc_1CBDE:
		addq.b  #$02, $0024(A0)
		move.b  $0028(A0), D0
		lsl.b   #$04, D0
		move.b  D0, $0038(A0)
		move.w  #$0002, $0036(A0)
		btst    #$00, $0022(A0)
		beq.s   loc_1CBFE
		neg.w   $0036(A0)
loc_1CBFE:
		lea     ($FFFFB000).w, A1
		bsr.s   loc_1CC0E
		lea     ($FFFFB040).w, A1
		bsr.s   loc_1CC0E
		bra.w     loc_1CC4C
loc_1CC0E:
		moveq   #$00, D2
		move.b  $0038(A0), D2
		move.w  D2, D3
		add.w   D3, D3
		move.w  $0008(A1), D0
		sub.w   $0008(A0), D0
		add.w   D2, D0
		cmp.w   D3, D0
		bcc.s   loc_1CC48
		move.w  $000C(A1), D1
		sub.w   $000C(A0), D1
		addi.w  #$0030, D1
		cmpi.w  #$0030, D1
		bcc.s   loc_1CC48
		btst    #$01, $0022(A1)
		bne.s   loc_1CC48
		move.w  $0036(A0), D0
		add.w   D0, $0008(A1)
loc_1CC48:
		rts
		
;=============================================================================== 
; Object 0x72 - Metropolis - Conveyor Belt Attributes
; [ End ]		         
;===============================================================================             
		nop		             ; Filler
loc_1CC4C:
		jmp     (loc_D30C)     
;=============================================================================== 
; Object 0x6E - Metropolis - Machine
; [ Begin ]		         
;===============================================================================		   
;Obj_0x6E_Machine: ; loc_1C2E4:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1C2F2(PC, D0), D1
		jmp     loc_1C2F2(PC, D1)
loc_1C2F2:
		dc.w    loc_1C300-loc_1C2F2
		dc.w    loc_1C36A-loc_1C2F2
		dc.w    loc_1C3F4-loc_1C2F2
loc_1C2F8: 
		dc.b    $10, $0C, $28, $08, $60, $18, $0C, $0C
loc_1C300:
		addq.b  #$02, $0024(A0)
		move.l  #Obj6E_MapUnc_1C464, $0004(A0) ; loc_1C464
		move.w  #$6000, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_18 ; loc_1C4EC
loc_1C316:
		ori.b   #$04, $0001(A0)
		move.b  #$04, $0018(A0)
		moveq   #$00, D0
		move.b  $0028(A0), D0
		lsr.w   #$03, D0
		andi.w  #$000E, D0
		lea     loc_1C2F8(PC, D0), A3
		move.b  (A3)+, $0019(A0)
		move.b  (A3)+, $0016(A0)
		lsr.w   #$01, D0
		move.b  D0, $001A(A0)
		move.w  $0008(A0), $0034(A0)
		move.w  $000C(A0), $0030(A0)
		cmpi.b  #$03, D0
		bne.s   loc_1C36A
		addq.b  #$02, $0024(A0)
		move.w  #$63F0, $0002(A0)
		bsr.w     J_Adjust2PArtPointer_18 ; loc_1C4EC
		move.b  #$05, $0018(A0)
		bra.w     loc_1C3F4
loc_1C36A:
		move.w  $0008(A0), -(A7)
		move.b  (Oscllating_Data+$20).w, D1
		subi.b  #$38, D1
		ext.w   D1
		move.b  (Oscllating_Data+$24).w, D2
		subi.b  #$38, D2
		ext.w   D2
		btst    #$00, $0028(A0)
		beq.s   loc_1C38E
		neg.w   D1
		neg.w   D2
loc_1C38E:
		btst    #$01, $0028(A0)
		beq.s   loc_1C39A
		neg.w   D1
		exg.l   D1, D2
loc_1C39A:
		add.w   $0034(A0), D1
		move.w  D1, $0008(A0)
		add.w   $0030(A0), D2
		move.w  D2, $000C(A0)
		move.w  (A7)+, D4
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		moveq   #$00, D2
		move.b  $0016(A0), D2
		move.w  D2, D3
		addq.w  #$01, D3
		bsr.w     J_SolidObject_0C        ; loc_1C4F2
		move.w  $0034(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1C3DC
		jmp     DisplaySprite           ; (loc_D3C2)
loc_1C3DC:
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   J_DeleteObject_1B       ; loc_1C3EE
		bclr    #$07, $02(A2, D0)
J_DeleteObject_1B: ; loc_1C3EE:
		jmp     DeleteObject            ; (loc_D3B4)
loc_1C3F4:
		move.b  (Oscllating_Data+$20).w, D1
		lsr.b   #$01, D1
		subi.b  #$1C, D1
		ext.w   D1
		move.b  (Oscllating_Data+$24).w, D2
		lsr.b   #$01, D2
		subi.b  #$1C, D2
		ext.w   D2
		btst    #$00, $0028(A0)
		beq.s   loc_1C418
		neg.w   D1
		neg.w   D2
loc_1C418:
		btst    #$01, $0028(A0)
		beq.s   loc_1C424
		neg.w   D1
		exg.l   D1, D2
loc_1C424:
		add.w   $0034(A0), D1
		move.w  D1, $0008(A0)
		add.w   $0030(A0), D2
		move.w  D2, $000C(A0)
		move.w  $0034(A0), D0
		andi.w  #$FF80, D0
		sub.w   (Camera_X_pos_coarse).w, D0
		cmpi.w  #$0280, D0
		bhi.s   loc_1C44C
		jmp     DisplaySprite           ; (loc_D3C2)
loc_1C44C:
		lea     (Object_Respawn_Table).w, A2
		moveq   #$00, D0
		move.b  $0023(A0), D0
		beq.s   J_DeleteObject_1C       ; loc_1C45E
		bclr    #$07, $02(A2, D0)
J_DeleteObject_1C: ; loc_1C45E:
		jmp     DeleteObject            ; (loc_D3B4)   
; ---------------------------------------------------------------------------
; Sprite mappings
; ---------------------------------------------------------------------------
Obj6E_MapUnc_1C464:	incbin	"mappings/sprite/obj6E.bin"

;=============================================================================== 
; Object 0x6E - Metropolis - Machine
; [ End ]		         
;===============================================================================		   
J_Adjust2PArtPointer_18: ; loc_1C4EC:
		jmp     Adjust2PArtPointer     ; (loc_DC30)
J_SolidObject_0C: ; loc_1C4F2:
		jmp     SolidObject             ; (loc_F4A0)   
Oscllating_Data:	equ	$FFFFFE60;60
;=============================================================================== 
; Object 0x78 - Chemical Plant - Rotanting Platforms / Down when Touch Platform 
; [ Begin ]		         
;===============================================================================		  
;Obj_0x78_Rotating_Platforms: ; loc_1D3C0:
		moveq   #$00, D0
		move.b  $0024(A0), D0
		move.w  loc_1D3D6(PC, D0), D1
		jsr     loc_1D3D6(PC, D1)
		move.w  $0030(A0), D0
		bra.w     loc_1D58E
loc_1D3D6:
		dc.w    loc_1D3DC-loc_1D3D6
		dc.w    loc_1D460-loc_1D3D6
		dc.w    loc_1D474-loc_1D3D6
loc_1D3DC:
		addq.b  #$02, $0024(A0)
		moveq   #$34, D3
		moveq   #$02, D4
		btst    #$00, $0022(A0)
		beq.s   loc_1D3F0
		moveq   #$3A, D3
		moveq   #-2, D4
loc_1D3F0:
		move.w  $0008(A0), D2
		move.l  A0, A1
		moveq   #$03, D1
		bra.s   loc_1D408
loc_1D3FA:		
		bsr.w     J_SingleObjLoad2_09 ; loc_1D57C
		bne.w    loc_1D460
		move.b  #$04, $0024(A1)
loc_1D408:
		move.b  0(A0), 0(A1);_move.b  0(A0), 0(A1)
		move.l  #Obj6B_MapUnc_1BF4A, $0004(A1) ; loc_1BF4A
		move.w  #$6418, $0002(A1)
		bsr.w     J_Adjust2PArtPointer2_02 ; loc_1D582
		move.b  #$04, $0001(A1)
		move.b  #$03, $0018(A1)
		move.b  #$10, $0019(A1)
		move.b  $0028(A0), $0028(A1)
		move.w  D2, $0008(A1)
		move.w  $000C(A0), $000C(A1)
		move.w  $0008(A0), $0030(A1)
		move.w  $000C(A1), $0032(A1)
		addi.w  #$0020, D2
		move.b  D3, $002F(A1)
		move.l  A0, $003C(A1)
		add.b   D4, D3
		dbf    D1, loc_1D3FA
loc_1D460:
		moveq   #$00, D0
		move.b  $0028(A0), D0
		andi.w  #$0007, D0
		add.w   D0, D0
		move.w  loc_1D4AC(PC, D0), D1
		jsr     loc_1D4AC(PC, D1)
loc_1D474:
		move.l  $003C(A0), A2
		moveq   #$00, D0
		move.b  $002F(A0), D0
		move.w  $00(A2, D0), D0
		add.w   $0032(A0), D0
		move.w  D0, $000C(A0)
		moveq   #$00, D1
		move.b  $0019(A0), D1
		addi.w  #$000B, D1
		move.w  #$0010, D2
		move.w  #$0011, D3
		move.w  $0008(A0), D4
		bsr.w     J_SolidObject_12        ; loc_1D588
		swap  D6
		or.b    D6, $002E(A2)
		rts
loc_1D4AC:
		dc.w    loc_1D4BC-loc_1D4AC
		dc.w    loc_1D528-loc_1D4AC
		dc.w    loc_1D4E0-loc_1D4AC
		dc.w    loc_1D528-loc_1D4AC
		dc.w    loc_1D4BC-loc_1D4AC
		dc.w    loc_1D552-loc_1D4AC
		dc.w    loc_1D4E0-loc_1D4AC
		dc.w    loc_1D552-loc_1D4AC
loc_1D4BC:
		tst.w   $002C(A0)
		bne.s   loc_1D4D4
		move.b  $002E(A0), D0
		andi.b  #$30, D0
		beq.s   loc_1D4D2
		move.w  #$001E, $002C(A0)
loc_1D4D2:
		rts
loc_1D4D4:
		subq.w  #$01, $002C(A0)
		bne.s   loc_1D4D2
		addq.b  #$01, $0028(A0)
		rts
loc_1D4E0:
		tst.w   $002C(A0)
		bne.s   loc_1D4F8
		move.b  $002E(A0), D0
		andi.b  #$0C, D0
		beq.s   loc_1D4F6
		move.w  #$003C, $002C(A0)
loc_1D4F6:
		rts
loc_1D4F8:
		subq.w  #$01, $002C(A0)
		bne.s   loc_1D504
		addq.b  #$01, $0028(A0)
		rts
loc_1D504:
		lea     $0034(A0), A1
		move.w  $002C(A0), D0
		lsr.b   #$02, D0
		andi.b  #$01, D0
		move.w  D0, (A1)+
		eori.b  #$01, D0
		move.w  D0, (A1)+
		eori.b  #$01, D0
		move.w  D0, (A1)+
		eori.b  #$01, D0
		move.w  D0, (A1)+
		rts
loc_1D528:
		lea     $0034(A0), A1
		cmpi.w  #$0080, (A1)
		beq.s   loc_1D550
		addq.w  #$01, (A1)
		moveq   #$00, D1
		move.w  (A1)+, D1
		swap  D1
		lsr.l   #$01, D1
		move.l  D1, D2
		lsr.l   #$01, D1
		move.l  D1, D3
		add.l   D2, D3
		swap  D1
		swap  D2
		swap  D3
		move.w  D3, (A1)+
		move.w  D2, (A1)+
		move.w  D1, (A1)+
loc_1D550:
		rts
loc_1D552:
		lea     $0034(A0), A1
		cmpi.w  #$FF80, (A1)
		beq.s   loc_1D57A
		subq.w  #$01, (A1)
		moveq   #$00, D1
		move.w  (A1)+, D1
		swap  D1
		asr.l   #$01, D1
		move.l  D1, D2
		asr.l   #$01, D1
		move.l  D1, D3
		add.l   D2, D3
		swap  D1
		swap  D2
		swap  D3
		move.w  D3, (A1)+
		move.w  D2, (A1)+
		move.w  D1, (A1)+
loc_1D57A:
		rts   
;=============================================================================== 
; Object 0x78 - Chemical Plant - Rotanting Platforms / Down when Touch Platform 
; [ End ]		         
;===============================================================================		   
J_SingleObjLoad2_09: ; loc_1D57C:
		jmp     SingleObjLoad2      ; (loc_E788)
J_Adjust2PArtPointer2_02: ; loc_1D582:
		jmp     Adjust2PArtPointer2   ; (loc_DC4C)
J_SolidObject_12: ; loc_1D588:
		jmp     SolidObject             ; (loc_F4A0)
loc_1D58E:
		jmp     (loc_D2D8)  
Obj6B_MapUnc_1BF4A:	incbin	"mappings/sprite/obj6B.bin"
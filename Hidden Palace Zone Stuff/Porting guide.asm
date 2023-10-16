;NOTE: This guide assumes you have all other HPZ objects and art are ported/in the disasm.
;Make sure the other art and object names match to the names here (some might be already).





;Update "NonWaterEffects" with this:
NonWaterEffects:
	cmpi.b	#oil_ocean_zone,(Current_Zone).w	; is the level OOZ?
	bne.s	+			; if not, branch
	bsr.w	OilSlides		; call oil slide routine
+
	cmpi.b	#wing_fortress_zone,(Current_Zone).w	; is the level WFZ?
	bne.s	+			; if not, branch
	bsr.w	WindTunnel		; call wind and block break routine
+
        cmpi.b	#hidden_palace_zone,(Current_Zone).w	; is the level HPZ?
	bne.s	+			; if not, branch
	jmp	WaterSlides		; call water slide routine
+	
	rts

;Place the "WaterSlides" code from the file after "Obj3C_MapUnc_15ECC".

;Place "Obj4C" code from the file after "JmpTo7_MarkObjGone3".
;Place "ObjDD" code from the file after "Obj4C".
;Place "Obj4E" code from the file after "ObjDD".
;Place "Obj4F" code from the file after "JmpTo19_ObjectMove".

;BFish mappings go in: "mappings/sprite/Piranha.bin" in the main disasm, not in the folder this file is in.
;(Same goes for the art files for the badniks).
;Other unused badnik mappings are part of the object itself, if you wish to split them into their own files, you may.





;Update "DbgObjList_HPZ" with this:
DbgObjList_HPZ: dbglistheader   
        dbglistobj ObjID_Ring,		Obj25_MapUnc_12382,   0,   0, make_art_tile(ArtTile_ArtNem_Ring,1,0)
	dbglistobj ObjID_Monitor,	Obj26_MapUnc_12D36,   8,   0, make_art_tile(ArtTile_ArtNem_Powerups,0,0)
	dbglistobj ObjID_ForcedSpin,	Obj03_MapUnc_1FFB8,   0,   0, make_art_tile(ArtTile_ArtNem_Ring,1,0)
	dbglistobj ObjID_ForcedSpin,	Obj03_MapUnc_1FFB8,   4,   4, make_art_tile(ArtTile_ArtNem_Ring,1,0)
	dbglistobj ObjID_Spikes,	Obj36_MapUnc_15B68,   0,   0, make_art_tile(ArtTile_ArtNem_Spikes_HPZ,1,0)
	dbglistobj ObjID_Spring,	Obj41_MapUnc_1901C, $81,   0, make_art_tile(ArtTile_ArtNem_VrtclSprng_HPZ,0,0)
	dbglistobj ObjID_Spring,	Obj41_MapUnc_1901C, $A0,   6, make_art_tile(ArtTile_ArtNem_VrtclSprng_HPZ,0,0)
	dbglistobj ObjID_PulsingOrb,	Obj71_MapUnc_11396, $11,   3, make_art_tile(ArtTile_ArtNem_HPZOrb,3,0)
	dbglistobj ObjID_HPZWaterfall,  Obj13_MapUnc_20528,   4,   4, make_art_tile(ArtTile_ArtNem_HPZ_Waterfall,3,0)
	dbglistobj ObjID_HPZCollapsPform, Obj1A_MapUnc_1101C,   0,   0, make_art_tile(ArtTile_ArtNem_HPZPlatform,2,0)
	dbglistobj ObjID_PlaneSwitcher,	Obj03_MapUnc_1FFB8,   9,   1, make_art_tile(ArtTile_ArtNem_Ring,1,0)
        dbglistobj ObjID_Dinobot,       Dinobot_Mappings,     0,   0, make_art_tile(ArtTile_ArtNem_Dinobot,0,0)
        dbglistobj ObjID_Piranha,	Piranha_Mappings,     1,   0, make_art_tile(ArtTile_ArtNem_Piranha,1,0)
        dbglistobj ObjID_Batbot,        Batbot_Mappings,      0,   0, make_art_tile(ArtTile_ArtNem_Batbot,0,0)
        dbglistobj ObjID_Rhinobot,      Rhinobot_Mappings,    0,   0, make_art_tile(ArtTile_ArtNem_Rhinobot,0,0)
        dbglistobj ObjID_ARZBubbles,	Obj24_MapUnc_1FBF6, $81,  $E, make_art_tile(ArtTile_ArtNem_BigBubbles,0,1)
DbgObjList_HPZ_End





;Place the following text above "ArtNem_Spikes":
ArtNem_Spikes_HPZ:

;Place the following text above "ArtNem_VrtclSprng":
ArtNem_VrtclSprng_HPZ:

;Place the following text above "ArtNem_HrzntlSprng":
ArtNem_HrzntlSprng_HPZ:





;Make sure "PLCptr_Hpz1" and "PLCptr_Hpz2" exist after "PLCptr_Htz2", I don't feel like checking if they do in unmodded Sonic 2.
;If it exists, update the HPZ PLC's with this (goes after "PlrList_Htz2" if it doesn't exist):
;---------------------------------------------------------------------------------------
; Pattern load queue
; HPZ Primary
;---------------------------------------------------------------------------------------
PlrList_Hpz1: plrlistheader
	plreq ArtTile_ArtNem_HPZ_Bridge, ArtNem_HPZ_Bridge
        plreq ArtTile_ArtNem_HPZ_Waterfall, ArtNem_HPZ_Waterfall
        plreq ArtTile_ArtNem_HPZPlatform, ArtNem_HPZPlatform
       	plreq ArtTile_ArtNem_HPZOrb, ArtNem_HPZPulseOrb
        plreq ArtTile_ArtNem_HPZ_Emerald, ArtNem_HPZ_Emerald
	plreq ArtTile_ArtNem_WaterSurface, ArtNem_WaterSurface
	plreq ArtTile_ArtNem_Spikes_HPZ, ArtNem_Spikes_HPZ
        plreq ArtTile_ArtNem_VrtclSprng_HPZ, ArtNem_VrtclSprng_HPZ
	plreq ArtTile_ArtNem_HrzntlSprng_HPZ, ArtNem_HrzntlSprng_HPZ               	
PlrList_Hpz1_End
;---------------------------------------------------------------------------------------
; Pattern load queue
; HPZ Secondary
;---------------------------------------------------------------------------------------
PlrList_Hpz2: plrlistheader
        plreq ArtTile_ArtNem_Rhinobot, ArtNem_Rhinobot
        plreq ArtTile_ArtNem_Dinobot, ArtNem_Dinobot
        plreq ArtTile_ArtNem_Piranha, ArtNem_Piranha
        plreq ArtTile_ArtNem_Batbot, ArtNem_Batbot
        plreq ArtTile_ArtNem_BigBubbles, ArtNem_BigBubbles
PlrList_Hpz2_End





;Make sure "PLCID_Hpz1" and "PLCID_Hpz2" exist in "s2.constants.asm" after "PLCID_Htz2" add the following code if it isn't there:
PLCID_Hpz1 =		id(PLCptr_Hpz1) ; 14
PLCID_Hpz2 =		id(PLCptr_Hpz2) ; 15

;Replace whats after "levartptrs PLCID_Htz1" at "LevelArtPointers" with this if it already doesn't exist:
	levartptrs PLCID_Hpz1,     PLCID_Hpz2,      PalID_HPZ,  ArtKos_HPZ, BM16_HPZ, BM128_HPZ ;   8 ; HPZ  ; HIDDEN PALACE ZONE





;Replace what exists after "ObjPtr_Buzzer" in "s2.asm" with these:
ObjPtr_Batbot:		dc.l Obj4C	; Batbot from HPZ
ObjPtr_Rhinobot:	dc.l Obj4D	; Rhinobot from HPZ
ObjPtr_Crocobot:	dc.l Obj4E	; Crocobot
ObjPtr_Dinobot:		dc.l Obj4F	; Dinobot from HPZ

;(Add this to the end of the pointer list)
ObjPtr_Piranha:	        dc.l ObjDD      ; Piranha (Bfish)

;Add these in "s2.constants.asm" after "ObjID_Buzzer":
ObjID_Batbot =			id(ObjPtr_Batbot)		; 4C
ObjID_Rhinobot =		id(ObjPtr_Rhinobot)		; 4D
ObjID_Crocobot =		id(ObjPtr_Crocobot)		; 4E
ObjID_Dinobot =			id(ObjPtr_Dinobot)		; 4F

;(Add this to the end of the pointer list in the same file)
ObjID_Piranha =                 id(ObjPtr_Piranha)              ; DD





;Place these art pointers after "ArtNem_Buzzer" (remove the octus art copy afterwards):
;--------------------------------------------------------------------------------------
; Nemesis compressed art (blocks)
; Batbot from HPZ
	even
ArtNem_Batbot:	BINCLUDE	"art/nemesis/Batbot from HPZ.bin"
;--------------------------------------------------------------------------------------
; Nemesis compressed art (58 blocks)
; Octopus badnik from OOZ	; ArtNem_8336A:
	even
ArtNem_Octus:	BINCLUDE	"art/nemesis/Octopus badnik from OOZ.bin"
;--------------------------------------------------------------------------------------
; Nemesis compressed art (blocks)
; Rhinobot from HPZ
	even
ArtNem_Rhinobot:BINCLUDE	"art/nemesis/Rhinobot from HPZ.bin"
;--------------------------------------------------------------------------------------
; Nemesis compressed art (blocks)
; Dinobot from HPZ
	even
ArtNem_Dinobot:BINCLUDE	"art/nemesis/Dinobot from HPZ.bin"
;--------------------------------------------------------------------------------------
; Nemesis compressed art (blocks)
; Piranha
	even
ArtNem_Piranha:BINCLUDE	"art/nemesis/Piranha.bin"
;--------------------------------------------------------------------------------------





;Update "Obj36_Init" with this:
Obj36_Init:
	addq.b	#2,routine(a0)	; => Obj36_Upright
	move.l	#Obj36_MapUnc_15B68,mappings(a0)
	
	move.w	#make_art_tile(ArtTile_ArtNem_Spikes,1,0),art_tile(a0)
	
	cmpi.b	#hidden_palace_zone,(Current_Zone).w ; are we in HPZ?
	bne.s	+			; if not, branch
	move.w	#make_art_tile(ArtTile_ArtNem_Spikes_HPZ,1,0),art_tile(a0) ; set HPZ art
+
	ori.b	#4,render_flags(a0)
	move.b	#4,priority(a0)
	move.b	subtype(a0),d0
	andi.b	#$F,subtype(a0)		; lower 4 bits determine behavior, upper bits need to be removed
	andi.w	#$F0,d0
	lea_	Obj36_InitData,a1	; upper 4 bits determine size and orientation
	lsr.w	#3,d0			; use upper 4 bits * 2 as offset
	adda.w	d0,a1
	move.b	(a1)+,width_pixels(a0)
	move.b	(a1)+,y_radius(a0)
	lsr.w	#1,d0			; use upper 4 bits to determine mappings frame
	move.b	d0,mapping_frame(a0)
	cmpi.b	#4,d0			; do spikes face sideways?
	blo.s	+			; if not, branch
	addq.b	#2,routine(a0)	; => Obj36_Sideways
	move.w	#make_art_tile(ArtTile_ArtNem_HorizSpike,1,0),art_tile(a0)
+
	btst	#1,status(a0)		; are spikes upsiede-down?
	beq.s	+			; if not, branch
	move.b	#6,routine(a0)	; => Obj36_Upsidedown
+
	move.w	x_pos(a0),spikes_base_x_pos(a0)
	move.w	y_pos(a0),spikes_base_y_pos(a0)
	bra.w	Adjust2PArtPointer





;Update "Obj41_Init" with this:
Obj41_Init:
	addq.b	#2,routine(a0)
	move.l	#Obj41_MapUnc_1901C,mappings(a0)
	
	move.w	#make_art_tile(ArtTile_ArtNem_VrtclSprng,0,0),art_tile(a0)
	
	cmpi.b	#hidden_palace_zone,(Current_Zone).w ; are we in HPZ?
	bne.s	+			; if not, branch
	move.w	#make_art_tile(ArtTile_ArtNem_VrtclSprng_HPZ,0,0),art_tile(a0) ; set HPZ art
+	
	ori.b	#4,render_flags(a0)
	move.b	#$10,width_pixels(a0)
	move.b	#4,priority(a0)
	move.b	subtype(a0),d0
	lsr.w	#3,d0
	andi.w	#$E,d0
	move.w	Obj41_Init_Subtypes(pc,d0.w),d0
	jmp	Obj41_Init_Subtypes(pc,d0.w)





;Update "Obj41_Init_Horizontal" with this:
Obj41_Init_Horizontal:
	move.b	#4,routine(a0)
	move.b	#2,anim(a0)
	move.b	#3,mapping_frame(a0)
	
	move.w	#make_art_tile(ArtTile_ArtNem_HrzntlSprng,0,0),art_tile(a0)
	
	cmpi.b	#hidden_palace_zone,(Current_Zone).w ; are we in HPZ?
	bne.s	+			; if not, branch
	move.w	#make_art_tile(ArtTile_ArtNem_HrzntlSprng_HPZ,0,0),art_tile(a0) ; set HPZ art
+
	move.b	#8,width_pixels(a0)
	bra.s	Obj41_Init_Common





;Add this after the HTZ list around the end of "s2.constants.asm" (some of these may already exist at the very end of the file, if they do, remove them):

; HPZ
ArtTile_ArtUnc_HPZPulseOrb_1          = $02E8
ArtTile_ArtUnc_HPZPulseOrb_2          = $02F0
ArtTile_ArtUnc_HPZPulseOrb_3          = $02F8
ArtTile_ArtNem_HPZ_Bridge             = $0300
ArtTile_ArtNem_HPZ_Waterfall          = $0315
ArtTile_ArtNem_HPZPlatform            = $034A
ArtTile_ArtNem_HPZOrb                 = $035A
ArtTile_ArtNem_HPZ_Emerald            = $0392
ArtTile_ArtNem_Dinobot                = $0500
ArtTile_ArtNem_Piranha                = $0466
ArtTile_ArtNem_Batbot                 = $0418;$0530 Old VRAM position. (Don't change back).
ArtTile_ArtNem_Rhinobot               = $03B2
ArtTile_ArtNem_VrtclSprng_HPZ         = $0452
ArtTile_ArtNem_HrzntlSprng_HPZ        = $07A0
ArtTile_ArtNem_Spikes_HPZ             = $07AC
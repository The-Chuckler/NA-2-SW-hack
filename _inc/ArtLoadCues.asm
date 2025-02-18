; ---------------------------------------------------------------------------
; "MAIN LEVEL LOAD BLOCK" (after Nemesis)
;
; This struct array tells the engine where to find all the art associated with
; a particular zone. Each zone gets four longwords, in which it stores four
; pointers (in the lower 24 bits) and three jump table indeces (in the upper eight
; bits). The assembled data looks something like this:
;
; aaBBBBBB
; ccDDDDDD
; EEEEEE
; ffgghhii
;
; aa = index for primary pattern load request list
; BBBBBB = unused, pointer to level art
; cc = index for secondary pattern load request list
; DDDDDD = pointer to 16x16 block mappings
; EEEEEE = pointer to 128x128 block mappings
; ff = unused, always 0
; gg = unused, music track
; hh = unused, palette
; ii = palette
;
; Nemesis refers to this as the "main level load block". However, that name implies
; that this is code (obviously, it isn't), or at least that it points to the level's
; collision, object and ring placement arrays (it only points to palettes and 16x16
; mappings although the 128x128 mappings do affect the actual level layout and collision)
; ---------------------------------------------------------------------------

; macro for declaring a "main level load block" (MLLB)
levartptrs macro plc1,plc2,palette,art,map16x16,map128x128,music
	dc.l art+(plc1<<24)
	dc.l map16x16+(plc2<<24)
	dc.l map128x128
	dc.b 0,music,palette,palette
	endm
;FOR IDIOTS THAT DONT UNDERSTAND:
;first number is the first PLC
;second number is second PLC
;third number is palette
;then tiles, blocks, chunks, and music
; MainLoadBlocks:
LevelArtPointers:
		levartptrs  4,  5,  4, Nem_GHZ, Map16_GHZ, UnkComp_Map128_GHZ, bgm_GHZ	;   0 ; GHZ  ; GREEN HILL ZONE
		levartptrs  6,  7,  5, Nem_MTZ, BM16_MTZ,  BM128_MTZ, bgm_LZ			;   1 ; LZ   ; LABYRINTH ZONE
		levartptrs  8,  9,  6, Nem_CPZ, Map16_CPZ, Map128_CPZ, bgm_MZ		;   2 ; CPZ  ; CHEMICAL PLANT ZONE
		levartptrs $A, $B,  7, Nem_EHZ, Map16_EHZ, Map128_EHZ, bgm_SLZ		;   3 ; EHZ  ; EMERALD HILL ZONE
		levartptrs $C, $D,  8, Nem_HPZ, Map16_HPZ, Map128_HPZ, bgm_SYZ		;   4 ; HPZ  ; HIDDEN PALACE ZONE
		levartptrs $E, $F,  9, Nem_EHZ, Map16_EHZ, Map128_EHZ, bgm_SBZ		;   5 ; HTZ  ; HILL TOP ZONE
		levartptrs $22,$22,$13, Nem_WZ,  Map16_WZ,  Map128_WZ,  bgm_SBZ;0,  0,$13, Nem_WZ,  Map16_WZ,  Map128_WZ,  bgm_SBZ	;   6 ; LEV6 ; LEVEL 6 (UNUSED, SONIC 1 ENDING)
		levartptrs $23,$2B,$14, Nem_DHZ,  Map16_DHZ,  Map128_DHZ,  bgm_GHZ
		levartptrs $28,$28,$15, Nem_CNZ,  Map16_CNZ,  Map128_CNZ,  bgm_GHZ
		levartptrs $25,$2A,$16, Nem_OOZ,  Map16_OOZ,  Map128_OOZ,  bgm_GHZ
		levartptrs $26,$29,$17, Nem_NGHZ,  Map16_NGHZ,  Map128_NGHZ,  bgm_GHZ
		levartptrs $24,$27,$1A, Nem_SSZ,  Map16_SSZ,  Map128_SSZ,  bgm_GHZ
; ---------------------------------------------------------------------------
; PATTERN LOAD REQUEST LISTS
;
; Pattern load request lists are simple structures used to load
; Nemesis-compressed art for sprites.
;
; The decompressor predictably moves down the list, so request 0 is processed first, etc.
; This only matters if your addresses are bad and you overwrite art loaded in a previous request.
;

; NOTICE: The load queue buffer can only hold $10 (16) load requests. None of the routines
; that load PLRs into the queue do any bounds checking, so it's possible to create a buffer
; overflow and completely screw up the variables stored directly after the queue buffer.
; (in my experience this is a guaranteed crash or hang)
;
; Many levels queue more than 16 items overall, but they don't exceed the limit because
; their PLRs are split into multiple parts (like PLC_GHZ and PLC_GHZ2) and they fully
; process the first part before requesting the rest.
; ---------------------------------------------------------------------------

;---------------------------------------------------------------------------------------
; Table of pattern load request lists. Remember to use word-length data when adding lists
; otherwise you'll break the array.
;---------------------------------------------------------------------------------------
plreq macro toVRAMaddr,fromROMaddr
	dc.l	fromROMaddr		; art to load
	dc.w	(toVRAMaddr<<5)		; VRAM address to load it at (multiplied by $20)
	endm
ArtLoadCues:	dc.w PLC_Main-ArtLoadCues,PLC_Main2-ArtLoadCues;0,1
		dc.w PLC_Explode-ArtLoadCues,PLC_GameOver-ArtLoadCues;2,3
		dc.w PLC_GHZ-ArtLoadCues,PLC_GHZ2-ArtLoadCues;4,5
		dc.w PLC_MTZ-ArtLoadCues,PLC_MTZ2-ArtLoadCues;6,7
		dc.w PLC_CPZ-ArtLoadCues,PLC_CPZ2-ArtLoadCues;8,9
		dc.w PLC_EHZ-ArtLoadCues,PLC_EHZ2-ArtLoadCues;$A,$B
		dc.w PLC_HPZ-ArtLoadCues,PLC_HPZ2-ArtLoadCues;$C,$D
		dc.w PLC_HTZ-ArtLoadCues,PLC_HTZ2-ArtLoadCues;$E,$F
		dc.w PLC_S1TitleCard-ArtLoadCues,PLC_Boss-ArtLoadCues;$10,$11
		dc.w PLC_Signpost-ArtLoadCues,PLC_S1SpecialStage-ArtLoadCues;10 and 11 seems like;$12,$13
		dc.w PLC_S1SpecialStage-ArtLoadCues,PLC_GHZAnimals-ArtLoadCues;12,13;$14,$15
		dc.w PLC_LZAnimals-ArtLoadCues,PLC_CPZAnimals-ArtLoadCues;14,15;$16,$17
		dc.w PLC_EHZAnimals-ArtLoadCues,PLC_HPZAnimals-ArtLoadCues;16,17;$18,$19
		dc.w PLC_HTZAnimals-ArtLoadCues,PLC_EHZAnimals-ArtLoadCues; pointers for zones 5 and 6 animals;$1A,$1B
		dc.w PLC_EHZAnimals-ArtLoadCues,PLC_EHZAnimals-ArtLoadCues; zones 7&8 animals;$1C,$1D
		dc.w PLC_EHZAnimals-ArtLoadCues,PLC_EHZAnimals-ArtLoadCues; zone 9,$A;$1E,$1F
		dc.w PLC_EHZAnimals-ArtLoadCues,PLC_EHZAnimals-ArtLoadCues; zone $B, no DEZ, or do i add it anyway?YES;$20,$21
		dc.w PLC_WZ-ArtLoadCues;PLC_HTZAnimals-ArtLoadCues;LeftoverArt_Unknown-ArtLoadCues;18,19;$22
		dc.w PLC_DHZ-ArtLoadCues,PLC_SSZ-ArtLoadCues;LeftoverArt_Unknown+2-ArtLoadCues,LeftoverArt_Unknown+4-ArtLoadCues;1A,1B;$23,$24
		dc.w PLC_OOZ-ArtLoadCues,PLC_NGHZ-ArtLoadCues;LeftoverArt_Unknown+6-ArtLoadCues,LeftoverArt_Unknown+8-ArtLoadCues;$25,$26
		dc.w PLC_SSZ-ArtLoadCues;,PLC_NGHZ-ArtLoadCues;$27; why are there 2 for ssz...
		dc.w PLC_CNZ-ArtLoadCues,PLC_NGHZ_2-ArtLoadCues;$28,$29
		dc.w PLC_OOZ_2-ArtLoadCues,PLC_DHZ_2-ArtLoadCues;$2A,$2B
		dc.w PLC_OOZ_2-ArtLoadCues,PLC_DHZ_2-ArtLoadCues;$2C,$2D
; macro for a pattern load request

; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Standard 1 - loaded for every level
; --------------------------------------------------------------------------------------
PLC_Main:	dc.w ((PLC_Main_End-PLC_Main)/6)-1
		plreq $47C, Nem_Lamppost
		plreq $6CA, Nem_HUD
		plreq $7D4, Nem_Lives
		plreq $6BC, Nem_Ring
		plreq $4AC, Nem_Points
PLC_Main_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Standard 2 - loaded for every level
; --------------------------------------------------------------------------------------
PLC_Main2:	dc.w ((PLC_Main2_End-PLC_Main2)/6)-1
		plreq $680, Nem_Monitors
		plreq $4BE, Nem_Shield
		plreq $4DE, Nem_Stars
PLC_Main2_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Explosion - loaded for every level AFTER the title card
; --------------------------------------------------------------------------------------
PLC_Explode:	dc.w ((PLC_Explode_End-PLC_Explode)/6)-1
		plreq $5A0, Nem_Explosion
PLC_Explode_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Game/Time over
; --------------------------------------------------------------------------------------
PLC_GameOver:	dc.w ((PLC_GameOver_End-PLC_GameOver)/6)-1
		plreq $55E, Nem_GameOver
PLC_GameOver_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone primary
; --------------------------------------------------------------------------------------
PLC_GHZ:	dc.w ((PLC_GHZ_End-PLC_GHZ)/6)-1
		plreq 0, Nem_GHZ
		plreq $470, Nem_GHZ_Piranha
		plreq $4A0, Nem_VSpikes
		plreq $4A8, Nem_VSpring
		plreq $4B8, Nem_HSpring
		plreq $4C6, Nem_GHZ_Bridge
		plreq $4D0, Nem_SwingPlatform
		plreq $4E0, Nem_Motobug
;		plreq $6C0, Nem_GHZ_Rock
PLC_GHZ_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone secondary
; --------------------------------------------------------------------------------------
PLC_GHZ2:	dc.w ((PLC_GHZ2_End-PLC_GHZ2)/6)-1
		plreq $470, Nem_GHZ_Piranha
PLC_GHZ2_End:
PLC_MTZ:	dc.w ((PLC_MTZ_End-PLC_MTZ-$02)/6)-1
		plreq 0, Nem_MTZ
		dc.l    Mz_Teleport             ; loc_75382
		dc.w    $6780
		dc.l    ArtNem_MtzWheel        ; loc_7461C
		dc.w    $6F00
		dc.l    ArtNem_MtzWheelIndent         ; loc_74A74
		dc.w    $7E00
		dc.l    ArtNem_LavaCup
		dc.w    $7F20
		dc.l    ArtNem_BoltEnd_Rope
		dc.w    $7FA0
		dc.l    ArtNem_MtzSteam		; loc_74BEA
		dc.w    $80A0
		dc.l    ArtNem_MtzSpikeBlock		; loc_74B1C
		dc.w    $8280
		dc.l    ArtNem_MtzSpike              ; loc_74CF4
		dc.w    $8380
PLC_MTZ_End:
PLC_WZ:		dc.w ((PLC_WZ_End-PLC_WZ-$02)/6)-1
		plreq 0, Nem_WZ
PLC_WZ_End:
PLC_DHZ:	dc.w ((PLC_DHZ_End-PLC_DHZ-$02)/6)-1
		plreq 0, Nem_DHZ
PLC_DHZ_End:
PLC_CNZ:	dc.w ((PLC_CNZ_End-PLC_CNZ-$02)/6)-1
		plreq 0, Nem_CNZ
PLC_CNZ_End:
PLC_OOZ:	dc.w ((PLC_OOZ_End-PLC_OOZ-$02)/6)-1
		plreq 0, Nem_OOZ
		dc.l    ArtNem_OOZElevator            ; loc_75F70
		dc.w    $6000
		dc.l    ArtNem_SpikyThing     ; loc_76060
		dc.w    $6180
		dc.l    ArtNem_BurnerLid      ; loc_76258
		dc.w    $6580
		dc.l    ArtNem_StripedBlocksVert         ; loc_762EE
		dc.w    $6640
		dc.l    ArtNem_Oilfall		 ; loc_7635A
		dc.w    $66C0
		dc.l    ArtNem_Oilfall2           ; loc_764D6
		dc.w    $68C0
PLC_OOZ_End:
PLC_NGHZ:	dc.w ((PLC_NGHZ_End-PLC_NGHZ-$02)/6)-1
		plreq 0, Nem_NGHZ
		dc.l    Nghz_Water_Surface      ; loc_78270
		dc.w    $8000
		dc.l    Nghz_Leaves             ; loc_78356
		dc.w    $8200
		dc.l    ArtNem_ArrowAndShooter      ; loc_783E2
		dc.w    $82E0
		dc.l    Nghz_Water_Splash       ; loc_78540
		dc.w    $8500
PLC_NGHZ_End:;Nem_NGHZ
PLC_NGHZ_2:
loc_247B4:
		dc.w    (((loc_247D4-loc_247B4-$02)/$06)-$01) ; Auto Detect Number of Sprites Esrael L. G. Neto
		dc.l    Air_Bubbles_Numbers     ; loc_79AC0
		dc.w    $A000
		dc.l    Nem_VSpikes		  ; loc_7914E
		dc.w    $8680
		dc.l    Nem_DSpring;ArtNem_LeverSpring       ; loc_798F4
		dc.w    $8800
		dc.l    Nem_VSpring2;ArtNem_VrtclSprng         ; loc_78658
		dc.w    $8B80
		dc.l    Nem_HSpring2;ArtNem_HrzntlSprng       ; loc_78774
		dc.w    $8E00
loc_247D4:
PLC_OOZ_2:
loc_24684:
		dc.w    (((loc_246C2-loc_24684-$02)/$06)-$01) ; Auto Detect Number of Sprites Esrael L. G. Neto
		dc.l    ArtNem_OOZBall		; loc_76602
		dc.w    $6A80
		dc.l    ArtNem_LaunchBall              ; loc_76722
		dc.w    $6D00
		dc.l    ArtNem_OOZPlatform ; loc_76A12
		dc.w    $73A0
		dc.l    ArtNem_PushSpring   ; loc_76CA6
		dc.w    $78A0
		dc.l    ArtNem_OOZSwingPlat      ; loc_76E68
		dc.w    $7C60
		dc.l    ArtNem_Button		  ; loc_78580
		dc.w    $8480
		dc.l    Nem_VSpikes;ArtNem_Spikes		  ; loc_7914E
		dc.w    $8680
		dc.l    ArtNem_DignlSprng         ; loc_7883E
		dc.w    $8780
		dc.l    Nem_VSpring2;ArtNem_VrtclSprng         ; loc_78658
		dc.w    $8B80
		dc.l    Nem_HSpring2;ArtNem_HrzntlSprng       ; loc_78774
		dc.w    $8E00
Dust_Hill_Sprites_1:
loc_246C2:
PLC_DHZ_2:
loc_246E2:
		dc.w    (((loc_24708-loc_246E2-$02)/$06)-$01) ; Auto Detect Number of Sprites Esrael L. G. Neto
		dc.l    ArtNem_HorizSpike   ; loc_79A44
		dc.w    $8580
		dc.l    Nem_VSpikes;ArtNem_Spikes		  ; loc_7914E
		dc.w    $8680
		dc.l    ArtNem_DHZGateLog              ; loc_77614
		dc.w    $8780
		dc.l    ArtNem_LeverSpring       ; loc_798F4
		dc.w    $8800
		dc.l    Nem_VSpring2;ArtNem_VrtclSprng         ; loc_78658
		dc.w    $8B80
		dc.l    Nem_HSpring2;ArtNem_HrzntlSprng       ; loc_78774
		dc.w    $8E00
Casino_Night_Sprites_1:
loc_24708:
;End_Level_Results_Sprites:
PLC_MTZ2:	dc.w ((PLC_MTZ2_End-PLC_MTZ2-$02)/6)-1
		dc.l    ArtNem_Button		  ; loc_78580
		dc.w    $8480
		plreq $434, Nem_VSpikes
		plreq $43C, Nem_DSpring
		plreq $45C, Nem_VSpring2
		plreq $470, Nem_HSpring2
		dc.l    ArtNem_MtzAsstBlocks            ; loc_74DB6
		dc.w    $A000
		dc.l    ArtNem_MtzLavaBubble          ; loc_74E2C
		dc.w    $A6C0
		dc.l    ArtNem_MTZ_Platform  ; loc_74F52
		dc.w    $A7E0
		dc.l    ArtNem_MtzCog            ; loc_752A0
		dc.w    $ABE0
PLC_MTZ2_End
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone primary
; --------------------------------------------------------------------------------------
PLC_CPZ:	dc.w ((PLC_CPZ_End-PLC_CPZ-$02)/6)-1
		plreq 0, Nem_CPZ
		plreq $3D0, Nem_CPZ_Unknown
		plreq $400, Nem_CPZ_FloatingPlatform
		dc.l    Cpz_Metal_Structure     ; loc_77A1C
		dc.w    $6E60
		dc.l    ArtNem_ConstructionStripes      ; loc_77C66
		dc.w    $7280
		dc.l    ArtNem_CPZBooster       ; loc_77942
		dc.w    $7380
		dc.l    ArtNem_CPZElevator            ; loc_77684
		dc.w    $7400
		dc.l    ArtNem_CPZAnimatedBits ; loc_77CD2
		dc.w    $7600
		dc.l    ArtNem_CPZTubeSpring        ; loc_78074
		dc.w    $7C00
		dc.l    Nem_HPZ_WaterSurface;Water_Surface           ; loc_777D2
		dc.w    $8000
		dc.l    ArtNem_CPZStairBlock           ; loc_77EB4
		dc.w    $8300
		dc.l    ArtNem_CPZMetalBlock
		dc.w    $8600
PLC_CPZ_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone secondary
; --------------------------------------------------------------------------------------
PLC_CPZ2:	dc.w ((PLC_CPZ2_End-PLC_CPZ2)/6)-1
		plreq $434, Nem_VSpikes
		dc.l    ArtNem_CPZDroplet               ; loc_779AA
		dc.w    $8780
;		plreq $43C, Nem_DSpring
		plreq $45C, Nem_VSpring2
		plreq $470, Nem_HSpring2
PLC_CPZ2_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone primary
; --------------------------------------------------------------------------------------
PLC_EHZ:	dc.w ((PLC_EHZ_End-PLC_EHZ)/6)-1
		plreq 0, Nem_EHZ
		plreq $39E, Nem_EHZ_Fireball
		plreq $3AE, Nem_EHZ_Waterfall
		plreq $3C6, Nem_EHZ_Bridge
		plreq $3CE, Nem_HTZ_Seesaw
		plreq $434, Nem_VSpikes
		plreq $43C, Nem_DSpring
		plreq $45C, Nem_VSpring2
		plreq $470, Nem_HSpring2
PLC_EHZ_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone secondary
; --------------------------------------------------------------------------------------
PLC_EHZ2:	dc.w ((PLC_EHZ2_End-PLC_EHZ2)/6)-1
		plreq $560, Nem_Shield
		plreq $4AC, Nem_Points
		plreq $3E6, Nem_Buzzer
		plreq $402, Nem_Snail
		plreq $41C, Nem_Masher
PLC_EHZ2_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone primary
; --------------------------------------------------------------------------------------
PLC_HPZ:	dc.w ((PLC_HPZ_End-PLC_HPZ)/6)-1
		plreq 0, Nem_HPZ
		plreq $300, Nem_HPZ_Bridge
		plreq $315, Nem_HPZ_Waterfall
		plreq $34A, Nem_HPZ_Platform
		plreq $35A, Nem_HPZ_PulsingBall
		plreq $37C, Nem_HPZ_Various
;		dc.l    Hpz_Unknow_Platform     ; loc_75DD6
;		dc.w    $6F80 ;384 if divided by 2, yes i used an online calculator i'm too lazy
		plreq $384, Hpz_Unknow_Platform;originally $374
		plreq $392, Nem_HPZ_Emerald
		plreq $400, Nem_HPZ_WaterSurface
PLC_HPZ_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone secondary
; --------------------------------------------------------------------------------------
PLC_HPZ2:	dc.w ((PLC_HPZ2_End-PLC_HPZ2)/6)-1
		plreq $500, Nem_Redz
		plreq $3C4, Nem_Triceratops
		plreq $45C, Nem_VSpring2
		plreq $430, Nem_HPZ_Piranha
word_1C1E2:	plreq $530, Nem_Bat
PLC_HPZ2_End:
		; unused PLR entries
		plreq $300, Nem_Crocobot
		plreq $32C, Nem_Buzzer
		plreq $350, Nem_Bat
		plreq $3C4, Nem_Triceratops
		plreq $500, Nem_Redz
		plreq $530, Nem_HPZ_Piranha
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hill Top Zone primary
; --------------------------------------------------------------------------------------
PLC_HTZ:	dc.w ((PLC_HTZ_End-PLC_HTZ)/6)-1
		plreq 0, Nem_EHZ
		plreq $1FC, Nem_HTZ
		plreq $500, Nem_HTZ_AniPlaceholders
		plreq $39E, Nem_EHZ_Fireball
		plreq $3AE, Nem_HTZ_Fireball
		plreq $3BE, Nem_HTZ_AutomaticDoor
		plreq $3C6, Nem_EHZ_Bridge
		plreq $3CE, Nem_HTZ_Seesaw
		plreq $434, Nem_VSpikes
		plreq $43C, Nem_DSpring
PLC_HTZ_End:
		; unused PLR entries
		plreq $45C, Nem_VSpring2
		plreq $470, Nem_HSpring2
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hill Top Zone secondary
; --------------------------------------------------------------------------------------
PLC_HTZ2:	dc.w ((PLC_HTZ2_End-PLC_HTZ2)/6)-1
		plreq $3E6, Nem_HTZ_Lift
PLC_HTZ2_End:
		; unused PLR entries
		plreq $3E6, Nem_Buzzer
		plreq $402, Nem_Snail
		plreq $41C, Nem_Masher
; NEW PLCS ADDED LATER THAN THE LAST BUILD
PLC_SSZ:	dc.w ((PLC_SSZ_End-PLC_SSZ-$02)/6)-1
		plreq 0, Nem_SSZ
		plreq $300, Nem_Crocobot
PLC_SSZ_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Sonic 1 title card
; --------------------------------------------------------------------------------------
PLC_S1TitleCard:dc.w ((PLC_S1TitleCard_End-PLC_S1TitleCard)/6)-1
		plreq $580, Nem_S1TitleCard
PLC_S1TitleCard_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; End of zone bosses
; --------------------------------------------------------------------------------------
PLC_Boss:	dc.w ((PLC_Boss_End-PLC_Boss)/6)-1
		plreq $460, Nem_BossShip
		plreq $4C0, Nem_EHZ_Boss
		plreq $540, Nem_EHZ_Boss_Blades
PLC_Boss_End:
		; unused PLR entries
		plreq $400, Nem_BossShip
		plreq $460, Nem_CPZ_ProtoBoss
		plreq $4D0, Nem_BossShipBoost
		plreq $4D8, Nem_Smoke
		plreq $4E8, Nem_EHZ_Boss
		plreq $568, Nem_EHZ_Boss_Blades
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; End of level signpost
; --------------------------------------------------------------------------------------
PLC_Signpost:	dc.w ((PLC_Signpost_End-PLC_Signpost)/6)-1
		plreq $680, Nem_Signpost
		plreq $4B6, Nem_S1BonusPoints
		plreq $462, Nem_BigFlash
PLC_Signpost_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Sonic 1 Special Stage, although since it's blank, using it will crash the game
; unless you remove the +$10
; --------------------------------------------------------------------------------------
; PLC_Invalid:
PLC_S1SpecialStage:	dc.w ((PLC_S1SpecialStage_End-PLC_S1SpecialStage)/6)+$10
PLC_S1SpecialStage_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone animals
; --------------------------------------------------------------------------------------
PLC_GHZAnimals:	dc.w ((PLC_GHZAnimals_End-PLC_GHZAnimals)/6)-1
		plreq $580, Nem_Bunny
		plreq $592, Nem_Flicky
PLC_GHZAnimals_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Labyrinth Zone animals
; --------------------------------------------------------------------------------------
PLC_LZAnimals:	dc.w ((PLC_LZAnimals_End-PLC_LZAnimals)/6)-1
		plreq $580, Nem_Penguin
		plreq $592, Nem_Seal
PLC_LZAnimals_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone animals
; --------------------------------------------------------------------------------------
PLC_CPZAnimals:	dc.w ((PLC_CPZAnimals_End-PLC_CPZAnimals)/6)-1
		plreq $580, Nem_Squirrel
		plreq $592, Nem_Seal
PLC_CPZAnimals_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone animals
; --------------------------------------------------------------------------------------
PLC_EHZAnimals:	dc.w ((PLC_EHZAnimals_End-PLC_EHZAnimals)/6)-1
		plreq $580, Nem_Pig
		plreq $592, Nem_Flicky
PLC_EHZAnimals_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone animals
; --------------------------------------------------------------------------------------
PLC_HPZAnimals:	dc.w ((PLC_HPZAnimals_End-PLC_HPZAnimals)/6)-1
		plreq $580, Nem_Pig
		plreq $592, Nem_Chicken
PLC_HPZAnimals_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hill Top Zone animals
; --------------------------------------------------------------------------------------
PLC_HTZAnimals:	dc.w ((PLC_HTZAnimals_End-PLC_HTZAnimals)/6)-1
		plreq $580, Nem_Bunny
		plreq $592, Nem_Chicken
PLC_HTZAnimals_End:

; ===========================================================================
; ----------------------------------------------------------------------------
; Object DD - Piranha (Bfish)
; ----------------------------------------------------------------------------
ObjDD:
                moveq	#0,d0
		move.b	$24(a0),d0
                move.w  Offset_0x01FEAE(PC, D0), D1
                jmp     Offset_0x01FEAE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01FEAE:
                dc.w    Offset_0x01FEB4-Offset_0x01FEAE
                dc.w    Offset_0x01FF2C-Offset_0x01FEAE
                dc.w    Offset_0x01FF9C-Offset_0x01FEAE      
;-------------------------------------------------------------------------------
Offset_0x01FEB4:
                addq.b  #$02, routine(A0)
                move.l	#Piranha_Mappings,4(A0)
                move.w	#make_art_tile(ArtTile_ArtNem_Piranha,1,0),art_tile(a0)
                ori.b	#4,render_flags(a0)
                move.b	#$A,collision_flags(a0)
		move.b	#4,priority(a0)
		move.b	#$10,width_pixels(a0)
                moveq   #$00, D0
                move.b  subtype(A0), D0                             
                move.b  D0, D1
                andi.w  #$00F0, D1
                add.w   D1, D1
                add.w   D1, D1
                move.w  D1, sub9_x_pos(A0)                      
                move.w  D1, sub9_y_pos(A0)                   
                andi.w  #$000F, D0
                lsl.w   #$06, D0
                subq.w  #$01, D0
                move.w  D0, sub7_y_pos(A0)                    
                move.w  D0, objoff_32(A0)                   
                move.w  #$FF80, x_vel(A0)                         
                move.l  #$FFFB8000, sub8_y_pos(A0)            
                move.w  y_pos(A0), sub8_x_pos(A0)        
                bset    #$06, sub5_x_pos(A0)                          
                btst    #$00, sub5_x_pos(A0)                         
                beq.s   Offset_0x01FF2C
                neg.w   x_vel(A0)                                 
;-------------------------------------------------------------------------------
Offset_0x01FF2C:
                cmpi.w  #$FFFF, sub9_x_pos(A0)               
                beq.s   Offset_0x01FF38
                subq.w  #$01, sub9_x_pos(A0)                     
Offset_0x01FF38:
                subq.w  #$01, sub7_y_pos(A0)                  
                bpl.s   Offset_0x01FF5A
                move.w  sub7_y_pos(A0), objoff_32(A0) 
                neg.w   x_vel(A0)                                 
                bchg    #00, sub5_x_pos(A0)                            
                move.b  #$01, prev_anim(A0)                         
                move.w  sub9_y_pos(A0), sub9_x_pos(A0)
Offset_0x01FF5A:
                lea     (Piranha_Animate_Data), A1            
                bsr     Jmp_07_To_AnimateSprite              
                bsr     Jmp_0E_To_SpeedToPos                
                tst.w   sub9_x_pos(A0)                        
                bgt     Jmp_1A_To_MarkObjGone                
                cmpi.w  #$FFFF, sub9_x_pos(A0)                
                beq     Jmp_1A_To_MarkObjGone              
                move.l  #$FFFB8000, sub8_y_pos(A0)           
                addq.b  #$02, sub5_y_pos(A0)                         
                move.w  #$FFFF, sub9_x_pos(A0)                
                move.b  #$02, sub4_x_pos(A0)                      
                move.w  #$0001, objoff_3E(A0)                
                bra     Jmp_1A_To_MarkObjGone                
;-------------------------------------------------------------------------------
Offset_0x01FF9C:
                move.w  #$0600, (Water_Level_1).w 
                ;move.w  #$0390, (Water_Level_1).w                   
                lea     (Piranha_Animate_Data), A1           
                bsr     Jmp_07_To_AnimateSprite             
                move.w  objoff_3E(A0), D0                    
                sub.w   D0, sub7_y_pos(A0)                     
                bsr     Offset_0x02004C
                tst.l   sub8_y_pos(A0)                         
                bpl.s   Offset_0x01FFF4
                move.w  y_pos(A0), D0                                
                cmp.w   (Water_Level_1).w, D0                       
                bgt     Jmp_1A_To_MarkObjGone                
                move.b  #$03, anim(A0)                     
                bclr    #$06, sub5_x_pos(A0)                          
                tst.b   sub6_y_pos(A0)                               
                bne     Jmp_1A_To_MarkObjGone               
                move.w  x_vel(A0), D0                             
                asl.w   #$01, D0
                move.w  D0, x_vel(A0)                            
                addq.w  #$01,  objoff_3E(A0)                  
                st      sub6_y_pos(A0)                                 
                bra     Jmp_1A_To_MarkObjGone                
Offset_0x01FFF4:
                move.w  y_pos(A0), D0                                   
                cmp.w   (Water_Level_1).w, D0                    
                bgt.s   Offset_0x020008
                move.b  #$01, anim(A0)                     
                bra     Jmp_1A_To_MarkObjGone               
Offset_0x020008:
                move.b  #$00, anim(A0)                      
                bset    #$06, sub5_x_pos(A0)                         
                bne.s   Offset_0x020022
                move.l  sub8_y_pos(A0), D0                    
                asr.l   #$01, D0
                move.l  D0, sub8_y_pos(A0)                   
                nop
Offset_0x020022:
                move.w  sub8_x_pos(A0), D0                  
                cmp.w   y_pos(A0), D0                                
                bgt     Jmp_1A_To_MarkObjGone                
                subq.b  #$02, routine(A0)                        
                tst.b   sub6_y_pos(A0)                                 
                beq     Jmp_1A_To_MarkObjGone               
                move.w  x_vel(A0), D0                             
                asr.w   #$01, D0
                move.w  D0, x_vel(A0)                            
                sf      sub6_y_pos(A0)                                 
                bra     Jmp_1A_To_MarkObjGone               
Offset_0x02004C:
                move.l  x_pos(A0), D2                                
                move.l  y_pos(A0), D3                                
                move.w  x_vel(A0), D0                            
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                add.l   sub8_y_pos(A0), D3                    
                btst    #$06, sub5_x_pos(A0)                         
                beq.s   Offset_0x020088
                tst.l   sub8_y_pos(A0)                        
                bpl.s   Offset_0x020080
                addi.l  #$00001000, sub8_y_pos(A0)            
                addi.l  #$00001000, sub8_y_pos(A0)           
Offset_0x020080:
                subi.l  #$00001000, sub8_y_pos(A0)            
Offset_0x020088:
                addi.l  #$00001800, sub8_y_pos(A0)             
                move.l  D2, x_pos(A0)                               
                move.l  D3, y_pos(A0)                                
                rts           
;-------------------------------------------------------------------------------
Piranha_Animate_Data:                                         
                dc.w    Offset_0x0200A2-Piranha_Animate_Data
                dc.w    Offset_0x0200A6-Piranha_Animate_Data
                dc.w    Offset_0x0200AA-Piranha_Animate_Data
                dc.w    Offset_0x0200AE-Piranha_Animate_Data
Offset_0x0200A2:
                dc.b    $0E, $00, $01, $FF
Offset_0x0200A6:
                dc.b    $03, $00, $01, $FF
Offset_0x0200AA:
                dc.b    $0E, $02, $03, $FF
Offset_0x0200AE:
                dc.b    $03, $02, $03, $FF    
;-------------------------------------------------------------------------------
Piranha_Mappings:	BINCLUDE "mappings/sprite/Piranha.bin"
                
                dc.w    $0000                 
Jmp_1A_To_MarkObjGone:                                         
                jmp     (MarkObjGone)                          
Jmp_07_To_AnimateSprite:                                      
                jmp     (AnimateSprite)                       
Jmp_0E_To_SpeedToPos:                                        
                jmp     (ObjectMove)                         
                dc.w    $0000
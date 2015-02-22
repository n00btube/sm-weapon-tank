; Copyright 2015 Adam <https://github.com/n00btube>
; MIT license (this file).

lorom

; --------------------------------------------------------------
; Most of our work here will be in bank $84, the PLM bank.
; This first routine is the code behind our new PLM instruction to handle
; the item pickup.  This address (F070) is just "somewhere in free space."
; Be careful adding code, not to overwrite the PLM data at F0A0...
; this code is 21 ($15) bytes, leaving 21 ($15) more.
org $84f070
	; PLM arguments:
	; Value (2 bytes), unused since the math is too hard for me yet
	; Message box (1 byte)
	; However, neither of the above show up in SMILE because it doesn't know
	; anything about this new PLM.

tank_collect:
	LDA $09D8   ; load current number of tanks
	INC         ; add hardcoded "one tank"
	STA $09D8   ; save tank number

	LDA $0002,Y ; grab message box arg
	AND #$00FF  ; convert to byte
	JSL $858080 ; display message box

	INY         ; advance past our args, to next instruction
	INY
	INY
	RTS         ; return to PLM loop


; --------------------------------------------------------------
; Item definition, referenced by the files in the PLMs directory.
org $84f0a0
	; item header: EE64 for a pickup
	DW $EE64,item_data

item_data:
	DW $8764,$9000 ; custom graphics: reserve tank (I can't draw gfx yet, sorry)
		DB 0,0,0,0,0,0,0,0  ; graphics palettes
	DW $887C,end_plm ; if item has been picked up, delete PLM
	DW $8A2E,$DFAF ; chozo ball stuff (x2)
	DW $8A2E,$DFC7
	DW $8A24,pickup_plm ; save address of 'pickup triggered' PLM routine
	DW $86C1,$DF89 ; set pre-PLM instruction
	DW $874E       ; store $16 to 1D77,X (the 'variable use PLM value')
		DB $16         ; no idea why, but Chaos Arms did it, and taking it out crashes.

gfx_plm:
	DW $E04F       ; graphics/pickup stuff
	DW $E067       ; flashing animation
	DW $8724,gfx_plm ; use graphics stuff as next (frame's?) PLM instruction

pickup_plm:
	DW $8899       ; mark PLM as picked up
	DW $8BDD
		DB $02       ; play track 02 (item collect)
	DW tank_collect,$0000 ; item type + value (the latter unused)
		DB $1D       ; msgbox identifier, I think $1D may be the first free msgbox?
	DW $0001,$A2B5 ; schedule block redraw & graphics update after 1 frame delay

end_plm:
	DW $86BC       ; done: delete PLM



; --------------------------------------------------------------
; missile pickup (item drop) optimization
; as in, I didn't want it overwriting weapon tanks w/ reserve missiles,
; so I rewrote it entirely.  I made it smaller, so no free space used.
org $91df80
	PHP        ; save flags
	PHB        ; save data bank
	PHK        ; set data bank to code bank ($91)
	PLB
	REP #$30   ; set 16-bit modes

	CLC        ; add pickup size (in A) to current value
	ADC $09C6
	STA $09C6
	CMP $09C8  ; check for overfill
	BMI missiles_done

	; originally, the reserve-missile code was in here.
	; but we just want to set current=max and get on our way.
	LDA $09C8
	STA $09C6

missiles_done:
	PLB        ; restore data bank
	PLP        ; restore flags
	RTL


; --------------------------------------------------------------
; damage calculation hijack point
; this is the obvious point: the LDA instruction that gets the base damage value.
; which is why this conflicts with pretty much "any other damage-modifying patch"
org $93803c
	JSR damage_hijack

; routine for boosting the damage calculation
; TODO: check that $14 and 2 bytes of stack are usable right now
org $93f620
damage_hijack:
	PHX           ; save register

	LDA $09D8     ; load number of weapon tanks
	AND #$000F    ; limit to (hopefully sane) maximum value: 15 tanks
	TAX           ; set up for damage loop

	LDA $0000,y   ; overwritten during hijack: load damage from pointer
	LSR           ; added damage per weapon tank = base/2
	STA $14       ; store added damage

	LDA $0000,y   ; reload base damage
	CLC           ; prep for add loop
damage_add:
	CPX #$0000    ; if we're out of weapon tanks (or had none)
	BEQ damage_ready ; we are done adding up damage

	DEX           ; count the tank we just used
	ADC $14       ; add the half-damage value from tmp space
	BPL damage_add
damage_overflow:
	JMP damage_overflow ; freeze here so failure is obvious in the debugger

damage_ready:
	PLX           ; restore register
	RTS
;F641

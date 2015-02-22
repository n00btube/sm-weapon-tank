;K: A hack to add new message boxes. Based on an item in Insanity, stripped of spoily stuff and commented for public use.
;K: This hasn't been extensively bugtested yet, but at the moment I don't know of any bugs from it.
;J: I've tested it. Looks like, you can use big and small messages with or without highlighted buttons.

;header	
;K: Uncomment this if you're using a headered ROM
;J: Hint: commented lines are starting from ";" and they aren't executed.

lorom


;K: Somewhere in your bank 84 you should have a PLM using a message box, change the index to 1D or higher.
;K: See PLM_Details.txt for how to do that.
;J: You can create new item or use Messanger patch (see patch section) for this purpose.

;	DW $88F3 : DW $0040 : DB $1D	;For example, this is the instruction used by a new item in Insanity.


org $859643

;K: Here is where you can put in new message box entries and tiles. All entries must be consecutive; do not put tiles in between entries.

;K: Example message box entries. They start at the first new slot, 1D.
;K: The first two DW's are for the message box setup and size. This is a simple, 3-high message box with 1 line of text. Other options are possible (see the table at 85869B if you want) but I haven't documented any and the code at the bottom only supports this option.
;J: Alright, I did it. The only thing I don't know is how to get 3 line text messages, such as "Energy recharge completed."

;K: Each new entry simply needs a new message box name for the last DW.
;J: For the big messages, use word $83C5 to get a message with correct Fire button and word $83CC to get a message with correct Dash button. To get a big message without rewriting certain tile you can use any of these 2 instructions.
;	DW $83C5 : DW $825A : DW BigMessageBoxShoot
;	DW $83CC : DW $825A : DW BigMessageBoxDash
	DW $8436 : DW $8289 : DW WeaponTank

;J: Don't touch this line. Meaning of it is that game can't display the last message in the array correctly, even if is a pointer is leading to unexisting message. FixSize subroutine in the Kej's code allows to use only small message box as last one (see below).
	DW $8436 : DW $8289 : DW ButtonArray



;K: Small message box tiles. Start with the message box name from its entry.
;K: The first and third lines are blank tiles for past the left and right edge of the message box. These must be in every message box, and you probably don't want to change them.
;K: The second line is the text in the middle line of the message box you'll probably want to edit. $284E is simply a black box. See TextFormat.txt for values to use - the first section is for message boxes.
;K: Each small message box requires 32 words, so don't add or delete any words, just change them.

WeaponTank:
	DW $000E, $000E, $000E, $000E, $000E, $000E
	DW $284E, $284E, $284E, $284E, $28F6, $28E4, $28E0, $28EF, $28EE, $28ED, $284E, $28F3, $28E0, $28ED, $28EA, $284E, $284E, $284E, $284E
	DW $000E, $000E, $000E, $000E, $000E, $000E, $000E














;J: Big message box tiles. Start with the message box name from its entry.
;K&J: The first and third lines in each group are blank tiles for past the left and right edge of the message box. These must be in every message box, and you probably don't want to change them.
;K&J: The second line in each group is the text in the middle line of the message box you'll probably want to edit. $284E is simply a black box. See TextFormat.txt by Key for values to use - the first section is for message boxes or MessageBoxGuide by DC .
;K&J: Each big message box requires 128 words, so don't add or delete any words, just change them.





;BigMessageBoxShoot:
;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E

;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E

;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E

;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E




;BigMessageBoxDash:
;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E

;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E

;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E

;	DW $000E, $000E, $000E
;	DW $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E, $284E
;	DW $000E, $000E, $000E


;J: Strict order like "small messages first" isn't nessary. 

;==========================================================================

;J: There is a relocated button array for big messages with text "press certain button". 
;J: Meaning of this array is if you change default control settings and shot will use Y button instead of X, then in the default text (press the X button) letter X will be rewritten with Y. 
;J: Actually, there are a different button written by default in each message, but this doesn't matter.

;J: Each word is a position of correct letter. 
;J: When adding a new message, don't forget to add a word to this array. 

;J: In short messages such as "Energy Tank" the value must be 0000.

;J: In big messages the value is the position of tile that will be rewriten.
;J: Add 2 to move the button right, substract 2 to move the button left.
;J: Add 40 to move the button down, substract 40 to move the button up.
;J: To create big message without rewriting a tile, use value $0200.
;J: Note that you can overwrite empty tiles in top and border lines of each message.


ButtonArray:
	DW $0000, $012A, $012A, $012C, $012C, $012C, $0000, $0000, $0000, $0000, $0000, $0000, $0120, $0000, $0000	;Messages 01-0F
	DW $0000, $0000, $012A, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $012A, $0120, $0000, $012A, $0000	;Messages 10-1C
	DW $0000	;Message 1D


;K: The rest is code to make the game use the free space above for new message boxes. No touching.
;K: If you do intend to try something tricky, please note that this code is placed at the end of the above message boxes and doesn't have its own org.
;J: FixSize subroutine is replaced. It has a limitation for using only small messages. I've tweaked it a bit, but got another limitation: last message must be small. So, I got rid of it and added a bunch of pointers to unexisting message (see above).
Fix1C1F:
	LDA $1C1F
	CMP #$001D
	BPL +
	RTS
+
	ADC #$027F
	RTS

org $858243
	JSR Fix1C1F

org $8582E5
	JSR Fix1C1F

org $858413
	DW ButtonArray

;K: Kejardon
;J: JAM
;Version 2

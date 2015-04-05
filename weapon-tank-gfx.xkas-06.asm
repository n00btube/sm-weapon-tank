; Weapon Tank Graphics

lorom

; place at a suitable location in bank $89, then point the
; item_data for custom graphics to it in weapon-tank.xkas-06.asm
; (change the 9400 there to the latter 2/3 of this org)
org $899400
	; frame 1
	DB $3F,$3F,$50,$7F,$98,$F7,$3F,$D0,$1C,$90,$1D,$F0,$1D,$90,$7F,$90,$3F,$00,$7F,$00,$FF,$08,$FF,$0C,$FF,$0C,$DF,$6D,$FF,$0D,$FF,$0F
	DB $FC,$FC,$0A,$FE,$19,$EF,$FC,$0B,$38,$09,$B8,$0F,$B8,$09,$FE,$09,$FC,$00,$FE,$00,$FF,$10,$FF,$30,$FF,$30,$FF,$B6,$FF,$B0,$FF,$F0
	DB $3F,$D0,$92,$FD,$50,$7F,$3F,$3F,$0C,$0C,$08,$04,$66,$78,$66,$78,$FF,$07,$FF,$02,$7F,$10,$3F,$00,$0C,$00,$0C,$00,$7F,$01,$7F,$01
	DB $FC,$0B,$29,$DF,$0A,$FE,$FC,$FC,$30,$30,$10,$20,$66,$1E,$66,$1E,$FF,$70,$FF,$20,$FE,$08,$FC,$00,$30,$00,$30,$00,$FE,$80,$FE,$80
	; frame 2
	DB $3F,$3F,$50,$7F,$90,$F7,$33,$D0,$10,$90,$10,$90,$10,$90,$70,$90,$3F,$00,$7F,$00,$F7,$08,$F3,$0C,$F3,$0C,$F2,$6D,$F2,$0D,$F0,$0F
	DB $FC,$FC,$0A,$FE,$09,$EF,$CC,$0B,$08,$09,$08,$09,$08,$09,$0E,$09,$FC,$00,$FE,$00,$EF,$10,$CF,$30,$CF,$30,$4F,$B6,$4F,$B0,$0F,$F0
	DB $31,$D0,$90,$FB,$50,$7F,$3F,$3F,$0C,$0C,$08,$04,$64,$78,$64,$78,$F1,$0E,$FB,$04,$7F,$10,$3F,$00,$0C,$00,$0C,$00,$7F,$01,$7F,$01
	DB $8C,$0B,$09,$DF,$0A,$FE,$FC,$FC,$30,$30,$10,$20,$26,$1E,$26,$1E,$8F,$70,$DF,$20,$FE,$08,$FC,$00,$30,$00,$30,$00,$FE,$80,$FE,$80


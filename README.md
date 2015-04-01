# Weapon Tank

I got this idea from a SM:Again demo video by MetroidMst with commentary from DSO.

This is a patch for Super Metroid that replaces the unused ‘reserve missiles’ with Weapon Tanks.
They make regular (and charge) beams deal more damage.

# Special Thanks

* **Kejardon**: notes on PLMs and the RAM map.
* **GF\_Kennon**: bank logs.
* **DChronos**: message box guide.
* **JAM**: SMILE JX and the Chaos Arms item, the latter of which I studied greatly.
* **MetroidMst** and **DSO**: both the idea, and a lot of inspiration.

# Known Issues

The message-box patch I have/used seems to have broken the button rewriting in the bombs message box.
It now Samus lays them with “L” (coded as the default value) instead of the actual shoot button.

# Compatibility

Expected to be incompatible with any other patch that affects weapon damage.
Also, anything that uses the reserve missiles RAM at $7E:09D8.
I’m _not_ sure about patches that affect SRAM save/load, since they may have chosen to skip the reserve missiles byte.
Always test!

Uses some free space in bank $84 (item/PLMs) and bank $93 (beam firing).
Also uses message $1D.

# Technical details

The weapon tank ASM, as shipped, reconfigures all projectiles to deal
`base_damage + (base_damage * weapon_tanks / 2)`
damage.
IOW, half of the base damage is added each time a tank is picked up.
A beam doing 300 damage will do 450 with 1 tank and 900 with 4 tanks.
Except for Hyper Beam, because I’m lazy.
Maybe just boost its damage if you need to?

# Author

Of the _particular_ bits in weapon-tank.xkas-06.asm, Adam.
But I stand on the shoulders of giants.

# License

Mix of MIT and unknown.

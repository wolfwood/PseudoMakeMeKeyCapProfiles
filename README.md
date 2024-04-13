# Pseudo Make Me Key Cap Profile

## Changes
* DES R2-4 standard and lateral (inner column) compatibility for lofree/choc v2 and mx switches
    * Note: NOT compatible with Gateron KS-33 switches
* decreased keycap height as much as possible
* added fdm parameter: option to chamfer bottom edges for better bed adhesion
* added [slicer settings](https://github.com/dohn-joh/PseudoMakeMeKeyCapProfiles/tree/master/slicer_settings) for printing in PLA
* changed homeDot parameter from homing dots to a homing bar

Some of these changes were made for fdm printing. The uploaded stl's contain chamfers. If you want to print using a different method, be sure to change the tolerance values, remove the chamfers, add sprues, etc. 

## Huge thanks
* to Pseudoku for creating and sharing all of his keycaps and for assisting with debugging.
* to zzeneg for sharing the low profile modifications and for checking ks33 compatibility.
* to wolfwood for sharing the chamfering technique and print setting suggestions.
* to levpopov for the print setting suggestions.

## Comparison photos
![front](https://raw.githubusercontent.com/dohn-joh/PseudoMakeMeKeyCapProfiles/master/Photo/comparison_front.png)
![side](https://raw.githubusercontent.com/dohn-joh/PseudoMakeMeKeyCapProfiles/master/Photo/comparison_side.png)
![top](https://raw.githubusercontent.com/dohn-joh/PseudoMakeMeKeyCapProfiles/master/Photo/comparison_top.png)
![ruler](https://raw.githubusercontent.com/dohn-joh/PseudoMakeMeKeyCapProfiles/master/Photo/comparison_ruler.jpg)

---

## Update from zzeneg
* [low profile version](https://github.com/zzeneg/PseudoMakeMeKeyCapProfiles/tree/master/stl/MX/lowprofile) - short skirt, bit tighter stems, tested in MJF Nylon (JLCPCB) with KS-33 switches (Gateron Low Profile), probably compatible with other low profiles
* [minY version](https://github.com/zzeneg/PseudoMakeMeKeyCapProfiles/tree/minY/stl/MX/lowprofile/minY) - minimal vertical spacing (19x16mm), tested in MJF Nylon with KS-33 and regular MX switches

## What the fork

* scripts to generate CS, DES, and Liminal Chimera keycaps
* sprued stls packs for MJF/SLS printing
* adding 1.25 to 2.25u Choc CS regular and convex caps

## How to
* make sure OpenSCAD is up to date.
* unzip libraries.zip into your OpenSCAD libraries
* select keycap you want to render by changing KeyID value
* change KeyID to corresponding Parameter ID
* press F5 to review
* press F6 to render
* press F7 to export as STL

#Some notes on ## Distorted Ellipsoidal Saddle (DES) High sculpt smooth transition profile
![DES](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/R1-R5.png)
### Standard
![Neuron v1](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/DES_cast.jpg)

### Concave
![Corne thumb and Convex Caps](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/Convex.jpg)

### Thumbs
![IMK Corne v1](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/DES_corne.jpg)
![Kyria](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/DES_kyria.png)

### Chicago Stenographer
Subtly sculpted choc spaced low profile
![CS](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/CS.png)
#### Standard
![Look](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/CS_gergo.jpg)

#### Convex
![Georgi](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/CS_convex.jpg)
#### Thumbs
![1.5 + 1](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/CS_Thumb.png)
Additional sculpt angle and smoother transitions

### Philadelphia Minimalist
![under](https://raw.githubusercontent.com/pseudoku/PseudoMakeMeKeyCapProfiles/master/Photo/Philadelphia_Minimalist.png)
Minimal spacing
Under construction

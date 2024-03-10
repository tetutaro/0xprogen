#!/bin/sh

# basic information
PROGEN_VERSION="0.3.1"
PROGEN_FAMILYNAME="0xProGenW"

# path of fontforge command
FONTFORGE_COMMAND="fontforge"

# temporally flag
leaving_tmp_flag="false"

# null device
redirection_stderr="/dev/stderr"

# path of original fonts
input_proto_regular="0xProto-Regular.ttf"
input_hackgen_regular="HackGen-Regular.ttf"

# intermediate fonts
# comma_hackgen_regular="Comma-HackGen-Regular.sfd"
# period_hackgen_regular="Period-HackGen-Regular.sfd"
# colon_hackgen_regular="Colon-HackGen-Regular.sdf"
modified_proto_regular="Modified-0xProto-Regular.sfd"
zenkaku_comma_regular="Zenkaku-Comma-Regular.sfd"
zenkaku_period_regular="Zenkaku-Period-Regular.sfd"
zenkaku_colon_regular="Zenkaku-Colon-Regular.sfd"
zenkaku_proto_regular="Zenkaku-0xProto-Regular.sfd"
modified_hackgen_regular="Modified-HackGen-Regular.sfd"

# fontforge scripts
# comma_hackgen_generator="comma_hackgen_generator.pe"
# period_hackgen_generator="period-hackgen_generator.pe"
# colon_hackgen_generator="colon_hackgen_generator.pe"
modified_proto_generator="modified_proto_generator.pe"
zenkaku_comma_generator="zenkaku_comma_generator.pe"
zenkaku_period_generator="zenkaku_period_generator.pe"
zenkaku_colon_generator="zenkaku_colon_generator.pe"
zenkaku_proto_generator="zenkaku_proto_generator.pe"
modified_hackgen_generator="modified_hackgen_generator.pe"
progen_generator="progen_generator.pe"

# Check fontforge existance
if ! which ${FONTFORGE_COMMAND} > ${redirection_stderr} 2>&1
then
    echo "Error: ${FONTFORGE_COMMAND} command not found" >&2
    exit 1
fi

# Make temporary directory
if [ -w "/tmp" -a "${leaving_tmp_flag}" = "false" ]
then
    tmpdir=`mktemp -d /tmp/progen_generator.XXXXXX` || exit 2
else
    tmpdir=`mktemp -d ./tmpdir_progen_generator.XXXXXX`    || exit 2
fi

# Remove temporary directory by trapping
if [ "${leaving_tmp_flag}" = "false" ]
then
    trap "if [ -d \"$tmpdir\" ]; then echo 'Remove temporary files'; rm -rf $tmpdir; echo 'Abnormally terminated'; fi; exit 3" HUP INT QUIT
    trap "if [ -d \"$tmpdir\" ]; then echo 'Remove temporary files'; rm -rf $tmpdir; echo 'Abnormally terminated'; fi" EXIT
else
    trap "echo 'Abnormally terminated'; exit 3" HUP INT QUIT
fi

# ########################################
# # extract comma from HackGen
# ########################################

# cat > ${tmpdir}/${comma_hackgen_generator} << _EOT_
# #!${FONTFORGE_COMMAND} -script

# input_list = ["${input_hackgen_regular}"]
# output_list = ["${comma_hackgen_regular}"]
# i = 0
# while (i < SizeOf(input_list))
#     # Open
#     Open(input_list[i])
#     SelectWorthOutputting()
#     UnlinkReference()
#     ScaleToEm(800, 200)
#     # Clear other glyphs
#     Select(0u002c); SelectInvert(); Clear()
#     # Adjust
#     Select(0u002c); Move(-20, 0); SetWidth(500)
#     RoundToInt(); RemoveOverlap(); RoundToInt()
#     # Clear instructions
#     SelectWorthOutputting()
#     ClearInstrs()
#     # Save
#     Save("${tmpdir}/" + output_list[i])
#     Close()
#     i += 1
# endloop
# Quit()
# _EOT_

# ########################################
# # extract period from HackGen
# ########################################

# cat > ${tmpdir}/${period_hackgen_generator} << _EOT_
# #!${FONTFORGE_COMMAND} -script

# input_list = ["${input_hackgen_regular}"]
# output_list = ["${period_hackgen_regular}"]
# i = 0
# while (i < SizeOf(input_list))
#     # Open
#     Open(input_list[i])
#     SelectWorthOutputting()
#     UnlinkReference()
#     ScaleToEm(800, 200)
#     # Clear other glyphs
#     Select(0u002e); SelectInvert(); Clear()
#     # Adjust
#     Select(0u002e); Move(-20, 0); SetWidth(500)
#     RoundToInt(); RemoveOverlap(); RoundToInt()
#     # Clear instructions
#     SelectWorthOutputting()
#     ClearInstrs()
#     # Save
#     Save("${tmpdir}/" + output_list[i])
#     Close()
#     i += 1
# endloop
# Quit()
# _EOT_

# ########################################
# # extract colon and semi-colon from HackGen
# ########################################

# cat > ${tmpdir}/${colon_hackgen_generator} << _EOT_
# #!${FONTFORGE_COMMAND} -script

# input_list = ["${input_hackgen_regular}"]
# output_list = ["${colon_hackgen_regular}"]
# i = 0
# while (i < SizeOf(input_list))
#     # Open
#     Open(input_list[i])
#     SelectWorthOutputting()
#     UnlinkReference()
#     ScaleToEm(800, 200)
#     # Clear other glyphs
#     Select(0u003a, 0u003b); SelectInvert(); Clear()
#     # Adjust
#     Select(0u003a, 0u003b); Move(-20, 0); SetWidth(500)
#     RoundToInt(); RemoveOverlap(); RoundToInt()
#     # Clear instructions
#     SelectWorthOutputting()
#     ClearInstrs()
#     # Save
#     Save("${tmpdir}/" + output_list[i])
#     Close()
#     i += 1
# endloop
# Quit()
# _EOT_

########################################
# Generate script for modified 0xProto
########################################

cat > ${tmpdir}/${modified_proto_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_proto_regular}"]
output_list = ["${modified_proto_regular}"]
# comma_list = ["${tmpdir}/${comma_hackgen_regular}"]
# period_list = ["${tmpdir}/${period_hackgen_regular}"]
# colon_list = ["${tmpdir}/${colon_hackgen_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # # Remove comma, period, colon and semi-colon
    # Select(0u002c); Clear()
    # Select(0u002e); Clear()
    # Select(0u003a, 0u003b); Clear()
    # Remove Zenkaku basic symbols
    Select(0uff01, 0uff5e); Clear();
    # Remove ambigous glyphs
    Select(0u00a1); Clear()
    Select(0u00a4); Clear()
    Select(0u00a7); Clear()
    Select(0u00a8); Clear()
    Select(0u00aa); Clear()
    Select(0u00ad); Clear()
    Select(0u00ae); Clear()
    Select(0u00b0); Clear()
    Select(0u00b1); Clear()
    Select(0u00b2, 0u00b3); Clear()
    Select(0u00b4); Clear()
    Select(0u00b6, 0u00b7); Clear()
    Select(0u00b8); Clear()
    Select(0u00b9); Clear()
    Select(0u00ba); Clear()
    Select(0u00bc, 0u00be); Clear()
    Select(0u00bf); Clear()
    Select(0u00c6); Clear()
    Select(0u00d0); Clear()
    Select(0u00d7); Clear()
    Select(0u00d8); Clear()
    Select(0u00de, 0u00e1); Clear()
    Select(0u00e6); Clear()
    Select(0u00e8, 0u00ea); Clear()
    Select(0u00ec, 0u00ed); Clear()
    Select(0u00f0); Clear()
    Select(0u00f2, 0u00f3); Clear()
    Select(0u00f7); Clear()
    Select(0u00f8, 0u00fa); Clear()
    Select(0u00fc); Clear()
    Select(0u00fe); Clear()
    Select(0u0101); Clear()
    Select(0u0111); Clear()
    Select(0u0113); Clear()
    Select(0u011b); Clear()
    Select(0u0126, 0u0127); Clear()
    Select(0u012b); Clear()
    Select(0u0131, 0u0133); Clear()
    Select(0u0138); Clear()
    Select(0u013f, 0u0142); Clear()
    Select(0u0144); Clear()
    Select(0u0148, 0u014b); Clear()
    Select(0u014d); Clear()
    Select(0u0152, 0u0153); Clear()
    Select(0u0166, 0u0167); Clear()
    Select(0u016b); Clear()
    Select(0u01ce); Clear()
    Select(0u01d0); Clear()
    Select(0u01d2); Clear()
    Select(0u01d4); Clear()
    Select(0u01d6); Clear()
    Select(0u01d8); Clear()
    Select(0u01da); Clear()
    Select(0u01dc); Clear()
    Select(0u0251); Clear()
    Select(0u0261); Clear()
    Select(0u02c4); Clear()
    Select(0u02c7); Clear()
    Select(0u02c9, 0u02cb); Clear()
    Select(0u02cd); Clear()
    Select(0u02d0); Clear()
    Select(0u02d8, 0u02db); Clear()
    Select(0u02dd); Clear()
    Select(0u02df); Clear()
    Select(0u0300, 0u036f); Clear()
    Select(0u0391, 0u03a1); Clear()
    Select(0u03a3, 0u03a9); Clear()
    Select(0u03b1, 0u03c1); Clear()
    Select(0u03c3, 0u03c9); Clear()
    Select(0u0401); Clear()
    Select(0u0410, 0u044f); Clear()
    Select(0u0451); Clear()
    Select(0u2010); Clear()
    Select(0u2013, 0u2015); Clear()
    Select(0u2016); Clear()
    Select(0u2018); Clear()
    Select(0u2019); Clear()
    Select(0u201c); Clear()
    Select(0u201d); Clear()
    Select(0u2020, 0u2022); Clear()
    Select(0u2024, 0u2027); Clear()
    Select(0u2030); Clear()
    Select(0u2032, 0u2033); Clear()
    Select(0u2035); Clear()
    Select(0u203b); Clear()
    Select(0u203e); Clear()
    Select(0u2074); Clear()
    Select(0u207f); Clear()
    Select(0u2081, 0u2084); Clear()
    Select(0u20ac); Clear()
    Select(0u2103); Clear()
    Select(0u2105); Clear()
    Select(0u2109); Clear()
    Select(0u2113); Clear()
    Select(0u2116); Clear()
    Select(0u2121, 0u2122); Clear()
    Select(0u2126); Clear()
    Select(0u212b); Clear()
    Select(0u2153, 0u2154); Clear()
    Select(0u215b, 0u215e); Clear()
    Select(0u2160, 0u216b); Clear()
    Select(0u2170, 0u2179); Clear()
    Select(0u2189); Clear()
    Select(0u2190, 0u2194); Clear()
    Select(0u2195, 0u2199); Clear()
    Select(0u21b8, 0u21b9); Clear()
    Select(0u21d2); Clear()
    Select(0u21d4); Clear()
    Select(0u21e7); Clear()
    Select(0u2200); Clear()
    Select(0u2202, 0u2203); Clear()
    Select(0u2207, 0u2208); Clear()
    Select(0u220b); Clear()
    Select(0u220f); Clear()
    Select(0u2211); Clear()
    Select(0u2215); Clear()
    Select(0u221a); Clear()
    Select(0u221d, 0u2220); Clear()
    Select(0u2223); Clear()
    Select(0u2225); Clear()
    Select(0u2227, 0u222c); Clear()
    Select(0u222e); Clear()
    Select(0u2234, 0u2237); Clear()
    Select(0u223c, 0u223d); Clear()
    Select(0u2248); Clear()
    Select(0u224c); Clear()
    Select(0u2252); Clear()
    Select(0u2260, 0u2261); Clear()
    Select(0u2264, 0u2267); Clear()
    Select(0u226a, 0u226b); Clear()
    Select(0u226e, 0u226f); Clear()
    Select(0u2282, 0u2283); Clear()
    Select(0u2286, 0u2287); Clear()
    Select(0u2295); Clear()
    Select(0u2299); Clear()
    Select(0u22a5); Clear()
    Select(0u22bf); Clear()
    Select(0u2312); Clear()
    Select(0u2460, 0u249b); Clear()
    Select(0u249c, 0u24e9); Clear()
    Select(0u24eb, 0u24ff); Clear()
    # Select(0u2500, 0u254b); Clear()
    # Select(0u2550, 0u2573); Clear()
    Select(0u2580, 0u258f); Clear()
    Select(0u2592, 0u2595); Clear()
    Select(0u25a0, 0u25a1); Clear()
    Select(0u25a3, 0u25a9); Clear()
    Select(0u25b2, 0u25b3); Clear()
    Select(0u25b6); Clear()
    Select(0u25b7); Clear()
    Select(0u25bc, 0u25bd); Clear()
    Select(0u25c0); Clear()
    Select(0u25c1); Clear()
    Select(0u25c6, 0u25c8); Clear()
    Select(0u25cb); Clear()
    Select(0u25ce, 0u25d1); Clear()
    Select(0u25e2, 0u25e5); Clear()
    Select(0u25ef); Clear()
    Select(0u2605, 0u2606); Clear()
    Select(0u2609); Clear()
    Select(0u260e, 0u260f); Clear()
    Select(0u261c); Clear()
    Select(0u261e); Clear()
    Select(0u2640); Clear()
    Select(0u2642); Clear()
    Select(0u2660, 0u2661); Clear()
    Select(0u2663, 0u2665); Clear()
    Select(0u2667, 0u266a); Clear()
    Select(0u266c, 0u266d); Clear()
    Select(0u266f); Clear()
    Select(0u269e, 0u269f); Clear()
    Select(0u26bf); Clear()
    Select(0u26c6, 0u26cd); Clear()
    Select(0u26cf, 0u26d3); Clear()
    Select(0u26d5, 0u26e1); Clear()
    Select(0u26e3); Clear()
    Select(0u26e8, 0u26e9); Clear()
    Select(0u26eb, 0u26f1); Clear()
    Select(0u26f4); Clear()
    Select(0u26f6, 0u26f9); Clear()
    Select(0u26fb, 0u26fc); Clear()
    Select(0u26fe, 0u26ff); Clear()
    Select(0u273d); Clear()
    Select(0u2776, 0u277f); Clear()
    Select(0u2b56, 0u2b59); Clear()
    Select(0u3248, 0u324f); Clear()
    Select(0ue000, 0uf8ff); Clear()
    Select(0ufe00, 0ufe0f); Clear()
    Select(0ufffd); Clear()
    # # Narrow all the width
    SelectWorthOutputting()
    # Scale(80, 100); Move(-60, 0); SetWidth(500)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # # Merge Hackgen's comma, period, colon and semi-colon
    # MergeFonts(comma_list[i])
    # MergeFonts(period_list[i])
    # MergeFonts(colon_list[i])
    # Clear instructions
    SelectWorthOutputting()
    ClearInstrs()
    # Save
    Save("${tmpdir}/" + output_list[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate script for Zenkaku Comma (HackGen)
########################################

cat > ${tmpdir}/${zenkaku_comma_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_hackgen_regular}"]
output_list = ["${zenkaku_comma_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # Clear other glyphs
    Select(0uff0c); SelectInvert(); Clear()
    # Adjust
    Select(0uff0c);
    # Move(-30, 0);
    SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Clear instructions
    SelectWorthOutputting()
    ClearInstrs()
    # Save
    Save("${tmpdir}/" + output_list[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate script for Zenkaku Period (HackGen)
########################################

cat > ${tmpdir}/${zenkaku_period_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_hackgen_regular}"]
output_list = ["${zenkaku_period_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # Clear other glyphs
    Select(0uff0e); SelectInvert(); Clear()
    # Adjust
    Select(0uff0e);
    Move(-30, 0);
    SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Clear instructions
    SelectWorthOutputting()
    ClearInstrs()
    # Save
    Save("${tmpdir}/" + output_list[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate script for Zenkaku Colon and Semi-Colon (HackGen)
########################################

cat > ${tmpdir}/${zenkaku_colon_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_hackgen_regular}"]
output_list = ["${zenkaku_colon_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # Clear other glyphs
    Select(0uff1a, 0uff1b); SelectInvert(); Clear()
    # Adjust
    Select(0uff1a, 0uff1b);
    Move(-30, 0);
    SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Clear instructions
    SelectWorthOutputting()
    ClearInstrs()
    # Save
    Save("${tmpdir}/" + output_list[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate script for Zenkaku Alphabets (0xProto)
########################################

cat > ${tmpdir}/${zenkaku_proto_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list        = ["${input_proto_regular}"]
zcomma_list       = ["${tmpdir}/${zenkaku_comma_regular}"]
zperiod_list      = ["${tmpdir}/${zenkaku_period_regular}"]
zcolon_list       = ["${tmpdir}/${zenkaku_colon_regular}"]
output_list       = ["${zenkaku_proto_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # Cut and Paste
    Select(0u0021, 0u007e); SelectInvert(); Clear()
    Select(0u0021, 0u007e); Copy(); Select(0uff01, 0uff5e); Paste()
    Scale(150,100);
    Move(320, 0);
    SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Remove Zenkaku comma, period, colon and semi-colon
    Select(0uff0c); Clear()
    Select(0uff0e); Clear()
    Select(0uff1a, 0uff1b); Clear()
    # Merge
    MergeFonts(zcomma_list[i])
    MergeFonts(zperiod_list[i])
    MergeFonts(zcolon_list[i])
    # Widen Zenkaku slash, back-slash and vertical bar
    Select(0uff0f); Move(20, 0); Scale(200, 100, 500, 0)
    Select(0u002f); Move(210, 0); Scale(115, 115, 500, 315); Rotate(-14, 500, 315)
    Copy(); Select(0uff0f); PasteInto(); OverlapIntersect(); SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    Select(0uff3c); Move(-10, 0); Scale(200, 100, 500, 0)
    Select(0u005c); Move(180, 0); Scale(115, 115, 500, 315); Rotate(14, 500, 315)
    Copy(); Select(0uff3c); PasteInto(); OverlapIntersect(); SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    Select(0uff5c); Scale(115, 100, 500, 0); SetWidth(1240)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Clear other glyphs
    Select(0uff01, 0uff5e); SelectInvert(); Clear()
    # Clear instructions
    SelectWorthOutputting()
    ClearInstrs()
    # Save
    Save("${tmpdir}/" + output_list[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate script for modified HackGen
########################################

cat > ${tmpdir}/${modified_hackgen_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_hackgen_regular}"]
output_list = ["${modified_hackgen_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # Adjust
    SelectWorthOutputting();
    Scale(107.05, 107.05, 0, 0); # Scale(93, 100);
    # Move(100, 0); # Move(-30, 0);
    SetWidth(110, 2)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Clear instructions
    SelectWorthOutputting()
    ClearInstrs()
    # Save
    Save("${tmpdir}/" + output_list[i])
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate script for 0xProGen
########################################

cat > ${tmpdir}/${progen_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

# Set parameters
proto_list        = ["${tmpdir}/${modified_proto_regular}"]
zenkaku_list      = ["${tmpdir}/${zenkaku_proto_regular}"]
hackgen_list      = ["${tmpdir}/${modified_hackgen_regular}"]
fontfamily        = "${PROGEN_FAMILYNAME}"
fontfamilysuffix  = ""
fontstyle_list    = ["Regular"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "Copyright (c) 2023 0xType\n" \\
                  + "Copyright (c) 2019 Yuko OTAWARA\n" \\
                  + "Copyright (c) 2018 Source Foundry Authors\n" \\
                  + "Copyright (c) 2015 JIKASEI FONT KOUBOU"
version           = "${PROGEN_VERSION}"

i = 0
while (i < SizeOf(fontstyle_list))
    # Open new file
    New()
    # Set encoding to Unicode-bmp
    Reencode("unicode")
    # Set configuration
    SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                 fontfamily, \\
                 fontfamily + " " + fontstyle_list[i], \\
                 fontstyle_list[i], \\
                 copyright, version)
    SetTTFName(0x409, 2, fontstyle_list[i])
    SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
    ScaleToEm(800, 200)
    SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
    SetOS2Value("Width",                   5) # Medium
    SetOS2Value("FSType",                  0)
    SetOS2Value("VendorID",           "PfEd")
    SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
    SetOS2Value("WinAscentIsOffset",       0)
    SetOS2Value("WinDescentIsOffset",      0)
    SetOS2Value("TypoAscentIsOffset",      0)
    SetOS2Value("TypoDescentIsOffset",     0)
    SetOS2Value("HHeadAscentIsOffset",     0)
    SetOS2Value("HHeadDescentIsOffset",    0)
    SetOS2Value("WinAscent",             900)
    SetOS2Value("WinDescent",            200)
    SetOS2Value("TypoAscent",            850)
    SetOS2Value("TypoDescent",          -200)
    SetOS2Value("TypoLineGap",            50)
    SetOS2Value("HHeadAscent",           900)
    SetOS2Value("HHeadDescent",         -200)
    SetOS2Value("HHeadLineGap",            0)
    SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])
    # Merge
    MergeFonts(proto_list[i])
    MergeFonts(zenkaku_list[i])
    MergeFonts(hackgen_list[i])
    # Edit Zenkaku Space (dotted circle)
    # Select(0u25cc); Copy(); Select(0u3000); Paste()
    # # Edit en dash
    # Select(0u2013); Copy()
    # PasteWithOffset(264, 0); PasteWithOffset(-264, 0)
    # OverlapIntersect(); SetWidth(1240)
    # RoundToInt(); RemoveOverlap(); RoundToInt()
    # # Edit em dash
    # Select(0u2014); Copy()
    # PasteWithOffset(410, 0); PasteWithOffset(-410, 0)
    # OverlapIntersect(); SetWidth(1240)
    # RoundToInt(); RemoveOverlap(); RoundToInt()
    # # Edit Zenkaku hyphen
    # Select(0uff0d); Copy(); Select(0u2010); Paste(); SetWidth(1240)
    # RoundToInt(); RemoveOverlap(); RoundToInt()
    # # Edit katakana small "he"
    # Select(0u30d8); Copy(); Select(0u31f8); Paste()
    # Scale(79, 79, 450, 356); Move(0, -80); SetWidth(1240)
    # RoundToInt(); RemoveOverlap(); RoundToInt()
    # Proccess before saving
    Select(".notdef")
    DetachAndRemoveGlyphs()
    SelectWorthOutputting()
    RoundToInt(); RemoveOverlap(); RoundToInt()
    AutoHint()
    AutoInstr()
    # Save
    Generate(fontfamily + "-" + fontstyle_list[i] + ".ttf", "", 0x84)
    Close()
    i += 1
endloop
Quit()
_EOT_

########################################
# Generate 0xProGen
########################################

# echo "Generate Comma HackGen"
# ${FONTFORGE_COMMAND} -script ${tmpdir}/${comma_hackgen_generator} \
#     2> ${redirection_stderr} || exit 4
# echo "Generate Period HackGen"
# ${FONTFORGE_COMMAND} -script ${tmpdir}/${period_hackgen_generator} \
#     2> ${redirection_stderr} || exit 4
# echo "Generate Colon HackGen"
# ${FONTFORGE_COMMAND} -script ${tmpdir}/${colon_hackgen_generator} \
#     2> ${redirection_stderr} || exit 4
echo "Generate Modified 0xProto"
${FONTFORGE_COMMAND} -script ${tmpdir}/${modified_proto_generator} \
    2> ${redirection_stderr} || exit 4
echo "Generate Zenkaku Comma HackGen"
${FONTFORGE_COMMAND} -script ${tmpdir}/${zenkaku_comma_generator} \
    2> ${redirection_stderr} || exit 4
echo "Generate Zenkaku Period HackGen"
${FONTFORGE_COMMAND} -script ${tmpdir}/${zenkaku_period_generator} \
    2> ${redirection_stderr} || exit 4
echo "Generate Zenkaku Colon HackGen"
${FONTFORGE_COMMAND} -script ${tmpdir}/${zenkaku_colon_generator} \
    2> ${redirection_stderr} || exit 4
echo "Generate Zenkaku 0xProto"
${FONTFORGE_COMMAND} -script ${tmpdir}/${zenkaku_proto_generator} \
    2> ${redirection_stderr} || exit 4
echo "Generate Modified HackGen"
${FONTFORGE_COMMAND} -script ${tmpdir}/${modified_hackgen_generator} \
    2> ${redirection_stderr} || exit 4
echo "Generate 0xProGen"
${FONTFORGE_COMMAND} -script ${tmpdir}/${progen_generator} \
    2> ${redirection_stderr} || exit 4

# Remove temporary directory
if [ "${leaving_tmp_flag}" = "false" ]
then
    echo "Remove temporary files"
    rm -rf $tmpdir
fi

# Exit
echo "Succeeded in generating 0xProGen"
exit 0

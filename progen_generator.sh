#!/bin/sh

PROGEN_VERSION="0.1.0"
PROGEN_FAMILYNAME="0xProGen"

FONTFORGE_COMMAND="/usr/bin/fontforge"

leaving_tmp_flag="false"

redirection_stderr="/dev/null"
input_proto_regular="0xProto-Regular.ttf"
modified_proto_regular="Modified-0xProto-Regular.sfd"
modified_proto_generator="modified_proto_generator.pe"
zenkaku_proto_regular="Zenkaku-0xProto-Regular.sfd"
zenkaku_proto_generator="zenkaku_proto_generator.pe"
input_hackgen_regular="HackGen-Regular.ttf"
comma_hackgen_regular="Comma-HackGen-Regular.sfd"
period_hackgen_regular="Period-HackGen-Regular.sfd"
colon_hackgen_regular="Colon-HackGen-Regular.sdf"
modified_hackgen_regular="Modified-HackGen-Regular.sfd"
modified_hackgen_generator="modified_hackgen_generator.pe"
progen_generator="progu_generator.pe"

# Check fontforge existance
if ! which ${FONTFORGE_COMMAND} > /dev/null 2>&1
then
    echo "Error: ${FONTFORGE_COMMAND} command not found" >&2
    exit 1
fi

# Make temporary directory
if [ -w "/tmp" -a "${leaving_tmp_flag}" = "false" ]
then
    tmpdir=`mktemp -d /tmp/progu_generator.XXXXXX` || exit 2
else
    tmpdir=`mktemp -d ./tmpdir_progu_generator.XXXXXX`    || exit 2
fi

# Remove temporary directory by trapping
if [ "${leaving_tmp_flag}" = "false" ]
then
    trap "if [ -d \"$tmpdir\" ]; then echo 'Remove temporary files'; rm -rf $tmpdir; echo 'Abnormally terminated'; fi; exit 3" HUP INT QUIT
    trap "if [ -d \"$tmpdir\" ]; then echo 'Remove temporary files'; rm -rf $tmpdir; echo 'Abnormally terminated'; fi" EXIT
else
    trap "echo 'Abnormally terminated'; exit 3" HUP INT QUIT
fi

########################################
# Generate script for modified 0xProto
########################################

cat > ${tmpdir}/${modified_proto_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_proto_regular}"]
output_list = ["${modified_proto_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
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
    Select(0u2500, 0u254b); Clear()
    Select(0u2550, 0u2573); Clear()
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
    # Narrow all the width
    SelectWorthOutputting()
    Scale(87, 100); Move(-40, 0); SetWidth(540)
    RoundToInt(); RemoveOverlap(); RoundToInt()
    # Remove zenkaku basic symbols
    Select(0uff01, 0uff5e); Clear();
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
# Generate script for zenkaku 0xProto
########################################

cat > ${tmpdir}/${zenkaku_proto_generator} << _EOT_
#!${FONTFORGE_COMMAND} -script

input_list = ["${input_proto_regular}"]
output_list = ["${zenkaku_proto_regular}"]
i = 0
while (i < SizeOf(input_list))
    # Open
    Open(input_list[i])
    SelectWorthOutputting()
    UnlinkReference()
    ScaleToEm(800, 200)
    # Copy and Paste
    Select(0u0021, 0u007e); SelectInvert(); Clear()
    Select(0u0021, 0u007e); Copy(); Select(0uff01, 0uff5e); Paste()
    Move(230, 0); SetWidth(1080)
    Select(0u0021, 0u007e); Clear()
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
    # Move right and widen
    SelectWorthOutputting()
    Move(6, 0); SetWidth(1080)
    # Remove Zenkaku basic symbols
    Select(0uff01, 0uff5e); Clear();
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
hackgen_list      = ["${tmpdir}/${modified_hackgen_regular}"]
zenkaku_list      = ["${tmpdir}/${zenkaku_proto_regular}"]
fontfamily        = "${PROGEN_FAMILYNAME}"
fontfamilysuffix  = ""
fontstyle_list    = ["Regular"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "Copyright (c) 2023 0xType\n" \\
                  + "Copyright (c) 2019 Yuko OTAWARA\n" \\
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
    SetOS2Value("WinAscent",             850)
    SetOS2Value("WinDescent",            150)
    SetOS2Value("TypoAscent",            850)
    SetOS2Value("TypoDescent",          -150)
    SetOS2Value("TypoLineGap",             0)
    SetOS2Value("HHeadAscent",           850)
    SetOS2Value("HHeadDescent",         -150)
    SetOS2Value("HHeadLineGap",            0)
    SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])
    # Merge
    MergeFonts(proto_list[i])
    MergeFonts(hackgen_list[i])
    MergeFonts(zenkaku_list[i])
    # Edit zenkaku space
    # - dotted circle
    # Select(0u25cc); Copy(); Select(0u3000); Paste()
    # Edit en dash
    Select(0u2013); Copy()
    PasteWithOffset(290, 0); PasteWithOffset(-290, 0)
    OverlapIntersect(); SetWidth(1080)
    # Edit em dash
    Select(0u2014); Copy()
    PasteWithOffset(450, 0); PasteWithOffset(-450, 0)
    OverlapIntersect(); SetWidth(1080)
    # Edit zenkaku hyphen
    Select(0uff0d); Copy(); Select(0u2010); Paste(); SetWidth(1080)
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
# Generate 0xProGu
########################################

echo "Generate Modified 0xProto"
${FONTFORGE_COMMAND} -script ${tmpdir}/${modified_proto_generator} \
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

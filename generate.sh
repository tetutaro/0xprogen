#!/usr/bin/env bash
set -eu

FONTFORGE_PYTHON="/bin/python3"
FONTS_DIR="fonts"
PROTO_VERSION="1.601"
HACKGEN_VERSION="2.9.0"

## download and extract 0xProto
PROTO_VERSION_U=${PROTO_VERSION//./_}
wget -O 0xProto_${PROTO_VERSION_U}.zip https://github.com/0xType/0xProto/releases/download/${PROTO_VERSION}/0xProto_${PROTO_VERSION_U}.zip
unzip -d 0xProto 0xProto_${PROTO_VERSION_U}.zip
mv -f 0xProto/fonts/0xProto-Regular.ttf .
rm -rf 0xProto
rm -f 0xProto_${PROTO_VERSION_U}.zip

## download and extract HackGen
wget -O HackGen_v${HACKGEN_VERSION}.zip https://github.com/yuru7/HackGen/releases/download/v${HACKGEN_VERSION}/HackGen_v${HACKGEN_VERSION}.zip
unzip -d HackGen HackGen_v${HACKGEN_VERSION}.zip
mv -f HackGen/HackGen_v${HACKGEN_VERSION}/HackGen-Regular.ttf .
rm -rf HackGen
rm -f HackGen_v${HACKGEN_VERSION}.zip

## create fonts directory
if [ -d ${FONTS_DIR} ]; then
    rm -rf ${FONTS_DIR}
fi
mkdir ${FONTS_DIR}

# generate 0xProGen
./progen_generator.sh

## delete original fonts
rm -f 0xProto-*.ttf
rm -f HackGen-*.ttf

## rename TTYname of 0xProGen
for progen in 0xProGen*.ttf; do
    ${FONTFORGE_PYTHON} ./rename.py --outputdir ${FONTS_DIR} ${progen}
done

## patch Nerd Fonts to 0xProGen
if [ -d nerd-fonts ]; then
    for progen in 0xProGen*.ttf; do
        mv -f ${progen} nerd-fonts/.
        cd nerd-fonts
        ${FONTFORGE_PYTHON} ./font-patcher --complete --boxdrawing --adjust-line-height --progressbars ${progen}
        rm -f ${progen}
        cd ..
    done
    for progen in nerd-fonts/0xProGen*.ttf; do
        ${FONTFORGE_PYTHON} ./rename.py --outputdir ${FONTS_DIR} "${progen}"
        rm -f "${progen}"
    done
fi

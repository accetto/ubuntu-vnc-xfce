#!/bin/bash
### @accetto, September 2019

ubuntu=$("${STARTUPDIR}/version_of.sh" ubuntu)

case "$1" in
    -v)
        echo "Ubuntu $ubuntu"
        ;;
    -V)
        mousepad=$("${STARTUPDIR}/version_of.sh" mousepad)
        vim=$("${STARTUPDIR}/version_of.sh" vim)
        tigervnc=$("${STARTUPDIR}/version_of.sh" tigervnc)
        novnc=$("${STARTUPDIR}/version_of.sh" novnc)
        websockify=$("${STARTUPDIR}/version_of.sh" websockify)
        curl=$("${STARTUPDIR}/version_of.sh" curl)
        git=$("${STARTUPDIR}/version_of.sh" git)
        jq=$("${STARTUPDIR}/version_of.sh" jq)
        echo "Ubuntu $ubuntu"
        echo "Mousepad $mousepad"
        echo "VIM $vim"
        echo "TigerVNC $tigervnc"
        echo "noVNC $novnc"
        echo "websockify $websockify"
        echo "curl $curl"
        echo "Git $git"
        echo "jq $jq"
        ;;
    *)
        ### example: ubuntu18.04.3
        sticker="ubuntu$ubuntu"
        echo "$sticker"
        ;;
esac

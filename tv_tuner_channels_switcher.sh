#!/bin/bash
MY_DIR=`dirname $0`
source "$MY_DIR/channels_arrays.sh"

curStandard=""

while true
do
    echo "Введите номер канала"
    read channelNumber

    if [ "$channelNumber" == "exit" ]
    then
        killall -9 vlc
        exit 0
    fi

    freq=${chFreq[$channelNumber]}
    standard=${chStandard[$channelNumber]}
    name=${chName[$channelNumber]}

    if [ -z "$freq" ]
    then
        echo "Такой канал не определён"
    else
        echo "Переключение на канал №$channelNumber. Название: $name; Частота: $freq; стандарт: $standard"
        if [ "$curStandard" == "$standard" ]
        then
            ivtv-tune -f "$freq" >/dev/null 2>&1
        else
            killall -9 vlc >/dev/null 2>&1
            sleep 0.2 >/dev/null 2>&1
            v4l2-ctl -s "$standard" >/dev/null 2>&1
            ivtv-tune -f "$freq" >/dev/null 2>&1
            vlc -vvv pvr:// :pvr-device="/dev/video0" :pvr-radio-device="/dev/radio0" --deinterlace=1 >/dev/null 2>&1 &
        fi
        curStandard="$standard"
    fi
done

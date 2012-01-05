#!/bin/bash
MY_DIR=`dirname $0`
$MY_DIR/channels_arrays.sh

while true
do
    echo 'Надо ввести номер канала'
    read chanel
    case "$chanel" in
        11)
            freq="151.25"
            standard="pal-D"
            ;;
        56)
            freq="511.25"
            standard="secam-D"
            ;;
        "exit")
            killall -9 vlc
            exit 0
            ;;
        *)
            echo 'неправильный номер'
            ;;
    esac
    killall -9 vlc >/dev/null 2>&1
    # Delay
    sleep 0.2 >/dev/null 2>&1
    v4l2-ctl -s "$standard"; ivtv-tune -f "$freq"; vlc -vvv pvr:// :pvr-device="/dev/video0" :pvr-radio-device="/dev/radio0" --deinterlace=1 >/dev/null 2>&1 &
done

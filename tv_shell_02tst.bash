#!/bin/bash
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

6	111.25	PAL-D	мтв
7	119.25	PAL-D	муз
8	127.25	PAL-D	8-й
9	135.25	SECAM-D	культура
10	143.25	PAL-D	10-й
11	151.25	PAL-D	стс
12	159.25	PAL-D	рен
13	167.25	SECAM-D	россия1

15	183.25	SECAM-D	5-й питер
16			
17	199.25	SECAM-D	нтв
18	207.25	PAL-D	звезда
19			
20	223.25	SECAM-D	1-й
21	231.25	PAL-D	2х2
22	239.25	PAL-D	тнт
23	247.25	PAL-D	
24	255.25	SECAM-D	россия2
25	263.25	SECAM-D	100
26	271.25	PAL-D	
27	279.25	SECAM-D	тв3
28	287.25	PAL-D	
29	295.25	SECAM-D	
30	303.25	SECAM-D	

35	343.25	PAL-D	

38	367.25	PAL-D	твой петерб
39	375.25	PAL-D	
40	383.25	SECAM-D	
41	391.25	PAL-D	совсек
42	399.25	SECAM-D	
43	407.25	SECAM-D	
44	415.25	SECAM-D	
45	423.25	SECAM-D	ру_мск

53	487.25	SECAM-D	53 историч
54	495.25	SECAM-D	54 тв1000

56	511.25	SECAM-D	евроспорт

58	527.25	SECAM-D	дискав

60	543.25	SECAM-D	авто

62	559.25	SECAM-D	анимал

72	639.25	SECAM-D	няня

74	655.25	SECAM-D	
75	663.25	PAL-D	75-й рен

77	679.25	SECAM-D	77-й росс 1
78	687.25	SECAM-D	78 вот

80	703.25	SECAM-D	

82	719.25	SECAM-D	82 твой тв

99	855.25	SECAM-D	99 росс 2

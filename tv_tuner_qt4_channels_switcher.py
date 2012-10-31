#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os, sys
import time
import functools

# sudo apt-get install pyqt4-dev-tools
from PyQt4.QtCore import *
from PyQt4.QtGui import *

# Информацию о каналах бёрем в gen_channels_arrays.py из CHANNELS_INFO
import gen_channels_arrays

BUTTONS_COUNT_IN_ROW = 9
BUTTON_WIDTH  = 100
BUTTON_HEIGHT = 90

selectedButton = None
curStandard = ""

class ClickableLabel(QLabel):
    def __init__(self, parent):
        super(QLabel, self).__init__(parent)
        self.setFrameStyle(QFrame.Box | QFrame.Sunken)

    def mousePressEvent(self, event):
        self.setStyleSheet("QLabel { background-color: yellow }")

    def setChannelInfo(self, ch):
        self.setText("""<center><span style='font-size:16pt; font-weight:bold; color:#aa0000;'>%s</span><br />
                                <span style='font-size:8pt; font-weight:normal; color:#000000;'>%s</span><br />
                                <span style='font-size:7pt; font-weight:normal; color:#000000;'>%s</span><br />
                                <span style='font-size:10pt; font-weight:normal; color:#000000;'>%s</span></center>""" % ch)

    def mouseReleaseEvent(self, event):
        self.emit(SIGNAL("clicked()"))

def buttonClicked(ch, button):
    global selectedButton
    global curStandard

    if curStandard == ch[2]:
        os.system("ivtv-tune -f \"%s\"" % ch[1])
        pass
    else:
        curStandard = ch[2]
        os.system("killall -9 vlc")
        time.sleep(2)
        os.system("v4l2-ctl -s \"%s\"" % ch[2])
        os.system("ivtv-tune -f \"%s\"" % ch[1])
        os.system("vlc -vvv pvr:// :pvr-device=\"/dev/video0\" :pvr-radio-device=\"/dev/radio0\" --deinterlace=1 >/dev/null 2>&1 &")

    if selectedButton != None:
        selectedButton.setStyleSheet("QLabel {}")

    selectedButton = button
    selectedButton.setStyleSheet("QLabel { background-color: #66FF00 }")

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = QWidget()
    window.setWindowTitle("TV Tuner Qt4 Channels Switcher")
    
    channelLister = gen_channels_arrays.ChannelLister()
    i = 0
    j = 0
    for ch in channelLister:
        ch[3] = ch[3].decode('utf-8')
        button = ClickableLabel(window)
        button.setChannelInfo(tuple(ch))
        button.resize(BUTTON_WIDTH, BUTTON_HEIGHT)
        button.move(i * BUTTON_WIDTH, j * BUTTON_HEIGHT)
        QObject.connect(button, SIGNAL("clicked()"), functools.partial(buttonClicked, ch, button))
        i += 1
        if i == BUTTONS_COUNT_IN_ROW:
            i = 0
            j += 1
    
    window.show()
    app.exec_()

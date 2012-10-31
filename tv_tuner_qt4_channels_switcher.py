#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

# sudo apt-get install pyqt4-dev-tools
from PyQt4.QtCore import *
from PyQt4.QtGui import *

# Информацию о каналах бёрем в gen_channels_arrays.py из CHANNELS_INFO
import gen_channels_arrays

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = QWidget()
    window.setWindowTitle("TV Tuner Qt4 Channels Switcher")
    #TODO: everything :)
    window.show()
    app.exec_()

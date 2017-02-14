# -*- coding: utf-8 -*-
import libebkvfd

vfd = libebkvfd.EbkVfd("192.168.21.151")
vfd.send(u"Hello world!")
vfd.send(u"äöüÄÖÜß")

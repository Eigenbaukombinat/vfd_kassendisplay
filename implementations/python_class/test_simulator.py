# -*- coding: utf-8 -*-
import libebkvfd

vfd = libebkvfd.EbkVfd("127.0.0.1",2323)
vfd.send(u"Hello world!")
vfd.send(u"äöüÄÖÜß")

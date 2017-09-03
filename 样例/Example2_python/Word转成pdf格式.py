#-*- coding:utf-8 -*-
# Requires Office 2007 SP2
# Requires python for win32 extension
#word转成pdf

import sys
import os
from win32com.client import Dispatch, constants, gencache


def doc2pdf(input, output):
    w = Dispatch("Word.Application")
    w.Visible = 1  # 1表示要顯示畫面，若為0則不顯示畫面。您可以隨時的更改此屬性
    try:
        doc = w.Documents.Open(input, ReadOnly=1)
        doc.ExportAsFixedFormat(output, constants.wdExportFormatPDF,
                                Item=constants.wdExportDocumentWithMarkup, CreateBookmarks=constants.wdExportCreateHeadingBookmarks)
        return 0
    except:
        return 1
    finally:
        w.Quit(constants.wdDoNotSaveChanges)


def main():
    input = 'C:\\Users\\abc\\Desktop\\python_learn-master\\未上传文件\\FusionSphere.docx'  # word文档的名称
    output = 'C:\\Users\\abc\\Desktop\\python_learn-master\\未上传文件\\FusionSphere.pdf'  # pdf文档的名称
    try:
        rc = doc2pdf(input, output)
        return rc
    except:
        return -1

if __name__ == '__main__':
    print("hello")
    rc = main()
    if rc:
        sys.exit(rc)
    sys.exit(0)

		gzip压缩
			import gzip
			f_in = open('file.log', 'rb')
			f_out = gzip.open('file.log.gz', 'wb')
			f_out.writelines(f_in)
			f_out.close()
			f_in.close()
		gzip压缩1
			File = 'xuesong_18.log'
			g = gzip.GzipFile(filename="", mode='wb', compresslevel=9, fileobj=open((r'%s.gz' %File),'wb'))
			g.write(open(r'%s' %File).read())
			g.close()
		gzip解压
			g = gzip.GzipFile(mode='rb', fileobj=open((r'xuesong_18.log.gz'),'rb'))
			open((r'xuesong_18.log'),'wb').write(g.read())
		压缩tar.gz
			import os
			import tarfile
			tar = tarfile.open("/tmp/tartest.tar.gz","w:gz")   # 创建压缩包名
			for path,dir,files in os.walk("/tmp/tartest"):     # 递归文件目录
				for file in files:
					fullpath = os.path.join(path,file)
					tar.add(fullpath)                          # 创建压缩包
			tar.close()
		解压tar.gz
			
			import tarfile
			tar = tarfile.open("/tmp/tartest.tar.gz")
			#tar.extract("/tmp")                           # 全部解压到指定路径
			names = tar.getnames()                         # 包内文件名
			for name in names:
				tar.extract(name,path="./")                # 解压指定文件
			tar.close()
		zip压缩
			import zipfile,os
			f = zipfile.ZipFile('filename.zip', 'w' ,zipfile.ZIP_DEFLATED)    # ZIP_STORE 为默认表不压缩. ZIP_DEFLATED 表压缩
			#f.write('file1.txt')                              # 将文件写入压缩包
			for path,dir,files in os.walk("tartest"):          # 递归压缩目录
				for file in files:
					f.write(os.path.join(path,file))           # 将文件逐个写入压缩包         
			f.close()
		zip解压
			if zipfile.is_zipfile('filename.zip'):        # 判断一个文件是不是zip文件
				f = zipfile.ZipFile('filename.zip')
				for file in f.namelist():                 # 返回文件列表
					f.extract(file, r'/tmp/')             # 解压指定文件
				#f.extractall()                           # 解压全部
				f.close()

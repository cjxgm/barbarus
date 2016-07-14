
import barbarus.private.manager
import macros

var global_manager: Manager

template set_language*(T: typedesc, dir = default_translation_dir) =
    global_manager = init_manager(T, dir)

macro `~`*(id: untyped, args: varargs[expr]): expr =
    result = new_call(
        bind_sym("translate"),
        bind_sym("global_manager"),
        new_lit($id.ident)
    )
    for arg in args:
        result.add arg


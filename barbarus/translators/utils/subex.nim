import subexes
import "../../translator"
import strutils

type Subex_translator* = ref object of Translator

proc new_translator*(T: typedesc[Subex_translator]): T = new result

method translate*(self: var Subex_translator, text: string, args: varargs[string, `$`]): string =
    try:
        text.subex.format(args)
    except Subex_error:
        "<[INVALID: ($#) $#]>" % [text, get_current_exception_msg()]


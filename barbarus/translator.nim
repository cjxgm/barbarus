
## Translator
## ----------
##
## Translator handles quirks of each language.
##

type Translator* = ref object of Root_obj

method translate*(
    self: var Translator,
    text: string,
    args: varargs[string, `$`]): string {.base.} = discard


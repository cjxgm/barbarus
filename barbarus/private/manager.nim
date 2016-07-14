
## Manager
## -------
##
## Manager tries to load translation files, and dispatch it to translator

import parsecfg
import "../translator"
from typetraits as tt import nil
from os import `/`, add_file_ext

type Manager* = object
    name*: string
    translator: Translator
    translation: Config

proc init_manager(translator: Translator, name: string, path: string): Manager =
    Manager(name: name, translator: translator, translation: path.load_config)

proc is_nil*(manager: var Manager): bool =
    manager.translator.is_nil or manager.translation.is_nil

proc translate*(manager: var Manager, id: string, args: varargs[string, `$`]): string =
    when not defined(release):
        if manager.is_nil:
            raise Access_violation_error.new_exception "You should call set_language before using any other functions of barbarus."
    let text = manager.translation.get_section_value(manager.name, id)
    if text.is_nil or text == "": return "<INVALID [" & id & "]>"
    manager.translator.translate(text, args)

const default_translation_dir* = "." / "translations"

template init_manager*(T: typedesc, dir = default_translation_dir): Manager =
    const name = tt.name(T)
    const path = dir / os.add_file_ext(name, ".ini")
    let translator = new_translator(T)
    init_manager(translator, name, path)

when is_main_module:
    import "../translators/english"
    var man = init_manager(en_US)
    echo man.translate("GREET", 3, 2)


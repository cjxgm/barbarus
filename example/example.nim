import "../barbarus"
import "../barbarus/translators/english"
import "../barbarus/translators/chinese"

proc test =
    echo ~YES
    echo `~`(GREET, 0, 3)
    echo `~`(GREET, 1, 0)
    echo `~`(GREET, 2, 6)
    echo `~`(GREET, 3, 4)
    echo ~GREET
    echo `~`(YES, 1, 3)

set_language en_US
test()
set_language zh_CN
test()


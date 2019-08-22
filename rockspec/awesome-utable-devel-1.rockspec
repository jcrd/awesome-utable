package = "awesome-utable"
version = "devel-1"
source = {
    url = "git://github.com/jcrd/awesome-utable",
    tag = "master",
}
description = {
    summary = "AwesomeWM library of table manipulation functions",
    homepage = "https://github.com/jcrd/awesome-utable",
    license = "GPL-3.0",
}
dependencies = {
    "lua >= 5.1",
}
build = {
    type = "builtin",
    modules = {
        ["awesome-utable"] = "init.lua",
    },
}

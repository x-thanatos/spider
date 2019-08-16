package = "lua-spider"
version = "0.0.0"
source = {
   url = "git+https://github.com/xbini/lua-spider.git"
}
description = {
   summary = "> Spider for searching my favorite game role",
   detailed = [[
> Spider for searching my favorite game role
]],
   homepage = "https://github.com/xbini/lua-spider",
   license = "MIT"
}

dependencies = {
   "lua >= 5.3, < 5.4",
   "htmlparser = 0.3.6-1",
   "luasocket = 3.0rc1-2"
}

build = {
   type = "builtin",
   modules = {}
}

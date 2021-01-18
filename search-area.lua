-- 搜索所有服务器id

package.path = package.path .. ";./src/modules/?.lua"

local http = require("socket.http")
local htmlparser = require("htmlparser")
local constants_module = require("constants")
local load_html_module = require("load-html")
local resolver_module = require("resolver")

local START_URL = constants_module.GOOD_LIST_SELLING_URL
local OUTPUT_AREAS_FILENAME = string.format(constants_module.OUTPUT_AREAS_FILENAME, os.time())

local load_html_string = load_html_module.load_html_string
local resolve_areas = resolver_module.resolve_areas

function start(url)
    local areas = resolve_areas(load_html_string(url))
    local file = io.open(OUTPUT_AREAS_FILENAME, "a+")
    file:write(areas)
    file:close()
end

function launch(mode)
    start(START_URL)
end

launch()

package.path = package.path .. ";./src/modules/?.lua"

local htmlparser = require("htmlparser")
local constants_module = require("constants")
local load_html_module = require("load-html")
local resolver_module = require("resolver")

local START_URL = constants_module.GOOD_LIST_SELLING_URL
local OUTPUT_ROLE_FILENAME = string.format(constants_module.OUTPUT_ROLE_FILENAME, os.time())

local load_html_string = load_html_module.load_html_string
local load_html_root = load_html_module.load_html_root
local resolve_good_urls = resolver_module.resolve_good_urls
local resolve_good_list_url = resolver_module.resolve_good_list_url
local resolve_role = resolver_module.resolve_role

local page = 1
local max_page = 1000
local result_count = 0

function start(url)
    local good_urls = resolve_good_urls(load_html_root(url))
    local count = #good_urls
    for index, value in pairs(good_urls) do
        local html_role_string = load_html_string(value)
        local html_role_element = htmlparser.parse(html_role_string)
        local matched, role_string = resolve_role(value, html_role_string, html_role_element)
        if matched then
            result_count = result_count + 1
            local out_string = role_string
            print(out_string)
            local file = io.open(OUTPUT_ROLE_FILENAME, "a+")
            file:write(out_string)
            file:close()
        end
        if count == index and page < max_page then
            local query_param = {}
            page = page + 1
            query_param.page = page
            local url = resolve_good_list_url(query_param)
            start(url)
        end
    end
end
-- mode 0: 从第一页开始加载，直到手动结束进程
-- mode 1: TODO
function launch(mode)
    if (mode == 0) then
        start(START_URL)
    end
end

launch(0)

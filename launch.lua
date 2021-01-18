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
local resolve_list_url = resolver_module.resolve_list_url
local resolve_role = resolver_module.resolve_role
local resolve_max_page = resolver_module.resolve_max_page

local result_count = 0

function analyze(url, start_page, end_page)
    local query_param = {}
    query_param.page = start_page
    local t_url = resolve_list_url(url, query_param)
    local good_urls = resolve_good_urls(load_html_root(t_url))
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
        if count == index and start_page < end_page then
            start(url, query_param.page + 1, end_page)
        end
    end
end

function launch()
    local size = 5
    local html_element = load_html_root(START_URL)
    local max_page = resolve_max_page(html_element)
    local pool = {}
    for i = 1, max_page, size do
        local start_page = i
        local end_page = start_page + size
        if end_page + size > max_page then
            analyze(START_URL, start_page, max_page)
        else
            analyze(START_URL, start_page, end_page)
        end
    end
end

launch()

local http = require("socket.http")
local htmlparser = require("htmlparser")

htmlparser_looplimit = 200000

-- 商品列表id
local GOOD_LIST_ID = "#J_good_list"
local START_URL = "http://tl.cyg.changyou.com/"

local function load_root(url)
    local result = http.request(url)
    return htmlparser.parse(result)
end

local function load_good_urls(root)
    local good_list = root:select(GOOD_LIST_ID)
    local good_urls = {}
    for index, e in ipairs(good_list) do
        for index_of_a, a in ipairs(e:select("li a")) do
            local url = a.attributes.href
            good_urls[index_of_a] = url
        end
    end
    return good_urls
end

local good_urls = load_good_urls(load_root(START_URL))
for index, value in pairs(good_urls) do
    print(index, value)
end

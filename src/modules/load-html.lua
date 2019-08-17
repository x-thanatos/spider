local http = require("socket.http")
local htmlparser = require("htmlparser")

htmlparser_looplimit = 200000

local module = {}

function module.load_html_string(url)
    print("加载页面: " .. url)
    local result_string = http.request(url)
    print("加载完毕！")
    return result_string
end

function module.load_html_root(url)
    local result_string = module.load_html_string(url)
    return htmlparser.parse(result_string)
end

return module

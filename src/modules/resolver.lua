local constants_module = require("constants")
local target_setting_module = require("target-setting")

local module = {}

-- 过滤有效属性
module.effective_properties = {}
for k, v in pairs(target_setting_module) do
    if type(v) == "number" and v > 0 then
        module.effective_properties[k] = v
    end
end

function module.resolve_good_urls(root)
    local good_list_element = root:select(constants_module.GOOD_LIST_ID)
    local good_urls = {}
    for index, e in ipairs(good_list_element) do
        for index_of_a, a in ipairs(e:select("li .item-img a")) do
            local url = a.attributes.href
            good_urls[index_of_a] = url
        end
    end
    return good_urls
end

function module.resolve_areas(html_string)
    local areas = string.match(html_string, "<script>var SERVER_INFO = (.*);</script>")
    areas = string.gsub(areas, "name", '"name"')
    areas = string.gsub(areas, "id", '"id"')
    areas = string.gsub(areas, "server", '"server"')
    return '{"areas":' .. areas .. "}"
end

function module.resolve_good_list_url(query_params)
    local url = constants_module.GOOD_LIST_SELLING_URL
    if query_params.page then
        url = url .. "&page_num=" .. query_params.page
    end
    return url
end

function resolve_attribute(attribute, html_string)
end

function module.resolve_role(url, html_string, html_element)
    local role_string = ""
    local exist = false
    -- print(html_string)
    local ele = html_element:select("#bing model c-o-l p")
    for i, v in ipairs(ele) do
        print(i, v)
    end
    for k, v in pairs(module.effective_properties) do
        -- print(k, v)
    end
    if string.find(html_string, "月白龙马") then
        exist = true
        role_string = "" .. "符合条件：" .. url .. "\n"
    end
    return exist, role_string
end

return module

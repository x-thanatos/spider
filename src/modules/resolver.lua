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

function resolve_attributes(attributes, html_string, html_element)
    local attributes_values = {}
    for attr_name, attr in pairs(constants_module.ATTACH_MAP) do
        -- print(attr_name, attr.id)
        local p_elements = html_element:select(attr.id .. " .model .c-o-l p")
        print(p_elements[1]:getcontent())
        local attach = string.match(p_elements[1]:getcontent(), attr.zh_name .. "攻击 (.*)")
        local denfense = string.match(p_elements[2]:getcontent(), attr.zh_name .. "攻击 (.*)")
        local denfense = string.match(p_elements[2]:getcontent(), attr.zh_name .. "攻击 (.*)")
        local denfense = string.match(p_elements[2]:getcontent(), attr.zh_name .. "攻击 (.*)")
        print(attach)
        print(p_elements[2]:getcontent())
        print(p_elements[3]:getcontent())
        print(p_elements[4]:getcontent())
        -- for i, p_element in ipairs(p_elements) do
        --     local attach = string.match(p_element:gettext(), "<p>" .. attr.zh_name .. "攻击 +(.*)</p>")
        --     -- print(p_element:gettext())
        --     print(attach)
        -- end
    end

    for name, value in pairs(attributes) do
        if string.find(name, "") then
        -- body
        end
    end
end

function module.resolve_role(url, html_string, html_element)
    local role_string = ""
    local exist = false
    -- print(html_string)
    resolve_attributes(module.effective_properties, html_string, html_element)
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

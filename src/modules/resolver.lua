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
    local current_attributes_values = {}
    for attr_name, attr in pairs(constants_module.ATTACK_MAP) do
        local p_elements = html_element:select(attr.id .. " .model .c-o-l p")
        local attack = string.match(p_elements[1]:getcontent(), attr.zh_name .. "攻击 %+(%d*)")
        local denfense = string.match(p_elements[2]:getcontent(), attr.zh_name .. "抗 %+(%d*)")
        local ignore_denfense = string.match(p_elements[3]:getcontent(), "减" .. attr.zh_name .. "抗 %+(%d*)")
        local ignore_denfense_limit = string.match(p_elements[4]:getcontent(), "减" .. attr.zh_name .. "抗下限 %+(%d*)")
        current_attributes_values[attr.attack_key] = attack + 0
        current_attributes_values[attr.denfence_key] = denfense + 0
        current_attributes_values[attr.ignore_denfense_key] = ignore_denfense + 0
        current_attributes_values[attr.ignore_denfense_limit_key] = ignore_denfense_limit + 0
    end
    for key, v in pairs(attributes) do
        local current_value = current_attributes_values[key]
        if current_value < v then
            return false
        end
    end

    return true
end

function module.resolve_role(url, html_string, html_element)
    local role_string = ""
    local matched = resolve_attributes(module.effective_properties, html_string, html_element)
    if matched then
        role_string = "" .. "符合条件：" .. url .. "\n"
    end
    return matched, role_string
end

return module

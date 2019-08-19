local constants = require("constants")

local module = {}

function module.resolve_good_urls(root)
    local good_list_element = root:select(constants.GOOD_LIST_ID)
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
    areas = string.gsub(areas, "%s", "")
    areas = string.gsub(areas, "name", '"name"')
    areas = string.gsub(areas, "id", '"id"')
    areas = string.gsub(areas, "server", '"server"')
    return '{"areas":' .. areas .. "}"
end

function module.resolve_good_list_url(query_params)
    local url = constants.GOOD_LIST_SELLING_URL
    if query_params.page then
        url = url .. "&page_num=" .. query_params.page
    end
    return url
end

function module.resolve_role(url, html_string, html_element)
    local role_string = ""
    local exist = false
    if string.find(html_string, "月白龙马") then
        exist = true
        role_string = "" .. "该角色拥有月白龙马：" .. url .. "\n"
    end
    return exist, role_string
end

return module

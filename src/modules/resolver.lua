local constants = require("constants")

local module = {}

function module.resolve_good_urls(root)
    local good_list = root:select(constants.GOOD_LIST_ID)
    local good_urls = {}
    for index, e in ipairs(good_list) do
        for index_of_a, a in ipairs(e:select("li .item-img a")) do
            local url = a.attributes.href
            good_urls[index_of_a] = url
        end
    end
    return good_urls
end

function module.resolve_good_list_url(query_params)
    local url = constants.GOOD_LIST_SELLING_URL
    if query_params.page then
        url = url .. "&page_num=" .. query_params.page
    end
    return url
end

return module

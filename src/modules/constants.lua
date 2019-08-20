local url = require("target-setting").start_url

local module = {}

-- 商品列表id
module.GOOD_LIST_ID = "#J_good_list"
-- 交易区
module.GOOD_LIST_SELLING_URL = url
-- 公示区
module.GOOD_LIST_PUBLIC_URL = "http://tl.cyg.changyou.com/goods/public?time=1"

-- 角色属性模板
module.ATTACH_MAP = {
    ice = {
        id = "#bing",
        zh_name = "冰",
        attch_key = "ice_attach",
        denfence_key = "ice_defense",
        ignore_denfense_key = "ice_ignore_denfense",
        ignore_denfense_limit_key = "ice_ignore_denfense_limit"
    },
    fire = {
        id = "#huo",
        zh_name = "火",
        attch_key = "fire_attach",
        denfence_key = "fire_defense",
        ignore_denfense_key = "fire_ignore_denfense",
        ignore_denfense_limit_key = "fire_ignore_denfense_limit"
    },
    poison = {
        id = "#du",
        zh_name = "毒",
        attch_key = "poison_attach",
        denfence_key = "poison_defense",
        ignore_denfense_key = "poison_ignore_denfense",
        ignore_denfense_limit_key = "poison_ignore_denfense_limit"
    },
    thunder = {
        id = "#xuan",
        zh_name = "玄",
        attch_key = "thunder_attach",
        denfence_key = "thunder_defense",
        ignore_denfense_key = "thunder_ignore_denfense",
        ignore_denfense_limit_key = "thunder_ignore_denfense_limit"
    }
}

-- 符合条件的角色输出目录
module.OUTPUT_ROLE_FILENAME = "role-result-%d.txt"

-- 所有服务器信息输出
module.OUTPUT_AREAS_FILENAME = "areas-%d.json"

return module

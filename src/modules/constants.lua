local url = require("target-setting").start_url

local module = {}

-- 商品列表id
module.GOOD_LIST_ID = "#J_good_list"
-- 交易区
module.GOOD_LIST_SELLING_URL = url
-- 公示区
module.GOOD_LIST_PUBLIC_URL = "http://tl.cyg.changyou.com/goods/public?time=1"

-- 符合条件的角色输出目录
module.OUTPUT_ROLE_FILENAME = "role-result-%d.txt"

-- 所有服务器信息输出
module.OUTPUT_AREAS_FILENAME = "areas-%d.json"

return module

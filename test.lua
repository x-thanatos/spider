local extend_path = ";./src/modules/?.lua"
package.path = package.path .. extend_path

local htmlparser = require("htmlparser")
local load_html_module = require("load-html")
local resolver_module = require("resolver")

local load_html_string = load_html_module.load_html_string
local resolve_role = resolver_module.resolve_role

local url = "http://tl.cyg.changyou.com/goods/char_detail?serial_num=201907301448574031"
local html_role_string = load_html_string(url)
local html_role_element = htmlparser.parse(html_role_string)
local exist, role_string = resolve_role(ulr, html_role_string, html_role_element)

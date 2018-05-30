local template = require "resty.template"
local cjson = require "cjson"

ngx.say(template.render("silverkey.yml.tmpl", { version = "Hello, World!" }))


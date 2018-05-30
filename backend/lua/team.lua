local template = require "resty.template"
template.render("template/silverkey.yml.tmpl", { version = "Hello, World!" })

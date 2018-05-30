local template = require "resty.template"
local cjson = require "cjson"

local manifest_tmpl = template.compile("silverkey.yml.tmpl")

local manifest = manifest_tmpl {
  etcd = {
    version = "3.0.17"
  }
}

local cmd = { "/usr/local/bin/kubectl", "--kubeconfig", "/tmp/kubeconfig", "-n", "silverkey", "apply", "-f", "-" }
local prog = require 'resty.exec'.new(os.getenv("SOCKEXEC_SOCKET"))

local res, err = prog( {
     argv = cmd,
     stdin = manifest,
} )

if (err) then
     ngx.say(err)
  else
     ngx.say(res.stdout)
end

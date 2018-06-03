local K8S = {}

function K8S:dump_kubeconfig()
  local kubeconfig = K8S:dbKey("kubeconfig")
end

function K8S:dbNs() {
  return "/backend/" .. self.k8s
}

function K8S:dbKey(key) {
  return self.etcd:get(K8S:dbNs() .. "/" .. key)
}

function K8S:deploy()
  local template = require "resty.template"
  local cjson = require "cjson"
  local uuid = require 'resty.jit-uuid'

  local manifest_tmpl = template.compile("silverkey.yml.tmpl")

  local manifest = manifest_tmpl {
    etcd = {
      version = "3.0.17"
    },
    team = {
      uuid = uuid()
    }
  }

  local cmd = { "/usr/local/bin/kubectl", "--kubeconfig", "/tmp/kubeconfig", "create", "-f", "-" }
  local prog = require 'resty.exec'.new(os.getenv("SOCKEXEC_SOCKET"))

  local res, err = prog(
    {
     argv = cmd,
     stdin = manifest,
    }
  )

  if (err) then
     ngx.say(err)
  else
     ngx.say(res.stdout)
  end
end

function K8S:new(k8s_name)
  local self = {}
  setmetatable(self, { __index = K8S })
  self.uuid = uuid
  self.k8s = k8s_name
  self.etcd = require('etcdsk'):new(os.getenv('DB_HOST'))
  return self
end

return K8S

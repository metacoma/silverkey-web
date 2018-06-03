local K8S = {}

function K8S.new_backend()
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

function K8S:kubectl(cmd, stdin)
  local tmpfile = "/tmp/kubeconfig_" .. self.name
  local f = io.open(tmpfile, "w")
  f:write(self.env.kubeconfig)
  f:close()

  local cmd = { "/usr/local/bin/kubectl", "--kubeconfig", tmpfile, "get", "pods" }
  local prog = require 'resty.exec'.new(os.getenv("SOCKEXEC_SOCKET"))

  local res, err = prog(
    {
     argv = cmd,
     stdin = stdin,
    }
  )
  os.remove(tmpfile)

  if (err) then
    return nil, err
  else
    return res, nil
  end


end

function K8S:new(env_name)
  local self = {}
  local inspect = require('inspect')
  setmetatable(self, { __index = K8S })
  self.env, err = require('etcdsk'):new(os.getenv("DB_HOST")):ns2table("/backend/" .. env_name)
  self.name = env_name
  ngx.log(ngx.ERR, inspect(self.env))
  return self
end


return K8S

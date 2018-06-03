local K8S = {}

local function array_concat(...)
    local t = {}
    for n = 1,select("#",...) do
        local arg = select(n,...)
        if type(arg)=="table" then
            for _,v in ipairs(arg) do
                t[#t+1] = v
            end
        else
            t[#t+1] = arg
        end
    end
    return t
end

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

  cmd_arr = {}
  for word in cmd:gmatch("%S+") do table.insert(cmd_arr, word) end

  local cmd = array_concat({ "/usr/local/bin/kubectl", "--kubeconfig", tmpfile }, cmd_arr )
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

function K8S:deployBackend(backendId)
  local template = require "resty.template"
  local deployCmd = "create -f -"

  local manifest_tmpl = template.compile("silverkey.yml.tmpl")

  local manifest = manifest_tmpl {
    etcd = {
      version = "3.0.17"
    },
    uuid = backendId
  }


  return self:kubectl(deployCmd, manifest)
end

function K8S:destroyBackend(backendId)
  return self:kubectl("delete ns " .. backendId, nil)
end


function K8S:new(env_name)
  local self = {}
  local inspect = require('inspect')
  self.env, err = require('etcdsk'):new(os.getenv("DB_HOST")):ns2table("/backend/" .. env_name)
  self.name = env_name
  setmetatable(self, { __index = K8S })
  ngx.log(ngx.ERR, inspect(self))
  return self
end


return K8S

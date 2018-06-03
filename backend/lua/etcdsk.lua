local http = require "resty.http"
local encodeJSON = require('cjson.safe').encode
local decodeJSON = require('cjson.safe').decode


local EtcdSk = {}

local function basename(namespace)
  return string.gsub(namespace, "(.*/)(.*)", "%2")
end

function EtcdSk:getApiCall(namespace)
    local httpc = http.new()

    local res, err = httpc:request_uri(
        self.url .. "/v2/keys" .. namespace,
        {}
    )


    if not res then
      ngx.log(ngx.ERR, "NILL res " .. self.url .. "/v2/keys" .. namespace .. " url")
      return nil, err
    end
    return res.body, nil
end

function EtcdSk:get(key)
    local res, err = self:getApiCall(key)

    if not res then
      return nil, err
    end

    return decodeJSON(res)["node"]["value"], nil
end

function EtcdSk:ns2table(namespace)
  local inspect = require('inspect')
  local t = {}

  local res, err = self:getApiCall(namespace)

  ngx.log(ngx.ERR, inspect(res))

  if not res then
    return nil, err
  end


  local data = decodeJSON(res)
  for nodeId = 1, table.getn(data.node.nodes) do
    local node = data.node.nodes[nodeId]
    t[basename(node.key)] = node.value
  end
  return t, nil
end

function EtcdSk:new(url)
   local self = {}
   setmetatable(self, { __index = EtcdSk })
   self.url = url
   return self
end

return EtcdSk


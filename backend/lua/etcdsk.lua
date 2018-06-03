local http = require "resty.http"
local encodeJSON = require('cjson.safe').encode
local decodeJSON = require('cjson.safe').decode


local EtcdSk = {}

function EtcdSk:getApiCall(namespace)
    local httpc = http.new()

    local res, err = httpc:request_uri(
        self.url .. "/v2/keys/" .. namespace,
        {}
    )

    if not res then
      return nil, err
    end
    return res.body
end

function EtcdSk:get(key)
    local res, err = EtcdSk:getApiCall(key)

    if not res then
      return nil, err
    end

    return decodeJSON(res)["node"]["value"], nil
end

function EtcdSk:ns2table(namespace)
  local t = {}

  local res, err = EtcdSk:getApiCall(namespace)

  if not res then
    return nil, err
  end


  for node in decodeJSON(res)["node"]["nodes"] do
    t[node["key"]] = node["value"]
  end

  return t
end

function EtcdSk:new(url)
   local self = {}
   setmetatable(self, { __index = EtcdSk })
   self.url = url
   return self
end

return EtcdSk


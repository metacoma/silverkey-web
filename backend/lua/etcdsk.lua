local http = require "resty.http"
local encodeJSON = require('cjson.safe').encode
local decodeJSON = require('cjson.safe').decode


local EtcdSk = {}

function EtcdSk:get(key)
    local httpc = http.new()
    --httpc:set_timeout(1200)
    --httpc:connect("172.19.0.7", 2379)

    local res, err = httpc:request_uri(
        "http://staging.silverkey.app-db:2379/v2/keys/kubeconfig",
        {}
    )
    if not res then
      return nil, err
    end

    return decodeJSON(res.body), nil
end

function EtcdSk.new(url)
   local self = {}
   self.url = url
   setmetatable(self, { __index = EtcdSk })
   return self
end

return EtcdSk


local http = require "resty.http"
local encodeJSON = require('cjson.safe').encode
local decodeJSON = require('cjson.safe').decode


local EtcdSk = {}

function EtcdSk:get(key)
    local httpc = http.new()

    local res, err = httpc:request_uri(
        self.url .. "/v2/keys/" .. key,
        {}
    )
    if not res then
      return nil, err
    end

    return decodeJSON(res.body), nil
end

function EtcdSk:new(url)
   local self = {}
   setmetatable(self, { __index = EtcdSk })
   self.url = url
   return self
end

return EtcdSk


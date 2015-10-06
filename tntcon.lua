# connect to 1.5 or 1.6
tarantool = require("tarantool")

local tar, err = tarantool:new({
    host           = "127.0.0.1",
    port	   = 3017,
    socket_timeout = 2000,
    connect_now    = true,
})

if tar then
	ngx.say('connected')
else
	ngx.say('error '..err)
end

# call tarantool function to find out uplink
local res = tar:call("mist.route",ngx.var['arg_connect-id'])
print("uplink ",res[1][1])
# redirect
ngx.exec('/proxyp/'..res[1][1]..ngx.var.uri..'?connect-id='..ngx.var['arg_connect-id'])


-- load namespace
local socket = require("socket")
local server = assert(socket.bind("*", "9000", 1024))
server:settimeout(0)

while 1 do
    local conn = server:accept()
    if conn then
        print(conn)
    end
end

gpio.mode(4, gpio.OUTPUT)
gpio.write(4, gpio.LOW)
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local buf = "<!DOCTYPE html><html><body><h1>Ivan's NodeMCU Microcontroller</h1><form src=\"/\">Turn embedded LED <select name=\"pin\" onchange=\"form.submit()\">"
    local _, _, get = string.find(request, "GET (.*) HTTP")
    local _light, _dark = "", ""
    if (string.find(get, "light")) then
      _light = " selected=\"true\""
      gpio.write(4, gpio.LOW)
    elseif (string.find(get, "dark")) then
      _dark = " selected=\"true\""
      gpio.write(4, gpio.HIGH)
    end
    buf = buf .. "<option value=\"light\"" .. _light .. ">ON</option><option value=\"dark\"" .. _dark .. ">OFF</option></select></form>"
    client:send(buf)
    client:send('<pre>')
    client:send(request)
    client:send(get)
    client:send('</pre></body></html>')
  end)
  conn:on("sent", function(c) c:close() end)
end)

local mqtt = require("mqtt_library")

function mqttcb(topic, message)
   print("Sending")
   controle = not controle
end

function love.load()
  x = 50 y = 200
  w = 200 h = 150
end

function naimagem (mx, my, x, y) 
  return (mx>x) and (mx<x+w) and (my>y) and (my<y+h)
end

function love.keypressed(key)
  local mx, my = love.mouse.getPosition() 
  if key == 'b' and naimagem (mx,my, x, y) then
     y = 200
  end
end

function love.update (dt)
  local mx, my = love.mouse.getPosition() 
  if love.keyboard.isDown("down")  and naimagem(mx, my, x, y)  then
    y = y + 10
  end
end

function love.draw ()
  love.graphics.rectangle("line", x, y, w, h)
end


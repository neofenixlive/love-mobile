local touch = {}

touch.touchScreen = {}
touch.mouseRightClickInterval = 0.2
touch.mouseLastClick = 0

touch.displayKey = {}
touch.mobileKey = {}

touch.displayMouse = {[0]=love.graphics.newImage("mobile/assets/idle.png"), [1]=love.graphics.newImage("mobile/assets/select.png"), [2]=love.graphics.newImage("mobile/assets/select.png")}
touch.mobileMouse = {x=0, y=0, button=0}

function love.touchpressed(id, x, y)
    touch.mobileMouse.x, touch.mobileMouse.y = x, y
    if touch.mouseLastClick > touch.mouseRightClickInterval then
        touch.mobileMouse.button = 1
    else
        touch.mobileMouse.button = 2
    end
    touch.mouseLastClick = 0
    touch.touchScreen[id] = {x=x, y=y}
end
function love.touchmoved(id, x, y)
    touch.mobileMouse.x, touch.mobileMouse.y = x, y
end
function love.touchreleased(id, x, y)
    touch.mobileMouse.button = 0
    touch.touchScreen[id] = nil
end

function touch.assignKey(key, x, y, scale)
    touch.displayKey[key] = {x=x, y=y, scale=scale, image=love.graphics.newImage("mobile/assets/"..key..".png")}
end
function touch.updateMobile(dt)
    for code, key in pairs(touch.displayKey) do
        touch.mobileKey[code] = false
        for _, i in pairs(touch.touchScreen) do
            if i ~= nil and i.x>key.x and i.x<key.x+(key.image:getWidth()*key.scale) and i.y>key.y and i.y<key.y+(key.image:getHeight()*key.scale) then
                touch.mobileKey[code] = true
            end
        end
    end
    touch.mouseLastClick = touch.mouseLastClick + dt
end
function touch.drawMobile()
    for code, key in pairs(touch.displayKey) do
        if not touch.mobileKey[code] then
            love.graphics.setColor(255, 255, 255, 80)
        end
        love.graphics.draw(key.image, key.x, key.y, 0, key.scale, key.scale)
        love.graphics.setColor(255, 255, 255, 255)
    end
    love.graphics.draw(touch.displayMouse[touch.mobileMouse.button], touch.mobileMouse.x, touch.mobileMouse.y, 0, 2, 2)
end

return touch

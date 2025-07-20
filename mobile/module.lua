local mod = {}

mod.mouseRightClickInterval = 0.2
mod.mouseLastClick = 0

mod.displayKey = {}
mod.mobileKey = {}

mod.displayMouse = {none=love.graphics.newImage("mobile/idle.png"), left=love.graphics.newImage("mobile/select.png"), right=love.graphics.newImage("mobile/select.png")}
mod.mobileMouse = {x=0, y=0, button="none"}

function love.touchpressed(id, x, y)
    mod.mobileMouse.x, mod.mobileMouse.y = x, y
    if mod.mouseLastClick > mod.mouseRightClickInterval then
        mod.mobileMouse.button = "left"
    else
        mod.mobileMouse.button = "right"
    end
    mod.mouseLastClick = 0
end
function love.touchmoved(id, x, y)
    mod.mobileMouse.x, mod.mobileMouse.y = x, y
end
function love.touchreleased(id, x, y)
    mod.mobileMouse.button = "none"
end

function mod.assignKey(key, x, y, scale)
    mod.displayKey[key] = {x=x, y=y, scale=scale, image=love.graphics.newImage("mobile/keys/"..key..".png")}
end
function mod.updateMobile(dt)
    for code, key in pairs(mod.displayKey) do
        local mouse = mod.mobileMouse
        mod.mobileKey[key] = false
        if mouse.button == "left" and mouse.x>key.x and mouse.x<key.x+(key.image:getWidth()*key.scale) and mouse.y>key.y and mouse.y<key.y+(key.image:getHeight()*key.scale) then
            mod.mobileKey[code] = true
        end
    end
    mod.mouseLastClick = mod.mouseLastClick + dt
end
function mod.drawMobile()
    for code, key in pairs(mod.displayKey) do
        love.graphics.draw(key.image, key.x, key.y, 0, key.scale, key.scale)
    end
    love.graphics.draw(mod.displayMouse[mod.mobileMouse.button], mod.mobileMouse.x, mod.mobileMouse.y, 0, 2, 2)
end

return mod
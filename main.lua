local core = {}
local key = {}
local buf = {}

function key.setting()
    key[0], key[1], key[2], key[3] = {}, {}, {}, {}
    key[0].x = 100 
    key[0].y = -50
    key[0].width = 50 
    key[0].height = 50
    key[0].mode = 0

    key[1].x = 175
    key[1].y = -50
    key[1].width = 50
    key[1].height = 50
    key[1].mode = 0

    key[2].x = 250
    key[2].y = -50
    key[2].width = 50
    key[2].height = 50
    key[2].mode = 0

    key[3].x = 325
    key[3].y = -50
    key[3].width = 50
    key[3].height = 50
    key[3].mode = 0
end

function love.load()
    success = love.window.setMode(800, 600, flags) core["scene"] = 0
    core["touch"] = -1

    core["mem"] = 0

    key.setting()

    core["score"] = 0
    love.keyboard.setKeyRepeat(false)

    core["logo"] = love.graphics.newImage("logo.png")
    core["menu"] = love.graphics.newImage("menu.jpg")
    core["music"] = love.audio.newSource("song.mp3", 'stream')
end

function key.checkClicked(x)
    for i = 0, core.touch do
        if (buf[i] ~= nil and buf[i].x == x and buf[i].y > 500 and buf[i].y < 650) then
            buf[i].anim = buf[i].anim - 0.4
            return (1)
        end
    end
    return (0)
end

function key.fadeOut()
    for i = 0, core.touch do
        if(buf[i] ~= nil and buf[i].anim < 1) then
            buf[i].anim =buf[i].anim - 0.1
        end
        if(buf[i] ~= nil and buf[i].anim == 0) then
            buf[i].y = nil buf[i].x = nil buf[i] = nil
        end
    end
end

function love.keypressed(myKey)
    if myKey == "q" and key.checkClicked(100) == 1 then
        core.score = core.score + 10
    end
    if myKey == "s" and key.checkClicked(175) == 1 then
        core.score = core.score + 10
    end
    if myKey == "d" and key.checkClicked(250) == 1 then
        core.score = core.score + 10
    end
    if myKey == "f" and key.checkClicked(325) == 1 then
        core.score = core.score + 10
    end
end

function key.appendBuffer()
    --[[if(math.random(1000) < 25) then
        --Append number of items.
        buf[core.touch].anim = 1
        core.touch = core.touch + 1
        --Create object depending on key config
        buf[core.touch] = {} buf[core.touch].x = key[math.random(4) - 1].x
        buf[core.touch].y = -50
    end]]--
end

function key.scrolling()
    for i = 0, core.touch do
        if(buf[i] ~= nil) then
            buf[i].y = buf[i].y + 10
        end

        if(buf[i] ~= nil and buf[i].y == 600) then
            buf[i].y = nil buf[i].x = nil buf[i] = nil
        end
    end
end

function memoryCleaner()
    core.mem = core.mem + 1
    if(core.mem == 500) then
        collectgarbage()
    end
end

function love.update(dt)
    dt = math.min(dt, 1/60)
    if core.scene == 0 then
        key.appendBuffer()
        key.scrolling()
        memoryCleaner()
        key.fadeOut()
    end
    if core.scene == 0 then
        if love.mouse.isDown(1) then
            core.scene = 1
        end
    end
end

function core.ui()
    love.graphics.setColor(1, 1, 1, 0.8) 
    love.graphics.rectangle("fill", 95, 0, 60, 600) 
    love.graphics.rectangle("fill", 170, 0, 60, 600) 
    love.graphics.rectangle("fill", 245, 0, 60, 600) 
    love.graphics.rectangle("fill", 320, 0, 60, 600) 
end

function core.drawSceneGame()
    core.ui() for i = 0, core.touch do
        if(buf[i] ~= nil) then
            love.graphics.setColor(0, 0.66, 0.66, 1)
            if buf[i].anim < 1
                then love.graphics.setColor(0, 0.33, 0.33, buf[i].anim)
            end
            love.graphics.rectangle("fill", buf[i].x, buf[i].y, 50, 30)
        end
    end
    love.graphics.setColor(1, 1, 195, 0.5)
    love.graphics.rectangle("fill", 420, 150, 0, 4, 4)
    
    love.graphics.print("SCORE:", 420, 150, 0, 4, 4)
    love.graphics.print(core.score, 420, 200, 0, 4, 4)

    love.audio.play(core.music)
end

function core.drawSceneMenu()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(core.menu)
    love.graphics.draw(core.logo, 20, 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", 0, 500, 800, 60)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("Play", 50, 500, 0, 4, 4)
end

function love.draw()
    if core.scene == 1 then
        core.drawSceneGame()
    end
    if core.scene == 0 then
        core.drawSceneMenu()
    end
end
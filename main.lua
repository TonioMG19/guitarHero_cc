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
end

function love.draw()
    love.graphics.print("SCORE:", 420, 150, 0 , 4, 4)
    love.graphics.print(core.score, 420, 200, 0, 4, 4)
end

function key.checkClicked(x)
    for i = 0, core.touch do
        if (buf[i] ~= nil and buf[i].x == x and buf[i].y > 500 and buf[i].y < 550) then
            buf[i].y = nil
            buf[i].x = nil
            buf[i] = nil
            return (1)
        end
    end
    return (0)
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
    if(math.random(1000) < 25) then
        core.touch = core.touch + 1
        buf[core.touch] = {} buf[core.touch].x = key[math.random(4) - 1].x
        buf[core.touch].y = -50
    end
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
    key.appendBuffer()
    key.scrolling()
    memoryCleaner()
end
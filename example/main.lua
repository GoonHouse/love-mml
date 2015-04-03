package.path = package.path .. ";../?.lua" -- to load from base directory

local mmlplayer = require 'love-mml'

function love.load()
	local twinkle = "t120 l4 o4  ccggaag2 ffeeddc2 ggffeed2 ggffeed2 ccggaag2 ffeeddc2"
	mmlplayer:initialize(twinkle, "multiplier")
	local steeldrum = love.audio.newSource("I12.wav", "static")
	mmlplayer:setInstrument(steeldrum)
end

function love.update(dt)
	-- use our sync
	mmlplayer:update(dt)
end
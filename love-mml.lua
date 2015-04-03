local mml = require("mml")

local love_mml = {
	_VERSION = "1.0.0",
	_DESCRIPTION = "A Music Macro Language player (for love).",
	_URL = "https://github.com/GoonHouse/love-mml",
	_LICENSE = [[
		Copyright (c) 2015-??? EntranceJew, HammerGuy
		
		¯\_(ツ)_/¯
	]],
	iterator = 1, --the sample we are set to
	nexttime = 0, --the next position of time that we're meant to play a note
	instrument = nil,
	
	data = nil, --processed table by mml
	
	debug = false, --do we want to print note data? maybe.
}

function love_mml:initialize(str, outputType)
	self.data = mml.newPlayer(str, outputType)
end

function love_mml:setInstrument(inst)
	self.instrument = inst
	self.instrument:setLooping(false)
end

function love_mml:reset()
	self.iterator = 1
	self.nexttime = 0
end

function love_mml:update(dt)
	self.nexttime = self.nexttime - dt
	-- only play if we aren't delayed
	if self.nexttime <= 0 and self.iterator <= #self.data then
		local sample = self.data[self.iterator]
		local note = sample.output
		local time = sample.notetime
		local volume = sample.volume
		if self.debug then
			print("NOTE DEBUG:", love.timer.getTime(), iterator, note, time, volume)
		end
		
		if note then
			-- stop the existing note because we have to start our next
			love.audio.stop(self.instrument)
			self.instrument:setPitch(note)
			self.instrument:setVolume(volume)
			love.audio.play(self.instrument)
			self.nexttime = time
		else
			-- If "note" is nil, it's a rest.
			-- To be entirely honest, I'm not even sure if this code happens.
			self.nexttime = time
		end
		self.iterator = self.iterator + 1
	end
end

return love_mml
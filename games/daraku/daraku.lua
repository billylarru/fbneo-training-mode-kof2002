assert(rb,"Run fbneo-training-mode.lua")

print "Known Issues: with daraku"
print "Can't set timer"
print ""

p1maxhealth = 0x61
p2maxhealth = 0x61

p1maxmeter = 0x2C
p2maxmeter = 0x2C

local p1health = 0x602DF1B
local p2health = 0x602E11B

local p1meter = 0x602DF21
local p2meter = 0x602E121


local p1direction = 0x602de52
local p2direction = 0x602e052

local p1combocounter = 0x602E154
local p2combocounter = 0x602DF54

local p1character = 0x602DE81
local p2character = 0x602E081

translationtable = {
	{
		"coin",
		"start",
		"select",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button 1"] = 8,
	["Button 2"] = 9,
	["Button 3"] = 10,
	["Button 4"] = 11,
}

gamedefaultconfig = {
	combogui = {
		combotextx=145,
		combotexty=42,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==8
end

function playerTwoFacingLeft()
	return rb(p2direction)==8
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
	if (meter==p1maxmeter) then -- activates the timer
		wb(p1meter+1, 1)
	end
end

function readPlayerTwoMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p2meter, meter)
	if (meter==p2maxmeter) then -- activates the timer
		wb(p2meter+1, 1)
	end
end
--[[
Need to investigate how game allocates to figure this out
local timer = { -- timer location is based on p1 character
	0x6002176, -- Yuiren
	0x6001976, -- Yuiran
	0x6001976, -- Cool
	0x6001b76, -- Harry
	0x6001b76, -- Taro
	0x6001d76, -- Roche
	0x6002b76, -- Torao
	0x6001f76, -- Haiji
	0x6001976, -- Trigger
	0x6001976, -- Carlos
}

function infiniteTime()
	ww(timer[rb(p1character)+1], 0x1530)
end
--]]
function Run() -- runs every frame
	--infiniteTime()
end

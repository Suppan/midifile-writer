require 'help-functions'

local durList = {500,1500,2000} --milliseconds
local midiList = {60,62,64}
local chanList = {1,1,1}
local velList = {40,40,40}
local filename = "test.mid"

--===================================================================  	
-- 1. make tickList and count Totalbytes
--===================================================================

local countTotalBytes = 0
local tickList = {}

for i = 1,#durList do
	local delta_ticks = ms2ticks(durList[i])
	local bytes_list  = writeVarLen(delta_ticks)
	countTotalBytes = countTotalBytes + #bytes_list + 7 --2x3-> (90 3c 28) + 1x (00) delta
	table.insert(tickList,bytes_list)
end

countTotalBytes = countTotalBytes + 4 --plus size endOfTrack

--===================================================================  	
-- 2. make file- and trackheaders
--=================================================================== 

local fileHeader = {
    0x4D, 0x54, 0x68, 0x64, -- MIDI header
    0x00, 0x00, 0x00, 0x06, -- Chunk size
    0x00, 0x00,             -- MIDI format (type 0)
    0x00, 0x01--,           -- Number of tracks
    --0x00, 0x80            -- Time division = 128 (will be filled in later)
  }
 
local addTimeDivision = write4bit(ticksPerQuarterNote)

for i = 1,#addTimeDivision do 
	table.insert(fileHeader,addTimeDivision[i]) 
end

-- Define the track header
local trackHeader = {
    0x4D, 0x54, 0x72, 0x6B--, -- Track header
    --0x00, 0x00, 0x00, 0x0D  -- Chunk size=13 (will be filled in later)
  }

local addChunkSize = write8bit(countTotalBytes)

for i = 1,#addChunkSize do 
	table.insert(trackHeader,addChunkSize[i])
end

 -- Define the end of track message
local endOfTrack = {
    0x00, 0xFF, 0x2F, 0x00  -- last timedelta + End of track message
  }

--===================================================================  	
-- 3. write track data and headers
--=================================================================== 

local file = io.open(filename, "wb")

for i = 1, #fileHeader do
  file:write(string.char(fileHeader[i]))
end

for i = 1, #trackHeader do
  file:write(string.char(trackHeader[i]))
end

for i = 1, #tickList do
	local midix = midiList[i] % 127
	local chanx = (chanList[i] - 1) % 16
	local velx = velList[i] % 127
	file:write(string.char("0x00"))
	file:write(string.char("0x"..string.format("9%01x",chanx))) --note ON
	file:write(string.char("0x"..string.format("%02x",midix)))
	file:write(string.char("0x"..string.format("%02x",velx)))
	file:write(string.char(table.unpack(tickList[i])))          --duration      
	file:write(string.char("0x"..string.format("8%01x",chanx))) --note OFF
	file:write(string.char("0x"..string.format("%02x",midix)))
	file:write(string.char("0x"..string.format("%02x",velx)))
end

for i = 1, #endOfTrack do
  file:write(string.char(endOfTrack[i]))
end

file:close()

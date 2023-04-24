ticksPerQuarterNote = 128
tempo = 120

function ms2ticks (durx)
  local secondsPerBeat = 60.0 / tempo
  local ticksPerSecond = ticksPerQuarterNote / secondsPerBeat
  return math.floor(durx / 1000.0 * ticksPerSecond)
end

function writeVarLen(value)
  local bytes = {}
  repeat
    table.insert(bytes, 1, value % 128)
    value = math.floor(value / 128)
  until value == 0
  for i = 1, #bytes-1 do
    bytes[i] = bytes[i] + 128
  end
  return bytes
end

function write4bit(value)
  local str = string.format("%04x",value)
  local arr = {}
  for i = 1, 4 ,2 do
    table.insert(arr,"0x"..string.sub(str,i,i+1))
  end
  return arr
end

function write8bit(value)
  local str = string.format("%08x",value)
  local arr = {}
  for i = 1, 8 ,2 do
    table.insert(arr,"0x"..string.sub(str,i,i+1))
  end
  return arr
end

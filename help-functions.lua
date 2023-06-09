local mf = {}

smfTempo = 500000 -- = tempo 120 (in microseconds)
ticksPerQuarterNote = 128

function mf.ms2ticks (ms)
  return math.floor(ms * 1000 / (smfTempo / ticksPerQuarterNote))
end

function mf.writeVarLen(value)
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

function mf.write4bit(value)
  local str = string.format("%04x",value)
  local arr = {}
  for i = 1, 4 ,2 do
    table.insert(arr,"0x"..string.sub(str,i,i+1))
  end
  return arr
end

function mf.write8bit(value)
  local str = string.format("%08x",value)
  local arr = {}
  for i = 1, 8 ,2 do
    table.insert(arr,"0x"..string.sub(str,i,i+1))
  end
  return arr
end

return mf

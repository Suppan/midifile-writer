# midifile-writer
simple midi file writer in Lua


## Why?

For better understanding of how to write midi messages (Type-0) in Lua

## Usage

after installing Lua (ie via homebrew: brew install lua)

enter in terminal: 
```
lua mf-writer.lua
```
with given data (all lists have to have the same length!) inside the file:

local durList = {500,1500,2000} --milliseconds  
local midiList = {60,62,64}  
local chanList = {1,1,1}  
local velList = {40,40,40}  
local filename = "test.mid" 

result:
```
"test.mid"
```
*************
This program is free software. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
*************

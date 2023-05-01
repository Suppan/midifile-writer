# midifile-writer
simple and basic midifile writer for writing midi messages (type-0) in Lua without external libraries

## Why?

Because of the limitation, it is intended to provide a basic example to understand the structure of midi messages or the basic way to write a midi file from scratch.

## Usage

after installing Lua (ie via homebrew: brew install lua)

enter in terminal: 
```
lua midifile-writer.lua
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

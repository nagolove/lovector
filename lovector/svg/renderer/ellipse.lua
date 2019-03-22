--[[
MIT License

Copyright (c) 2019 nasso <nassomails ~ at ~ gmail {dot} com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local cwd = (...):match('(.*lovector).-$') .. "."
local PathBuilder = require(cwd .. "pathbuilder")
local common = require(cwd .. "svg.common")

local renderer = {}

function renderer:empty(svg, options)
    local cx = tonumber(common.get_attr(self, "cx", "0"), 10)
    local cy = tonumber(common.get_attr(self, "cy", "0"), 10)
    local rx = tonumber(common.get_attr(self, "rx", "0"), 10)
    local ry = tonumber(common.get_attr(self, "ry", "0"), 10)

    if rx <= 0 or ry <= 0 then
        return ""
    end

    local path = PathBuilder(options)

    path:ellipticalArc(cx, cy, rx, ry, 0, 360)

    local result = ""

    for i = 1, #(path.subpaths) do
        local sub = path.subpaths[i]

        result = result .. common.gen_subpath(svg, self, sub.vertices, sub.closed, options)
    end

    return result
end

return renderer
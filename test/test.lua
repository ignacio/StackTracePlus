require "luarocks.require"
local SS = require "StackTracePlus"

debug.traceback = SS.stacktrace

function f(str, tb, ...)
	local g = function(fun)
		local str = str
		local tb = tb
		local a = nil .. "text"
	end
	return g(table)
end

f("hey", {foo="bar", dummy=1, blah=true}, 1)
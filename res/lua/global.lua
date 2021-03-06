------------------------------------------------------------------------
-- Copyright (C) 1994-2008 Lua.org, PUC-Rio.  All rights reserved.
--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
------------------------------------------------------------------------

-- Basic Functions  http://www.lua.org/manual/5.3/manual.html#6.1

-- The basic library provides core functions to Lua. If you do not include this library in your application, you should check carefully whether you need to provide implementations for some of its facilities.
function assert(v, message) end

-- Calls error if the value of its argument v is false (i.e., nil or false); otherwise, returns all its arguments. In case of error, message is the error object; when absent, it defaults to "assertion failed!"
function collectgarbage(opt, arg) end

-- Opens the named file and executes its contents as a Lua chunk. When called without arguments, dofile executes the contents of the standard input (stdin). Returns all values returned by the chunk. In case of errors, dofile propagates the error to its caller (that is, dofile does not run in protected mode).
function dofile(filename) end

-- Terminates the last protected function called and returns message as the error object. Function error never returns.
-- Usually, error adds some information about the error position at the beginning of the message, if the message is a string. The level argument specifies how to get the error position. With level 1 (the default), the error position is where the error function was called. Level 2 points the error to where the function that called error was called; and so on. Passing a level 0 avoids the addition of error position information to the message.
function error(message, level) end

-- A global variable (not a function) that holds the global environment (see §2.2). Lua itself does not use this variable; changing its value does not affect any environment, nor vice versa.
_G = {}

-- If object does not have a metatable, returns nil. Otherwise, if the object's metatable has a __metatable field, returns the associated value. Otherwise, returns the metatable of the given object.
function getmetatable(object) end

--Returns three values (an iterator function, the table t, and 0) so that the construction
--      for i,v in ipairs(t) do body end
-- will iterate over the key–value pairs (1,t[1]), (2,t[2]), ..., up to the first nil value.
function ipairs(t) end

-- Loads a chunk.
-- If chunk is a string, the chunk is this string. If chunk is a function, load calls it repeatedly to get the chunk pieces. Each call to chunk must return a string that concatenates with previous results. A return of an empty string, nil, or no value signals the end of the chunk.
-- If there are no syntactic errors, returns the compiled chunk as a function; otherwise, returns nil plus the error message.
-- If the resulting function has upvalues, the first upvalue is set to the value of env, if that parameter is given, or to the value of the global environment. Other upvalues are initialized with nil. (When you load a main chunk, the resulting function will always have exactly one upvalue, the _ENV variable (see §2.2). However, when you load a binary chunk created from a function (see string.dump), the resulting function can have an arbitrary number of upvalues.) All upvalues are fresh, that is, they are not shared with any other function.
-- chunkname is used as the name of the chunk for error messages and debug information (see §4.9). When absent, it defaults to chunk, if chunk is a string, or to "=(load)" otherwise.
-- The string mode controls whether the chunk can be text or binary (that is, a precompiled chunk). It may be the string "b" (only binary chunks), "t" (only text chunks), or "bt" (both binary and text). The default is "bt".
-- Lua does not check the consistency of binary chunks. Maliciously crafted binary chunks can crash the interpreter.
function load(chunk, chunkname, mode, env) end

-- Similar to load, but gets the chunk from file filename or from the standard input, if no file name is given.
function loadfile(filename, mode, env) end

-- Allows a program to traverse all fields of a table. Its first argument is a table and its second argument is an index in this table. next returns the next index of the table and its associated value. When called with nil as its second argument, next returns an initial index and its associated value. When called with the last index, or with nil in an empty table, next returns nil. If the second argument is absent, then it is interpreted as nil. In particular, you can use next(t) to check whether a table is empty.
-- The order in which the indices are enumerated is not specified, even for numeric indices. (To traverse a table in numerical order, use a numerical for.)
-- The behavior of next is undefined if, during the traversal, you assign any value to a non-existent field in the table. You may however modify existing fields. In particular, you may clear existing fields.
function next(table, index) end

-- If t has a metamethod __pairs, calls it with t as argument and returns the first three results from the call.
-- Otherwise, returns three values: the next function, the table t, and nil, so that the construction
--      for k,v in pairs(t) do body end
-- will iterate over all key–value pairs of table t.
-- See function next for the caveats of modifying the table during its traversal.
function pairs(t) end

-- Calls function f with the given arguments in protected mode. This means that any error inside f is not propagated; instead, pcall catches the error and returns a status code. Its first result is the status code (a boolean), which is true if the call succeeds without errors. In such case, pcall also returns all results from the call, after this first result. In case of any error, pcall returns false plus the error message.
function pcall(f, arg1, ...) end

-- Receives any number of arguments and prints their values to stdout, using the tostring function to convert each argument to a string. print is not intended for formatted output, but only as a quick way to show a value, for instance for debugging. For complete control over the output, use string.format and io.write.
function print(...) end

-- Checks whether v1 is equal to v2, without invoking the __eq metamethod. Returns a boolean.
function rawequal(v1, v2) end

-- Gets the real value of table[index], without invoking the __index metamethod. table must be a table; index may be any value.
function rawget(table, index) end

-- Returns the length of the object v, which must be a table or a string, without invoking the __len metamethod. Returns an integer.
function rawlen(v) end

-- Sets the real value of table[index] to value, without invoking the __newindex metamethod. table must be a table, index any value different from nil and NaN, and value any Lua value.
-- This function returns table.
function rawset(table, index, value) end

-- If index is a number, returns all arguments after argument number index; a negative number indexes from the end (-1 is the last argument). Otherwise, index must be the string "#", and select returns the total number of extra arguments it received.
function select(index, ...) end

-- Sets the metatable for the given table. (To change the metatable of other types from Lua code, you must use the debug library (§6.10).) If metatable is nil, removes the metatable of the given table. If the original metatable has a __metatable field, raises an error.
-- This function returns table.
function setmetatable(table, metatable) end

-- When called with no base, tonumber tries to convert its argument to a number. If the argument is already a number or a string convertible to a number, then tonumber returns this number; otherwise, it returns nil.
-- The conversion of strings can result in integers or floats, according to the lexical conventions of Lua (see §3.1). (The string may have leading and trailing spaces and a sign.)
-- When called with base, then e must be a string to be interpreted as an integer numeral in that base. The base may be any integer between 2 and 36, inclusive. In bases above 10, the letter 'A' (in either upper or lower case) represents 10, 'B' represents 11, and so forth, with 'Z' representing 35. If the string e is not a valid numeral in the given base, the function returns nil.
function tonumber(e, base) end

-- Receives a value of any type and converts it to a string in a human-readable format. (For complete control of how numbers are converted, use string.format.)
-- If the metatable of v has a __tostring field, then tostring calls the corresponding value with v as argument, and uses the result of the call as its result.
function tostring(v) end

-- Returns the type of its only argument, coded as a string. The possible results of this function are "nil" (a string, not the value nil), "number", "string", "boolean", "table", "function", "thread", and "userdata".
function type(v) end

-- A global variable (not a function) that holds a string containing the running Lua version. The current value of this variable is "Lua 5.3".
_VERSION = "Lua 5.3"

-- This function is similar to pcall, except that it sets a new message handler msgh.
function xpcall(f, msgh, arg1, ...) end

-- Loads the given module. The function starts by looking into the package.loaded table to determine whether modname is already loaded. If it is, then require returns the value stored at package.loaded[modname]. Otherwise, it tries to find a loader for the module.
-- To find a loader, require is guided by the package.searchers sequence. By changing this sequence, we can change how require looks for a module. The following explanation is based on the default configuration for package.searchers.
-- First require queries package.preload[modname]. If it has a value, this value (which must be a function) is the loader. Otherwise require searches for a Lua loader using the path stored in package.path. If that also fails, it searches for a C loader using the path stored in package.cpath. If that also fails, it tries an all-in-one loader (see package.searchers).
-- Once a loader is found, require calls the loader with two arguments: modname and an extra value dependent on how it got the loader. (If the loader came from a file, this extra value is the file name.) If the loader returns any non-nil value, require assigns the returned value to package.loaded[modname]. If the loader does not return a non-nil value and has not assigned any value to package.loaded[modname], then require assigns true to this entry. In any case, require returns the final value of package.loaded[modname].
-- If there is any error loading or running the module, or if it cannot find any loader for the module, then require raises an error.
function require(modname) end
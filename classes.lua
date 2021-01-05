local _G = _G

module 'classes'

local _M = _M

_G.require 'freeze'
local frozen_env = _G.freeze.frozen(_M)
_G.setfenv(1, frozen_env)

_M.Class = {}

local function initialize_class(new_class, name)
  new_class.name = name
  local new_class_metatable = {class = Class}

  function new_class_metatable.__tostring(class)
    return "class '" .. class.name .. "'"
  end

  _G.setmetatable(new_class, new_class_metatable)
end

function Class.new(name)
  local new_class = {}
  initialize_class(new_class, name)
  return new_class
end

initialize_class(Class, 'Class')

_M.Nil = Class.new('Nil')
_M.Number = Class.new('Number')
_M.String = Class.new('String')
_M.Boolean = Class.new('Boolean')
_M.Table = Class.new('Table')
_M.Function = Class.new('Function')
_M.Thread = Class.new('Thread')
_M.Userdata = Class.new('Userdata')

local string_to_class = {
  ['nil'] = Nil,
  number = Number,
  string = String,
  boolean = Boolean,
  table = Table,
  ['function'] = Function,
  thread = Thread,
  userdata = Userdata,
}

function _M.type(value)
  local metatable = _G.getmetatable(value)
  if metatable and metatable.class then
    return metatable.class
  else
    local type = _G.type(value)
    return string_to_class[type]
  end
end
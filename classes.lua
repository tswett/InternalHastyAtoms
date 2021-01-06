local _G = _G

module 'classes'

local _M = _M

_G.require 'freeze'
local frozen_env = _G.freeze.frozen(_M)
_G.setfenv(1, frozen_env)

local lists = _G.require 'lists'

-- Create the Class class.
--
-- We would kind of like to do _M.Class = Class.new('Class', {Table}), but that's
-- obviously impossible.

--23456789(10)456789(20)456789(30)456789(40)456789(50)456789(60)456789(70)456789(80)456789(90)456789

_M.Class = {}

local function initialize_class(new_class, name, parents, metaclass)
  new_class.name = name
  new_class.metatable = {class = metaclass or Class}

  function new_class.metatable.__tostring(class)
    return "class '" .. class.name .. "'"
  end

  _G.setmetatable(new_class, new_class.metatable)

  parents = parents or {}
  new_class.parents = lists.new_list(parents)
end

function Class.new(name, parents, metaclass)
  local new_class = {}
  initialize_class(new_class, name, parents, metaclass)
  return new_class
end

initialize_class(Class, 'Class')

-- Now the Class class is almost finished. Its parent (the Table class) will be added later.

-- Next, create all the classes for builtin types.

_M.EnumClass = Class.new('EnumClass', {Class})

function EnumClass.new_without_values(name)
  local new_class = Class.new(name, {}, EnumClass)
  return new_class
end

_M.Nil = EnumClass.new_without_values('Nil')
Nil.values = lists.new_list({},1)
_M.Number = Class.new('Number')
_M.String = Class.new('String')
_M.Boolean = EnumClass.new_without_values('Boolean')
Boolean.values = lists.new_list{true, false, ['true'] = true, ['false'] = false}
_M.Table = Class.new('Table')
Class.parents[1] = Table
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
local _G = _G

module 'lists'

local _M = _M

_G.require 'freeze'
local frozen_env = _G.freeze.frozen(_M)
_G.setfenv(1, frozen_env)

local list_metatable = {}

function list_metatable.__tostring(list)
  local pieces = {'{'}
  local is_first_element = true

  for i, value in _G.ipairs(list) do
    if not is_first_element then
      _G.table.insert(pieces, ', ')
    end

    _G.table.insert(pieces, _G.tostring(value))

    is_first_element = false
  end

  _G.table.insert(pieces, '}')

  local result = _G.table.concat(pieces)

  return result
end

function _M.new_list(table)
  local list = {}
  _G.setmetatable(list, list_metatable)

  for i, value in _G.ipairs(table) do
    _G.table.insert(list, value)
  end

  return list
end
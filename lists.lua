local _G = _G
require 'freeze'
freeze.frozen_module 'lists'
local _M = _M

local list_metatable = {}

function list_metatable.__tostring(list)
  local pieces = {'{'}
  local is_first_element = true

  local function add_piece(value)
    if not is_first_element then
      _G.table.insert(pieces, ', ')
    end

    _G.table.insert(pieces, _G.tostring(value))

    is_first_element = false
  end

  if list.length then
    for i = 1, list.length do
      add_piece(list[i])
    end
  else
    for i, value in _G.ipairs(list) do
      add_piece(value)
    end
  end

  _G.table.insert(pieces, '}')

  local result = _G.table.concat(pieces)

  return result
end

function _M.new_list(table, length)
  local list = {length = length}
  _G.setmetatable(list, list_metatable)

  for i, value in _G.ipairs(table) do
    _G.table.insert(list, value)
  end

  return list
end
local _G = _G

module 'examine'

local _M = _M

_G.require 'freeze'
local frozen_env = _G.freeze.frozen(_M)
_G.setfenv(1, frozen_env)

function _M.print_items(table, print_function)
  print_function = print_function or _G.print
  
  if _G.type(table) ~= 'table' then
    print_function 'The given value is not a table.'
    return
  end

  local printed_something = false

  for key, value in _G.pairs(table) do
    print_function(_G.tostring(key) .. ': ' .. _G.tostring(value))
    printed_something = true
  end

  if not printed_something then
    print_function 'No items.'
  end
end
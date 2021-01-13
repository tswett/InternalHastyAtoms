local _G = _G
require 'freeze'
freeze.frozen_module 'examine'
local _M = _M

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
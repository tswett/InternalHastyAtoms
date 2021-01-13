-- The 'freeze' module provides a function for getting a read-only view on a table. The other
-- modules use this one to avoid accidentally setting global variables.

--23456789(10)456789(20)456789(30)456789(40)456789(50)456789(60)456789(70)456789(80)456789(90)456789

local _G = _G

module 'freeze'

-- Get a read-only view on the given table.
function frozen(underlying)
  local function frozen_index(table, key)
    return underlying[key]
  end

  local function frozen_newindex(table, key, value)
    _G.error('Attempted to set a value in a frozen table.', 2)
  end

  local metatable =
    {__index = frozen_index, __newindex = frozen_newindex}

  local new_table = {}

  _G.setmetatable(new_table, metatable)

  return new_table
end

function frozen_module(name)
  local _G = _G
  local frozen = frozen

  local new_module

  local function get_new_module()
    _G.module(name)
    new_module = _M
  end

  get_new_module()
  local frozen_env = frozen(new_module)

  _G.setfenv(2, frozen_env)
end
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
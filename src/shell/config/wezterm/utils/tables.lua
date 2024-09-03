local tables = {}

--- Merge all the given tables into a single one and return it.
function tables.merge_all(...)
  local result = {}

  for _, table in ipairs({ ... }) do
    for k, v in pairs(table) do
      result[k] = v
    end
  end

  return result
end

return tables

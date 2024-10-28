-- WezTerm configuration
---------------------------------------------------------------
require("status")
require("tabs")

local tables = require("utils/tables")

local full_config = tables.merge_all(
  require("fonts"),
  require("key_tables"),
  require("keys"),
  require("misc"),
  require("theme"),
  require("ui"),
  {}
)

return full_config

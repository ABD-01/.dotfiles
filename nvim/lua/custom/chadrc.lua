---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme = 'chadracula',
  theme_toggle = {"chadracula", "one_light"}
  -- transparency = true
}
 M.mappings = require("custom.mappings")
 M.plugins = "custom.plugins"
 return M

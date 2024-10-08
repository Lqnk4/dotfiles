local M = {}

function M.get_raw_config(server)
  local ok, ret = pcall(require, "lspconfig.configs." .. server)
  if ok then
    return ret
  end
  return require("lspconfig.server_configurations." .. server)
end

return M

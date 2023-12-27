return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    local l = require("lualine")

    l.setup({
      theme = "catppuccin",
      options = {
        icons_enabled = false,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          { "filename", path = 1 },
          {
            "branch",
            fmt = function(str)
              return "[" .. str .. "]"
            end,
          },
          "diagnostics",
        },
        lualine_x = {
          { "diagnostics", sources = { "nvim_workspace_diagnostic" }, sections = { "error" } },
          {
            function()
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return
              end
              local msg = "["
              for i, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  if i == 1 then
                    msg = msg .. client.name
                  else
                    msg = msg .. " " .. client.name
                  end
                end
              end
              msg = msg .. "]"
              return msg
            end,
            icon = "",
            cond = function()
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return false
              end
              return true
            end,
            color = { fg = "#6E738D", gui = "bold" },
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fugitive" },
    })
  end,
}

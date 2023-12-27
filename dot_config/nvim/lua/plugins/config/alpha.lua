return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local startify = require("alpha.themes.startify")
    startify.nvim_web_devicons.enabled = false
    require("alpha").setup(startify.config)
  end,
}

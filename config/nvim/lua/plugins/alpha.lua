return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                                                   ]],
      [[ ██╗███╗   ██╗████████╗ ██████╗     ████████╗██╗  ██╗███████╗    ██╗   ██╗ ██████╗ ██╗██████╗       ]],
      [[ ██║████╗  ██║╚══██╔══╝██╔═══██╗    ╚══██╔══╝██║  ██║██╔════╝    ██║   ██║██╔═══██╗██║██╔══██╗      ]],
      [[ ██║██╔██╗ ██║   ██║   ██║   ██║       ██║   ███████║█████╗      ██║   ██║██║   ██║██║██║  ██║      ]],
      [[ ██║██║╚██╗██║   ██║   ██║   ██║       ██║   ██╔══██║██╔══╝      ╚██╗ ██╔╝██║   ██║██║██║  ██║      ]],
      [[ ██║██║ ╚████║   ██║   ╚██████╔╝       ██║   ██║  ██║███████╗     ╚████╔╝ ╚██████╔╝██║██████╔╝      ]],
      [[ ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝        ╚═╝   ╚═╝  ╚═╝╚══════╝      ╚═══╝   ╚═════╝ ╚═╝╚═════╝       ]],
      [[                                                                                                   ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("n", "  New File", ":ene <BAR> startinsert<CR>"),
      dashboard.button("g", "  Find Text", ":Telescope live_grep<CR>"),
      dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
      dashboard.button("s", "  Restore Session", ":SessionRestore<CR>"),
      dashboard.button("L", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}

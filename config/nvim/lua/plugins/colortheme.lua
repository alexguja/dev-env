-- Monochrome take on vague: syntax flattened to a greyscale ramp so
-- structure reads through lightness, not hue. Diagnostics and git
-- colours are left to vague so they still stand out.
local mono = {
  ghost = "#5a5a64", -- comments: visible, ignorable
  faint = "#8a8a94", -- punctuation-level: operators
  dim = "#8a8a98", -- structural chrome: keywords, icons, root paths
  muted = "#9a9aa2", -- strings
  soft = "#a0a0ac", -- parameters, empty folders
  mid = "#a6a6b4", -- types, builtins, symlinks
  strong = "#adadb8", -- numbers
  bold = "#b0b0c0", -- constants
  bright = "#b8b8c4", -- properties, directories
  peak = "#c0c0ca", -- functions, special/exec files
}

return {
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require("vague").setup {
        colors = {
          comment = mono.ghost,
          keyword = mono.dim,
          operator = mono.faint,
          string = mono.muted,
          parameter = mono.soft,
          builtin = mono.mid,
          type = mono.mid,
          number = mono.strong,
          constant = mono.bold,
          property = mono.bright,
          func = mono.peak,
        },
        -- Directory drives folder names in nvim-tree (vague paints it with
        -- its hint blue) — grey it out along with nvim-tree's own groups,
        -- without touching DiagnosticHint which shares the blue.
        on_highlights = function(highlights, _)
          highlights.Directory = { fg = mono.bright }
          highlights.NvimTreeFolderIcon = { fg = mono.dim }
          highlights.NvimTreeFolderName = { fg = mono.bright }
          highlights.NvimTreeOpenedFolderName = { fg = mono.peak }
          highlights.NvimTreeEmptyFolderName = { fg = mono.soft }
          highlights.NvimTreeRootFolder = { fg = mono.dim }
          highlights.NvimTreeSpecialFile = { fg = mono.peak }
          highlights.NvimTreeExecFile = { fg = mono.peak }
          highlights.NvimTreeSymlink = { fg = mono.mid }
        end,
      }
      vim.cmd.colorscheme "vague"
    end,
  },
  {
    -- Part of the monochrome look: strip the per-filetype brand colours
    -- from file icons (nvim-tree, telescope, etc.)
    "nvim-tree/nvim-web-devicons",
    opts = {
      color_icons = false,
      default = true,
      -- devicons defines its own highlight groups on load (after the theme),
      -- so the icon grey has to be set here rather than in on_highlights
      override = {
        default_icon = { icon = "󰈚", color = mono.dim, name = "Default" },
      },
    },
  },
}

-- Trying out thorn.nvim — flip to false to go back to the tinted-mono vague
local use_thorn = true

-- Tinted-mono take on vague: the old greyscale ramp, but each step
-- blended ~15% back towards vague's original hue, so structure still
-- reads through lightness while a little colour comes through.
-- Diagnostics and git colours are left to vague so they still stand out.
local mono = {
  ghost = "#5c5c6b", -- comments: visible, ignorable
  faint = "#8c929f", -- punctuation-level: operators
  dim = "#808da1", -- structural chrome: keywords, icons, root paths
  muted = "#b5a399", -- strings
  soft = "#a99fb2", -- parameters, empty folders
  mid = "#a2abb7", -- types, builtins, symlinks
  strong = "#bfaa9a", -- numbers
  bold = "#afafc6", -- constants
  bright = "#bcbcca", -- properties, directories
  peak = "#c1aab1", -- functions, special/exec files
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
      if not use_thorn then
        vim.cmd.colorscheme "vague"
      end
    end,
  },
  {
    "jpwol/thorn.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Thorn-forest with the same treatment as the vague setup above:
      -- keywords in the Old Irony copper.
      -- towards grey so structure reads through lightness with a hint
      -- of hue, red/git/diagnostics left full so they stand out, and
      -- the whole palette dimmed by 10%.
      local copper = "#CC9878"
      local dim_factor = 0.90
      local hue_keep = 1.0 -- 1.0 = full thorn colour; lower towards 0 for the mono look
      local function parse(hex)
        local r, g, b = hex:match "^#(%x%x)(%x%x)(%x%x)$"
        if not r then
          return nil -- e.g. "NONE"
        end
        return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
      end
      local function darken(hex)
        local r, g, b = parse(hex)
        if not r then
          return hex
        end
        return string.format(
          "#%02X%02X%02X",
          math.floor(r * dim_factor),
          math.floor(g * dim_factor),
          math.floor(b * dim_factor)
        )
      end
      local function desaturate(hex)
        local r, g, b = parse(hex)
        if not r then
          return hex
        end
        local grey = 0.299 * r + 0.587 * g + 0.114 * b
        return string.format(
          "#%02X%02X%02X",
          math.floor(r * hue_keep + grey * (1 - hue_keep)),
          math.floor(g * hue_keep + grey * (1 - hue_keep)),
          math.floor(b * hue_keep + grey * (1 - hue_keep))
        )
      end
      require("thorn").setup {
        theme = "forest",
        on_highlights = function(hl, palette)
          -- thorn paints keywords with palette.orange; swap only the
          -- keyword-ish groups, leaving orange's other uses alone.
          for _, group in ipairs {
            "Keyword",
            "Statement",
            "@keyword.directive",
            "@keyword.function",
          } do
            -- some groups are string links, which can't be extended
            local spec = type(hl[group]) == "table" and hl[group] or {}
            spec.fg = copper
            hl[group] = spec
          end
          -- syntax palette values to pull towards grey; red, git, diff
          -- and background colours are deliberately left out
          local desat = { [copper] = true }
          for _, name in ipairs {
            "green_0",
            "green_1",
            "green_2",
            "green_3",
            "green_4",
            "green_5",
            "green_6",
            "yellow",
            "orange",
            "blue",
          } do
            desat[palette[name]] = true
          end
          -- runs after the copper swap so keywords get the same treatment
          for _, spec in pairs(hl) do
            if type(spec) == "table" then
              for _, key in ipairs { "fg", "bg", "sp" } do
                local value = spec[key]
                if type(value) == "string" then
                  if desat[value] then
                    value = desaturate(value)
                  end
                  spec[key] = darken(value)
                end
              end
            end
          end
        end,
      }
      if use_thorn then
        vim.cmd.colorscheme "thorn"
      end
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

return {
  -- Highlights color codes (e.g., #RRGGBB, rgb()) with their actual colors.
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end, -- Uses defaults.
}

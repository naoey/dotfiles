-- lua/plugins/rose-pine.lua
return { 
	"rose-pine/neovim", 
	name = "rose-pine",
    variant = "moon",
    dark_variant = "moon",

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    config = function()
        require("rose-pine").setup({
            styles = {
                bold = true,
                italic = false,
                transparency = true,
            }
        })
	end
}

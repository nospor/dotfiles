return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'dracula'
            },
            sections = {
                lualine_a = { 'mode', 'buffers' },
                lualine_c = {},
                -- to show select env file in rest
                lualine_x = {
                    {
                        "rest",
                        icon = "",
                        fg = "#428890"
                    }
                }
            },
        }
    }
}

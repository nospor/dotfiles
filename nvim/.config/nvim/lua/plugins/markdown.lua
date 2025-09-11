return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        config = function()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
                render_modes = { 'n', 'c', 't' },
            })
        end,
    },
    {
        -- Install markdown preview, use npx if available.
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function(plugin)
            if vim.fn.executable "npx" then
                vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
            else
                vim.cmd [[Lazy load markdown-preview.nvim]]
                vim.fn["mkdp#util#install"]()
            end
        end,
        init = function()
            if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
        end,
        keys = {
            { "<C-p>", "<cmd>MarkdownPreviewToggle<cr>", mode = "n", desc = "Markdown Prewiew Toggle" },
        },
    },
}

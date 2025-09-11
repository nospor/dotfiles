return {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    keys = {
        { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest method" },
        { "<leader>tT", "<cmd>TestFile<cr>",    desc = "Test given file" },
        { "<leader>ts", "<cmd>TestSuite<cr>",   desc = "Test suite" },
        { "<leader>tl", "<cmd>TestLast<cr>",    desc = "Test last" },
    },
    config = function()
        vim.g['test#php#phpunit#executable'] = './docker.sh phpunit'
        vim.g['test#strategy'] = 'vimux'
    end,
}

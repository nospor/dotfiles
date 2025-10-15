return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Gitsigns Preview Hunk" })
            vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Gitsigns Reset Hunk" })
            vim.keymap.set("n", "<leader>gS", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Gitsigns Stage/Unstage Hunk" })
            require("gitsigns").setup({
                current_line_blame = true, -- ← enables inline blame
                current_line_blame_opts = {
                    delay = 500,
                    virt_text_pos = "eol", -- or 'overlay' or 'right_align'
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> <abbrev_sha> - <summary>",
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']h', function()
                        if vim.wo.diff then return ']h' end
                        gs.next_hunk()
                    end, { expr = true })
                    map('n', '[h', function()
                        if vim.wo.diff then return '[h' end
                        gs.prev_hunk()
                    end, { expr = true })
                end
            })
        end,
        opts = {},
    }
}

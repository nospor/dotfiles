return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldlevel = 99
            vim.opt.foldenable = true
            --
            -- shortcut for toggling folds: za
            -- shortcut for opening all folds: zR
            -- shortcut for closing all folds: zM
            -- shortcut for opening current fold: zo
            -- shortcut for closing current fold: zc


            config.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "php", "twig", "html", "dockerfile", "css", "json", "yaml", "python" },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true, additional_vim_regex_highlighting = false, },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>"
                    }
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        include_surrounding_whitespace = false,
                        keymaps = {
                            ["i="] = "@assignment.inner",
                            ["a="] = "@assignment.outer",
                            ["ic"] = "@conditional.inner",
                            ["ac"] = "@conditional.outer",
                            ["il"] = "@loop.inner",
                            ["al"] = "@loop.outer",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            --["ac"] = "@class.outer",
                            --["ic"] = "@class.inner",
                            ["as"] = {
                                query = "@scope",
                                query_group = "locals"
                            }
                        }
                    }
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    }
}

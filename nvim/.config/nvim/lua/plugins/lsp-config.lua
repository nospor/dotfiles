return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "ts_ls", "intelephense", "jsonls", "marksman", "html", "pyright" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- configure servers
            local servers = { "lua_ls", "ts_ls", "marksman", "pyright", "html" }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
            end

            -- enable them
            vim.lsp.enable(servers)

            vim.diagnostic.config({
                virtual_text = {
                    -- severity = { min = vim.diagnostic.severity.WARN }, -- to show only warnings and errors, can be set to HINT
                    -- prefix = "●", -- could be '●', '▎', 'x'
                    spacing = 2,
                },                        -- show inline diagnostics
                signs = true,             -- show signs in the gutter
                underline = true,         -- underline problematic text
                update_in_insert = false, -- avoid updating while typing
            })

            -- format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.php", "*.html", "*.py", "*.lua" },
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })

            -- keymaps (applied globally via LspAttach event)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    -- local opts = { buffer = ev.buf, noremap = true, silent = true }
                    local opts = { noremap = true, silent = true }
                    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gk', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
                end,
            })
        end
    }
}

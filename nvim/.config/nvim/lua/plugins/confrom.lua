return {
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                -- Conform will run multiple formatters sequentially
                python = { "ruff" },
            },
        },
    }
}

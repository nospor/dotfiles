
vim.api.nvim_create_augroup("HttpKeybindings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "HttpKeybindings",
    pattern = "http",
    callback = function()
        vim.keymap.set("n", "<CR>", ":Rest run<CR>", { buffer = true })
        vim.keymap.set("n", "<leader>rl", ":Rest logs<CR>", { buffer = true, desc = "REST logs" })
        vim.keymap.set("n", "<leader>rs", ":Rest env select<CR>", { buffer = true, desc = "REST env select" })

        -- Visual mode: press Enter to run :Http and clear selection
        vim.keymap.set("v", "<CR>", ":<C-U>Rest run<CR>", { buffer = true })
    end,
})

-- set formatprg for JSON files
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "*",
--     callback = function()
--         vim.bo.formatprg = "jq ."
--     end,
-- })
--

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "*",
--   callback = function()
--     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--     for _, line in ipairs(lines) do
--       if line:match("^%s*[%[{]") then
--         vim.bo.formatprg = "jq ."
--         return
--       end
--     end
--   end,
-- })
--


return {
    "rest-nvim/rest.nvim"
}

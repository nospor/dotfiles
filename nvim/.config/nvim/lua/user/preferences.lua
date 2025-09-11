vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.title = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.backup = false
vim.o.ignorecase = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'

vim.o.termguicolors = true

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

vim.o.expandtab = true
vim.o.scrolloff = 10
vim.o.showcmd = true
vim.o.history = 1000
vim.o.number = true
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest'
vim.o.hidden = true
--vim.o.colorcolumn = "80"
vim.o.cursorline = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Go to left window" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Go to lower window" })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Go to upper window" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Go to right window" })

-- in visual mode when you paste, it doesn't yank the text you replace
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- setting b shortcut to switch to buffers
-- vim.keymap.set('n', '<leader>b', '<cmd>buffers<cr>:buffer ', {desc = 'switch buffer'})

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<cmd>quitall<cr>', { desc = 'Exit vim' })

-- vim.keymap.set('n', 'a', 'i', { desc = 'Make a as i' })

vim.keymap.set('i', '<c-space>', '<c-x><c-o>')

-- command to copy Current Buffer path to clipboard
vim.api.nvim_create_user_command("CBpath", function()
--    local path = vim.fn.expand("%:p") -- this is for full path
    local path = vim.fn.expand("%:~:.") -- this is for relative path
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- TERMINAL
vim.keymap.set('t', '<leader><Esc>', [[<C-\><C-n>]], { desc = 'Escape terminal mode' })
vim.opt.guicursor = {
  "n-v-c:block",          -- Normal/Visual/Command-line -> block cursor
  "i-ci:ver25",           -- Insert modes -> vertical bar, 25% width
  "r:hor20",              -- Replace -> horizontal bar, 20% height
  "t:ver25"
}
-- END TERMINAL

vim.o.clipboard = "unnamedplus"
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x' }, 'gp', '"+p', { desc = 'Paste clipboard text' })

vim.keymap.set({ 'v' }, '<leader>vj', [[:'<,'>!jq .<CR>]], { desc = 'Run jq on selected text' })
vim.keymap.set('v', '<leader>vp', [[:'<,'>!~/scripts/phpcbf-wrapper.sh<CR>]],
    { desc = 'Auto-fix PHP with phpcbf (wrapper)' })

vim.keymap.set("n", "<Tab>", function()
    if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
        vim.cmd("write")
    end
    vim.cmd("bnext")
end, { silent = true })

vim.keymap.set("n", "<S-Tab>", function()
    if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
        vim.cmd("write")
    end
    vim.cmd("bprevious")
end, { silent = true })


-- moving lines up and down
vim.keymap.set('n', '<c-s-up>', "<cmd>m -2<cr>==", { desc = 'Move line(s) up' })
vim.keymap.set('n', '<c-s-down>', '<cmd>m +1<cr>==', { desc = 'Move line(s) down' })
vim.keymap.set('v', '<C-S-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', '<C-S-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('i', '<C-S-Up>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up in insert mode' })
vim.keymap.set('i', '<C-S-Down>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down in insert mode' })

-------------------------------------------------------------------------------
--                           Folding section
-------------------------------------------------------------------------------

-- Checks each line to see if it matches a markdown heading (#, ##, etc.):
-- It’s called implicitly by Neovim’s folding engine by vim.opt_local.foldexpr
function _G.markdown_foldexpr()
    local lnum = vim.v.lnum
    local line = vim.fn.getline(lnum)
    local heading = line:match("^(#+)%s")
    if heading then
        local level = #heading
        if level == 1 then
            -- Special handling for H1
            if lnum == 1 then
                return ">1"
            else
                local frontmatter_end = vim.b.frontmatter_end
                if frontmatter_end and (lnum == frontmatter_end + 1) then
                    return ">1"
                end
            end
        elseif level >= 2 and level <= 6 then
            -- Regular handling for H2-H6
            return ">" .. level
        end
    end
    return "="
end

local function set_markdown_folding()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
    vim.opt_local.foldlevel = 99

    -- Detect frontmatter closing line
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local found_first = false
    local frontmatter_end = nil
    for i, line in ipairs(lines) do
        if line == "---" then
            if not found_first then
                found_first = true
            else
                frontmatter_end = i
                break
            end
        end
    end
    vim.b.frontmatter_end = frontmatter_end
end

-- Use autocommand to apply only to markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = set_markdown_folding,
})

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
    -- Move to the top of the file without adding to jumplist
    vim.cmd("keepjumps normal! gg")
    -- Get the total number of lines
    local total_lines = vim.fn.line("$")
    for line = 1, total_lines do
        -- Get the content of the current line
        local line_content = vim.fn.getline(line)
        -- "^" -> Ensures the match is at the start of the line
        -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
        -- "%s" -> Matches any whitespace character after the "#" characters
        -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
        if line_content:match("^" .. string.rep("#", level) .. "%s") then
            -- Move the cursor to the current line without adding to jumplist
            vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
            -- Check if the current line has a fold level > 0
            local current_foldlevel = vim.fn.foldlevel(line)
            if current_foldlevel > 0 then
                -- Fold the heading if it matches the level
                if vim.fn.foldclosed(line) == -1 then
                    vim.cmd("normal! za")
                end
                -- else
                --   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
            end
        end
    end
end

local function fold_markdown_headings(levels)
    -- I save the view to know where to jump back after folding
    local saved_view = vim.fn.winsaveview()
    for _, level in ipairs(levels) do
        fold_headings_of_level(level)
    end
    vim.cmd("nohlsearch")
    -- Restore the view to jump to where I was
    vim.fn.winrestview(saved_view)
end

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set("n", "zj", function()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfj", function()
    -- Reloads the file to refresh folds, otheriise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 1 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set("n", "zk", function()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfk", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3, 2 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 2 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set("n", "zl", function()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfl", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 3 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 4 or above
vim.keymap.set("n", "z;", function()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mf;", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 4 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
-- vim.keymap.set("n", "<CR>", function()
--     -- Get the current line number
--     local line = vim.fn.line(".")
--     -- Get the fold level of the current line
--     local foldlevel = vim.fn.foldlevel(line)
--     if foldlevel == 0 then
--         vim.notify("No fold found", vim.log.levels.INFO)
--     else
--         vim.cmd("normal! za")
--         vim.cmd("normal! zz") -- center the cursor line on screen
--     end
-- end, { desc = "[P]Toggle fold" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for unfolding markdown headings of level 2 or above
-- Changed all the markdown folding and unfolding keymaps from <leader>mfj to
-- zj, zk, zl, z; and zu respectively lamw25wmal
vim.keymap.set("n", "zu", function()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfu", function()
    -- Reloads the file to reflect the changes
    vim.cmd("edit!")
    vim.cmd("normal! zR") -- Unfold all headings
    vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Unfold all headings level 2 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- gk jummps to the markdown heading above and then folds it
-- zi by default toggles folding, but I don't need it lamw25wmal
vim.keymap.set("n", "zi", function()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- Difference between normal and normal!
    -- - `normal` executes the command and respects any mappings that might be defined.
    -- - `normal!` executes the command in a "raw" mode, ignoring any mappings.
    vim.cmd("normal gk")
    -- This is to fold the line under the cursor
    vim.cmd("normal! za")
    vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold the heading cursor currently on" })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------

vim.opt.sessionoptions = {
    "buffers",
    "curdir",
    "tabpages",
    "winsize",
    "help",
    "globals",
    "skiprtp",
    "folds",
    "localoptions"
}

vim.o.spell = true
vim.o.spelloptions = "camel,noplainbuffer"
vim.o.spelllang = "en"

vim.keymap.set("n", "<leader>tt", ":tabnext<CR>", { desc = "Next tab" })

----------------------
--- Custom MACROS ----
----------------------

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

vim.api.nvim_create_augroup("VarDumpPhpMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    callback = function()
        vim.fn.setreg("v", "viwyovar_dump($" .. esc .. "pA;exit;" .. esc .. "")
        vim.fn.setreg("p", "viwyoprint_r($" .. esc .. "pA;exit;" .. esc .. "")
        vim.fn.setreg("d", "viwyodump($" .. esc .. "pA;" .. esc .. "")
    end,
    group = "VarDumpPhpMacro"
})


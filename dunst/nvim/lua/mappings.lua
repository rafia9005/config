require "nvchad.mappings"
-- add yours mapping here
local map = vim.keymap.set
local lsp = vim.lsp
local builtin = require "telescope.builtin"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Leader>f", "<Plug>(prettier-format)", { silent = true })
map("n", "<C-q>", ":bd<CR>", { desc = "Close buffer", silent = true })
-- telescope mapping
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
-- next tab mapping
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next tab", silent = true })

-- map("n", "<Tab>", "", { desc = "Next tab", silent = true })
-- risize width vsp or sp mapping
map("n", "<C-w>h", ":vertical resize -10<CR>", { desc = "Resize window left", silent = true })
map("n", "<C-w>l", ":vertical resize +10<CR>", { desc = "Resize window right", silent = true })
map("n", "<C-w>k", ":resize +10<CR>", { desc = "Resize window up", silent = true })
map("n", "<C-w>j", ":resize -10<CR>", { desc = "Resize window down", silent = true })
-- clear search highlight mapping
map("n", "<leader>h", ":noh<CR>", { desc = "Clear search highlights", silent = true })
-- rename same text mapping
map("n", "<leader>rn", lsp.buf.rename, { desc = "LSP Rename" })
-- rest nvim
map("n", "<leader>rr", "<Plug>RestNvim", { noremap = true, silent = true })
map("n", "<leader>rp", "<Plug>RestNvimPreview", { noremap = true, silent = true })
map("n", "<leader>rl", "<Plug>RestNvimLast", { noremap = true, silent = true })

-- NeoTree configure
map("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })

-- Copilot github
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.keymap.set("n", "<C-A-b>", function() require("CopilotChat").toggle() end, { desc = "Toggle (CopilotChat)" })

-- Codium AI
map('i', '<C-g>', 'codeium#Accept()', { expr = true, silent = true })
map('i', '<C-;>', 'codeium#CycleCompletions(1)', { expr = true, silent = true })
map('i', '<C-,>', 'codeium#CycleCompletions(-1)', { expr = true, silent = true })
map('i', '<C-x>', 'codeium#Clear()', { expr = true, silent = true })


-- nvim-mdview: readable, editable markdown with no dependencies.
-- Configure with `vim.g.mdview = { conceallevel = 2, wrap = true, ... }` before this loads.
if vim.b.did_mdview_ftplugin then return end
vim.b.did_mdview_ftplugin = true

local opts = vim.tbl_extend("force", {
  enable = true,          -- set false to disable everything below
  conceallevel = 2,       -- 2 hides markup (**, `, link URLs); 0 shows raw
  concealcursor = "",     -- "" reveals raw markup on the cursor line; "n" keeps it hidden in normal mode
  wrap = true,            -- soft-wrap at word boundaries
  indent = 2,             -- shiftwidth/tabstop for markdown
  map = "<leader>m",      -- buffer-local toggle key; false for none
}, vim.g.mdview or {})
if not opts.enable then return end

-- Neovim 0.11 usually starts this itself; start it explicitly if not.
pcall(vim.treesitter.start)

local wo = vim.wo[0][0]
wo.conceallevel = opts.conceallevel
wo.concealcursor = opts.concealcursor
wo.wrap = opts.wrap
wo.linebreak = opts.wrap
wo.breakindent = opts.wrap
wo.relativenumber = false
wo.colorcolumn = ""
vim.bo.shiftwidth = opts.indent
vim.bo.tabstop = opts.indent

if opts.map then
  vim.keymap.set("n", opts.map, "<cmd>MdViewToggle<cr>",
    { buffer = true, desc = "toggle markdown concealment" })
end

vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. "|" or "")
  .. "setlocal conceallevel< concealcursor< wrap< linebreak< breakindent< relativenumber< colorcolumn< shiftwidth< tabstop<"
  .. "|unlet! b:did_mdview_ftplugin"

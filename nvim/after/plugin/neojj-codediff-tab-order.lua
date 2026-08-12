-- codediff's `gf` (open_in_prev_tab, see codediff/ui/view/actions/panes.lua)
-- opens the real file in "the tab before the diff tab". When neojj opens a
-- codediff view, codediff.ui.view.create() does `vim.cmd("tabnew")`, which by
-- default lands the diff tab right *after* neojj's own tab - so "the tab
-- before" is neojj itself, and `gf` clobbers neojj's window.
--
-- Fix: after codediff creates its tab, move it to sit *before* the tab we
-- came from, but only when that tab is neojj's own UI (filetype starting
-- with "Neojj", same convention neojj's own lib/jump.lua uses). Then "the
-- tab before the diff tab" is never neojj.
--
-- Temporary local patch; the real fix belongs upstream in
-- neojj/integrations/codediff.lua (see neojj-codediff-tab-order.patch).

local ok, view = pcall(require, "codediff.ui.view")
if not ok then
  return
end

local orig_create = view.create
view.create = function(session_config, filetype, on_ready)
  local prev_tab = vim.api.nvim_get_current_tabpage()
  local result = orig_create(session_config, filetype, on_ready)

  if vim.api.nvim_tabpage_is_valid(prev_tab) and vim.api.nvim_get_current_tabpage() ~= prev_tab then
    local win = vim.api.nvim_tabpage_list_wins(prev_tab)[1]
    local buf = win and vim.api.nvim_win_get_buf(win)
    local ft = buf and vim.api.nvim_get_option_value("filetype", { buf = buf }) or ""
    if vim.startswith(ft, "Neojj") then
      vim.cmd("tabmove -1")
    end
  end

  return result
end

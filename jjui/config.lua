function setup(config)
  -- Open file in nvim at the first changed line
  config.action("open-in-nvim", function()
    local file = context.file()
    local change_id = context.change_id()

    if not file or file == "" or not change_id or change_id == "" then
      return
    end

    -- --context 0 means the hunk header's +new_start is exactly the first changed line
    local diff_output, _ = jj("diff", "-r", change_id, "--git", "--context", "0", "--", file)
    local line_num = 1
    if diff_output then
      local new_start = diff_output:match("@@%s+%-[%d,]+%s+%+(%d+)")
      if new_start then
        line_num = tonumber(new_start)
      end
    end

    -- Single-quote the path, escaping any literal single quotes in the filename
    local quoted = "'" .. file:gsub("'", "'\\''") .. "'"
    exec_shell(string.format("nvim +%d %s", line_num, quoted))
  end, {
    key = "o",
    scope = "revisions.details",
    desc = "open file in nvim at first changed line",
  })

  -- Smart q / esc swap
  --
  -- Default bindings: esc -> ui.cancel (go back), q -> ui.quit (quit app)
  -- Goal: q goes back everywhere; q quits (and esc quits) from the root revisions list.
  --
  -- Strategy:
  --   1. Override ui.quit so q goes back in every context (calls the real cancel).
  --   2. In the revisions scope specifically, bind both q and esc to a real-quit
  --      action. Scope-specific bindings win over the global ui-scope override,
  --      so q/esc at root quit; q/esc inside a sub-panel still go back.

  -- Step 1: make q go back everywhere by default
  config.action("ui.quit", function()
    jjui.builtin.ui.cancel()
  end)

  -- Step 2: real quit, used only from the root revisions list
  config.action("quit-jjui", function()
    jjui.builtin.ui.quit()
  end)
  config.bind({ action = "quit-jjui", key = "q",   scope = "revisions", desc = "quit" })
  config.bind({ action = "quit-jjui", key = "esc", scope = "revisions", desc = "quit" })
end

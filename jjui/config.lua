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

# TO-DO

# Nvim 13
* Multi cursor
* Build muscle memory for `al` instead of `ggVG`
  * (one other command, don't remember, like al for a line)
* Better fix for ruby indent with or without treesitter. Removing `.` right now, but maybe a better way exists. If we turned off the indenting with treesitter then `.` work, but indentation breaks. Not sure what's going on there. But it does say indenting is experimental, so maybe that?
* Long external cause weird character wrapping when concealed. Track issue here: https://github.com/neovim/neovim/pull/42370
  * OMG ITS MERGED!!!

## Obsidian (See Obsidian Help)

## Neovim
* Better fold keybindings (za currently)
* Add ruby dap back in, need it more often then I think I will
* Install lua lsp for goodness sake

## Harper
* Have ignore Harper error permanently ignore it, even on file close/reopen
  * This might be happening. But the thing I added isn't doing anything.
* Only sometimes works. Look at a Markdown file like such, and see it only shows the capital letter warning for one of the lines with a code action. But other ones do have yellow underline (not sure if that's Harper or not)
```markdown
what is happening here. this is also broken. when is this one

when about this one
```

## JJ
* Remove `lily_<stuf>??` commits when doing a fetch all. Seems to happen automatically when local branch is exactly even with main, but if it is behind then it fails and I have to manually change it. Should be simple enough to just nuke it if it's no longer really there.
  * Last commit seemed to handle it fine, even w/ the squash. Maybe it's only here sometimes and can be ignored?

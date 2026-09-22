# TO-DO

## Obsidian (See Obsidian Help)(
* Built in auto commands (oops)
* (maybe) smart action (<CR>) do not create checkboxes? Feels awkward and not useful most of the time
* Long external cause weird character wrapping when concealed. Shou in theory fixed in nvim 0.13: https://github.com/neovim/neovim/issues/18282

## Normal Dev TODO
* Add tscheck to lints
  * Cannot easily fix this, because it wont let you have files specified at the same time that the configuration file is passed in via `-p`. I think the closest thin I could think of would be to make a temp file of the configuration, update it with the target files, run it with that, and close the file when we are done with it. Very doable. Annoying. But doable.
* Fix `jj fa` to not crash out on bookmarks that have been deleted when the fetch happened.

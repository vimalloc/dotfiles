if status is-interactive
  set --global fish_key_bindings fish_default_key_bindings
  fish_config theme choose "catppuccin-frappe"

  function sync_history --on-event fish_postexec
    history save
    history merge
  end

  # Homebrew autocompletion
  if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end

  fish_add_path /opt/homebrew/lib/ruby/gems/4.0.0/bin
end


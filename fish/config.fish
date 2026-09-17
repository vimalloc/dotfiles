if status is-interactive
  set --global fish_key_bindings fish_default_key_bindings
  fish_config theme choose "catppuccin-frappe"

  function sync_history --on-event fish_postexec
    history save
    history merge
  end

  # Heroku autocompletion
  if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end
end

# Add docker to path
set -gx PATH "/Users/lily/.docker/bin" $PATH

# Add pnpm to path
set -gx PNPM_HOME '/Users/lily/Library/pnpm'
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end

if status is-interactive
    # Commands to run in interactive sessions can go here
  alias vi nvim
  alias vim nvim
  alias lv lvim
  alias py /opt/homebrew/bin/python3
  alias python3 /opt/homebrew/bin/python3
  alias python /opt/homebrew/bin/python3
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


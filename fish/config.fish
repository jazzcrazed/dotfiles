if test "$os" = "darwin"
  # Homebrew on Mac
  eval "$(/opt/homebrew/bin/brew shellenv)"
end

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Linux-specific config
set -l os (uname)
if test "$os" = "linux"
  source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# My aliases
alias vim nvim

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/jazzcrazed/.lmstudio/bin
# End of LM Studio CLI section

# opencode
if test "$os" = "linux"
  fish_add_path /home/jazzcrazed/.opencode/bin
end
if test "$os" = "darwin"
  fish_add_path /Users/marcocarag/.opencode/bin
end
export PATH="$HOME/.local/bin:$PATH"

# Snap
fish_add_path /var/lib/snapd/snap/bin

# Starship prompt (replaced Powerlevel10k instant prompt)
export APPLE_SSH_ADD_BEHAVIOR="macos"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GOPATH="${HOME}/Code/go"

set -o vi


HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Initialize starship prompt (if installed)
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_SHELL="zsh"
  eval "$(starship init zsh)"
fi

eval "$(fnm env --use-on-cd)"


# Removed legacy git prompt, aliases, and functions for cleanup
export TERM="xterm-256color"

# fzf configuration
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='find . -type f -not -path ".*/.*"'
export FZF_CTRL_T_COMMAND='find . -type f -not -path ".*/.*"'
export FZF_ALT_C_COMMAND='find . -type d -not -path ".*/.*"'

# Source fzf key bindings and completion (dynamic path)
if command -v brew >/dev/null 2>&1; then
  FZF_PREFIX="$(brew --prefix fzf 2>/dev/null)"
  if [[ -n $FZF_PREFIX ]]; then
    source "$FZF_PREFIX/shell/key-bindings.zsh"
    source "$FZF_PREFIX/shell/completion.zsh"
  fi
fi

# Using fnm for Node version management (removed previous nvm init)

# Completion init (cached, speeds startup)
autoload -Uz compinit
if [[ -f ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# --- Dynamic terminal title: project (branch) for Ghostty ---
# Sets window/tab title to "project (branch)" if in a git repo, else last directory name.
# Robust branch detection + dual OSC sequences (0 and 2) for compatibility.
# Hooks: precmd (each prompt), chpwd (directory changes).
function _update_terminal_title() {
  local git_root project branch title
  if git_root=$(command git rev-parse --show-toplevel 2>/dev/null); then
    project="${git_root:t}"
    # Primary: human branch name (ignores detached)
    branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null)
    # Fallbacks for detached HEAD or unusual states
    if [[ -z $branch || $branch == HEAD ]]; then
      branch=$(command git branch --show-current 2>/dev/null)
    fi
    if [[ -z $branch ]]; then
      branch=$(command git describe --tags --always --dirty 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null)
    fi
    if [[ -n $branch ]]; then
      title="${project} (${branch})"
    else
      title="${project}"
    fi
  else
    title="${PWD:t}"
  fi
  # Send both icon+window (0) and window-only (2) titles
  printf '\033]0;%s\007\033]2;%s\007' "$title" "$title"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _update_terminal_title

# Ensure our title updater runs LAST in precmd (after Ghostty/starship)
add-zsh-hook precmd _update_terminal_title
if (( $+precmd_functions )); then
  precmd_functions=(${precmd_functions:#_update_terminal_title} ${precmd_functions} _update_terminal_title)
fi

# Preexec: temporarily show running command as title
function _preexec_temp_title() {
  # $1 is the command about to run
  local cmd=$1
  # Abbreviate very long commands
  if (( ${#cmd} > 80 )); then
    cmd="${cmd[1,77]}..."
  fi
  # Preserve project/branch prefix if in git repo
  local git_root project branch prefix
  if git_root=$(command git rev-parse --show-toplevel 2>/dev/null); then
    project="${git_root:t}"
    branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null || command git branch --show-current 2>/dev/null)
    if [[ -n $branch ]]; then
      prefix="${project} (${branch})"
    else
      prefix="${project}"
    fi
    printf '\033]0;%s — %s\007\033]2;%s — %s\007' "$prefix" "$cmd" "$prefix" "$cmd"
  else
    printf '\033]0;%s\007\033]2;%s\007' "$cmd" "$cmd"
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _preexec_temp_title

# Initial set for early shell (first prompt)
_update_terminal_title

# (Removed attention pattern watch & bell block for performance)

# --- Force block cursor + color every prompt (override any program changes) ---
function _force_block_cursor() {
  # 2 => steady block cursor (DECSCUSR), then OSC 12 sets cursor color (xterm sequence many terminals support)
  printf '\e[2 q\033]12;#00ff5f\007'
}
add-zsh-hook precmd _force_block_cursor
if (( $+precmd_functions )); then
  precmd_functions=(${precmd_functions:#_force_block_cursor} ${precmd_functions} _force_block_cursor)
fi

# Ensure cursor stays block across vi-mode and keymap switches
if [[ -o interactive ]]; then
  zle -N zle-line-init _force_block_cursor
  zle -N zle-keymap-select _force_block_cursor
fi

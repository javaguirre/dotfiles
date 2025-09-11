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

# --- Attention Pattern Watch & Flashing Title ("enter") ---
# Watches a log file for lines containing the pattern (default: "enter") and
# triggers a bell + flashing title until the terminal tab/window is focused.
# Focus detection (macOS) polls frontmost app via osascript; stops when Ghostty or VS Code focused.
# Configure:
#   OPENCODE_WATCH_FILE  : file to tail (default: ~/.opencode/log)
#   OPENCODE_WATCH_PATTERN: pattern (default: enter, case-insensitive)
#   ATTN_FLASH_MESSAGE   : message in flashing title (default: ATTENTION: enter detected)
#   ATTN_FLASH_INTERVAL  : seconds between flash toggles (default: 0.8)
#   ATTN_ENABLE_NOTIFY   : if set to 1 and osascript present, show macOS notification
# NOTE: Requires the producing process to append to the watched file.

: ${OPENCODE_WATCH_FILE:="$HOME/.opencode/log"}
: ${OPENCODE_WATCH_PATTERN:="enter"}
: ${ATTN_FLASH_MESSAGE:="🚨 enter detected"}
: ${ATTN_FLASH_INTERVAL:=0.8}
: ${ATTN_ENABLE_NOTIFY:=1}

# Ensure directory exists for default log file
if [[ ! -e ${OPENCODE_WATCH_FILE:h} ]]; then
  mkdir -p "${OPENCODE_WATCH_FILE:h}" 2>/dev/null || true
fi

function _attention_trigger() {
  # If terminal already focused (macOS check) skip flashing but still optional bell
  local frontApp=""
  if command -v osascript >/dev/null 2>&1; then
    frontApp=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null || echo "")
  fi
  # Audible bell always
  printf '\a'
  # Only proceed to flash if not currently focused on Ghostty or VS Code
  if [[ "$frontApp" == "Ghostty" || "$frontApp" == "Visual Studio Code" ]]; then
    return
  fi
  # macOS notification (optional)
  if (( ATTN_ENABLE_NOTIFY )) && command -v osascript >/dev/null 2>&1; then
    osascript -e "display notification \"🚨 Pattern '${OPENCODE_WATCH_PATTERN}' detected\" with title \"Terminal\""
  fi
  # Start flashing if not already active
  if [[ -z ${ATTN_FLASH_ACTIVE:-} || ${ATTN_FLASH_ACTIVE} -eq 0 ]]; then
    ATTN_FLASH_ACTIVE=1
    _attention_flash_loop &!  # background
    ATTN_FLASH_LOOP_PID=$!
  fi
}

function _attention_flash_loop() {
  # Loop until focus returns (macOS) OR flash manually cleared.
  local show=1 frontApp
  while (( ATTN_FLASH_ACTIVE )); do
    if command -v osascript >/dev/null 2>&1; then
      frontApp=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null || echo "")
      if [[ "$frontApp" == "Ghostty" || "$frontApp" == "Visual Studio Code" ]]; then
        # Focus regained; stop flashing
        ATTN_FLASH_ACTIVE=0
        break
      fi
    fi
    if (( show )); then
      printf '\033]0;%s\007\033]2;%s\007' "$ATTN_FLASH_MESSAGE" "$ATTN_FLASH_MESSAGE"
      show=0
    else
      _update_terminal_title
      show=1
    fi
    sleep "$ATTN_FLASH_INTERVAL"
  done
  _update_terminal_title
}

# Manual clear command (user can run `attention_clear`)
function attention_clear() {
  if [[ -n ${ATTN_FLASH_LOOP_PID:-} ]]; then
    ATTN_FLASH_ACTIVE=0
    kill $ATTN_FLASH_LOOP_PID 2>/dev/null || true
    unset ATTN_FLASH_LOOP_PID
    _update_terminal_title
  fi
}

# Also clear on next typed command (preexec) once focused
function _attention_preexec_clear() {
  if [[ -n ${ATTN_FLASH_LOOP_PID:-} ]]; then
    attention_clear
  fi
}
add-zsh-hook preexec _attention_preexec_clear 2>/dev/null || true

function _pattern_watch_start() {
  # Only start if file exists or can be created.
  if [[ ! -f "$OPENCODE_WATCH_FILE" ]]; then
    # Touch file so tail -F starts immediately
    : > "$OPENCODE_WATCH_FILE" 2>/dev/null || return
  fi
  if [[ -n ${OPENCODE_OUTPUT_WATCH_PID:-} ]] && kill -0 $OPENCODE_OUTPUT_WATCH_PID 2>/dev/null; then
    return
  fi
  {
    tail -n0 -F "$OPENCODE_WATCH_FILE" 2>/dev/null | while IFS= read -r line; do
      # Case-insensitive match
      if [[ ${line:l} == *${OPENCODE_WATCH_PATTERN:l}* ]]; then
        _attention_trigger
      fi
    done
  } &!
  OPENCODE_OUTPUT_WATCH_PID=$!
}

_pattern_watch_start
# --- End Attention Pattern Watch ---

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/anto/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/anto/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/anto/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/anto/.fzf/shell/key-bindings.zsh"


# custom aliases
alias load="code ~/.zshrc"
alias reload="source ~/.zshrc"
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias ts="tree -L 2"
alias weather="curl wttr.in"
alias snowsql="/Applications/SnowSQL.app/Contents/MacOS/snowsql"
alias circles="cd ~/Desktop/circles && tree -L 1"
alias orbit-sync='cd ~/Desktop/circles/pyscripts && python3 sync-repo.py && cd -'
alias vim="nvim"
alias vi="nvim"
alias lv="lvim"
alias lg="lazygit"
alias k=kubectl
alias pn=pnpm
# alias go=colorgo

mcd()
{
  test -d "$1" || mkdir "$1" && cd "$1"
}

export PATH="/opt/homebrew/opt/curl/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# jump words using ctrl arrow
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/wongshennan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/wongshennan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/wongshennan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/wongshennan/google-cloud-sdk/completion.zsh.inc'; fi


# flutter
export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"

# lvim
export PATH="/Users/wongshen.nan/.local/bin/lvim:${PATH}"


# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/Users/wongshen.nan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

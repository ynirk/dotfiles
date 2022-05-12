# Oh my zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
COMPLETION_WAITING_DOTS="true"
plugins=(docker git golang kubectl)
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'

export HISTSIZE=10000000
export APPEND_HISTORY
export HIST_IGNORE_ALL_DUPS
export HIST_FIND_NO_DUPS
export HIST_SAVE_NO_DUPS
export HIST_IGNORE_SPACE

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

unsetopt nomatch

case `uname` in
  Darwin)
    # homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    if type brew &>/dev/null; then
      FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
      FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

      autoload -Uz compinit
      compinit
    fi

    export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"

    alias ls='gls --color=auto'
    alias cat='bat -p'
    alias find='fd'
    alias vim='nvim'
    alias vi='nvim'
  ;;
  Linux)
    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    # pinentry
    export PINENTRY_USER_DATA=Linux

    alias cat='batcat -p'
    alias find='fdfind'
  ;;
esac

# yubikey ssh
export KEYID=0xDDA8DEDBF8B81076
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

## tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

export AWS_PAGER=""

# personal env
for file in ~/.{functions,work}; do
        if [[ -r "$file" ]] && [[ -f "$file" ]]; then
                  source "$file"
        fi
done
unset file

# alias
alias grep='rg'
alias diff='diff --color=auto'
alias ll='ls -alsh'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
USER_PATH=/home/$(whoami)
if [[ $(whoami) == "root" ]]; then
    USER_PATH=/root
fi
export ZSH=$USER_PATH/.oh-my-zsh
ZSH_THEME="mh"
export FZF_BASE=/usr/bin/fzf

plugins=(
  git
  dotenv
  fzf
)

source $ZSH/oh-my-zsh.sh
export SSH_KEY_PATH="~/.ssh/cp_key"

source /usr/share/zsh/scripts/zplug/init.zsh

alias "cd.."="cd .."
autoload -U compinit && compinit

export QT_QPA_PLATFORMTHEME=qt5ct
PATH=$PATH:$USER_PATH/.cargo/bin
PATH=$PATH:$USER_PATH/.gem/ruby/2.5.0/gems/colorls-1.1.1/exe
mkcd() { mkdir -p "$1" && cd "$1"; }
alias "ll"="colorls -l --group-directories-first --gs --dark"
alias "la"="ls --group-directories-first -hal"
alias ":q"="exit"
alias "rm -rf /"="echo \"read mail really fast\""
alias "pls"="sudo \$(history | tail -n1 | cut --complement -d' ' -f1)"
alias "copy"="xsel -ib"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS='
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

zplug 'wfxr/forgit', defer:1
zplug 'zdharma/fast-syntax-highlighting'
zplug 'fALKENdk/mylocation'
zplug 'romkatv/powerlevel10k', as:theme, depth:1

zplug load

shrug() {
    echo $em_shrug
    echo $em_shrug | xsel -i -b
}

run() {
    nohup $* >/dev/null 2>&1 &
}

open() {
    nohup xdg-open $1 >/dev/null 2>&1 &
}

wrun() {
    ~/.scripts/open_floating_window.sh $*
}

wopen() {
    wrun xdg-open $*
}

pw() {
    bw get password $1 | tr -d '\n' | xsel -i -b
}

bw-unlock() {
    export BW_SESSION="$(bw unlock --raw)"
}

setwall() {
    betterlockscreen -u $1 -r 2560x1440
    betterlockscreen -w
}

#neofetch



autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli

export PATH=$PATH:~/.scripts
export EDITOR=/usr/bin/vim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

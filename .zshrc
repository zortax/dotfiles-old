export FZF_BASE=/usr/bin/fzf

source /usr/share/zsh/share/antigen.zsh

export QT_QPA_PLATFORMTHEME=qt5ct

PATH=$PATH:$USER_PATH/.cargo/bin
PATH=$PATH:$USER_PATH/.gem/ruby/2.5.0/gems/colorls-1.1.1/exe


source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS='
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

export ZSH_AUTOSUGGEST_USE_ASYNC=1

antigen use oh-my-zsh

antigen bundle 'wfxr/forgit'
antigen bundle 'zdharma/fast-syntax-highlighting'
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'reobin/typewritten'

antigen theme typewritten
antigen apply

source ~/.scripts/aliases.zsh
source ~/.scripts/shortcuts.zsh

export PATH=$PATH:~/.scripts
export EDITOR=/usr/bin/vim


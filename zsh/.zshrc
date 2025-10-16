# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/robertn/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"

# this must be commented out for tmux to work properly
#export TERM="xterm-256color"

export PATH="/home/linuxbrew/.linuxbrew/bin/:$HOME/.fzf/bin:$PATH:/opt/nvim-linux-x86_64/bin"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="af-magic"

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)

plugins=(git git-flow sudo wd docker zsh-autosuggestions)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

#source $ZSH/oh-my-zsh.sh

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

dstop() { docker stop $(docker ps -a -q); }
drmi() { docker rmi $(docker images -q); }
#remove only dangling images
drmid() { docker rmi $(docker images -f dangling=true -q) }
#remove all dangling volumes. It will not remove used volumes
drmv() { docker volume rm $(docker volume ls -q -f dangling=true) }
dexec() { docker exec -i -t $@ bash; }
dexecash() { docker exec -i -t $@ ash; }
dup() { docker-compose up -d; }
dps() { docker ps $@ | less -S; }
#dps() { docker ps --format="table {{.Image}}\t{{.Ports}}\t{{.Status}}\t{{.Names}}" $@; }
ds() { ./docker.sh $@; }
dc() { docker compose $@; }
dcip() { docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $@ }
drmnonei() { docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi }
#
#cupmm() { composer73 up mediatel/mapping; }
#pstorm() { /home/robertn/PhpStorm-193.6494.47/bin/phpstorm.sh }
#composer() { docker run --rm -it --dns=192.168.0.112 --dns-search=mediatel.co.uk \
#    -v $(pwd):/app \
#    -v ~/.composer:/home/composer/.composer \
#    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
#    composer $@
#}
#
#composerprv() { docker run --rm -it \
#    -v $(pwd):/usr/src/app \
#    -v ~/.composer:/home/composer/.composer \
#    -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
#    composer $@
#}
#
#composer7() { 
#    docker run --rm -v $(pwd):/app prooph/composer:7.1 $@
#}
#
#composer73() { 
#    docker run --rm -it --dns=192.168.0.112 --dns-search=mediatel.co.uk \
#    -v $(pwd):/app \
#    -v ~/.composer:/home/composer/.composer \
#    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
#    prooph/composer:7.3 $@
#}
#
memoryuse() { ps aux  | awk '{print $6/1024 " MB\t\t" $11}'  | sort -n }
#node() { docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app node:4 node $@}
##npm() {docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app node:4 npm $@}
npm8() { docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app node:8 npm $@}
npm10() { docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app node:10 npm $@}
node10() { docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app node:10 node $@}
mapwatch() { docker run -it --name=mapwatcher --rm -v "$PWD":/usr/src/app -p 35729:35729 -w /usr/src/app node:10 ./node_modules/.bin/gulp watch }
mapstopwatch() { docker stop mapwatcher }
surveyswatch() { docker run -it --name=surveywatcher --rm -v "$PWD":/usr/src/app -w /usr/src/app node:8 ./node_modules/.bin/encore dev --watch }
surveyswatchstop() { docker stop surveywatcher }
surveysproduction() { docker run -it --name=surveywatcher --rm -v "$PWD":/usr/src/app -w /usr/src/app node:8 ./node_modules/.bin/encore production  }
docker-volume-size() { sudo du -sh $(docker volume inspect --format '{{ .Mountpoint }}' $@)}
doc2txt() { libreoffice --headless --convert-to txt $@ }
#
#phan() { docker run -v $PWD:/mnt/src --rm -u "$(id -u):$(id -g)" cloudflare/phan:latest }
#
#runc() { docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 g++ $1 && ./a.out }
#
runjava() { docker run --rm -it -v "$PWD":/usr/src/myapp -w /usr/src/myapp openjdk:11 javac $1.java && docker run --rm -it -v "$PWD":/usr/src/myapp -w /usr/src/myapp openjdk:11 java $1 }
#
#
export DOCKER_ENV_USR="robertn"
export BEHAT_ENV_USR="behat"
alias lzd='lazydocker'
alias dotcfg='git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'

# alias docker-compose='docker compose'
# alias ls='eza'
alias ll='eza -alh'
alias tree='eza --tree --long'

#alias cat='bat'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
alias fzfp="fzf --preview 'bat --style=numbers --color=always {}'"
alias fzfr='fzf --height 40% --reverse'
alias fzfd="git status -s \
 | fzf --no-sort --reverse \
 --preview 'git diff --color=always {+2}' \
 --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up \
 --preview-window=right:60%:wrap"
#
##. "$HOME/.local/bin/env"
#
alias vim='nvim'
export EDITOR=vim
#
#
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

PATH="/home/robertn/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/robertn/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/robertn/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/robertn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/robertn/perl5"; export PERL_MM_OPT;

# this is to be able to run sudoedit with my nvim
export EDITOR='/home/linuxbrew/.linuxbrew/bin/nvim'
export VISUAL='/home/linuxbrew/.linuxbrew/bin/nvim'
alias sudovim='sudoedit'
# though sudoedit can edit only files. If I want to run nvim in a folder:
# sudo -E PATH="$PATH" /home/linuxbrew/.linuxbrew/bin/nvim 
# or use this function :D
sudo_vim() {
    # Full path to your user nvim binary
    NVIM_BIN="/home/linuxbrew/.linuxbrew/bin/nvim"

    if [ ! -x "$NVIM_BIN" ]; then
        echo "Error: nvim not found at $NVIM_BIN"
        return 1
    fi

    # Preserve PATH so node/python/plugins work
    sudo -E PATH="$PATH" "$NVIM_BIN" "$@"
}

# and now I don't even have to remember to use sudo_vim/sudovim
sudo() {
    if [ "$1" = "vim" ]; then
        shift
        sudo_vim "$@"
    else
        command sudo "$@"
    fi
}

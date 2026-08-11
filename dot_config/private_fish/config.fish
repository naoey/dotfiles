switch (uname)
    case "Linux"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # Any Linux
    case "Darwin"
        switch (uname -m)
            case "arm64"
                eval "$(/opt/homebrew/bin/brew shellenv)" # ARM Mac
            case "x86_64"
                eval "$(/usr/local/bin/brew shellenv)" # Intel Mac
        end
end

# Various functions

function get_host_ip
    switch (uname)
        case "Darwin"
            for iface in en0 en1
                set ip (ipconfig getifaddr $iface 2>/dev/null)
                if test -n "$ip"
                    echo $ip
                    return
                end
            end
        case "Linux"
            set ip (ip route get 1.1.1.1 2>/dev/null | awk '/src/ {print $NF; exit}')
            if test -n "$ip"
                echo $ip
                return
            end
    end
end

function ghpr
    gh pr checkout $argv (pbpaste)
end

function fish_greeting
    #  fortune -a | pokemonsay | lolcat
end

function envsource
  set -f envfile "$argv"
  if not test -f "$envfile"
    echo "Unable to load $envfile"
    return 1
  end
  while read line
    if not string match -qr '^#|^$' "$line"
      set item (string split -m 1 '=' $line)
      # Trim double quotes from the value
      set key $item[1]
      set value (string trim -c '"' $item[2])
      set -gx $key $value
      echo "Exported key $key"
    end
  end < "$envfile"
end

function git_apply
    if type -q pbpaste
        pbpaste | git apply
    else if type -q xclip
        xclip -selection clipboard -o | git apply
    else if type -q wl-paste
        wl-paste | git apply
    else
        echo "No compatible clipboard tool found (pbpaste, xclip, wl-paste)." >&2
        return 1
    end
end

function git_copy
    # Check if we are in a git repository
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Error: Not a git repository" >&2
        return 1
    end

    # Detect clipboard tool once
    set -l copy_tool
    if type -q pbcopy
        set copy_tool "pbcopy"
    else if type -q xclip
        set copy_tool "xclip -selection clipboard"
    else if type -q wl-copy
        set copy_tool "wl-copy"
    else
        echo "No compatible clipboard tool found (pbcopy, xclip, wl-copy)." >&2
        return 1
    end

    # Generate the diff and pipe it directly to the tool
    # git add -N ensures untracked files are included in the diff
    git add -N .
    set -l diff_exists (git diff HEAD)

    if test -n "$diff_exists"
        git diff HEAD | eval $copy_tool
        echo "Copied all changes (including untracked) to clipboard via "(echo $copy_tool | awk '{print $1}')
    else
        echo "No changes to copy."
    end

    # Cleanup the "intent-to-add"
    git reset . >/dev/null 2>&1
end

# Environment variable setup

set --global --export LANG en_IN.UTF-8

set -xg EDITOR nvim
set -xg XDG_CONFIG_HOME "$HOME/.config"
set -xg HOST_IP (get_host_ip)
set -xg GPG_TTY (tty)
set -xg ANDROID_HOME ~/Library/Android/sdk

# $PATH

fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path /usr/local/sbin

# aliases

alias poi yarn
alias lg lazygit
alias ld lazydocker

alias ls eza
alias ll "eza -lah --total-size"
alias azr "az repos"

alias ggg "git bisect good"
alias gbg "git bisect bad"

alias md "glow -p"

# use ssh kitten to avoid annoying ssh from kitty
alias ssh="kitty +kitten ssh"

# autocompletions

kubectl completion fish | source

# interactive shell setup

if status is-interactive
    # Commands to run in interactive sessions can go here
    rbenv init - fish | source
    fnm env --use-on-cd --version-file-strategy recursive --shell fish | source
end

# finally add any machine specific config

if [ -e ~/.config/fish/local.fish ]
    source ~/.config/fish/local.fish
end


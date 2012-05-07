# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 10 numeric
zstyle ':completion:*' prompt 'ls'
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_histfile
HISTSIZE=100000000000000000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
 

# Zsh configuration file.


# MISCELLANEOUS SETTINGS

# Be paranoid, new files are readable/writable by me only.
umask 077

# Disable beeps.
setopt nobeep

# Prevent overwriting existing files with '> filename', use '>| filename'
# (or >!) instead.
setopt noclobber

# Entering the name of a directory (if it's not a command) will automatically
# cd to that directory.
setopt autocd

# When entering a nonexistent command name automatically try to find a similar
# one.
setopt correct

# Enable zsh's extended glob abilities.
setopt extendedglob

# Don't exit if <C-d> is pressed.
setopt ignoreeof


# KEY BINDINGS

# Not all bindings are done here, only those not specific to a given section.

# Use Vi(m) style key bindings.
bindkey -v

# Use jj and jk to exit insert mode.
bindkey 'jj' vi-cmd-mode
bindkey 'jk' vi-cmd-mode

# I don't need the arrow keys, I use ^N and ^P for this (see below).
bindkey -r '^[OA' '^[OB' '^[OC' '^[OD' '^[[A' '^[[B' '^[[C' '^[[D'
# Also not in Vi mode.
bindkey -a -r '^[OA' '^[OB' '^[OC' '^[OD' '^[[A' '^[[B' '^[[C' '^[[D'


# FUNCTION SETTINGS

# Make sure every entry in $fpath is unique.
typeset -U fpath
# ~/.zsh/functions/completion is a symbolic link to the Completion directory
# of a Zsh CVS checkout. Use it to get the newest completions if available.
if [[ -d ~/.zsh/functions/completion ]]; then
    fpath=(~/.zsh/functions/completion/*/*(/) $fpath)
fi
# Set correct fpath to allow loading my functions (including completion
# functions).
fpath=(~/.zsh/functions $fpath)
# Autoload my functions (except completion functions and hidden files). Thanks
# to caphuso from the Zsh example files for this idea.
if [[ -d ~/.zsh/functions ]]; then
    autoload -Uz ${fpath[1]}/^_*(^/:t)
fi

# Simulate hooks using _functions arrays for Zsh versions older than 4.3.4. At
# the moment only precmd(), preexec() and chpwd() are simulated.
#
# At least 4.3.4 (not sure about later versions) has an error in add-zsh-hook
# so the compatibility version is used there too.
if [[ $ZSH_VERSION != (4.3.<5->|4.<4->*|<5->*) ]]; then
    # Provide add-zsh-hook which was added in 4.3.4.
    fpath=(~/.zsh/functions/compatibility $fpath)

    # Run all functions defined in the ${precmd,preexec,chpwd}_functions
    # arrays.
    function precmd() {
        for function in $precmd_functions; do
            $function $@
        done
    }
    function preexec() {
        for function in $preexec_functions; do
            $function $@
        done
    }
    function chpwd() {
        for function in $chpwd_functions; do
            $function $@
        done
    }
fi

# Autoload add-zsh-hook to add/remove zsh hook functions easily.
autoload -Uz add-zsh-hook

# Load zmv (zsh move) which is a powerful file renamer.
autoload -Uz zmv


# HISTORY SETTINGS

# Use history and store it in ~/.zsh/history.
HISTSIZE=500000000
SAVEHIST=500000000
HISTFILE=~/.zsh/history
# Append to the history file instead of overwriting it and do it immediately
# when a command is executed.
setopt appendhistory
setopt incappendhistory
# If the same command is run multiple times store it only once in the history.
setopt histignoredups
# Vim like completions of previous executed commands (also enter Vi-mode). If
# called at the beginning it just recalls old commands (like cursor up), if
# called after typing something, only lines starting with the typed text are
# returned. Very useful to get old commands quickly - in addition to the
# history commands (!..). Thanks to Mikachu in #zsh on Freenode (2010-01-17
# 12:47 CET) for the information how to a use function with bindkey.
zle -N my-vi-history-beginning-search-backward
my-vi-history-beginning-search-backward() {
    local not_at_beginning_of_line
    if [[ $CURSOR -ne 0 ]]; then
        not_at_beginning_of_line=yes
    fi

    zle history-beginning-search-backward

    # Start Vi-mode and stay at the same position (Vi-mode moves one left,
    # this counters it).
    zle vi-cmd-mode
    if [[ -n $not_at_beginning_of_line ]]; then
        zle vi-forward-char
    fi
}
bindkey '^P' my-vi-history-beginning-search-backward
bindkey -a '^P' history-beginning-search-backward # binding for Vi-mode
# Here only Vi-mode is necessary as ^P enters Vi-mode and ^N only makes sense
# after calling ^P.
bindkey -a '^N' history-beginning-search-forward

# Automatically push cd-ed directories on the directory stack.
setopt autopushd
# Don't push duplicates on the directory stack.
setopt pushdignoredups
# Exchange the meaning of + and - when specifying a directory on the stack.
# This way cd -<Tab> lists the last used directory first, which is more
# natural because cd - goes to the last directory.
setopt pushdminus


# PROMPT SETTINGS

# Use colorized output, necessary for prompts and completions.
autoload -Uz colors && colors

# Necessary for $EPOCHSECONDS, the UNIX time.
zmodload zsh/datetime

# Some shortcuts for colors. The %{...%} tells zsh that the data in between
# doesn't need any space, necessary for correct prompt drawing.
local red="%{${fg[red]}%}"
local blue="%{${fg[blue]}%}"
local green="%{${fg[green]}%}"
local yellow="%{${fg[yellow]}%}"
local default="%{${fg[default]}%}"

# vcs_info was added in 4.3.9 but it works in earlier versions too. So load it
# if the necessary files are available in ~/.zsh/functions/vcs_info (often a
# symbolic link to current checkout of Zsh's sources).
if [[ $ZSH_VERSION == (4.3.<9->|4.<4->*|<5->*) ||
      -d ~/.zsh/functions/vcs_info ]]; then
    # Update fpath to allow loading the vcs_info functions.
    if [[ -d ~/.zsh/functions/vcs_info ]]; then
       fpath=(~/.zsh/functions/vcs_info/
              ~/.zsh/functions/vcs_info/Backends
              $fpath)
    fi

    # Load vcs_info to display information about version control repositories.
    autoload -Uz vcs_info
    # Only look for git and mercurial repositories; the only I use.
    zstyle ':vcs_info:*' enable git hg
    # Check the repository for changes so they can be used in %u/%c (see
    # below). This comes with a speed penalty for bigger repositories.
    zstyle ':vcs_info:*' check-for-changes yes

    # Set style of vcs_info display. The current branch (green) and VCS (blue)
    # is displayed. If there is an special action going on (merge, rebase)
    # it's also displayed (red). Also display if there are unstaged or staged
    # (%u/%c) changes.
    if [[ $ZSH_VERSION == (4.3.<11->|4.<4->*|<5->*) ||
          -d ~/.zsh/functions/vcs_info ]]; then
        zstyle ':vcs_info:*' formats \
            "($green%b%u%c$default:$blue%s$default)"
        zstyle ':vcs_info:*' actionformats \
            "($green%b%u%c$default/$red%a$default:$blue%s$default)"
    else
        # In older versions %u and %c are not defined yet and are not
        # correctly expanded.
        zstyle ':vcs_info:*' formats \
            "($green%b$default:$blue%s$default)"
        zstyle ':vcs_info:*' actionformats \
            "($green%b$default/$red%a$default:$blue%s$default)"
    fi
    # Set style for formats/actionformats when unstaged (%u) and staged (%c)
    # changes are detected in the repository; check-for-changes must be set to
    # true for this to work. Thanks to Bart Trojanowski
    # (http://jukie.net/~bart/blog/pimping-out-zsh-prompt) for the idea
    # (2010-03-11 00:20 CET).
    zstyle ':vcs_info:*' unstagedstr '¹'
    zstyle ':vcs_info:*' stagedstr   '²'

    # Default to run vcs_info. If possible we prevent running it later for
    # speed reasons. If set to a non empty value vcs_info is run.
    FORCE_RUN_VCS_INFO=1

    # Cache system inspired by Bart Trojanowski
    # (http://jukie.net/~bart/blog/pimping-out-zsh-prompt).
    zstyle ':vcs_info:*+pre-get-data:*' hooks pre-get-data
    +vi-pre-get-data() {
        # Only Git and Mercurial support and need caching. Abort if any other
        # VCS is used.
        [[ "$vcs" != git && "$vcs" != hg ]] && return

        # If the shell just started up or we changed directories (or for other
        # custom reasons) we must run vcs_info.
        if [[ -n $FORCE_RUN_VCS_INFO ]]; then
            FORCE_RUN_VCS_INFO=
            return
        fi

        # Don't run vcs_info by default to speed up the shell.
        ret=1
        # If a git/hg command was run then run vcs_info as the status might
        # need to be updated.
        case "$(fc -ln $(($HISTCMD-1)))" in
            git* | g\ *)
                ret=0
                ;;
            hg*)
                ret=0
                ;;
        esac
    }

    # Must run vcs_info when changing directories.
    prompt_chpwd() {
        FORCE_RUN_VCS_INFO=1
    }
    add-zsh-hook chpwd prompt_chpwd

    # Used by prompt code below to determine if vcs_info should be run.
    RUN_VCS_INFO=1
else
    RUN_VCS_INFO=
fi

# Set the prompt. A two line prompt is used. On the top left the current
# working directory is displayed, on the right vcs_info (if available) and the
# current time in hex. On the bottom left current user name and host is shown,
# the exit code of the last command if it wasn't 0, the number of running jobs
# if not 0.
#
# The prompt is in green and blue to make easily detectable, the error exit
# code in red and bold and the job count in yellow.
#
# Thanks to Adam's prompt for the basic idea of this prompt.
prompt_precmd() {
    # Regex to remove elements which take no space. Used to calculate the
    # width of the top prompt. Thanks to Bart's and Adam's prompt code in
    # Functions/Prompts/prompt_*_setup.
    local zero='%([BSUbfksu]|([FB]|){*})'

    # Call vcs_info before every prompt.
    if [[ -n $RUN_VCS_INFO ]]; then
        vcs_info
    else
        vcs_info_msg_0_=
    fi

    local width width_left width_right
    local top_left top_right

    # Display the current time in HEX in bright blue and vcs_info (if used) on
    # the right in the top prompt.
    top_right="$vcs_info_msg_0_($blue%B0x$(([##16] EPOCHSECONDS))%b$default)"
    width_right=${#${(S%%)top_right//$~zero/}}
    # Remove it if it would get too long.
    if [[ $(( COLUMNS - 4 - 1 - width_right )) -lt 0 ]]; then
        top_right=
        width_right=0
    fi

    # Display current directory on the left in the top prompt. Truncate the
    # directory if necessary.
    width=$(( COLUMNS - 4 - 1 - width_right ))
    top_left=".-$default%b($yellow%$width<..<%~%<<$default)%B$blue"

    # Calculate the width of the top prompt to fill the middle with "-".
    width_left=${#${(S%%)top_left//$~zero/}}
    width_right=${#${(S%%)top_right//$~zero/}}
    width=$(( COLUMNS - width_left - width_right ))

    PROMPT="$blue%B$top_left${(l:$width::-:)}%b$default$top_right
$blue%B'%b$default\
$green%B%n%b$default@$green%B%m%b$default %(1j.$yellow%j$default.)%# \
%(?..($red%B%?%b$default%) )"
}
add-zsh-hook precmd prompt_precmd


# When screen, xterm or rxvt is used set the name of the window to the
# currently running program.
#
# When a program is started preexec() sets the window's name to it; when it
# stops precmd() resets the window's name to 'zsh'.
#
# It works with screen, xterm and rxvt.
#
# If a command is run with sudo or if the shell is running as root then a ! is
# added at the beginning of the command to make this clear. If a command is
# running on a different computer with ssh a @ is added at the beginning. If
# screen is running on the remote machine instead of @screen @:hostname
# (hostname replaced by the machine's hostname) is displayed. This only works
# if the .zshrc on the server also uses this command.
#
# screen* is necessary as `screen` uses screen.linux for example for a linux
# console.
if [[ $TERM == screen* || $TERM == xterm* || $TERM == rxvt* ]]; then
    # Is set to a non empty value to reset the window name in the next
    # precmd() call.
    window_reset=yes
    # Is set to a non empty value when the shell is running as root.
    if [[ $UID -eq 0 ]]; then
        window_root=yes
    fi

    window_preexec() {
        # Get the program name with its arguments.
        local program_name=$1

        # When sudo is used use real program name instead, but with an
        # exclamation mark at the beginning (handled below).
        local program_sudo=
        if [[ $program_name == sudo* ]]; then
            program_name=${program_name#sudo }
            program_sudo=yes
        fi
        # Remove all arguments from the program name.
        program_name=${program_name%% *}

        # Ignore often used commands which are only running for a very short
        # time. This prevents a "blinking" name when it's changed to "cd" for
        # example and then some milliseconds later back to "zsh".
        [[ $program_name == (cd*|d|ls|l|la|ll|clear|c) ]] && return

        # Change my shortcuts so the real name of the program is displayed.
        case $program_name in
            e)
                program_name=elinks
                ;;
            g)
                program_name=git
                ;;
            m)
                program_name=mutt
                ;;
            v)
                program_name=vim
                ;;
        esac

        # Add an exclamation mark at the beginning if running with sudo or if
        # running zsh as root.
        if [[ -n $program_sudo || -n $window_root ]]; then
            program_name=!$program_name
        fi

        # Add an at mark at the beginning if running through ssh on a
        # different computer.
        if [[ -n $SSH_CONNECTION ]]; then
            program_name="@$program_name"

            # If screen is running in SSH then display "@:hostname" as title
            # in the term/outer screen.
            if [[ $program_name == @screen ]]; then
                program_name="@:${HOST//.*/}"
            # Use "@:!hostname" for root screens.
            elif [[ $program_name == @!screen ]]; then
                program_name="@:!${HOST//.*/}"
            fi
        fi

        # Set the window name to the currently running program.
        window_title "$program_name"

        # Tell precmd() to reset the window name when the program stops.
        window_reset=yes
    }

    window_precmd() {
        # Abort if no window name reset is necessary.
        [[ -z $window_reset ]] && return

        # Reset the window name to 'zsh'.
        local name=zsh
        # If the function was called with an argument then reset the window
        # name to '.zsh' (used by clear alias).
        if [[ -n $1 ]]; then
            name=.zsh
        fi

        # Prepend prefixes like in window_preexec().
        if [[ -n $window_root ]]; then
            name="!$name"
        fi
        if [[ -n $SSH_CONNECTION ]]; then
            name="@$name"
        fi
        window_title $name

        # Just reset the name, so no screen reset necessary for the moment.
        window_reset=
    }

    # Sets the window title. Works with screen, xterm and rxvt. (V) escapes
    # all non-printable characters. Thanks to Mikachu in #zsh on Freenode
    # (2010-08-07 17:09 CEST).
    if [[ $TERM == screen* ]]; then
        window_title() {
            print -n "\ek${(V)1}\e\\"
        }
    elif [[ $TERM == xterm* || $TERM == rxvt* ]]; then
        window_title() {
            print -n "\e]2;${(V)1}\e\\"
        }
    else
        # Fallback if another TERM is used.
        window_title() { }
    fi

    # Add the preexec() and precmd() hooks.
    add-zsh-hook preexec window_preexec
    add-zsh-hook precmd window_precmd
else
    # Fallback if another TERM is used, necessary to run screen (see below in
    # "RUN COMMANDS").
    window_preexec() { }
fi


# COMPLETION SETTINGS

# Load the complist module which provides additional features to completion
# lists (coloring, scrolling).
zmodload zsh/complist
# Use new completion system, store dumpfile in ~/.zsh/cache to prevent
# cluttering of ~/. $fpath must be set before calling this. Thanks to Adlai in
# #zsh on Freenode (2009-08-07 21:05 CEST) for reminding me of the $fpath
# problem.
autoload -Uz compinit && compinit -d ~/.zsh/cache/zcompdump

# Use cache to speed up some slow completions (dpkg, perl modules, etc.).
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache

# Let the completion system handle all completions, including expanding of
# shell wildcards (which is handled by other shell mechanisms if the default
# expand-or-complete is used).
bindkey '^I' complete-word
# If there are multiple matches after pressing <Tab> always display them
# immediately without requiring another <Tab>. a<Tab> completes to aa and
# lists aaa, aab, aac as possible completions if the directory contains aaa,
# aab, aac, bbb instead of only completing to aa.
setopt nolistambiguous
# Support completions in the middle of a word, without this option zsh jumps
# to the end of the word before the completion process begins. Is required for
# the _prefix completer.
setopt completeinword

zstyle ':completion:::::' completer \
    _expand _complete _prefix _ignored _approximate

# Try uppercase if the currently typed string doesn't match. This allows
# typing in lowercase most of the time and completion fixes the case. Don't
# perform these fixes in _approximate to prevent it from changing the input
# too much. Thanks to the book "From Bash to Z Shell" page 249.
zstyle ':completion:*:(^approximate):*' matcher-list 'm:{a-z}={A-Z}'

# Allow one mistake per three characters. Thanks to the book "From Bash to Z
# Shell" page 248.
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Expand shell wildcards to all matching files after <Tab>. echo *<Tab>
# results in a b c if the directory contains the files a, b, c. Thanks to the
# book "From Bash to Z Shell" page 246.
zstyle ':completion:*:expand:*' tag-order all-expansions
# Keep prefixes unexpanded if possible: $HOME/<Tab> doesn't expand $HOME,
# while $HOME<Tab> does.
zstyle ':completion:*:expand:*' keep-prefix yes

# When completing multiple path components display all matching ambiguous
# components. For example /u/s/d/r/README<Tab> lists all matching READMEs
# instead of just the matching paths up to the r/ component. Can be slow if
# there are many matching files.
zstyle ':completion:*' list-suffixes yes

# Use ls-like colors for completions.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Make completion lists scrollable so "do you wish to see all n possibilities"
# is no longer displayed. Display current position in percent (%p).
zstyle ':completion:*:default' list-prompt '%p'
# Display group name (%d) (like 'external command', 'alias', etc.), in bold.
# Also display a message if _approximate found errors and if no matches were
# found.
zstyle ':completion:*'             format '    %B%d%b:'
zstyle ':completion:*:corrections' format '    %B%d%b (errors: %e)'
zstyle ':completion:*:warnings'    format '    %Bno matches for %d%b'
# Display different types of matches separately.
zstyle ':completion:*' group-name ''

# Separate man pages by section.
zstyle ':completion:*' separate-sections yes

# Don't draw trailing / in bold (new in zsh 4.3.11). Thanks to Mikachu in #zsh
# on Freenode for the fix (2010-12-17 13:46 CET).
zle_highlight=(suffix:none)

# Ignore completion functions.
zstyle ':completion:*:functions' ignored-patterns '_*'
# Ignore parent directory.
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# Always complete file names only once in the current line. This makes it easy
# to complete multiple file names because I can just press tab to get all
# possible values. Otherwise I would have to skip the first value again and
# again. Thanks to Mikachu in #zsh on Freenode (2011-08-11 14:42 CEST) for the
# hint to use other. other is necessary so prefix<Tab> lists both prefix and
# prefixrest if the directory contains prefix and prefixrest.
zstyle ':completion:*:all-files' ignore-line other
# Except for mv and cp, because I often want to use to similar names, so I
# complete to the same and change it.
zstyle ':completion:*:(mv|cp):all-files' ignore-line no

# Don't complete ./config.* files, this makes running ./configure much
# simpler. Thanks to Nomexous in #zsh on Freenode (2010-03-16 01:54 CET)
zstyle ':completion:*:*:-command-:*' ignored-patterns './config.*'
# Don't complete unwanted files with Vim. Thanks to Nomexous in #zsh on
# Freenode (2010-06-06 04:54 CEST). See below for a way to complete them.
zstyle ':completion:*:*:vim:*:all-files' ignored-patterns \
    '*.aux' '*.log' '*.pdf' \
    '*.class'

# Provide a fallback completer which always completes files. Useful when Zsh's
# completion is too "smart". Thanks to Frank Terbeck <ft@bewatermyfriend.org>
# (http://www.zsh.org/mla/users/2009/msg01038.html).
zle -C complete-files complete-word _generic
zstyle ':completion:complete-files:*' completer _files
bindkey '^F' complete-files


# CUSTOM ALIASES AND FUNCTIONS

# If ^C is pressed while typing a command, add it to the history so it can be
# easily retrieved later and then abort like ^C normally does. This is useful
# when I want to abort an command to do something in between and then finish
# typing the command.
#
# Thanks to Vadim Zeitlin <vz-zsh@zeitlins.org> for a fix (--) so lines
# starting with - don't cause errors; and to Nadav Har'El
# <nyh@math.technion.ac.il> for a fix (-r) to handle whitespace/quotes
# correctly, both on the Zsh mailing list.
TRAPINT() {
    # Store the current buffer in the history.
    zle && print -s -r -- $BUFFER

    # Return the default exit code so Zsh aborts the current command.
    return $1
}

# Load aliases and similar functions also used by other shells.
if [[ -f ~/.shell/aliases ]]; then
    . ~/.shell/aliases
fi

# Make sure aliases are expanded when using sudo.
alias sudo='sudo '

# Global aliases for often used commands in the command line.
alias -g E='2>&1'
alias -g L='E | less'
alias -g D='E | colordiff L'
alias -g G='| grep'
alias -g S='| sort'
alias -g U='| uniq'
alias -g H='| head'
alias -g T='| tail'

# Make going up directories simple.
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# If the window naming feature is used (see above) then use ".zsh" (leading
# dot) as title name after running clear so it's clear to me that the window
# is empty. I open so much windows that I don't know in which I have something
# important. This helps me to remember which windows are empty (I run clear
# after I finished my work in a window).
if [[ -n $window_reset ]]; then
    alias clear='clear; window_reset=yes; window_precmd reset'
fi

# Display all branches (except stash) in gitk but only 200 commits as this is
# much faster. Also put in the background and disown. Thanks to sitaram in
# #git on Freenode (2009-04-20 15:51).
gitk() {
    command gitk \
        --max-count=200 \
        $(git rev-parse --symbolic-full-name --remotes --branches) \
        $@ &
    disown %command
}
# Same for tig (except the disown part as it's no GUI program).
tig() {
    command tig \
        --max-count=200 \
        $(git rev-parse --symbolic-full-name --remotes --branches) \
        $@
}

# Pipe output through less.
tree() {
    command tree -C "$@" | less
}

# Automatically disown.
xpdf() {
    command xpdf "$@" &
    disown %command
}


# OS SPECIFIC SETTINGS

if [[ $OSTYPE == linux* ]]; then
    # Settings when creating Debian packages.
    DEBEMAIL=simon@ruderich.org
    export DEBEMAIL
    DEBFULLNAME='Simon Ruderich'
    export DEBFULLNAME
fi


# LOAD ADDITIONAL CONFIGURATION FILES

. ~/.zsh/rc.local


# RUN COMMANDS

# If not already in screen reattach to a running session or create a new one.
# This also starts screen on a remote server when connecting through ssh.
#if [[ $TERM != dumb && $TERM != linux && -z $STY ]]; then
#    # Get running detached sessions.
#    session=$(screen -list | grep 'Detached' | awk '{ print $1; exit }')
#
#    # As we exec later we have to set the title here.
#    window_preexec "screen"
#
#    # Create a new session if none is running.
#    if [[ -z $session ]]; then
#        exec screen
#    # Reattach to a running session.
#    else
#        exec screen -r $session
#    fi
#fi

# Colorize stderr in red. Very useful when looking for errors. Thanks to
# http://gentoo-wiki.com/wiki/Zsh for the basic script and Mikachu in #zsh on
# Freenode (2010-03-07 04:03 CET) for some improvements (-r, printf). It's not
# yet perfect and doesn't work with su and git for example, but it can handle
# most interactive output quite well (even with no trailing new line) and in
# cases it doesn't work, the E alias can be used as workaround.
#
# Moved in the "run commands" section to prevent one unnecessary zsh process
# when starting screen (see above).
exec 2>>(while read -r -k -u 0 line; do
    printf '\e[91m%s\e[0m' "$line";
    print -n $'\0';
done &)

# Run reminder and redisplay it every four hours (if it's available).
PERIOD=14400
periodic() {
    which rem > /dev/null && [ -f ~/.reminders ] && rem -h
}


# vim: ft=zsh

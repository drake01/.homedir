if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%?%{$reset_color%}"
local curr_time="%(?:%{$fg[yellow]%}%D{%H%M%S}:%{$fg[yellow]%}%D{%H%M%S})%?%{$reset_color%}"
# local curr_time="%{$fg[yellow]%D{%H%M%S}%}$reset_color"
PROMPT='$FG[237]-------------------------------------------------------------------------------%{$reset_color%}
[$curr_time][$ret_status] \
$FG[032]%1~\
$FG[105]%(!.#. $)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${curr_time}${return_code}'
RPROMPT='$(virtualenv_prompt_info)' && type "virtualenv_prompt_info" > /dev/null || ''

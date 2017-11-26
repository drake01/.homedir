if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%?%{$reset_color%}"
PROMPT='$FG[237]-------------------------------------------------------------------------------%{$reset_color%}
[$ret_status] \
$FG[032]%1~\
$FG[105]%(!.#. $)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'
RPROMPT='$(virtualenv_prompt_info)' && type "virtualenv_prompt_info" > /dev/null || ''

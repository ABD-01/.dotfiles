# Based on https://github.com/oskarkrawczyk/honukai-iterm-zsh and bash/honukai-custom.omp.json
# Based on the great ys theme (http://ysmood.org/wp/2013/03/my-ys-terminal-theme/)

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

local path_segment='$(honukai_shorten_path)'
honukai_shorten_path() {
  local path="${PWD/#$HOME/~}"
  local -a parts

  parts=("${(@s:/:)path}")

  # Determine effective depth: ~ prefix takes one slot, so adjust threshold
  local threshold=3
  [[ "$path" == "~"* ]] && threshold=4

  if (( ${#parts[@]} <= threshold )); then
    print -r -- "$path"
    return
  fi

  if [[ "$path" == "~"* ]]; then
    print -r -- "~/${parts[-2]}/${parts[-1]}"
  else
    print -r -- "../../${parts[-2]}/${parts[-1]}"
  fi
}

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✖︎"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
# the following prompt is replaced wth hardcoded "ABD"
# %{$fg[cyan]%}%n \
# the following section goes before "in ../path"
# %{$fg[white]%}at %{$fg[green]%}$(box_name) \
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%F{33}ABD \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${path_segment}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%F{117}%* %{$fg[white]%}| %F{117}%D{%e %b, %a}%{$fg[white]%}]
%{$terminfo[bold]$fg[red]%}λ %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
# the following section goes before "in ../path"
# %{$fg[white]%}at %{$fg[green]%}$(box_name) \
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${path_segment}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[red]%}λ %{$reset_color%}"
fi

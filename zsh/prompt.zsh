autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null)
  # echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
  echo "${ref#refs/heads/}"
}

git_prompt_no_dirty_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null)
  if [[ $ref == "" ]];
  then
    echo ""
  else
    echo "on %{$fg_bold[yellow]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

if (( $+commands[svn] ))
then
  svn="$commands[svn]"
else
  svn="/usr/bin/svn"
fi

svn_prompt() {
  ref=$($svn info 2>/dev/null | grep '^URL:' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$')
  if [[ $ref == "" ]];
  then
    echo ""
  else
    echo "on %{$fg_bold[yellow]%}$ref%{$reset_color%}"
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

python_version() {
  if (( $+commands[pyenv] ))
  then
    echo "$(pyenv version | awk '{print $1}')"
  fi
}

python_prompt() {
  if ! [[ -z $VIRTUAL_ENV ]]
  then
    echo "%{$fg_bold[magenta]%}$VIRTUAL_ENV:t%{$reset_color%} "
  else
    echo ""
  fi
}

node_prompt() {
  if ! [[ -z $NODE_VIRTUAL_ENV ]]
  then
    echo "%{$fg_bold[white]%}$NODE_VIRTUAL_ENV:t%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%0/%\/%{$reset_color%}"
}

# displaying ruby & git dirty info on each prompt seems slow on
# Windows Subsystem for Linux
if grep -q Microsoft /proc/version 2>/dev/null; then
  export PROMPT=$'\n$(node_prompt)$(python_prompt)$(directory_name) $(git_prompt_no_dirty_info)\n› '
else
  export PROMPT=$'\n$(node_prompt)$(rb_prompt)$(python_prompt)$(directory_name) $(svn_prompt)$(git_dirty)$(need_push)\n› '
fi

set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  #title "zsh" "%m" "%55<...<%~"
  set_prompt
}

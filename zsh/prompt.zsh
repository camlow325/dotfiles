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
  ref=$($git symbolic-ref HEAD 2>/dev/null)
  echo "${ref#refs/heads/}"
}

git_prompt() {
  if ! git_status=$($git status --porcelain --ignore-submodules 2>/dev/null)
  then
    echo ""
  elif [[ "$git_status" == "" ]]
  then
    echo "on %{$fg_bold[green]%}$(git_branch)%{$reset_color%}"
  else
    echo "on %{$fg_bold[red]%}$(git_branch)%{$reset_color%}"
  fi
}

git_prompt_no_dirty() {
  ref=$(git_branch)
  if [[ $ref == "" ]];
  then
    echo ""
  else
    echo "on %{$fg_bold[yellow]%}$(git_branch)%{$reset_color%}"
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

kube_prompt() {
  type kube_context >/dev/null 2>/dev/null
  if [ $# -eq 0 ]
  then
    kube_prompt_text=$(kube_context)
    if ! [[ -z "$kube_prompt_text" ]]
    then
      namespace=$(kube_namespace)
      if ! [[ -z "$namespace" ]]
      then
        kube_prompt_text="${kube_prompt_text}|${namespace}"
      fi
    fi
    if ! [[ -z "$kube_prompt_text" ]]
    then
      echo -e "%{$fg_bold[white]%}$kube_prompt_text:t%{$reset_color%} "
    else
      echo ""
    fi
  else
    echo ""
  fi
}

terraform_prompt() {
  if [[ -d ".terraform" ]] && (( $+commands[terraform] ))
  then
    terraform_prompt_text=$(terraform workspace show)
    echo -e "%{$fg_bold[blue]%}$terraform_prompt_text:t%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%0/%\/%{$reset_color%}"
}

battery_status() {
  if test ! "$(uname)" = "Darwin"
  then
    exit 0
  fi

  if [[ $(sysctl -n hw.model) == *"Book"* ]]
  then
    $ZSH/bin/battery-status
  fi
}

# displaying ruby & git dirty info on each prompt seems slow on
# Windows Subsystem for Linux
if grep -q Microsoft /proc/version 2>/dev/null; then
  export PROMPT=$'\n$(battery_status)$(node_prompt)$(python_prompt)$(directory_name) $(git_prompt_no_dirty)\n› '
else
  export PROMPT=$'\n$(battery_status)$(kube_prompt)$(terraform_prompt)$(python_prompt)$(directory_name) $(git_prompt)$(need_push)\n› '
fi

set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}

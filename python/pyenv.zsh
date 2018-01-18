if (( $+commands[pyenv] )) && $(grep -qv Microsoft /proc/version 2>/dev/null)
then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

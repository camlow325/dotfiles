if (( $+commands[pyenv] )) && $(grep -qv Microsoft /proc/version)
then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

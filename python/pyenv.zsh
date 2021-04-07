if (( $+commands[pyenv] ))
then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  if (( $+commands[awsume] ))
  then
    alias awsume=". $(pyenv which awsume)"
  fi
elif (( $+commands[awsume] ))
then
  alias awsume=". awsume"
fi

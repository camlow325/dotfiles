export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# Initialize `pyenv` and `rbenv` after setting up system paths so that their
# executables can take precedence.
if (( $+commands[pyenv] ))
then
  eval "$(pyenv init -)"

  if pyenv commands | grep -q ^virtualenv-init$; then
    eval "$(pyenv virtualenv-init -)"
  fi

  if (( $+commands[awsume] ))
  then
    alias awsume=". $(pyenv which awsume)"
  fi
elif (( $+commands[awsume] ))
then
  alias awsume=". awsume"
fi

if (( $+commands[rbenv] ))
then
    eval "$(rbenv init -)"
fi

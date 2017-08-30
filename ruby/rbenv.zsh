if (( $+commands[rbenv] )) && $(grep -qv Microsoft /proc/version)
then
  eval "$(rbenv init -)"
fi

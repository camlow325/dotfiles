if (( $+commands[rbenv] )) && $(grep -qv Microsoft /proc/version 2>/dev/null)
then
  eval "$(rbenv init -)"
fi

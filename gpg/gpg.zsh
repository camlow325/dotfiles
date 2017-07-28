agent_start() {
  eval `gpg-agent --daemon --no-grab`
}

agent_run_state=$(gpg-agent >| /dev/null 2>&1; echo $?)

if [ $agent_run_state = 2 ]; then
  agent_start
fi

export GPG_TTY=$(tty)

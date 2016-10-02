compctl -K _floaty floaty
compctl -K _sshvm sshvm

_floaty_commands() {
  reply=(delete get help list modify query \
      revert snapshot status summary token)
}

_floaty_oses() {
  local oses="$(floaty list)"
  reply=("${(ps:\n:)oses}")
}

_floaty_vms() {
  local vms="$(floaty list --active | awk '/-/ { print $2 }')"
  reply=("${(ps:\n:)vms}")
}

_floaty() {
  local word words
  read -cA words
  word="${words[2]}"

  case ${#words} in
    2)
      _floaty_commands ;;
    3)
      case $word in
        delete|modify|query|revert|snapshot)
          _floaty_vms ;;
        get)
          _floaty_oses ;;
        help)
          _floaty_commands ;;
        list)
          reply=(--active) ;;
      esac ;;
    *)
      case $word in
        delete|snapshot)
          _floaty_vms ;;
        get)
          _floaty_oses ;;
        modify)
          reply=(--lifetime --disk --tags) ;;
        revert)
          reply=(--snapshot) ;;
      esac ;;
  esac
}

_sshvm() {
  _floaty_vms
}

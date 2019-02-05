kube_context() {
  if (( $+commands[kubectl] )); then
    kubectl config current-context 2>/dev/null
  fi
}

if (( $+commands[kubectl] )); then
  if [[ -z $(kube_context) ]]; then
    echo "No kube context yet so creating 'none' as default"
    kubectl config set-context "none"
    kubectl config use-context "none"
  fi
fi

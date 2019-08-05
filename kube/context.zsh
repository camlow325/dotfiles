kube_context() {
  if (( $+commands[kubectl] )); then
    kubectl config current-context 2>/dev/null
  fi
}

kube_namespace(){
  NS=$(kubectl config view --minify --output 'jsonpath={..namespace}')
  if [ -z $NS ]; then echo "default"; else echo $NS; fi
}

if (( $+commands[kubectl] )); then
  if [[ -z $(kube_context) ]]; then
    echo "No kube context yet so creating 'none' as default"
    kubectl config set-context "none"
    kubectl config use-context "none"
  fi
fi

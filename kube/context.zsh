kube_context() {
  if (( $+commands[kubectl] )); then
    kubectl config current-context 2>/dev/null
  fi
}

dashboard() {
    local_port=9090
    if [ ! -z "$1" ]; then local_port=$1 ; fi
    echo "checking if local port $local_port is already in use..."
    lsof -Pi :$local_port -sTCP:LISTEN
    if [ $? -eq 0 ] ; then
        echo "ERROR: port $local_port is already in use.  Please close the application listed above and re-run."
    else
        context=$(kube_context)
        if [ -z "$context" ] ; then
            echo "ERROR: please set a kubectl context first!"
        else
            dashboard_pod=`kubectl get pods --all-namespaces -l app=kubernetes-dashboard | awk '{ if ($4 == "Running") { printf $2 ; exit 0 } }'`
            namespace=`kubectl get pods --all-namespaces -l app=kubernetes-dashboard | awk '{ if ($4 == "Running") { printf $1 ; exit 0 } }'`
            dashboard_port=`kubectl -n "$namespace" describe pod "$dashboard_pod" | grep "Port:" | head -n1 | sed 's/\/.*//g' | awk '{ print $2 }'`
            echo "creating dashboard to kubectl context \"$context\": port forward $dashboard_pod:$dashboard_port to https://localhost:$local_port"
            echo "remember, it may take 30 seconds to actually display the dashboard."
            echo "also, you may need to accept the invalid cert in chrome."

            if [[ $+commands[xdg-open] && ! -z "$DISPLAY" ]]; then
                xdg-open https://localhost:$local_port &
            fi
            echo "dashboard to https://localhost:$local_port"
            kubectl -n $namespace port-forward $dashboard_pod $local_port:$dashboard_port
        fi
    fi
}

if (( $+commands[kubectl] )); then
  if [[ -z $(kube_context) ]]; then
    echo "No kube context yet so creating 'none' as default"
    kubectl config set-context "none"
    kubectl config use-context "none"
  fi
fi

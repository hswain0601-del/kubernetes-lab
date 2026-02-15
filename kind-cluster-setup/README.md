kind --version

kind create cluster --name k8s-demo

kind delete cluster --name k8s-demo

kind create cluster --config "./kind-k8s-cluster-setup/kind-cluster-config.yaml"

kubectl get componentstatus

kubectl get --raw='/readyz?verbose'

kubectl cluster-info

kubectl get node -o wide
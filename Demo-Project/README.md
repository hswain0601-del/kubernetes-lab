## Check minikube status and start [if it is not running]
    minikube status
    minikube start
## Apply the deployment & service files 

    kubectl apply -f deploy.yaml
    kubectl apply -f service.yaml

## Check the deployment status

    kubectl get all

## Check services 

    kubectl get svc 

## port-forward to test the application
    kubectl port-forward service/bb-entrypoint 30001:3000

Now we can access the service locally on our machine. Open your browser and go to <http://localhost:30001>

Start minikube 

    minikube start
    minikube status

To test the deployment using dry-run 

    
    helm install bb-release . --dry-run

To perform deployment

    
    helm install bb-release . 
    

To list the deployment 
    
    helm ls 
    
Try running all the kubectl commands 

    
    kubectl get all 
    
To forward the service 

    kubectl port-forward service/bb-entrypoint 30001:3000
    
To uninstall the deployment 

    
    helm uninstall bb-release . 
    

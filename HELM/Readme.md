To test the deployment using dry-run 

    
    kubectl apply -f your-deployment-file.yaml

To perform deployment

    
    helm install bb-release . 
    

To list the deployment 

    
    helm ls 
    
Try running all the kubectl commands 

    
    kubectl get all 
    

To uninstall the deployment 

    
    helm uninstall bb-release . 
    

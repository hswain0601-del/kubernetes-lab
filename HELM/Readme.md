Provision the EKS Cluster 

    kubectl get nodes


To test the deployment using dry-run 
    
    helm install bb-release . --dry-run


To perform deployment

    helm install bb-release . 


To list the deployment

    helm ls 
    
Try running all the kubectl commands 

    
    kubectl get all 
    
To forward the service, get the LoadBalancer ExternalIP followed by port 3000 --> eg: aaff14ef5c52742ab929ecf1afef86f5-1091407520.us-east-1.elb.amazonaws.com:3000

    kubectl get svc 
    NAME            TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)     AGE
    bb-entrypoint   LoadBalancer   172.20.42.156   aaff14ef5c52742ab929ecf1afef86f5-1091407520.us-east-1.elb.amazonaws.com   3000:30001/TCP      3m2s
    
To uninstall the deployment 

    
    helm uninstall bb-release . 
    

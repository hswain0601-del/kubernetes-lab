To test the deployment using dry-run 

    ```bash
    kubectl apply -f your-deployment-file.yaml
    ```
To perform deployment

    ```bash
    helm install bb-release . 
    ```

To list the deployment 

    ```bash
    helm ls 
    ```
Try running all the kubectl commands 

    ```bash
    kubectl get all 
    ```

To uninstall the deployment 

    ```bash
    helm uninstall bb-release . 
    ```
**Use the following commands to interact with and test the pod.yml manifest:**

The provided manifest files define a Kubernetes Deployment named **`mydeployments`** and a corresponding Service named **`demoservice`**. The Deployment creates a single Pod running an Apache HTTP Server (**`httpd`**) image, exposing port 80. The Service, **`demoservice`**, exposes this deployment and allows external access through a NodePort.

## **Associated Commands**

Use the following commands to interact with and test the deployment and service:

1. **Apply Deployment Manifest:**
    
    ```bash
    kubectl apply -f deploy-httpd.yml
    ```
    
2. **Apply Service Manifest:**
    
    ```bash
    kubectl apply -f service.yml
    ```
    
3. **Check Deployment Status:**
    
    ```bash
    kubectl get deployments
    ```
    
    Verify that the **`mydeployments`** Deployment is in the "1/1" state, indicating one Pod is running.
    
4. **Check Pod Status:**
    
    ```bash
    kubectl get pods
    ```
    
    Verify that the Pod created by the Deployment is in the "Running" state.
    
5. **Check Service Status:**
    
    ```bash
    kubectl get services
    ```
    
    Verify that the **`demoservice`** Service is running.
    
6. **Access Service via NodePort:**
    
Our service **`demoservice`** is running on NodePort **`31175`**, you can use the following **`kubectl`** command to set up port forwarding:

```bash
kubectl port-forward svc/demoservice 8080:80
```

This command forwards local port **`8080`** to the NodePort **`80`** of the **`demoservice`** service. Adjust the local port (**`8080`** in this case) based on your preference.

Once the port forwarding is set up, you can access the Apache service by opening your browser and navigating to [http://localhost:8080](http://localhost:8080/).
    
7. **Clean Up (optional):**
    
    ```bash
    kubectl delete deployment mydeployments
    kubectl delete service demoservice
    ```
    
    Delete the Deployment and Service to clean up resources.

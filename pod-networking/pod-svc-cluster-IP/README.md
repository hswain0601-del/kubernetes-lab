**Use the following commands to interact with and test the pod.yml manifest:**

This Deployment creates a single replica of a pod named testpod1 with the label name: deployment. The pod runs an HTTPD (Apache) container exposing port 80.

This Service, named demoservice, exposes port 80 internally (ClusterIP type). It selects pods with the label name: deployment using the selector. The targetPort is set to 80, indicating that it directs traffic to the pod's port 80.

1. **Check Pods:**
    
    ```bash
    kubectl apply -f deploy-http.yml
    ```
    
2. **Check Deployments:**
    
    ```bash
    kubectl get deployments
    ```
    
3. **Check Service:**
    
    ```bash
    kubectl apply -f service.yml
    kubectl get services
    ```
    
    The output should show your **`demoservice`** with a ClusterIP assigned.
    
4. **Describe Service:**
    
    ```bash
    kubectl describe service demoservice
    ```
    
    This will provide detailed information about the service, including its ClusterIP, Ports, and Selector.
    
5. **Port Forwarding for Testing:**
If you want to test the service locally, you can use port forwarding:
    
    ```bash
    kubectl port-forward service/demoservice 8080:80
    ```
    
    Now you can access the service locally at **`http://localhost:8080`**.
    
3. **Pod Deletion:**
    - If you delete the pod created by the Deployment (**`kubectl delete pod <pod_name>`**), the Deployment controller detects the pod termination and creates a new pod to maintain the desired replica count.
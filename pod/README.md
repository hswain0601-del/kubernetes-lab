**Use the following commands to interact with and test the pod.yml manifest:**

The pod.yml file defines a Kubernetes Pod named testpod running an Ubuntu container. The container executes a simple Bash command, echoing "Hello-Nishant" every 5 seconds, with a restart policy set to "Never."

- Create or apply the Pod using **`kubectl apply`**:
    
    ```bash
    kubectl apply -f pod.yml
    ```
    
- View information about the Pod:
    
    ```bash
    kubectl get pod testpod
    ```
    
- Describe the Pod for more details:
    
    ```bash
    kubectl describe pod testpod
    ```
    
- Retrieve the logs from the container in the Pod:
    
    ```bash
    kubectl logs testpod -c c00
    ```
    
- Execute a command in the container:
    
    ```bash
    kubectl exec -it testpod -c c00 -- /bin/bash
    ```
    
- Delete the Pod::
    
    ```bash
   kubectl delete pod testpod
    ```

**Use the following commands to interact with and test the pod.yml manifest:**

The pod.yml file defines a Kubernetes Pod named testpod3 with two containers (c00 and c01), both running Ubuntu images. Each container executes a simple Bash command, echoing different messages ("Welcome Nishant" and "Hello Nishant," respectively) every 5 seconds.

1. To create or apply the multi-container Pod, use the **`kubectl apply`** command:
    
    ```bash
    kubectl apply -f pod.yaml
    ```
    
2. To view information about the Pod:
    
    ```bash
    kubectl get pod testpod
    ```
    
3. To describe the Pod for more details:
    
    ```bash
    kubectl describe pod testpod
    ```
    
4. To access the logs of a specific container within the Pod (e.g., container **`c00`**):
    
    ```bash
    kubectl logs testpod -c c00
    kubectl logs testpod -c c01
    ```
    
5. To access a shell in a specific container for troubleshooting (e.g., container **`c01`**):
    
    ```bash
    kubectl exec -it testpod -c c01 -- /bin/bash
    kubectl exec -it testpod -c c01 -- /bin/bash
    ```
    
6. To delete the multi-container Pod:
    
    ```bash
    kubectl delete pod testpod
    ```

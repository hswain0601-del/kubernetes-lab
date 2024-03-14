**Use the following commands to interact with and test the pod.yml manifest:**

The pod.yml file defines a Kubernetes Pod named environments running a single container (c00) with an Ubuntu image. The container executes a simple Bash command, echoing "Hello from c00" every 5 seconds. Additionally, an environment variable MYNAME is set with the value "testpod" inside the pod.

1. To create or apply the Pod with environment variables, use the **`kubectl apply`** command:
    
    ```bash
    kubectl apply -f pod3.yml
    ```
    
2. To view information about the Pod:
    
    ```bash
    kubectl get pod environments
    ```
    
3. To describe the Pod for more details:
    
    ```bash
    kubectl describe pod environments
    ```
    
4. To access the logs of the container within the Pod:
    
    ```bash
    kubectl logs environments -c c00
    ```
    
5. To access a shell in the container for troubleshooting:
    
    ```bash
    kubectl exec -it environments -c c00 -- /bin/bash
    ```
    
6. `echo $MYNAME —> environments`
7. `env` —> To see all the env variables 
8. To delete the Pod:

```bash
kubectl delete pod environments
```

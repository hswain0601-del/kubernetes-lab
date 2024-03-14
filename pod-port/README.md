**Use the following commands to interact with and test the pod.yml manifest:**

The pod.yml manifest file defines a Kubernetes Pod named testpod4 with a single container (c00) running an Apache HTTP Server (httpd) image. The container exposes port 80, indicating that it can receive incoming network traffic on that port.

1. Apply the file 

    ```bash
    kubectl apply -f pod3.yml
    kubectl get pod testpod4
    ```

2. To view information about the Pod:
    
    ```bash
    kubectl get pod testpod4
    ```
    
3. To describe the Pod for more details:
    
    ```bash
    kubectl describe pod testpod4
    ```
    
4. To access the logs of the container within the Pod:
    
    ```bash
    kubectl logs testpod4 -c c00
    ```
    
5. To access a shell in the container for troubleshooting:
    
    ```bash
    kubectl exec -it testpod4 -c c00 -- /bin/bash
    ```
    
6. kubectl get pods -o wide 
    
    ```jsx
    NAME                             READY   STATUS    RESTARTS        AGE     IP          NODE             NOMINATED NODE   READINESS GATES
    testpod4                         1/1     Running   0               78s     10.1.0.94   docker-desktop   <none>           <none>
    ```
    
7. To test port-forwarding 
    ```bash
    kubectl port-forward testpod4 8082:80
    ```
8. To delete the Pod:
    
    ```bash
    kubectl delete pod testpod4ed to the container.
    ```

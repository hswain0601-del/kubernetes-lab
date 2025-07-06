Liveness probes determine when to restart a container. For example, liveness probes could catch a deadlock when an application is running but unable to make progress.

If a container fails its liveness probe repeatedly, the kubelet restarts the container.

This setup essentially checks whether the file "/tmp/healthy" exists inside the container. If it does, the container is considered healthy; otherwise, it's marked as unhealthy.

To test the liveness probe for the provided Pod manifest, follow these steps:

1. **Apply the Pod manifest:**
    
    ```bash
    kubectl apply -f pod.yaml
    ```
    
2. **Monitor the Pod's status:**
    
    ```bash
    kubectl get pods
    ```
    
    Wait until the Pod is running. Initially, it may take some time for the **`initialDelaySeconds`** to pass before the liveness probe begins.
    
3. **Inspect the logs of the container:**
    
    ```bash
    kubectl logs mylivenessprobe -c liveness
    ```
    
    You should see no output because the liveness probe only checks the existence of the **`/tmp/healthy`** file.
    
4. **Check the events related to the Pod:**
    
    ```bash
    kubectl describe pod mylivenessprobe
    ```
    
    This command provides detailed information about the Pod, including events and any issues related to the liveness probe.
    
5. **Manually verify the file inside the container:**
    
    ```bash
    kubectl exec -it mylivenessprobe -- /bin/sh
    ```
    
    Inside the container, you can check if the **`/tmp/healthy`** file was created:
    
    ```bash
    cat /tmp/healthy
    ```
    
    It should display something like "Hello, I'm healthy!" if the liveness probe is functioning correctly.
    
6. **Simulate a failure (optional):**
    - If you want to simulate a failure and trigger the liveness probe, you can delete the **`/tmp/healthy`** file manually:
        
        ```bash
        kubectl exec -it mylivenessprobe -- /bin/sh
        rm /tmp/healthy
        ```
        
    
    After a short period, the liveness probe should detect the failure and restart the container.
    
    1. **Check the events related to the Pod:**
        
        ```bash
        kubectl describe pod mylivenessprobe
        ```
        
        See the events LivenessProbes failed 
        
    2. **Delete the pod**
    
    ```jsx
    kubectl delete pod mylivenessprobe
    ```
    
    ###

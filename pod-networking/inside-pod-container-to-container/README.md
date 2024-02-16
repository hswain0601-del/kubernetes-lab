**Use the following commands to interact with and test the pod.yml manifest:**

The pod.yml manifest file defines a Kubernetes Pod named testpod with two containers (c00 and c01).

Container c00 runs an Ubuntu image and executes a Bash command that continuously echoes "Hello-Nishant" every 5 seconds.
Container c01 runs an Apache HTTP Server (httpd) image and exposes port 80 for incoming network traffic.

- **Apply the Pod:**
    
    ```bash
    kubectl apply -f testpod.yml
    ```
    
    This command applies the configuration in the specified YAML file (**`filename.yaml`**) to the Kubernetes cluster.
    
- **Get Pods:**
    
    ```bash
    kubectl get pods
    ```
    
    This command lists all the Pods in the cluster, including the one named **`testpod`**.
    
- **Get Pod Details:**
    
    ```bash
    kubectl describe pod testpod
    ```
    
    This command provides detailed information about the **`testpod`** Pod, including its containers and configuration.
    
- **Accessing the Pod Shell:**
    
    ```bash
    kubectl exec -it testpod -- /bin/bash
    ```
    
    This command opens an interactive shell (**`/bin/bash`**) in the **`testpod`** Pod, allowing you to interact with its containers.
    
- **Port Forwarding:**
    
    ```bash
    kubectl port-forward testpod 8080:80
    ```
    
    This command forwards local port 8080 to port 80 in the **`testpod`** Pod, allowing you to access the Apache HTTP Server running in the second container locally at **`http://localhost:8080`**.
    
    - check inside the container
    - `kubectl exec testpod -it -c c00 -- /bin/bash`
    - `apt-get update && apt-get install curl -y`
    
    curl localhost:80
    <html><body><h1>It works!</h1></body></html>
    
- **Delete Pod:**
    
    ```bash
    kubectl delete pod testpod
    ```
    
    This command deletes the **`testpod`** Pod and its associated containers.

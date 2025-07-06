1. **Create a Secret File:**
    
    Create a file named **`mysecret.yaml`** 
    
    To decode the base64-encoded values of **`username`** and **`password`** in a Secret, you can use the following commands in a Unix-like shell (such as Bash):
    
    For **`username`**:
```
echo "admin" | base64
```

    
    ```bash
    echo "dXNlcm5hbWU=" | base64 --decode
    ```
    
    For **`password`**:
    
    ```bash
    echo "cGFzc3dvcmQ=" | base64 --decode
    ```
    
3. **Create the Secret:**
    
    Run the following command to create the Secret:
    
    ```bash
    kubectl apply -f mysecret.yaml
    ```
    
4. **Create the Pod:**
    
    Use the **`myvolsecret`** Pod manifest:
    
    ```bash
    kubectl apply -f myvolsecret.yaml
    ```
    
5. **Verify Pod Creation:**
    
    Ensure that the Pod has been created:
    
    ```bash
    kubectl get pods
    ```
    
6. **Exec into the Pod:**
    
    ```bash
    kubectl exec myvolsecret -it -- /bin/bash
    ```
    
7. **Inside the Pod (`ls` command):**
    
    Once inside the Pod, navigate to the mount path and list the contents:
    
    ```bash
    cd /tmp/mysecrets
    ls
    ```
    
    This should display the files corresponding to the keys in the Secret.

1. **Create a Secret File:**
    
    Create a file name **`sample.conf`** and then encode the secrets and put it in the file:
    ```
    echo -n "DB_HOST=db.prod.internal" | base64
    echo -n "DB_PORT=5432" | base64
    echo -n "DB_USER=admin" | base64
    echo -n "DB_PASSWORD=password123" | base64
    ```
    
    To decode the base64-encoded values in a Secret, we can use the following commands:
    
    For eg: **`DB_HOST`**:

    ```bash
    echo "REJfSE9TVD1kYi5wcm9kLmludGVybmFs" | base64 --decode
    ```
    
    
3. **Create the Secret:**
    
    - Encode the full file at once, because we cannot store multi line secret in our secret object file:
    
    ```bash
    cat sample.conf | base64
    REJfSE9TVD1SRUpmU0U5VFZEMWtZaTV3Y205a0xtbHVkR1Z5Ym1GcwpEQl9QT1JUPVJFSmZVRTlTVkQwMU5ETXkKREJfVVNFUj1SRUpmVlZORlVqMWhaRzFwYmc9PQpEQl9QQVNTV09SRD1SRUpmVUVGVFUxZFBVa1E5Y0dGemMzZHZjbVF4TWpNPQo=
    ```
    
    - store the secret for eg:

    ```bash
    apiVersion: v1
    kind: Secret
    metadata:
      name: mysecret
    type: Opaque
    data:
      sample.conf: |
        REJfSE9TVD1SRUpmU0U5VFZEMWtZaTV3Y205a0xtbHVkR1Z5Ym1GcwpEQl9QT1JUPVJFSmZVRTlTVkQwMU5ETXkKREJfVVNFUj1SRUpmVlZORlVqMWhaRzFwYmc9PQpEQl9QQVNTV09SRD1SRUpmVUVGVFUxZFBVa1E5Y0dGemMzZHZjbVF4TWpNPQo=
    ```
4. **Create the Pod:**
    
    Use the **`pod.yaml`** Pod manifest:
    
    ```bash
    kubectl apply -f pod.yaml
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
    cd /tmp/secret
    ls
    ```
    
    This should display the files corresponding to the keys in the Secret.

    ## NOTE
    1. Valid Use - DB credentials, API keys, TLS certs, Application config files, Nginx files etc.
    2. When storing file-based Secrets in Kubernetes, the entire file must be base64-encoded and stored under a single key
    3. Kubernetes decodes the Secret once and writes the raw file content into the container filesystem.
    4. Configmap for non-sensitive and Secrets for sensitive 

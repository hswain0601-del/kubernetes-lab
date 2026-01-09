# --- pv.yml ----
1. Docker Desktop uses the hostPath provisioner for Persistent Volumes. Unfortunately, it doesn't support AWS EBS or other cloud    providers' volume types directly. If you want to simulate PV and PVC using Docker Desktop, you can use the hostPath provisioner.
2. This PersistentVolume is intended for use in a Kubernetes cluster where the host machine provides storage at the specified path. Note that hostPath volumes are specific to the node where the pod using the volume is scheduled.

# --- pvc.yml ----
This PersistentVolumeClaim is intended to request storage from a PersistentVolume that has at least 1Gi of available capacity and supports the ReadWriteOnce access mode.

# --- deploy.yml ----
This Deployment creates a pod running a CentOS container that sleeps for a long duration and mounts a PersistentVolumeClaim (**`myhostpathvolclaim`**) to the path **`/tmp/persistent`** within the container.

1. **Apply PV and PVC:**
    
    ```bash
    kubectl apply -f pv.yaml
    kubectl apply -f pvc.yaml
    ```
    
2. **Verify PV and PVC:**
    
    ```bash
    kubectl get pv
    kubectl get pvc
    ```
    
3. **Apply Deployment:**
    
    ```bash
    kubectl apply -f deploy.yaml
    ```
    
4. **Verify Deployment:**
    
    ```bash
    kubectl get pods
    ```
    
5. **Check PVC Bound:**
    
    ```bash
    kubectl get pvc
    ```
    
6. **Exec into Pod to Verify Mount:**
    
    ```bash
    kubectl exec -it <pod-name> -- /bin/bash
    ```
    
    Inside the pod, check if the volume is mounted:
    
    ```
    cd /tmp/persistent
    touch test.txt
    exit
    ```
    
7. **Delete the Pod:**

```bash
kubectl delete pod <pod-name>

```

1. **Check if Pod is Deleted:**
    
    ```bash
    kubectl get pods
    
    ```
    
2. **Create a New Pod:**
You can create a new pod with the same volume specification or a similar one.
    
    ```bash
    kubectl apply -f pod.yaml
    
    ```
    
3. **Verify Volume Mount in the New Pod:**
    
    ```bash
    kubectl exec -it <new-pod-name> -- /bin/bash
    ```
    
4. Inside the new pod, check if the volume is mounted:

```bash
cd /tmp/hostpath
ls --> we should see test.txt
```

5. Cleanup everything:

```bash
kubectl delete deployment pvdeploy
kubectl delete pvc myhostpathvolclaim
kubectl delete pv <pv-name>
```

In Docker Desktop for Mac/Windows, the **`hostPath`** provisioner for Persistent Volumes uses the local file system of your Mac/Windows as the storage backend. By default, the paths are created under the Docker VM's file system.
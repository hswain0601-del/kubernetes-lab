**Use the following commands to interact with and test the pod.yml manifest:**

The pod.yml manifest file defines a Kubernetes ReplicationController named myreplica with a desired replica count of 2. The ReplicationController manages Pods based on a specified selector and template.

Selector: The ReplicationController selects Pods with the label myname: replica-label.

Template: Each managed Pod created by the ReplicationController is named testpod6 and has the label myname: replica-label. The Pod runs a single container (c00) with an Ubuntu image, executing a Bash command that continuously echoes "replica-label" every 5 seconds.

The ReplicationController ensures that there are always two Pods matching the specified selector and template running in the cluster. If a Pod fails or is deleted, the ReplicationController creates a new one to maintain the desired replica count.

1. **Apply the ReplicationController Manifest:**
    
    ```bash
    kubectl apply -f pod.yml
    ```
    
2. **Check ReplicationController Status:**
    
    ```bash
    kubectl get replicationcontroller
    ```
    
    Verify that the **`myreplica`** ReplicationController is in the "2/2" state, indicating that two Pods are running.
    
3. **Check Pod Status:**
    
    ```bash
    kubectl get pods
    ```
    
    Verify that there are two Pods with the name **`testpod6`** and the label **`myname: replica-label`** running.
    
4. **View Pod Logs:**
    
    ```bash
    kubectl logs <pod-name>
    ```
    
    Check the logs of one of the Pods to see the "replica-label" messages. Press **`Ctrl + C`** to exit.
    
5. **Scale ReplicationController (optional):**
    
    ```bash
    kubectl scale rc myreplica --replicas=3
    ```
    
    Scale the ReplicationController to three replicas. Check the status to ensure it's reflected in the desired replica count.
    
6. **Clean Up (optional):**
    
    ```bash
    kubectl delete replicationcontroller myreplica
    ```
    
    Delete the ReplicationController and associated Pods to clean up resources.

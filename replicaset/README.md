**Use the following commands to interact with and test the pod.yml manifest:**

Here's how this ReplicaSet works:

1. When you create or apply this ReplicaSet, it ensures that two Pods matching the label selector conditions are running at all times.
2. The ReplicaSet creates the initial two Pods based on the template defined in the **`template`** section.
3. If any of these Pods fail or are deleted, the ReplicaSet automatically replaces them to maintain the desired count of two replicas.
4. The label selector conditions are used to identify which Pods are managed by this ReplicaSet.
5. The ReplicaSet continuously monitors the state of the Pods and takes corrective action to ensure that there are always two replicas running.

Now, let's go through some common commands related to ReplicaSets:
- Create or apply the ReplicaSet using **`kubectl apply`**:
    
    ```bash
    kubectl apply -f myrs.yaml
    ```
    
- View information about the ReplicaSet:
    
    ```bash
    kubectl get replicaset myrs
    ```
    
- Describe the ReplicaSet for more details:
    
    ```bash
    kubectl describe replicaset myrs
    ```
    
- Scale the ReplicaSet to a different number of replicas (e.g., 3):
    
    ```bash
    kubectl scale replicaset myrs --replicas=3
    ```
    
- Delete the ReplicaSet:
    
    ```bash
    kubectl delete replicaset myrs
    ```
    

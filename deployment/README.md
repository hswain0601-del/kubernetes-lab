**Use the following commands to interact with and test the pod.yml manifest:**

Here's how this Deployment works:

1. When you create or apply this Deployment, it ensures that two Pods matching the label selector conditions are running at all times.
2. The Deployment creates the initial two Pods based on the template defined in the **`template`** section.
3. If any of these Pods fail or are deleted, the Deployment automatically replaces them to maintain the desired count of two replicas.
4. The label selector conditions are used to identify which Pods are managed by this Deployment.
5. You can easily update the Deployment to a new version by changing the Pod template or the Docker image. Kubernetes will perform rolling updates to ensure minimal disruption to the application.

Now, let's go through some common commands related to Deployments:

- Create or apply the Deployment using **`kubectl apply`**:
    
    ```bash
    kubectl apply -f your-deployment-file.yaml
    ```
    
- View information about the Deployment:
    
    ```bash
    kubectl get deployment mydeployments
    ```
    
- Describe the Deployment for more details:
    
    ```bash
    kubectl describe deployment mydeployments
    ```
    
- Rolling Update Test - Break the image eg: **"ubuntu" to "ubunt"**
    ```bash
    kubectl edit deployment mydeployments
    ```

- Watch pods
    ```bash
    kubectl get pods   
    NAME                            READY   STATUS             RESTARTS      AGE
    mydeployments-c77c895c9-rrvzk   0/1     ImagePullBackOff   0             9s
    mydeployments-fccc8cd48-46jqs   1/1     Running            0             29m
    mydeployments-fccc8cd48-52bmw   1/1     Running            0             29m
    mydeployments-fccc8cd48-hj4lg   1/1     Running            0             29m
    ```

**Observed behavior**
- 3 pods → Running
- 1 pod → ErrImagePull
- But Application keeps running
- And image does NOT cause downtime

**Check rollout status** - It menas rollout is safe because one pod is not healthy 
  ```bash
    kubectl rollout status deployment mydeployments
    Waiting for deployment "mydeployments" rollout to finish: 1 out of 3 new replicas have been updated...
  ```

**Fix & Rollback** - Fix image from **"ubunt" to "ubuntu"**
```bash
kubectl edit deployment mydeployments
```

- Change to a valid image:
```bash
image: ubuntu
```
- Verify rollout history
```bash 
kubectl rollout history deployment mydeployments
REVISION  CHANGE-CAUSE
1
2
```

- Rollback to previous version from 2 to 1
```bash
kubectl rollout undo deployment mydeployments
```
**Result:**

- 3 pods → Running
- **replicas: 3** - Ensures high availability & App stays live even if 1 pod fails
- **maxSurge: 1** - Allows 1 extra pod during update & New pod is created before old pod is deleted
- **maxUnavailable: 0** - Zero downtime guarantee & Old pods are deleted only after new pod is Ready also broken images or any configs do not affect LIVE traffic

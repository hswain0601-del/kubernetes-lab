### 1. Create a Database Configuration File (sample.conf) TYPE-1 -

Create a file named **`sample.conf`** with your desired database configuration. For example:

```
DB_HOST=localhost
DB_PORT=5432
DB_USER=myuser
DB_PASSWORD=mypassword
```

### 2. Create a ConfigMap

```bash
kubectl create configmap mymap --from-file=sample.conf
```

### 3. Create a Pod with the ConfigMap Volume

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myvolconfig
spec:
  containers:
  - name: c1
    image: ubuntu
    command: ["/bin/bash", "-c", "while true; do echo Hello-World; sleep 5 ; done"]
    volumeMounts:
      - name: testconfigmap
        mountPath: "/tmp/config"   # Config files will be mounted as ReadOnly by default
  volumes:
  - name: testconfigmap
    configMap:
       name: mymap   # Should match the ConfigMap name created earlier
       items:
       - key: sample.conf
         path: sample.conf
```

Apply the Pod configuration:

```bash
kubectl apply -f myvolconfig-pod.yaml
```

### 4. Verify ConfigMap Mount in the Pod

```bash
kubectl exec myvolconfig -it -- /bin/bash
```

Inside the Pod:

```bash
cd /tmp/config
cat sample.conf
exit
```

This lab demonstrates how to create a ConfigMap from a configuration file and mount it into a Pod, allowing the Pod to access the configuration data.

The provided YAML file **`myvolconfig-env-pod.yaml`** is a Kubernetes manifest file defining a Pod named **`myenvconfig`**. This Pod runs a container based on the CentOS image and has an environment variable (**`MYENV`**) that is populated using a ConfigMap (**`mymap`**).

Let's break down the components of the YAML file and the associated commands:

1. **Pod Definition (`myvolconfig-env-pod.yaml`):**
    
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: myenvconfig
    spec:
      containers:
      - name: c1
        image: centos
        command: ["/bin/bash", "-c", "while true; do echo Hello-world; sleep 5 ; done"]
        env:
        - name: MYENV
          valueFrom:
            configMapKeyRef:
              name: mymap
              key: sample.conf
    ```
    
    ### TYPE - 2
    **Lab: Creating a ConfigMap and Mounting it in a Pod via ENV**
    
    This Pod specification:
    
    - Defines a Pod named **`myenvconfig`**.
    - Contains a single container (**`c1`**) based on the CentOS image.
    - Runs a bash command in a loop to echo "Hello-World
    - " every 5 seconds.
    - Sets an environment variable **`MYENV`** with the value fetched from the **`sample.conf`** key in the **`mymap`** ConfigMap.
2. **Apply the Configuration:**
    
    ```bash
    kubectl apply -f myvolconfig-env-pod.yaml
    ```
    
    This command deploys the Pod configuration to the Kubernetes cluster.
    
3. **Exec into the Pod:**
    
    ```bash
    kubectl exec myenvconfig -it -- /bin/bash
    ```
    
    This command opens an interactive shell (**`/bin/bash`**) inside the running Pod (**`myenvconfig`**), allowing you to execute commands within the Pod.
    
4. **Inside the Pod (`env` and `echo` commands):**
    
    ```bash
    env
    ```
    
    This command lists all environment variables inside the Pod.
    
    ```bash
    echo $MYENV
    exit
    kubectl delete pod <pod-name>
    ```
    
    This command echoes the value of the **`MYENV`** environment variable, which is set to the content of the **`sample.conf`** key from the **`mymap`** ConfigMap.
    
5. **Result:**
    
    The output of **`env`** and **`echo $MYENV`** inside the Pod should display the environment variables, and **`MYENV`** should contain the values from the **`sample.conf`** key in the **`mymap`** ConfigMap.

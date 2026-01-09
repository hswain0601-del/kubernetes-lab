### 1. Create a Database Configuration File (sample.conf)

Create a file named **`sample.conf`** with your desired database configuration. For example:

```
DB_HOST=localhost
DB_PORT=5432
DB_USER=myuser
DB_PASSWORD=mypassword
```

### 2. Create a ConfigMap

```bash
kubectl apply -f configmap.yaml
kubectl get cm
kubectl get cm mymap -o yaml
kubectl get cm mymap -o json
```

### 3. Apply the Pod configuration:

```bash
kubectl apply -f pod.yaml
kubectl get pods
```

### 4. Verify ConfigMap Mount in the Pod

```bash
kubectl exec  -it myvolconfig -- /bin/bash
```

Inside the Pod:

```bash
cd /tmp/config
cat sample.conf
exit
```

## NOTES:
1. This lab demonstrates how to create a ConfigMap from a configuration file and mount it into a Pod, allowing the Pod to access the configuration data.
2. PVC stores application DATA, ConfigMap stores application CONFIGURATION 
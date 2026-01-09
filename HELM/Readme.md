# Helm Chart for getting-started Application

This Helm chart provides a simple way to deploy a NodeJS application.

## Prerequisites

- Kubernetes cluster 
- Helm 3.x
- docker

## Installation

### Clone the Repository

```bash
git clone https://github.com/DevOps-Playbbok/Kubernetes-Lab
cd HELM/
```

### Test the Chart in debug mode

We can test the Helm chart using the debug mode:

```bash
helm upgrade --install todo --dry-run --debug .
```

### Deploy the Chart 

We can install the Helm chart using the following command:

```bash
helm upgrade --install todo .
```


## Check resources

1. Check all the objects created:
```bash
kubectl get all
kubectl get pv,pvc,cm,secrets
```
2. Get the NodePort port and test the App Frontend
```bash
kubectl get svc 
kubectl get secret todo-todo-basic-auth -o yaml
```

3. Decode the username and password 
```bash
echo "YWRtaW46e1BMQUlOfWFkbWluMTIz" | base64 --decode
```

4. Login to frontend via NGINX and proxies the request to Backend NodeJS 
```bash
http://localhost:<NodePort>
```


## Cleanup

To uninstall the Helm chart:

```bash
helm uninstall wanderlast
```

## Additional Labs

🗄️ Database Management - Since the database is running inside the cluster, we can interact with it using kubectl exec.

1. Connect to MySQL Shell
Find your MySQL pod name and run:

```bash
kubectl exec -it <mysql-pod-name> -- mysql -u root -p
```
When prompted for a password, use the one defined in our values.yaml (default: secret).

2. View and Add Data - Once inside the MySQL shell:

- Select the Database:

```bash
USE todos;
```
- Check existing tables:

```bash
SHOW TABLES;
```

- Add a manual entry - any items from the frontend

```bash
SELECT * FROM todos;
```

## License

This Helm chart is licensed under the MIT License. See the `LICENSE` file for details.

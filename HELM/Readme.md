# Helm Chart for getting-started Application

This Helm chart provides a simple way to deploy a NodeJS application.

## Prerequisites

- Kubernetes cluster 
- Helm 3.x
- docker

## Architecture
<img width="2990" height="3384" alt="todo_app_k8s_architecture" src="https://github.com/user-attachments/assets/1bb829e5-1823-42da-a6bf-abefe21ef29e" />

**Here's the full end-to-end flow — click any box to ask more about that component. Here's how traffic moves:**
- Browser hits Cloud Shell Web Preview on port 8081 **(ports can be any port - 8081,8082,8083 etc)**
- NodePort service (todo-todo) receives it and routes to port 80 inside the pod
- OpenResty (nginx + Lua) checks for the auth cookie — redirects to login page if missing, proxies to 127.0.0.1:3000 if valid
- Todo App (Node.js) handles the request, reads/writes to MySQL using the MYSQL_HOST env var resolved via DNS
- ClusterIP service (todo-todo-mysql) routes the DB connection to the MySQL pod
- MySQL persists data to the PVC which survives pod restarts and redeployments

## Installation

Refer doc: https://helm.sh/docs/intro/install


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

### Check if any port-forward processes running - eg: 8081, 8082 & Kill them all cleanly:

```bash
pkill -f "kubectl port-forward"
ps aux | grep port-forward
```
<img width="1379" height="183" alt="Screenshot 2026-06-15 at 12 16 17 PM" src="https://github.com/user-attachments/assets/821b041f-8d89-4c89-adc1-da53f8eda662" />

### Deploy the Chart 

We can install the Helm chart using the following command:

```bash
helm upgrade --install todo .
```

### Test via port-forwarding (Cloudshell or any Public Coud)

* **Tunnel via port-forwarding:**
```bash
kubectl port-forward svc/todo-todo 8083:80
```
<img width="1440" height="171" alt="Screenshot 2026-06-15 at 12 22 49 PM" src="https://github.com/user-attachments/assets/246a946f-e579-41cc-ac3d-ed5233e5ef5b" />

* **The request hit the Nginx container**
<img width="1440" height="544" alt="Screenshot 2026-06-15 at 12 23 49 PM" src="https://github.com/user-attachments/assets/c481185e-0c48-4c1b-8e9c-b5799d8ea92c" />

* **Enter the Basic auth credentials - you can get it in secrets**
```bash
kubectl get secret todo-todo-basic-auth -o yaml
echo "YWRtaW46e1BMQUlOfWFkbWluMTIz" | base64 -d
```
<img width="1440" height="522" alt="Screenshot 2026-06-15 at 12 31 28 PM" src="https://github.com/user-attachments/assets/2537994b-b311-4589-8a5a-ef5f6e740362" />

* **Once we add the credentials the Nginx should proxy the request to the backend NodeJS container.
<img width="1440" height="471" alt="Screenshot 2026-06-15 at 12 33 19 PM" src="https://github.com/user-attachments/assets/4418bb90-369c-4707-9ad3-1536d5273d67" />


## Additional Labs

#### Database Management - Since the database is running inside the cluster, we can interact with it using kubectl exec.

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
SELECT * FROM todos_items;
```

## Cleanup

To uninstall the Helm chart:

```bash
helm uninstall todo
```

## License

This Helm chart is licensed under the MIT License. See the `LICENSE` file for details.

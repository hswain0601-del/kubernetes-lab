## Steps to Deploy in Kubernetes Cluster:

### Prerequisite:
* Update the **.env.docker** file in **frontend** directory
```bash
VITE_API_PATH="http://192.168.68.88:31100" # this ip from worker node
```
* Update the **.env.docker** file in **backend** directory
```bash
MONGODB_URI="mongodb://mongo-service/wanderlust"
```
* Rebuild the docker image with tag and push it to DockerHub
```bash
cd fronetnd
docker build -t <your-dockuerhub-username>/frontend:06.07.25 .
cd backend
docker build -t <your-dockuerhub-username>/backend:06.07.25 .
docker login -u <your-dockuerhub-username>
docker images
docker push <your-dockuerhub-username>/frontend:<TAG>
docker push <your-dockuerhub-username>/backend:<TAG>
```
<img width="1422" alt="Screenshot 2025-07-06 at 11 38 18 PM" src="https://github.com/user-attachments/assets/115e2b00-74c0-4be8-95d0-df7c4f8a9aab" />

<img width="1422" alt="Screenshot 2025-07-06 at 11 39 55 PM" src="https://github.com/user-attachments/assets/73269175-08bc-443c-8792-a78ad4cc8f83" />

<img width="1440" alt="Screenshot 2025-07-06 at 11 40 49 PM" src="https://github.com/user-attachments/assets/3e4d0985-1db0-4b8f-bfdf-b65241b2d374" />

* Now once the image is pushed you can just update the image tag in **frontend-deployment.yaml** and **backend-deployment.yaml** which you pushed above.
<img width="807" alt="Screenshot 2025-07-06 at 11 44 36 PM" src="https://github.com/user-attachments/assets/3432d46c-5bf2-41d5-8148-b1e27a5fa8b6" />

Enable DNS resolution on kubernetes cluster :
> Check coredns pod in kube-system namespace
```bash
kubectl get pods -n kube-system -o wide | grep -i core
```
> Scale coredns pod on worker node as well for DNS resolution
```bash
kubectl edit deploy coredns -n kube-system -o yaml
```
Edit replica from 2 to 4
![image](https://github.com/user-attachments/assets/f1f4f026-bcfe-42cc-8361-890035e5973e)

![image](https://github.com/user-attachments/assets/5c680291-6497-404a-ba23-115e391df7bb)

> Deploy manifest files to kubernets cluster
```
kubectl create -f kubernetes/
```
> Get all objects inside the namespace
<img width="1422" alt="Screenshot 2025-07-06 at 10 59 35 PM" src="https://github.com/user-attachments/assets/960cd204-6ade-4565-b61e-6eb234e4177b" />

> See the logs in case of deployment errors
```bash
kubectl describe pod <pod-name> 
kubectl logs <pod-name>
```
Results:
> Get the PublicIP and connect frontend:
```bash
kubectl port-forward service/frontend 31000:5173 --address 0.0.0.0 &
```

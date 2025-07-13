NGINX Ingress is a gateway that lets you expose internal Kubernetes services to the outside world using HTTP/HTTPS.


Create ingress-nginx Namespace
```
kubectl create namespace ingress-nginx
```
Install NGINX Ingress Controller for AWS (via manifest)
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/aws/deploy.yaml
```
This creates a LoadBalancer Service which gets a public ELB automatically.

check the service:
```
kubectl get svc -n ingress-nginx
```
Deploy the app , service and ingress:

```
kubectl apply -f deploy.yml
kubectl apply -f service.yml
kubectl apply -f ingress.yml
```
Use curl with Host header:
```
curl -H "Host: hello.eks.local" http://<elb-dns-name>
```
Access in browser using ELB DNS.
Delete resoruces:
```
kubectl delete -f deploy.yml
kubectl delete -f service.yml
kubectl delete -f ingress.yml
```

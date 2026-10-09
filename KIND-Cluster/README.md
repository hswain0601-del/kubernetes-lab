# Create Local KIND cluster

## Pre-requisites tools

- [Docker](https://www.docker.com/products/docker-desktop/)
- [KIND](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

```bash
docker --version
kind --version
kubectl version --client
```

you'll see something like this (the version can be different):

```bash
Docker version 29.8.2, build 7fc2dff
kind version 0.33.0
Client Version: v1.35.8-dispatcher
Kustomize Version: v5.7.1
```

## Commands

### List kind clusters
```bash
kind get clusters
```
Output: `No kind clusters found.` or `Found 1 cluster with name "local-cluster"`

### Create kind cluster

```bash
kind create cluster
```
Output: `Creating cluster "kind...` (it will take some time to create the cluster)


### Create kind cluster with arguments (custom image and name)

```bash
kind create cluster --image kindest/node:v1.35.0 --name local-cluster
```

### Create kind cluster with config file

```bash
cd KIND-Cluster
```

```bash
kind create cluster --config ./kind-cluster-config.yaml
```
---

## Varify if KubeConfig File is loaded

```bash
kubectl config view
```
Output:

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://127.0.0.1:60258
  name: kind-local-cluster
contexts:
- context:
    cluster: kind-local-cluster
    user: kind-local-cluster
  name: kind-local-cluster
current-context: kind-local-cluster
kind: Config
users:
- name: kind-local-cluster
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
```

### Varify if Nodes are running

```bash
kubectl get nodes
```
Output:

```
NAME                 STATUS   ROLES           AGE   VERSION
kind-control-plane   Ready    control-plane   2m    v1.37.0
```

## Delete kind cluster
```bash
kind delete cluster --name local-cluster
```
Output

```
kind delete cluster --name local-cluster
Deleting cluster "local-cluster" ...
```

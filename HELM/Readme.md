# Helm Chart for Three-Tier Application

This Helm chart provides a simple way to deploy a three-tier application consisting of a frontend, backend, and database. It is designed to be modular, allowing customization for various application needs.

## Architecture

1. **Frontend**: A web-based user interface.
2. **Backend**: An API or business logic layer.
3. **Database**: A persistent storage layer.

## Prerequisites

- Kubernetes cluster 
- Helm 3.x
- docker

## Installation

### Clone the Repository

```bash
git clone https://github.com/DevOps-Playbbok/MERN-Stack-Application
cd Helm
```

### Test the Chart in debug mode

You can test the Helm chart using the debug mode:

```bash
helm upgrade --install wanderlast --dry-run --debug .
```

### Deploy the Chart 

You can install the Helm chart using the following command:

```bash
helm upgrade --install wanderlast .
```


## Configuration

The following values can be overridden in the `values.yaml` file or passed as `--set` parameters during installation.

### Global Values

| Parameter                  | Description                         |
|----------------------------|-------------------------------------|
| `replicaCount`             | Number of replicas for each tier   |
| `imagePullSecrets`         | Secrets for pulling images         |
| `nodeSelector`             | Node selector configuration        |
| `tolerations`              | Toleration configuration           |
| `affinity`                 | Affinity rules                     |

### Frontend Values

| Parameter                  | Description                         |
|----------------------------|-------------------------------------|
| `frontend.image.repository`| Frontend image repository           |
| `frontend.image.tag`       | Frontend image tag                  |
| `frontend.service.type`    | Service type for frontend           |
| `frontend.service.port`    | Service port for frontend           |

### Backend Values

| Parameter                  | Description                         |
|----------------------------|-------------------------------------|
| `backend.image.repository` | Backend image repository            |
| `backend.image.tag`        | Backend image tag                   |
| `backend.service.type`     | Service type for backend            |
| `backend.service.port`     | Service port for backend            |

### Database Values

| Parameter                  | Description                         |
|----------------------------|-------------------------------------|
| `database.image.repository`| Database image repository           |
| `database.image.tag`       | Database image tag                  |
| `database.service.type`    | Service type for database           |
| `database.service.port`    | Service port for database           |
| `database.persistentVolume.enabled` | Enable persistent storage  |
| `database.persistentVolume.size`    | Size of persistent volume  |

## Usage

### Access the Frontend

To access the frontend, retrieve the service's LoadBalancer:

```bash
kubectl get svc 
```

### Logs

You can view the logs for each tier by running:

```bash
kubectl logs -l app.kubernetes.io/name=frontend
kubectl logs -l app.kubernetes.io/name=backend
kubectl logs -l app.kubernetes.io/name=database
```

## Cleanup

To uninstall the Helm chart:

```bash
helm uninstall wanderlast
```

## License

This Helm chart is licensed under the MIT License. See the `LICENSE` file for details.

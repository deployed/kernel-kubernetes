# Django on K3s

This guide provides step-by-step instructions to deploy a Django project on a K3s (lightweight Kubernetes) cluster.

## Prerequisites

- A running K3s cluster ([Install K3s](https://k3s.io))
- Docker

## Create and push the docker image (on your local machine)

1. Clone the repository: `git clone https://github.com/deployed/kernel-kubernetes.git `
2. Update <your-docker-image> in Makefile
3. Run `make build` and `make push`


## Setup application on K3s

1. Clone the repository: `git clone https://github.com/deployed/kernel-kubernetes.git `
2. Update <your-docker-image> in `django-app.yaml`, `django-migrations.yaml`, `webserver.yaml`
3. Update <your-domain> in `ingress.yaml`
4. Update <your-email> in `traefik-le.yaml`
5. Create the namespace: `kubectl create namespace django-app` or `kubectl apply -f k3s_manifests/namespace.yaml`
6. Create registry secret: `kubectl -n django-app create secret docker-registry k3s-django-app --docker-server=<docker-registry> --docker-username=<username> --docker-password=<token>`
7. Create app secret: `kubectl -n django-app create secret generic django-app-secret --from-literal=POSTGRES_PASSWORD=mysecretpassword --from-literal=DJANGO_SECRET_KEY=yourdjangosecretkey`
8. Apply the manifests: `kubectl apply -f k3s_manifests/`
9. Check the status: `kubectl get all -n django-app`

Application should be accessible at https://<your-domain>

## Cleanup

1. Delete the namespace: `kubectl delete namespace django-app`

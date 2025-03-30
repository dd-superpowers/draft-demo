# ☸️ Kubernetes [tmp 🚧 work in progress]

## Checks the K8S cluster connection

```bash
kubectl config get-contexts
# To switch to the docker-desktop context, use:
kubectl config use-context docker-desktop
# Verify
kubectl cluster-info
```

## Kube requirements

```bash
k9s --all-namespaces

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik

# namespace
kubectl create namespace demo --dry-run=client -o yaml | kubectl apply -f -
# if the namespace already exists with apps; you can delete with this command:
# kubectl delete namespace demo
kubectl apply -f ./01-deploy.redis.yaml -n demo
kubectl apply -f ./02-create.configmap.yaml -n demo
kubectl apply -f ./03-create.redis.client.pod.cli.yaml -n demo

kubectl exec redis-client -n demo -- /bin/sh /scripts/init-script.sh
```

## Deploy to Kube

```bash
# test the deployment of the application
kubectl apply -f ./04-deploy.app.yaml -n demo

# check
kubectl describe ingress demo-restos -n demo

# ✋✋✋ you can delete the deployment of the webapp with these commands:
kubectl delete -f ./04-deploy.app.yaml -n demo
```



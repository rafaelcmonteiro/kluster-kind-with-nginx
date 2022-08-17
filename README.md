# How to implement nginx ingress in a kind cluster, for the sake of study.
 
The idea of this project is to study how nginx works in a kubernetes cluster.

# Creating Kind Cluster

First thing, install [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).

After that use the following configuration to create the cluster:

```
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
```


This config will allow the host machine to make requests to the Ingress controller, in my case nginx ingress or any other ingress of your choice.

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```


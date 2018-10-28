# Kubernetes playgound using docker edge

## Dashboard
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl get secrets -n kube-system  | grep dashboard
kubectl describe secret kubernetes-dashboard-token-fs4xm -n kube-system
kubectl proxy
open http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

## Prometheus Operator
https://github.com/coreos/prometheus-operator
```
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/bundle.yaml
```

Scale down StatefulSets
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/statefulset?namespace=monitoring

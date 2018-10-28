# Core Concepts (19%)

https://kubernetes.io/docs/concepts/

Kubernetes is declarative, describing desired state rather than imperative, describing what to do.

Self healing, k8s continuously monitors and takes restorative actions to maintain the desired state.

Use the k8s api to create objects that define the desired state of the cluster, typically using 'kubectl'.
The k8s _control plane_ carries out the work to change the current state to match the desired state.

### Master Node Components
Monitor the current state and take action to achieve desired state
* [kube-apiserver](https://kubernetes.io/docs/admin/kube-apiserver/)
Provides the cluster’s shared state through which all other components interact
Validates and configures data for api objects
* [kube-controller-manager](https://kubernetes.io/docs/admin/kube-controller-manager/)
Manages the controllers that watch the shared state of the cluster, through the apiserver.
Attempts to move the current state towards the desired state.
* [kube-scheduler](https://kubernetes.io/docs/admin/kube-scheduler/)
Schedules workloads taking into account the cluster topology and policies.
* [cloud-controller-manager](https://kubernetes.io/docs/concepts/overview/components/#cloud-controller-manager)
Runs cloud-provider-specific controller loops. Other controllers are dependent on this to determine state etc of the underlying cloud infrastructure such as attaching volumes (volume-controller).
* [etcd](https://kubernetes.io/docs/concepts/overview/components/#etcd)
Provides a persistent state store for the cluster. Can be run separately, needs backup/restore (?)

### Worker Node Components
Respond to scheduling requests, hosting workloads through _pods_ and other kubernetes objects that represent the state of the system.
* kubelet
The primary _"node agent"_ that runs on each node.
Manages containers described in PodSpecs to ensure they are running and healthy
* kube-proxy
Provides TCP, UDP, and SCTP stream forwarding across a set of backends in accordance with defined cluster services
* container runtime

### Addons
[Core add-ons](https://kubernetes.io/docs/concepts/overview/components/#addons):
	* DNS, Web UI (dashboard), Resource Monitoring
[Additional extensions](https://kubernetes.io/docs/concepts/cluster-administration/addons/) can be installed to meet different requirements.
[Legacy Addons](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons) includes prometheus, grafana. These are now typically installed using [operators](https://coreos.com/operators/) and extend the native k8s api.


## API primitives
The [k8s api](https://kubernetes.io/docs/concepts/overview/kubernetes-api/) provides a way to interact with k8s objects, typically using the `kubectl` command. Since 1.x the openapi definitions

Basic operations:
Set of CRUD like operations for resources / api objects:

| get | retrieves a list |
| describe | shows details of a resource or set of resources |
| edit | interactive editor for existing objects |
| patch | modify specific fields of existing objects
| apply | config resource(s) from file or stdio
| delete | remove the named resources

## Cluster architecture
## Services and other network primitives

# dial-extension

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

Helm chart for dial extensions

## TL;DR

```console
helm repo add dial https://charts.epam-rail.com
helm install my-release dial/dial-extension --set image.repository=epam/ai-dial-adapter-openai
```

## Prerequisites

- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (optional)
- Ingress controller support in the underlying infrastructure (optional)

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/bitnamicharts | common | 2.29.0 |

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add dial https://charts.epam-rail.com
helm install my-release dial/dial-extension
```

The command deploys dial-extension on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

**NOTE**: Persistent Volumes created by StatefulSets won't be deleted automatically

## Parameters

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example:

```console
helm install my-release dial/dial-extension --set image.repository=epam/ai-dial-adapter-openai
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example:

```yaml
# values.yaml file content
image:
  repository: epam/ai-dial-adapter-openai
```

```console
helm install my-release dial/dial-extension -f values.yaml
```

**NOTE**: You can use the default [values.yaml](values.yaml)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for dial-extension pods assignment |
| annotations | object | `{}` | Annotations to add to dial-extension deployed objects |
| args | list | `[]` | Override default dial-extension args (useful when using custom images) |
| autoscaling.hpa.annotations | object | `{}` | Annotations for HPA resource |
| autoscaling.hpa.behavior | object | `{}` | HPA Behavior |
| autoscaling.hpa.customRules | list | `[]` | HPA Custom rules |
| autoscaling.hpa.enabled | bool | `false` | Enable HPA ref: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/ |
| autoscaling.hpa.maxReplicas | int | `3` | Maximum number of replicas |
| autoscaling.hpa.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.hpa.targetCPU | string | `""` | Target CPU utilization percentage |
| autoscaling.hpa.targetMemory | string | `""` | Target Memory utilization percentage |
| command | list | `[]` | Override default dial-extension command (useful when using custom images) |
| commonAnnotations | object | `{}` | Annotations to add to all deployed objects |
| commonLabels | object | `{}` | Labels to add to all deployed objects |
| containerPorts.http | int | `5000` | dial-extension HTTP container port |
| containerPorts.metrics | int | `9464` | dial-extension HTTP container port for metrics |
| containerSecurityContext.enabled | bool | `true` | Enabled dial-extension container's Security Context |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` | Set dial-extension containers' Security Context runAsNonRoot |
| containerSecurityContext.runAsNonRoot | bool | `true` | Set dial-extension containers' Security Context runAsNonRoot |
| containerSecurityContext.runAsUser | int | `1001` | Set dial-extension container's Security Context runAsUser |
| customLivenessProbe | object | `{}` | Custom livenessProbe that overrides the default one |
| customReadinessProbe | object | `{}` | Custom readinessProbe that overrides the default one |
| customStartupProbe | object | `{}` | Custom startupProbe that overrides the default one |
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (all probes will be disabled) |
| env | object | `{}` | Key-value pairs extra environment variables to add to dial-extension |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release |
| extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for dial-extension containers |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the dial-extension container(s) |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the dial-extension pod(s) |
| fullnameOverride | string | `""` | String to fully override common.names.fullname |
| global.imagePullSecrets | list | `[]` | Global Docker registry secret names as an array |
| global.imageRegistry | string | `""` | Global Docker image registry |
| global.storageClass | string | `""` | Global StorageClass for Persistent Volume(s) |
| hostAliases | list | `[]` | dial-extension pods host aliases https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/ |
| hostNetwork | bool | `false` | Enable Host Network If hostNetwork true, then dnsPolicy is set to ClusterFirstWithHostNet |
| image.digest | string | `""` | Image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images |
| image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| image.registry | string | `"docker.io"` | Image registry |
| image.repository | string | `""` | Image repository e.g: epam/ai-dial-adapter-openai |
| image.tag | string | `"latest"` | Image tag (immutable tags are recommended) |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. Use this parameter to set the required annotations for cert-manager, see ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations |
| ingress.enabled | bool | `false` | Enable ingress record generation for container |
| ingress.extraPaths | list | `[]` | An array with additional arbitrary paths that may need to be added to the ingress under the main host |
| ingress.extraRules | list | `[]` | An array with additional hostname(s) to be covered with the ingress record |
| ingress.hosts | list | `["dial-extension.local"]` | An array with hostname(s) to be covered with the ingress record |
| ingress.ingressClassName | string | `""` | IngressClass that will be be used to implement the Ingress ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class |
| ingress.path | string | `"/"` | Default path for the ingress record NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers |
| ingress.pathType | string | `"Prefix"` | Ingress path type |
| ingress.serviceName | string | `""` | Change default name of service for the ingress record |
| ingress.tls | list | `[]` | TLS configuration for additional hostname(s) to be covered with this ingress record (evaluated as a template) ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls |
| initContainers | list | `[]` | Add additional init containers to the dial-extension pod(s) ref: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ |
| labels | object | `{}` | Labels to add to dial-extension deployed objects |
| lifecycleHooks | object | `{}` | for the dial-extension container(s) to automate configuration before or after startup |
| livenessProbe.enabled | bool | `false` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.httpGet.path | string | `"/health"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `3` |  |
| metrics.enabled | bool | `false` | Enable the export of Prometheus metrics |
| metrics.service.annotations | object | `{}` | Additional custom annotations for dial-extension metrics service |
| metrics.service.clusterIP | string | `""` | dial-extension metrics service Cluster IP clusterIP: None |
| metrics.service.externalTrafficPolicy | string | `"Cluster"` | dial-extension metrics service external traffic policy ref http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| metrics.service.extraPorts | list | `[]` | Extra ports to expose in dial-extension metrics service (normally used with the `sidecars` value) |
| metrics.service.loadBalancerIP | string | `""` | dial-extension metrics service Load Balancer IP ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer |
| metrics.service.loadBalancerSourceRanges | list | `[]` | dial-extension metrics service Load Balancer sources ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service |
| metrics.service.nodePorts | object | `{"http":""}` | Node ports to expose NOTE: choose port between <30000-32767> |
| metrics.service.nodePorts.http | string | `""` | Node port for metrics |
| metrics.service.ports | object | `{"http":9464}` | dial-extension metrics service port |
| metrics.service.ports.http | int | `9464` | dial-extension metrics service port |
| metrics.service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None ref: https://kubernetes.io/docs/user-guide/services/ |
| metrics.service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| metrics.service.type | string | `"ClusterIP"` | dial-extension metrics service type |
| metrics.serviceMonitor.annotations | object | `{}` | Additional custom annotations for the ServiceMonitor |
| metrics.serviceMonitor.enabled | bool | `false` | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`) |
| metrics.serviceMonitor.honorLabels | bool | `false` | honorLabels chooses the metric's labels on collisions with target labels |
| metrics.serviceMonitor.interval | string | `""` | Interval at which metrics should be scraped. ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint e.g: interval: 10s |
| metrics.serviceMonitor.jobLabel | string | `""` | The name of the label on the target service to use as the job name in Prometheus |
| metrics.serviceMonitor.labels | object | `{}` | Extra labels for the ServiceMonitor |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Specify additional relabeling of metrics |
| metrics.serviceMonitor.namespace | string | `""` | Namespace in which Prometheus is running |
| metrics.serviceMonitor.path | string | `"/metrics"` | Specify metrics path ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint |
| metrics.serviceMonitor.port | string | `"http-metrics"` | Specify service metrics port ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint |
| metrics.serviceMonitor.relabelings | list | `[]` | Specify general relabeling |
| metrics.serviceMonitor.scrapeTimeout | string | `""` | Timeout after which the scrape is ended ref: https://github.com/coreos/prometheus-operator/blob/master/Documentation/api.md#endpoint e.g: scrapeTimeout: 10s |
| metrics.serviceMonitor.selector | object | `{}` | Prometheus instance selector labels ref: https://github.com/bitnami/charts/tree/main/bitnami/prometheus-operator#prometheus-configuration |
| nameOverride | string | `""` | String to partially override common.names.name |
| namespaceOverride | string | `""` | String to fully override common.names.namespace |
| nodeSelector | object | `{}` | Node labels for dial-extension pods assignment ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| pdb.create | bool | `false` | Enable/disable a Pod Disruption Budget creation |
| podAnnotations | object | `{}` | Annotations for dial-extension pods ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| podLabels | object | `{}` | Extra labels for dial-extension pods ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| podSecurityContext.enabled | bool | `true` | Enabled dial-extension pod's Security Context |
| podSecurityContext.fsGroup | int | `1001` | Set dial-extension pod's Security Context fsGroup |
| priorityClassName | string | `""` | dial-extension pods' priorityClassName |
| readinessProbe.enabled | bool | `false` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `15` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| replicaCount | int | `1` | Number of dial-extension replicas to deploy |
| resources | object | `{}` | dial-extension resource requests and limits ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| schedulerName | string | `""` | Name of the k8s scheduler (other than default) for dial-extension pods ref: https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/ |
| secrets | object | `{}` | Key-value pairs extra environment variables to add in environment variables from secrets to dial-extension |
| service.annotations | object | `{}` | Additional custom annotations for dial-extension service |
| service.clusterIP | string | `""` | dial-extension service Cluster IP clusterIP: None |
| service.externalTrafficPolicy | string | `"Cluster"` | dial-extension service external traffic policy ref http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip |
| service.extraPorts | list | `[]` | Extra ports to expose in dial-extension service (normally used with the `sidecars` value) |
| service.loadBalancerIP | string | `""` | dial-extension service Load Balancer IP ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer |
| service.loadBalancerSourceRanges | list | `[]` | dial-extension service Load Balancer sources ref: https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/#restrict-access-for-loadbalancer-service |
| service.nodePorts | object | `{"http":""}` | Node ports to expose NOTE: choose port between <30000-32767> |
| service.nodePorts.http | string | `""` | Node port for HTTP |
| service.ports.http | int | `80` | dial-extension service HTTP port |
| service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None ref: https://kubernetes.io/docs/user-guide/services/ |
| service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| service.type | string | `"ClusterIP"` | dial-extension service type |
| serviceAccount.annotations | object | `{}` | Additional Service Account annotations (evaluated as a template) |
| serviceAccount.automountServiceAccountToken | bool | `true` | Automount service account token for the server service account |
| serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| sidecars | list | `[]` | Add additional sidecar containers to the dial-extension pod(s) |
| startupProbe.enabled | bool | `false` |  |
| startupProbe.failureThreshold | int | `6` |  |
| startupProbe.httpGet.path | string | `"/health"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.initialDelaySeconds | int | `30` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| terminationGracePeriodSeconds | string | `""` | Seconds dial-extension pod needs to terminate gracefully ref: https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods |
| tolerations | list | `[]` | Tolerations for dial-extension pods assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| topologySpreadConstraints | list | `[]` | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods |
| updateStrategy.type | string | `"RollingUpdate"` | StrategyType Can be set to RollingUpdate or OnDelete |
# dial-extension

![Version: 2.1.1](https://img.shields.io/badge/Version-2.1.1-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

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
| oci://registry-1.docker.io/bitnamicharts | common | 2.31.4 |

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
| args | list | `[]` | Override default args (useful when using custom images) |
| automountServiceAccountToken | bool | `false` | Mount Service Account token in pods |
| autoscaling.hpa | object | [Documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) | Horizontal Pod Autoscaler (HPA) settings |
| autoscaling.hpa.annotations | object | `{}` | Annotations for HPA resource |
| autoscaling.hpa.behavior | object | `{}` | HPA Behavior |
| autoscaling.hpa.customRules | list | `[]` | HPA Custom rules |
| autoscaling.hpa.enabled | bool | `false` | Enable HPA |
| autoscaling.hpa.maxReplicas | int | `3` | Maximum number of replicas |
| autoscaling.hpa.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.hpa.targetCPU | string | `""` | Target CPU utilization percentage |
| autoscaling.hpa.targetMemory | string | `""` | Target Memory utilization percentage |
| command | list | `[]` | Override default command (useful when using custom images) |
| commonAnnotations | object | `{}` | Annotations to add to all deployed objects |
| commonLabels | object | `{}` | Labels to add to all deployed objects |
| containerPorts.http | int | `5000` | dial-extension HTTP container port |
| containerPorts.metrics | int | `9464` | dial-extension HTTP container port for metrics |
| containerSecurityContext | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) | Container Security Context Configuration |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` | Set dial-extension container's Security Context allowPrivilegeEscalation |
| containerSecurityContext.capabilities | object | `{"drop":["ALL"]}` | Set dial-extension container's Security Context capabilities |
| containerSecurityContext.enabled | bool | `true` | Enabled dial-extension container's Security Context |
| containerSecurityContext.privileged | bool | `false` | Set dial-extension container's Security Context privileged |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` | Set dial-extension containers' Security Context runAsNonRoot |
| containerSecurityContext.runAsGroup | int | `1001` | Set dial-extension container's Security Context runAsGroup |
| containerSecurityContext.runAsNonRoot | bool | `true` | Set dial-extension containers' Security Context runAsNonRoot |
| containerSecurityContext.runAsUser | int | `1001` | Set dial-extension container's Security Context runAsUser |
| containerSecurityContext.seLinuxOptions | object | `{}` | Set dial-extension SELinux options in container |
| containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` | Set dial-extension container's Security Context seccomp profile |
| customLivenessProbe | object | `{}` | Custom livenessProbe that overrides the default one |
| customReadinessProbe | object | `{}` | Custom readinessProbe that overrides the default one |
| customStartupProbe | object | `{}` | Custom startupProbe that overrides the default one |
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (all probes will be disabled) |
| env | object | `{}` | Key-value pairs extra environment variables to add to dial-extension |
| extraContainerPorts | list | `[]` | Optionally specify extra list of additional ports for dial-extension containers |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release |
| extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for dial-extension containers |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the dial-extension container(s) |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the dial-extension pod(s) |
| fullnameOverride | string | `""` | String to fully override common.names.fullname |
| global.compatibility.openshift.adaptSecurityContext | string | `"disabled"` |  |
| global.imagePullSecrets | list | `[]` | Global Docker registry secret names as an array |
| global.imageRegistry | string | `""` | Global Docker image registry |
| global.storageClass | string | `""` | Global StorageClass for Persistent Volume(s) |
| hostAliases | list | `[]` | dial-extension pods host aliases [Documentation](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| hostNetwork | bool | `false` | Enable Host Network If hostNetwork true, then dnsPolicy is set to ClusterFirstWithHostNet |
| image | object | [Documentation](https://kubernetes.io/docs/concepts/containers/images/) | Section to configure the image. |
| image.digest | string | `""` | Image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended) |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) |
| image.registry | string | `"docker.io"` | Image registry |
| image.repository | string | `""` | Image repository e.g: epam/ai-dial-adapter-openai |
| image.tag | string | `"latest"` | Image tag (immutable tags are recommended) |
| ingress | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/) | Ingress configuration |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. Use this parameter to set the required annotations for [cert-manager](https://cert-manager.io/docs/usage/ingress/#supported-annotations) |
| ingress.enabled | bool | `false` | Enable ingress record generation for container |
| ingress.extraPaths | list | `[]` | An array with additional arbitrary paths that may need to be added to the ingress under the main host |
| ingress.extraRules | list | `[]` | An array with additional hostname(s) to be covered with the ingress record |
| ingress.hosts | list | `["dial-extension.local"]` | An array with hostname(s) to be covered with the ingress record |
| ingress.ingressClassName | string | `""` | IngressClass that will be be used to implement the Ingress [Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class) |
| ingress.path | string | `"/"` | Default path for the ingress record NOTE: You may need to set this to '/*' in order to use this with ALB ingress controllers |
| ingress.pathType | string | `"Prefix"` | Ingress path type |
| ingress.serviceName | string | `""` | Change default name of service for the ingress record |
| ingress.tls | list | `[]` | TLS configuration for additional hostname(s) to be covered with this ingress record (evaluated as a template) [Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) |
| initContainers | list | `[]` | Add additional init containers to the dial-extension pod(s) [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) |
| lifecycleHooks | object | `{}` | for the dial-extension container(s) to automate configuration before or after startup |
| livenessProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes) | Liveness Probes configuration |
| livenessProbe.enabled | bool | `false` | Enable/disable livenessProbe |
| metrics | object | [Documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/getting-started/design.md) | Configuration resources for prometheus metrics |
| metrics.enabled | bool | `false` | Enable the export of Prometheus metrics |
| metrics.prometheusRule.enabled | bool | `false` | Creates a Prometheus Operator prometheusRule |
| metrics.prometheusRule.labels | object | `{}` | Additional labels that can be used so prometheusRule will be discovered by Prometheus |
| metrics.prometheusRule.namespace | string | `""` | Namespace for the prometheusRule Resource (defaults to the Release Namespace) |
| metrics.prometheusRule.rules | list | `[]` | Prometheus Rule definitions |
| metrics.service | object | - | Dedicated Kubernetes Service for dial-extension metrics configuration |
| metrics.service.annotations | object | `{}` | Additional custom annotations for dial-extension metrics service |
| metrics.service.clusterIP | string | `""` | metrics service Cluster IP clusterIP: None |
| metrics.service.externalTrafficPolicy | string | `"Cluster"` | dial-extension metrics service external traffic policy [Documentation](http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) |
| metrics.service.extraPorts | list | `[]` | Extra ports to expose in dial-extension metrics service (normally used with the `sidecars` value) |
| metrics.service.loadBalancerIP | string | `""` | dial-extension metrics service Load Balancer IP |
| metrics.service.loadBalancerSourceRanges | list | `[]` | dial-extension metrics service Load Balancer sources |
| metrics.service.nodePorts.http | string | `""` | Node port for metrics NOTE: choose port between <30000-32767> |
| metrics.service.ports | object | `{"http":9464}` | dial-extension metrics service port |
| metrics.service.ports.http | int | `9464` | dial-extension metrics service port |
| metrics.service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None |
| metrics.service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| metrics.service.type | string | `"ClusterIP"` | dial-extension metrics service type |
| metrics.serviceMonitor | object | [Documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/getting-started/design.md#servicemonitor) | Prometheus Operator ServiceMonitor configuration |
| metrics.serviceMonitor.annotations | object | `{}` | Additional custom annotations for the ServiceMonitor |
| metrics.serviceMonitor.enabled | bool | `false` | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`) |
| metrics.serviceMonitor.honorLabels | bool | `false` | honorLabels chooses the metric's labels on collisions with target labels |
| metrics.serviceMonitor.interval | string | `""` | Interval at which metrics should be scraped. e.g: interval: 10s |
| metrics.serviceMonitor.jobLabel | string | `""` | The name of the label on the target service to use as the job name in Prometheus |
| metrics.serviceMonitor.labels | object | `{}` | Extra labels for the ServiceMonitor |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Specify additional relabeling of metrics |
| metrics.serviceMonitor.namespace | string | `""` | Namespace in which Prometheus is running |
| metrics.serviceMonitor.path | string | `"/metrics"` | Specify metrics path |
| metrics.serviceMonitor.port | string | `"http-metrics"` | Specify service metrics port |
| metrics.serviceMonitor.relabelings | list | `[]` | Specify general relabeling |
| metrics.serviceMonitor.scrapeTimeout | string | `""` | Timeout after which the scrape is ended e.g: scrapeTimeout: 10s |
| metrics.serviceMonitor.selector | object | `{}` | Prometheus instance selector labels |
| nameOverride | string | `""` | String to partially override common.names.name |
| namespaceOverride | string | `""` | String to fully override common.names.namespace |
| networkPolicy | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/) | Network Policy configuration |
| networkPolicy.allowExternal | bool | `true` | When true, server will accept connections from any source |
| networkPolicy.allowExternalEgress | bool | `true` | Allow the pod to access any range of port and all destinations. |
| networkPolicy.enabled | bool | `true` | Specifies whether a NetworkPolicy should be created |
| networkPolicy.extraEgress | list | `[]` | Add extra ingress rules to the NetworkPolicy |
| networkPolicy.extraIngress | list | `[]` | Add extra ingress rules to the NetworkPolicy |
| networkPolicy.ingressNSMatchLabels | object | `{}` | Labels to match to allow traffic from other namespaces |
| networkPolicy.ingressNSPodMatchLabels | object | `{}` | Pod labels to match to allow traffic from other namespaces |
| networkPolicy.ingressPodMatchLabels | object | `{}` | Labels to match to allow traffic from other pods. Ignored if `networkPolicy.allowExternal` is true. |
| networkPolicy.metrics.allowExternal | bool | `true` | When true, server will accept connections to the metrics port from any source |
| networkPolicy.metrics.ingressNSMatchLabels | object | `{}` | Labels to match to allow traffic from other namespaces to metrics endpoint |
| networkPolicy.metrics.ingressNSPodMatchLabels | object | `{}` | Pod labels to match to allow traffic from other namespaces to metrics endpoint |
| nodeSelector | object | `{}` | Node labels for dial-extension pods assignment. [Documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| pdb | object | [Documentation](https://kubernetes.io/docs/tasks/run-application/configure-pdb) | Pod Disruption Budget configuration |
| pdb.create | bool | `false` | Enable/disable a Pod Disruption Budget creation |
| pdb.maxUnavailable | string | `""` | Max number of pods that can be unavailable after the eviction. You can specify an integer or a percentage by setting the value to a string representation of a percentage (eg. "50%"). It will be disabled if set to 0. Defaults to `1` if both `pdb.minAvailable` and `pdb.maxUnavailable` are empty. |
| pdb.minAvailable | string | `""` | Min number of pods that must still be available after the eviction. You can specify an integer or a percentage by setting the value to a string representation of a percentage (eg. "50%"). It will be disabled if set to 0 |
| podAnnotations | object | `{}` | Annotations for dial-extension pods [Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) |
| podLabels | object | `{}` | Extra labels for dial-extension pods [Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) |
| podSecurityContext | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) | Pods Security Context Configuration |
| podSecurityContext.enabled | bool | `true` | Enabled dial-extension pod's Security Context |
| podSecurityContext.fsGroup | int | `1001` | Set dial-extension pod's Security Context fsGroup |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` | Set filesystem group change policy |
| podSecurityContext.supplementalGroups | list | `[]` | Set filesystem extra groups |
| podSecurityContext.sysctls | list | `[]` | Set kernel settings using the sysctl interface |
| priorityClassName | string | `""` | dial-extension pods' priorityClassName |
| readinessProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes) | Readiness Probes configuration |
| readinessProbe.enabled | bool | `false` | Enable/disable readinessProbe |
| replicaCount | int | `1` | Number of dial-extension replicas to deploy |
| resources | object | `{}` | Container resource requests and limits [Documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| schedulerName | string | `""` | Name of the k8s scheduler (other than default) for dial-extension pods [Documentation](https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/) |
| secrets | object | `{}` | Key-value pairs extra environment variables to add in environment variables from secrets to dial-extension |
| service | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/service/) | Service configuration |
| service.annotations | object | `{}` | Additional custom annotations for dial-extension service |
| service.clusterIP | string | `""` | dial-extension service Cluster IP clusterIP: None |
| service.externalTrafficPolicy | string | `"Cluster"` | dial-extension service external traffic policy [Documentation](http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) |
| service.extraPorts | list | `[]` | Extra ports to expose in dial-extension service (normally used with the `sidecars` value) |
| service.loadBalancerIP | string | `""` | dial-extension service Load Balancer IP. [Documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer) |
| service.loadBalancerSourceRanges | list | `[]` | dial-extension service Load Balancer sources |
| service.nodePorts | object | `{"http":""}` | Node ports to expose NOTE: choose port between <30000-32767> |
| service.nodePorts.http | string | `""` | Node port for HTTP |
| service.ports.http | int | `80` | dial-extension service HTTP port |
| service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None |
| service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| service.type | string | `"ClusterIP"` | dial-extension service type |
| serviceAccount | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) | ServiceAccount configuration |
| serviceAccount.annotations | object | `{}` | Additional Service Account annotations (evaluated as a template) |
| serviceAccount.automountServiceAccountToken | bool | `false` | Automount service account token for the server service account |
| serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| sidecars | list | `[]` | Add additional sidecar containers to the dial-extension pod(s) |
| startupProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) | Startup Probes configuration |
| startupProbe.enabled | bool | `false` | Enable/disable startupProbe |
| terminationGracePeriodSeconds | string | `""` | Seconds dial-extension pod needs to terminate gracefully [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods) |
| tolerations | list | `[]` | Tolerations for dial-extension pods assignment. [Documentation](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) |
| topologySpreadConstraints | list | `[]` | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods) |
| updateStrategy | object | [Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies) | Deployment strategy type |
| updateStrategy.type | string | `"RollingUpdate"` | StrategyType Can be set to RollingUpdate or OnDelete |

## Upgrading

### To 2.0.0

> [!IMPORTANT]
> Duplicate values for **labels** and **annotations** have been removed.

- Move the values from the **labels** section to the **commonLabels** section during the update.
- Move the values from the **annotations** section to the **commonAnnotations** section during the update.

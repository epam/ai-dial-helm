# dial-admin

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 0.12.0](https://img.shields.io/badge/AppVersion-0.12.0-informational?style=flat-square)

Helm chart for DIAL Admin

## Prerequisites

- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (optional)
- Ingress controller support in the underlying infrastructure (optional)

## Requirements

Kubernetes: `>=1.25.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.epam-rail.com | frontend(dial-extension) | 1.3.3 |
| oci://registry-1.docker.io/bitnamicharts | common | 2.31.1 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 16.7.12 |

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add dial https://charts.epam-rail.com
helm install my-release dial/dial-admin
```

The command deploys dial-admin on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

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
helm install my-release dial/dial-admin --set backend.image.tag=latest
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example:

```yaml
# values.yaml file content
backend:
  image:
    tag: latest
```

```console
helm install my-release dial/dial-admin -f values.yaml
```

**NOTE**: You can use the default [values.yaml](values.yaml)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backend.affinity | object | `{}` | Affinity for dial-admin backend pods assignment |
| backend.args | list | `[]` | Override default dial-admin backend args (useful when using custom images) |
| backend.automountServiceAccountToken | bool | `false` | Mount Service Account token in pods |
| backend.autoscaling.hpa | object | [Documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) | Horizontal Pod Autoscaler (HPA) settings |
| backend.autoscaling.hpa.annotations | object | `{}` | Annotations for HPA resource |
| backend.autoscaling.hpa.behavior | object | `{}` | HPA Behavior |
| backend.autoscaling.hpa.customRules | list | `[]` | HPA Custom rules |
| backend.autoscaling.hpa.enabled | bool | `false` | Enable HPA |
| backend.autoscaling.hpa.maxReplicas | int | `3` | Maximum number of replicas |
| backend.autoscaling.hpa.minReplicas | int | `1` | Minimum number of replicas |
| backend.autoscaling.hpa.targetCPU | string | `""` | Target CPU utilization percentage |
| backend.autoscaling.hpa.targetMemory | string | `""` | Target Memory utilization percentage |
| backend.command | list | `[]` | Override default dial-admin backend command (useful when using custom images) |
| backend.configuration.datasourceVendor | string | `"postgresql"` | Database vendor for the datasource. Possible values: postgresql, mssql, h2 |
| backend.configuration.export.create | bool | `true` | Whether to grant permissions to create the export resource |
| backend.configuration.export.key | string | `""` | Key for export resources |
| backend.configuration.export.names | list | `[]` | List of export resource names |
| backend.configuration.export.namespace | string | `""` | Namespace for export resource |
| backend.configuration.export.type | string | `"secret"` | Type of export resource Possible values: secret or configmap |
| backend.containerPorts.http | int | `8080` | dial-admin backend HTTP container port |
| backend.containerPorts.metrics | int | `9464` | dial-admin backend HTTP container port for metrics |
| backend.containerSecurityContext | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) | Container Security Context Configuration |
| backend.containerSecurityContext.allowPrivilegeEscalation | bool | `false` | Set dial-admin backend container's Security Context allowPrivilegeEscalation |
| backend.containerSecurityContext.capabilities | object | `{"drop":["ALL"]}` | Set dial-admin backend container's Security Context capabilities |
| backend.containerSecurityContext.enabled | bool | `true` | Enabled dial-admin backend container's Security Context |
| backend.containerSecurityContext.privileged | bool | `false` | Set dial-admin backend container's Security Context privileged |
| backend.containerSecurityContext.readOnlyRootFilesystem | bool | `true` | Set dial-admin backend containers' Security Context runAsNonRoot |
| backend.containerSecurityContext.runAsGroup | int | `1001` | Set dial-admin backend container's Security Context runAsGroup |
| backend.containerSecurityContext.runAsNonRoot | bool | `true` | Set dial-admin backend containers' Security Context runAsNonRoot |
| backend.containerSecurityContext.runAsUser | int | `1001` | Set dial-admin backend container's Security Context runAsUser |
| backend.containerSecurityContext.seLinuxOptions | object | `{}` | Set dial-admin backend SELinux options in container |
| backend.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` | Set dial-admin backend container's Security Context seccomp profile type |
| backend.customLivenessProbe | object | `{}` | Custom livenessProbe that overrides the default one |
| backend.customReadinessProbe | object | `{}` | Custom readinessProbe that overrides the default one |
| backend.customStartupProbe | object | `{}` | Custom startupProbe that overrides the default one |
| backend.diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (all probes will be disabled) |
| backend.enableServiceLinks | bool | `true` | If set to false, disable Kubernetes service links in the pod spec [Documentation](https://kubernetes.io/docs/tutorials/services/connect-applications-service/#accessing-the-service) |
| backend.enabled | bool | `true` | Enable dial-admin backend deployment |
| backend.env | object | `{}` | Key-value pairs extra environment variables to add |
| backend.extraEnvVars | list | `[]` | Array containing extra env vars to configure the credential |
| backend.extraEnvVarsCM | string | `""` | ConfigMap containing extra env vars to configure the credential |
| backend.extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for dial-admin backend containers |
| backend.extraVolumeClaimTemplates | list | `[]` | Optionally specify extra list of additional volumeClaimTemplates for the dial-admin backend container(s) |
| backend.extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the dial-admin backend container(s) |
| backend.extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the dial-admin backend pod(s) |
| backend.hostAliases | list | `[]` | dial-admin backend pods host aliases [Documentation](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| backend.hostNetwork | bool | `false` | Enable Host Network If hostNetwork true, then dnsPolicy is set to ClusterFirstWithHostNet |
| backend.image | object | [Documentation](https://kubernetes.io/docs/concepts/containers/images/) | Section to configure the image. |
| backend.image.digest | string | `""` | Image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended) |
| backend.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| backend.image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) |
| backend.image.registry | string | `"docker.io"` | Image registry |
| backend.image.repository | string | `"epam/ai-dial-admin-backend"` | Image repository |
| backend.image.tag | string | `"0.12.0"` | Image tag (immutable tags are recommended) |
| backend.initContainers | list | `[]` | Add additional init containers to the dial-admin backend pod(s) [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) |
| backend.lifecycleHooks | object | `{}` | for the dial-admin backend container(s) to automate configuration before or after startup |
| backend.livenessProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes) | Liveness Probes configuration |
| backend.livenessProbe.enabled | bool | `true` | Enable/disable livenessProbe |
| backend.metrics | object | [Documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/getting-started/design.md) | Configuration resources for prometheus metrics |
| backend.metrics.enabled | bool | `false` | Enable the export of Prometheus metrics |
| backend.metrics.prometheusRule.enabled | bool | `false` | Creates a Prometheus Operator prometheusRule |
| backend.metrics.prometheusRule.labels | object | `{}` | Additional labels that can be used so prometheusRule will be discovered by Prometheus |
| backend.metrics.prometheusRule.namespace | string | `""` | Namespace for the prometheusRule Resource (defaults to the Release Namespace) |
| backend.metrics.prometheusRule.rules | list | `[]` | Prometheus Rule definitions |
| backend.metrics.service | object | - | Dedicated Kubernetes Service for dial-admin backend metrics configuration |
| backend.metrics.service.annotations | object | `{}` | Additional custom annotations for dial-admin backend metrics service |
| backend.metrics.service.clusterIP | string | `""` | dial-admin backend metrics service Cluster IP |
| backend.metrics.service.externalTrafficPolicy | string | `"Cluster"` | dial-admin backend metrics service external traffic policy [Documentation](http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) |
| backend.metrics.service.extraPorts | list | `[]` | Extra ports to expose in dial-admin backend metrics service (normally used with the `sidecars` value) |
| backend.metrics.service.loadBalancerIP | string | `""` | dial-admin backend metrics service Load Balancer IP |
| backend.metrics.service.loadBalancerSourceRanges | list | `[]` | dial-admin backend metrics service Load Balancer sources |
| backend.metrics.service.nodePorts.http | string | `""` | Node port for metrics NOTE: choose port between <30000-32767> |
| backend.metrics.service.ports.http | int | `9464` | dial-admin backend metrics service port |
| backend.metrics.service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None |
| backend.metrics.service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| backend.metrics.service.type | string | `"ClusterIP"` | dial-admin backend metrics service type |
| backend.metrics.serviceMonitor | object | [Documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/getting-started/design.md#servicemonitor) | Prometheus Operator ServiceMonitor configuration |
| backend.metrics.serviceMonitor.annotations | object | `{}` | Additional custom annotations for the ServiceMonitor |
| backend.metrics.serviceMonitor.enabled | bool | `false` | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`) |
| backend.metrics.serviceMonitor.honorLabels | bool | `false` | honorLabels chooses the metric's labels on collisions with target labels |
| backend.metrics.serviceMonitor.interval | string | `""` | Interval at which metrics should be scraped. |
| backend.metrics.serviceMonitor.jobLabel | string | `""` | The name of the label on the target service to use as the job name in Prometheus |
| backend.metrics.serviceMonitor.labels | object | `{}` | Extra labels for the ServiceMonitor |
| backend.metrics.serviceMonitor.metricRelabelings | list | `[]` | Specify additional relabeling of metrics |
| backend.metrics.serviceMonitor.namespace | string | `""` | Namespace in which Prometheus is running |
| backend.metrics.serviceMonitor.path | string | `"/metrics"` | Specify metrics path |
| backend.metrics.serviceMonitor.port | string | `"http-metrics"` | Specify service metrics port |
| backend.metrics.serviceMonitor.relabelings | list | `[]` | Specify general relabeling |
| backend.metrics.serviceMonitor.scrapeTimeout | string | `""` | Timeout after which the scrape is ended |
| backend.metrics.serviceMonitor.selector | object | `{}` | Prometheus instance selector labels |
| backend.networkPolicy | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/) | Section to configure Network Policy parameters |
| backend.networkPolicy.allowExternal | bool | `true` | Don't require client label for connections |
| backend.networkPolicy.allowExternalEgress | bool | `true` | Allow the pod to access any range of port and all destinations. |
| backend.networkPolicy.enabled | bool | `true` | Enable creation of NetworkPolicy resources |
| backend.networkPolicy.extraEgress | list | `[]` | Add extra ingress rules to the NetworkPolicy |
| backend.networkPolicy.extraIngress | list | `[]` | Add extra ingress rules to the NetworkPolicy |
| backend.networkPolicy.ingressNSMatchLabels | object | `{}` | Labels to match to allow traffic from other namespaces |
| backend.networkPolicy.ingressNSPodMatchLabels | object | `{}` | Pod labels to match to allow traffic from other namespaces |
| backend.nodeSelector | object | `{}` | Node labels for dial-admin backend pods assignment. [Documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| backend.pdb | object | [Documentation](https://kubernetes.io/docs/tasks/run-application/configure-pdb) | Pod Disruption Budget configuration |
| backend.pdb.create | bool | `false` | Enable/disable a Pod Disruption Budget creation |
| backend.pdb.maxUnavailable | string | `""` | Max number of pods that can be unavailable after the eviction. You can specify an integer or a percentage by setting the value to a string representation of a percentage (eg. "50%"). It will be disabled if set to 0. Defaults to `1` if both `pdb.minAvailable` and `pdb.maxUnavailable` are empty. |
| backend.pdb.minAvailable | string | `""` | Min number of pods that must still be available after the eviction. You can specify an integer or a percentage by setting the value to a string representation of a percentage (eg. "50%"). It will be disabled if set to 0 |
| backend.persistence | object | [Documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) | Section to configure persistence |
| backend.persistence.accessModes | list | `["ReadWriteOnce"]` | Persistent Volume Access Modes |
| backend.persistence.annotations | object | `{}` | Persistent Volume Claim annotations |
| backend.persistence.dataSource | object | `{}` | Custom PVC data source |
| backend.persistence.enabled | bool | `false` | Enable persistence using Persistent Volume Claims |
| backend.persistence.existingClaim | string | `""` | The name of an existing PVC to use for persistence |
| backend.persistence.mountPath | string | `"/data"` | Path to mount the volume at. |
| backend.persistence.selector | object | `{}` | Selector to match an existing Persistent Volume for dial-admin data PVC # If set, the PVC can't have a PV dynamically provisioned for it |
| backend.persistence.size | string | `"8Gi"` | Size of data volume |
| backend.persistence.storageClass | string | `""` | Storage class of backing PVC |
| backend.persistence.subPath | string | `""` | The subdirectory of the volume to mount to, useful in dev environments and one PV for multiple services |
| backend.podAnnotations | object | `{}` | Annotations for dial-admin backend pods [Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) |
| backend.podLabels | object | `{}` | Extra labels for dial-admin backend pods [Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) |
| backend.podSecurityContext | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) | Pods Security Context Configuration |
| backend.podSecurityContext.enabled | bool | `true` | Enabled dial-admin backend pod's Security Context |
| backend.podSecurityContext.fsGroup | int | `1001` | Set dial-admin backend pod's Security Context fsGroup |
| backend.podSecurityContext.fsGroupChangePolicy | string | `"Always"` | Set filesystem group change policy |
| backend.podSecurityContext.supplementalGroups | list | `[]` | Set filesystem extra groups |
| backend.podSecurityContext.sysctls | list | `[]` | Set kernel settings using the sysctl interface |
| backend.priorityClassName | string | `""` | dial-admin backend pods' priorityClassName |
| backend.rbac.create | bool | `true` | Binding dial-admin backend ServiceAccount to a role that allows dial-admin backend pods querying the K8s API |
| backend.readinessProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes) | Readiness Probes configuration |
| backend.replicaCount | int | `1` | Number of dial-admin backend replicas to deploy |
| backend.resources | object | `{}` | Container resource requests and limits [Documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| backend.schedulerName | string | `""` | Name of the k8s scheduler (other than default) for dial-admin backend pods [Documentation](https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/) |
| backend.secrets | object | `{}` | Key-value pairs extra environment variables to add in environment variables from secrets to dial-admin backend |
| backend.service | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/service/) | Service configuration |
| backend.service.annotations | object | `{}` | Additional custom annotations for dial-admin backend service |
| backend.service.clusterIP | string | `""` | dial-admin backend service Cluster IP |
| backend.service.externalTrafficPolicy | string | `"Cluster"` | dial-admin backend service external traffic policy [Documentation](http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) |
| backend.service.extraPorts | list | `[]` | Extra ports to expose in dial-admin backend service (normally used with the `sidecars` value) |
| backend.service.loadBalancerIP | string | `""` | dial-admin backend service Load Balancer IP. [Documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer) |
| backend.service.loadBalancerSourceRanges | list | `[]` | dial-admin backend service Load Balancer sources |
| backend.service.nodePorts | object | `{"http":""}` | Node ports to expose NOTE: choose port between <30000-32767> |
| backend.service.nodePorts.http | string | `""` | Node port for HTTP |
| backend.service.ports.http | int | `80` | dial-admin backend service HTTP port |
| backend.service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None |
| backend.service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| backend.service.type | string | `"ClusterIP"` | dial-admin backend service type |
| backend.serviceAccount | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) | ServiceAccount configuration |
| backend.serviceAccount.annotations | object | `{}` | Additional Service Account annotations (evaluated as a template) |
| backend.serviceAccount.automountServiceAccountToken | bool | `false` | Automount service account token for the server service account |
| backend.serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| backend.serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| backend.sidecars | list | `[]` | Add additional sidecar containers to the dial-admin backend pod(s) |
| backend.startupProbe.enabled | bool | `false` | Enable/disable startupProbe |
| backend.startupProbe.failureThreshold | int | `6` |  |
| backend.startupProbe.httpGet.path | string | `"/api/v1/health"` |  |
| backend.startupProbe.httpGet.port | string | `"http"` |  |
| backend.startupProbe.initialDelaySeconds | int | `10` |  |
| backend.startupProbe.periodSeconds | int | `10` |  |
| backend.startupProbe.successThreshold | int | `1` |  |
| backend.startupProbe.timeoutSeconds | int | `3` |  |
| backend.terminationGracePeriodSeconds | string | `""` | Seconds dial-admin backend pod needs to terminate gracefully [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods) |
| backend.tolerations | list | `[]` | Tolerations for dial-admin backend pods assignment. [Documentation](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) |
| backend.topologySpreadConstraints | list | `[]` | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods) |
| backend.updateStrategy | object | [Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) | Deployment strategy type |
| backend.updateStrategy.type | string | `"RollingUpdate"` | StrategyType Can be set to RollingUpdate or OnDelete |
| commonAnnotations | object | `{}` | Annotations to add to all deployed objects |
| commonLabels | object | `{}` | Labels to add to all deployed objects |
| deployment_manager.affinity | object | `{}` | Affinity for dial-admin deployment_manager pods assignment |
| deployment_manager.args | list | `[]` | Override default dial-admin deployment_manager args (useful when using custom images) |
| deployment_manager.automountServiceAccountToken | bool | `false` | Mount Service Account token in pods |
| deployment_manager.autoscaling.hpa | object | [Documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) | Horizontal Pod Autoscaler (HPA) settings |
| deployment_manager.autoscaling.hpa.annotations | object | `{}` | Annotations for HPA resource |
| deployment_manager.autoscaling.hpa.behavior | object | `{}` | HPA Behavior |
| deployment_manager.autoscaling.hpa.customRules | list | `[]` | HPA Custom rules |
| deployment_manager.autoscaling.hpa.enabled | bool | `false` | Enable HPA |
| deployment_manager.autoscaling.hpa.maxReplicas | int | `3` | Maximum number of replicas |
| deployment_manager.autoscaling.hpa.minReplicas | int | `1` | Minimum number of replicas |
| deployment_manager.autoscaling.hpa.targetCPU | string | `""` | Target CPU utilization percentage |
| deployment_manager.autoscaling.hpa.targetMemory | string | `""` | Target Memory utilization percentage |
| deployment_manager.command | list | `[]` | Override default dial-admin deployment_manager command (useful when using custom images) |
| deployment_manager.configuration.build | object | `{"namespace":""}` | Build images for mcp containers specific variables |
| deployment_manager.configuration.datasource | object | `{"database":"deployment_manager","datasourceVendor":"postgresql","password":"","user":"deployment_manager"}` | Database specific variables |
| deployment_manager.configuration.datasource.datasourceVendor | string | `"postgresql"` | Database vendor for the datasource. Possible values: postgresql, mssql, h2 |
| deployment_manager.configuration.deploy | object | `{"knative":{"enabled":true,"namespace":""},"kserve":{"enabled":false,"namespace":""},"nim":{"enabled":false,"namespace":""}}` | Deploy mcp containers specific variables |
| deployment_manager.containerPorts.http | int | `8080` | dial-admin deployment_manager HTTP container port |
| deployment_manager.containerPorts.metrics | int | `9464` | dial-admin deployment_manager HTTP container port for metrics |
| deployment_manager.containerSecurityContext | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) | Container Security Context Configuration |
| deployment_manager.containerSecurityContext.allowPrivilegeEscalation | bool | `false` | Set dial-admin deployment_manager container's Security Context allowPrivilegeEscalation |
| deployment_manager.containerSecurityContext.capabilities | object | `{"drop":["ALL"]}` | Set dial-admin deployment_manager container's Security Context capabilities |
| deployment_manager.containerSecurityContext.enabled | bool | `true` | Enabled dial-admin deployment_manager container's Security Context |
| deployment_manager.containerSecurityContext.privileged | bool | `false` | Set dial-admin deployment_manager container's Security Context privileged |
| deployment_manager.containerSecurityContext.readOnlyRootFilesystem | bool | `true` | Set dial-admin deployment_manager containers' Security Context runAsNonRoot |
| deployment_manager.containerSecurityContext.runAsGroup | int | `1001` | Set dial-admin deployment_manager container's Security Context runAsGroup |
| deployment_manager.containerSecurityContext.runAsNonRoot | bool | `true` | Set dial-admin deployment_manager containers' Security Context runAsNonRoot |
| deployment_manager.containerSecurityContext.runAsUser | int | `1001` | Set dial-admin deployment_manager container's Security Context runAsUser |
| deployment_manager.containerSecurityContext.seLinuxOptions | object | `{}` | Set dial-admin deployment_manager SELinux options in container |
| deployment_manager.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` | Set dial-admin deployment_manager container's Security Context seccomp profile type |
| deployment_manager.customLivenessProbe | object | `{}` | Custom livenessProbe that overrides the default one |
| deployment_manager.customReadinessProbe | object | `{}` | Custom readinessProbe that overrides the default one |
| deployment_manager.customStartupProbe | object | `{}` | Custom startupProbe that overrides the default one |
| deployment_manager.diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (all probes will be disabled) |
| deployment_manager.enableServiceLinks | bool | `true` | If set to false, disable Kubernetes service links in the pod spec [Documentation](https://kubernetes.io/docs/tutorials/services/connect-applications-service/#accessing-the-service) |
| deployment_manager.enabled | bool | `false` | Enable dial-admin deployment_manager deployment |
| deployment_manager.env | object | `{}` | Key-value pairs extra environment variables to add |
| deployment_manager.extraEnvVars | list | `[]` | Array containing extra env vars to configure the credential |
| deployment_manager.extraEnvVarsCM | string | `""` | ConfigMap containing extra env vars to configure the credential |
| deployment_manager.extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for dial-admin deployment_manager containers |
| deployment_manager.extraVolumeClaimTemplates | list | `[]` | Optionally specify extra list of additional volumeClaimTemplates for the dial-admin deployment_manager container(s) |
| deployment_manager.extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the dial-admin deployment_manager container(s) |
| deployment_manager.extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the dial-admin deployment_manager pod(s) |
| deployment_manager.hostAliases | list | `[]` | dial-admin deployment_manager pods host aliases [Documentation](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| deployment_manager.hostNetwork | bool | `false` | Enable Host Network If hostNetwork true, then dnsPolicy is set to ClusterFirstWithHostNet |
| deployment_manager.image | object | [Documentation](https://kubernetes.io/docs/concepts/containers/images/) | Section to configure the image. |
| deployment_manager.image.digest | string | `""` | Image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended) |
| deployment_manager.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| deployment_manager.image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) |
| deployment_manager.image.registry | string | `"docker.io"` | Image registry |
| deployment_manager.image.repository | string | `"epam/ai-dial-admin-deployment_manager-backend"` | Image repository |
| deployment_manager.image.tag | string | `"0.12.0"` | Image tag (immutable tags are recommended) |
| deployment_manager.initContainers | list | `[]` | Add additional init containers to the dial-admin deployment_manager pod(s) [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) |
| deployment_manager.lifecycleHooks | object | `{}` | for the dial-admin deployment_manager container(s) to automate configuration before or after startup |
| deployment_manager.livenessProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes) | Liveness Probes configuration |
| deployment_manager.livenessProbe.enabled | bool | `true` | Enable/disable livenessProbe |
| deployment_manager.metrics | object | [Documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/getting-started/design.md) | Configuration resources for prometheus metrics |
| deployment_manager.metrics.enabled | bool | `false` | Enable the export of Prometheus metrics |
| deployment_manager.metrics.prometheusRule.enabled | bool | `false` | Creates a Prometheus Operator prometheusRule |
| deployment_manager.metrics.prometheusRule.labels | object | `{}` | Additional labels that can be used so prometheusRule will be discovered by Prometheus |
| deployment_manager.metrics.prometheusRule.namespace | string | `""` | Namespace for the prometheusRule Resource (defaults to the Release Namespace) |
| deployment_manager.metrics.prometheusRule.rules | list | `[]` | Prometheus Rule definitions |
| deployment_manager.metrics.service | object | - | Dedicated Kubernetes Service for dial-admin deployment_manager metrics configuration |
| deployment_manager.metrics.service.annotations | object | `{}` | Additional custom annotations for dial-admin deployment_manager metrics service |
| deployment_manager.metrics.service.clusterIP | string | `""` | dial-admin deployment_manager metrics service Cluster IP |
| deployment_manager.metrics.service.externalTrafficPolicy | string | `"Cluster"` | dial-admin deployment_manager metrics service external traffic policy [Documentation](http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) |
| deployment_manager.metrics.service.extraPorts | list | `[]` | Extra ports to expose in dial-admin deployment_manager metrics service (normally used with the `sidecars` value) |
| deployment_manager.metrics.service.loadBalancerIP | string | `""` | dial-admin deployment_manager metrics service Load Balancer IP |
| deployment_manager.metrics.service.loadBalancerSourceRanges | list | `[]` | dial-admin deployment_manager metrics service Load Balancer sources |
| deployment_manager.metrics.service.nodePorts.http | string | `""` | Node port for metrics NOTE: choose port between <30000-32767> |
| deployment_manager.metrics.service.ports.http | int | `9464` | dial-admin deployment_manager metrics service port |
| deployment_manager.metrics.service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None |
| deployment_manager.metrics.service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| deployment_manager.metrics.service.type | string | `"ClusterIP"` | dial-admin deployment_manager metrics service type |
| deployment_manager.metrics.serviceMonitor | object | [Documentation](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/getting-started/design.md#servicemonitor) | Prometheus Operator ServiceMonitor configuration |
| deployment_manager.metrics.serviceMonitor.annotations | object | `{}` | Additional custom annotations for the ServiceMonitor |
| deployment_manager.metrics.serviceMonitor.enabled | bool | `false` | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`) |
| deployment_manager.metrics.serviceMonitor.honorLabels | bool | `false` | honorLabels chooses the metric's labels on collisions with target labels |
| deployment_manager.metrics.serviceMonitor.interval | string | `""` | Interval at which metrics should be scraped. |
| deployment_manager.metrics.serviceMonitor.jobLabel | string | `""` | The name of the label on the target service to use as the job name in Prometheus |
| deployment_manager.metrics.serviceMonitor.labels | object | `{}` | Extra labels for the ServiceMonitor |
| deployment_manager.metrics.serviceMonitor.metricRelabelings | list | `[]` | Specify additional relabeling of metrics |
| deployment_manager.metrics.serviceMonitor.namespace | string | `""` | Namespace in which Prometheus is running |
| deployment_manager.metrics.serviceMonitor.path | string | `"/metrics"` | Specify metrics path |
| deployment_manager.metrics.serviceMonitor.port | string | `"http-metrics"` | Specify service metrics port |
| deployment_manager.metrics.serviceMonitor.relabelings | list | `[]` | Specify general relabeling |
| deployment_manager.metrics.serviceMonitor.scrapeTimeout | string | `""` | Timeout after which the scrape is ended |
| deployment_manager.metrics.serviceMonitor.selector | object | `{}` | Prometheus instance selector labels |
| deployment_manager.networkPolicy | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/) | Section to configure Network Policy parameters |
| deployment_manager.networkPolicy.allowExternal | bool | `true` | Don't require client label for connections |
| deployment_manager.networkPolicy.allowExternalEgress | bool | `true` | Allow the pod to access any range of port and all destinations. |
| deployment_manager.networkPolicy.enabled | bool | `true` | Enable creation of NetworkPolicy resources |
| deployment_manager.networkPolicy.extraEgress | list | `[]` | Add extra ingress rules to the NetworkPolicy |
| deployment_manager.networkPolicy.extraIngress | list | `[]` | Add extra ingress rules to the NetworkPolicy |
| deployment_manager.networkPolicy.ingressNSMatchLabels | object | `{}` | Labels to match to allow traffic from other namespaces |
| deployment_manager.networkPolicy.ingressNSPodMatchLabels | object | `{}` | Pod labels to match to allow traffic from other namespaces |
| deployment_manager.nodeSelector | object | `{}` | Node labels for dial-admin deployment_manager pods assignment. [Documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| deployment_manager.pdb | object | [Documentation](https://kubernetes.io/docs/tasks/run-application/configure-pdb) | Pod Disruption Budget configuration |
| deployment_manager.pdb.create | bool | `false` | Enable/disable a Pod Disruption Budget creation |
| deployment_manager.pdb.maxUnavailable | string | `""` | Max number of pods that can be unavailable after the eviction. You can specify an integer or a percentage by setting the value to a string representation of a percentage (eg. "50%"). It will be disabled if set to 0. Defaults to `1` if both `pdb.minAvailable` and `pdb.maxUnavailable` are empty. |
| deployment_manager.pdb.minAvailable | string | `""` | Min number of pods that must still be available after the eviction. You can specify an integer or a percentage by setting the value to a string representation of a percentage (eg. "50%"). It will be disabled if set to 0 |
| deployment_manager.persistence | object | [Documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) | Section to configure persistence |
| deployment_manager.persistence.accessModes | list | `["ReadWriteOnce"]` | Persistent Volume Access Modes |
| deployment_manager.persistence.annotations | object | `{}` | Persistent Volume Claim annotations |
| deployment_manager.persistence.dataSource | object | `{}` | Custom PVC data source |
| deployment_manager.persistence.enabled | bool | `false` | Enable persistence using Persistent Volume Claims |
| deployment_manager.persistence.existingClaim | string | `""` | The name of an existing PVC to use for persistence |
| deployment_manager.persistence.mountPath | string | `"/data"` | Path to mount the volume at. |
| deployment_manager.persistence.selector | object | `{}` | Selector to match an existing Persistent Volume for dial-admin data PVC # If set, the PVC can't have a PV dynamically provisioned for it |
| deployment_manager.persistence.size | string | `"8Gi"` | Size of data volume |
| deployment_manager.persistence.storageClass | string | `""` | Storage class of backing PVC |
| deployment_manager.persistence.subPath | string | `""` | The subdirectory of the volume to mount to, useful in dev environments and one PV for multiple services |
| deployment_manager.podAnnotations | object | `{}` | Annotations for dial-admin deployment_manager pods [Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/) |
| deployment_manager.podLabels | object | `{}` | Extra labels for dial-admin deployment_manager pods [Documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) |
| deployment_manager.podSecurityContext | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) | Pods Security Context Configuration |
| deployment_manager.podSecurityContext.enabled | bool | `true` | Enabled dial-admin deployment_manager pod's Security Context |
| deployment_manager.podSecurityContext.fsGroup | int | `1001` | Set dial-admin deployment_manager pod's Security Context fsGroup |
| deployment_manager.podSecurityContext.fsGroupChangePolicy | string | `"Always"` | Set filesystem group change policy |
| deployment_manager.podSecurityContext.supplementalGroups | list | `[]` | Set filesystem extra groups |
| deployment_manager.podSecurityContext.sysctls | list | `[]` | Set kernel settings using the sysctl interface |
| deployment_manager.priorityClassName | string | `""` | dial-admin deployment_manager pods' priorityClassName |
| deployment_manager.rbac.create | bool | `true` | Binding dial-admin deployment_manager ServiceAccount to a role that allows dial-admin deployment_manager pods querying the K8s API |
| deployment_manager.readinessProbe | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#configure-probes) | Readiness Probes configuration |
| deployment_manager.replicaCount | int | `1` | Number of dial-admin deployment_manager replicas to deploy |
| deployment_manager.resources | object | `{}` | Container resource requests and limits [Documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| deployment_manager.schedulerName | string | `""` | Name of the k8s scheduler (other than default) for dial-admin deployment_manager pods [Documentation](https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/) |
| deployment_manager.secrets | object | `{}` | Key-value pairs extra environment variables to add in environment variables from secrets to dial-admin deployment_manager |
| deployment_manager.service | object | [Documentation](https://kubernetes.io/docs/concepts/services-networking/service/) | Service configuration |
| deployment_manager.service.annotations | object | `{}` | Additional custom annotations for dial-admin deployment_manager service |
| deployment_manager.service.clusterIP | string | `""` | dial-admin deployment_manager service Cluster IP |
| deployment_manager.service.externalTrafficPolicy | string | `"Cluster"` | dial-admin deployment_manager service external traffic policy [Documentation](http://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) |
| deployment_manager.service.extraPorts | list | `[]` | Extra ports to expose in dial-admin deployment_manager service (normally used with the `sidecars` value) |
| deployment_manager.service.loadBalancerIP | string | `""` | dial-admin deployment_manager service Load Balancer IP. [Documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer) |
| deployment_manager.service.loadBalancerSourceRanges | list | `[]` | dial-admin deployment_manager service Load Balancer sources |
| deployment_manager.service.nodePorts | object | `{"http":""}` | Node ports to expose NOTE: choose port between <30000-32767> |
| deployment_manager.service.nodePorts.http | string | `""` | Node port for HTTP |
| deployment_manager.service.ports.http | int | `80` | dial-admin deployment_manager service HTTP port |
| deployment_manager.service.sessionAffinity | string | `"None"` | Control where client requests go, to the same pod or round-robin Values: ClientIP or None |
| deployment_manager.service.sessionAffinityConfig | object | `{}` | Additional settings for the sessionAffinity |
| deployment_manager.service.type | string | `"ClusterIP"` | dial-admin deployment_manager service type |
| deployment_manager.serviceAccount | object | [Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) | ServiceAccount configuration |
| deployment_manager.serviceAccount.annotations | object | `{}` | Additional Service Account annotations (evaluated as a template) |
| deployment_manager.serviceAccount.automountServiceAccountToken | bool | `false` | Automount service account token for the server service account |
| deployment_manager.serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| deployment_manager.serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| deployment_manager.sidecars | list | `[]` | Add additional sidecar containers to the dial-admin deployment_manager pod(s) |
| deployment_manager.startupProbe.enabled | bool | `false` | Enable/disable startupProbe |
| deployment_manager.startupProbe.failureThreshold | int | `6` |  |
| deployment_manager.startupProbe.httpGet.path | string | `"/api/v1/health"` |  |
| deployment_manager.startupProbe.httpGet.port | string | `"http"` |  |
| deployment_manager.startupProbe.initialDelaySeconds | int | `10` |  |
| deployment_manager.startupProbe.periodSeconds | int | `10` |  |
| deployment_manager.startupProbe.successThreshold | int | `1` |  |
| deployment_manager.startupProbe.timeoutSeconds | int | `3` |  |
| deployment_manager.terminationGracePeriodSeconds | string | `""` | Seconds dial-admin deployment_manager pod needs to terminate gracefully [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods) |
| deployment_manager.tolerations | list | `[]` | Tolerations for dial-admin deployment_manager pods assignment. [Documentation](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) |
| deployment_manager.topologySpreadConstraints | list | `[]` | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template [Documentation](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods) |
| deployment_manager.updateStrategy | object | [Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy) | Deployment strategy type |
| deployment_manager.updateStrategy.type | string | `"RollingUpdate"` | StrategyType Can be set to RollingUpdate or OnDelete |
| externalDatabase.database | string | `"dial_admin"` | Name of the external database |
| externalDatabase.deploymentManagerDatabase | string | `"deployment_manager"` | Name of the external database for deployment manager |
| externalDatabase.deploymentManagerExistingSecretPasswordKey | string | `"deployment-manager-password"` | Password key for the existing secret containing the external DB of deployment manager password |
| externalDatabase.deploymentManagerPassword | string | `""` | Password for the above username |
| externalDatabase.deploymentManagerUser | string | `"deployment_manager"` | non-root Username for deployment manager Database |
| externalDatabase.existingSecret | string | `""` | Name of an existing secret resource containing the DB password |
| externalDatabase.existingSecretPasswordKey | string | `"password"` | Password key for the existing secret containing the external DB password |
| externalDatabase.host | string | `""` | Host of the external database |
| externalDatabase.password | string | `""` | Password for the above username |
| externalDatabase.port | int | `5432` | Database port number |
| externalDatabase.user | string | `"dial_admin"` | non-root Username for Database |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release |
| frontend.containerPorts.http | int | `3000` | dial-admin frontend HTTP container port |
| frontend.enabled | bool | `true` | Enable dial-admin frontend deployment |
| frontend.image.pullPolicy | string | `"Always"` | Frontend image pull policy |
| frontend.image.registry | string | `"docker.io"` | Frontend image registry |
| frontend.image.repository | string | `"epam/ai-dial-admin-frontend"` | Frontend image repository |
| frontend.image.tag | string | `"0.12.4"` | Frontend image tag |
| fullnameOverride | string | `""` | String to fully override common.names.fullname |
| global.compatibility.openshift.adaptSecurityContext | string | `"disabled"` | Adapt the securityContext sections of the deployment to make them compatible with Openshift restricted-v2 SCC: remove runAsUser, runAsGroup and fsGroup and let the platform use their allowed default IDs. Possible values: auto (apply if the detected running cluster is Openshift), force (perform the adaptation always), disabled (do not perform adaptation) |
| global.imagePullSecrets | list | `[]` | Global Docker registry secret names as an array |
| global.imageRegistry | string | `""` | Global Docker image registry |
| global.storageClass | string | `""` | Global StorageClass for Persistent Volume(s) |
| nameOverride | string | `""` | String to partially override common.names.name |
| namespaceOverride | string | `""` | String to fully override common.names.namespace |
| postgresql.auth.database | string | `"dial_admin"` | Name of the application database |
| postgresql.auth.password | string | `""` | Password for the application database user |
| postgresql.auth.postgresPassword | string | `""` | Password for the postgres user |
| postgresql.auth.username | string | `"dial_admin"` | Username for the application database |
| postgresql.deployment_manager | object | `{"enabled":false}` | Name of the application database |
| postgresql.enabled | bool | `true` | Enable bundled PostgreSQL deployment |
| postgresql.global.security.allowInsecureImages | bool | `true` |  |
| postgresql.image.repository | string | `"bitnamilegacy/postgresql"` |  |
| postgresql.primary.initdb.scripts."create-multiple-dbs.sh" | string | `"#!/bin/bash\nset -e\necho \"Creating multiple databases...\"\n\n# Check if any of the required environment variables are empty\nif [ -z '$DEPLOYMENT_MANAGER_DATABASE' ] || [ -z \"$DEPLOYMENT_MANAGER_USER\" ] || [ -z \"$DEPLOYMENT_MANAGER_PASSWORD\" ]; then\n  echo \"Skipping database creation due to missing environment variables.\"\nelse\n  echo \"Creating database: \"$DEPLOYMENT_MANAGER_DATABASE\"\" with user: \"$DEPLOYMENT_MANAGER_USER\"\"\n  psql -v ON_ERROR_STOP=1 --username \"$POSTGRES_USER\" <<-EOSQL\n      CREATE DATABASE \"$DEPLOYMENT_MANAGER_DATABASE\";\n      CREATE USER \"$DEPLOYMENT_MANAGER_USER\" WITH ENCRYPTED PASSWORD \"$DEPLOYMENT_MANAGER_PASSWORD\"\";\n      GRANT ALL PRIVILEGES ON DATABASE \"$DEPLOYMENT_MANAGER_DATABASE\" TO \"$DEPLOYMENT_MANAGER_USER\";\nEOSQL\nfi\necho \"Multiple databases created.\"\n"` |  |
| postgresql.primary.initdb.scriptsSecret | string | `"{{ include \"dialAdmin.deployment_manager.scriptSecret\" . }}"` |  |

## Upgrading

### To 0.6.0

> [!NOTE]
> The `CORE_CONFIG_VERSION` environment variable is now required if `ENABLE_CORE_CONFIG_VERSION_AUTO_DETECT` is set to `false` for DIAL Admin backend.

1. Specify the DIAL core version in `backend.env.CORE_CONFIG_VERSION`.
1. Change all variables related to the identity provider configuration for the DIAL Admin backend according to the [new format](https://github.com/epam/ai-dial-admin-backend/blob/0.11.2/docs/configuration.md#identity-providers-configuration).

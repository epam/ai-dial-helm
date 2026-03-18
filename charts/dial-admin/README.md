# dial-admin

![Version: 0.11.0](https://img.shields.io/badge/Version-0.11.0-informational?style=flat-square) ![AppVersion: 0.14.0](https://img.shields.io/badge/AppVersion-0.14.0-informational?style=flat-square)

Helm chart for DIAL Admin

## Prerequisites

- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (optional)
- Ingress controller support in the underlying infrastructure (optional)

## Requirements

Kubernetes: `>=1.25.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.dialx.ai | frontend(dial-extension) | 3.0.1 |
| https://charts.dialx.ai | manager(dial-extension) | 3.0.1 |
| oci://registry-1.docker.io/bitnamicharts | common | 2.31.1 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 16.7.12 |

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add dial https://charts.dialx.ai
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
| backend.image.tag | string | `"0.14.3"` | Image tag (immutable tags are recommended) |
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
| externalDatabase.database | string | `"dial_admin"` | Name of the external database |
| externalDatabase.existingSecret | string | `""` | Name of an existing secret resource containing the DB password |
| externalDatabase.existingSecretPasswordKey | string | `"password"` | Password key for the existing secret containing the external DB password |
| externalDatabase.host | string | `""` | Host of the external database |
| externalDatabase.password | string | `""` | Password for the above username |
| externalDatabase.port | int | `5432` | Database port number |
| externalDatabase.user | string | `"dial_admin"` | non-root Username for Database |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release |
| frontend.containerPorts.http | int | `3000` | dial-admin frontend HTTP container port |
| frontend.containerSecurityContext.enabled | bool | `false` |  |
| frontend.enabled | bool | `true` | Enable dial-admin frontend deployment |
| frontend.image.pullPolicy | string | `"Always"` | Frontend image pull policy |
| frontend.image.registry | string | `"docker.io"` | Frontend image registry |
| frontend.image.repository | string | `"epam/ai-dial-admin-frontend"` | Frontend image repository |
| frontend.image.tag | string | `"0.14.5"` | Frontend image tag |
| frontend.resourcesPreset | string | `"micro"` | Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if `resources` is set (recommended for production). [Documentation](https://github.com/bitnami/charts/blob/main/bitnami/common/templates/_resources.tpl#L15) |
| fullnameOverride | string | `""` | String to fully override common.names.fullname |
| global.compatibility.openshift.adaptSecurityContext | string | `"disabled"` | Adapt the securityContext sections of the deployment to make them compatible with Openshift restricted-v2 SCC: remove runAsUser, runAsGroup and fsGroup and let the platform use their allowed default IDs. Possible values: auto (apply if the detected running cluster is Openshift), force (perform the adaptation always), disabled (do not perform adaptation) |
| global.imagePullSecrets | list | `[]` | Global Docker registry secret names as an array |
| global.imageRegistry | string | `""` | Global Docker image registry |
| global.storageClass | string | `""` | Global StorageClass for Persistent Volume(s) |
| manager.commonAnnotations | object | `{}` |  |
| manager.commonLabels."app.kubernetes.io/component" | string | `"deployment-manager"` |  |
| manager.configuration.build | object | `{"namespace":""}` | Build images for mcp containers specific variables |
| manager.configuration.database | object | `{"name":"deployment_manager","password":"","user":"deployment_manager"}` | Database specific variables. It will be used only in case of postgresql.enabled: true. In other cases, you need to supply credentials yourself via manager.secrets, manager.env, or manager.extraEnvVarsSecret. |
| manager.configuration.deploy | object | `{"knative":{"enabled":true,"namespace":""},"kserve":{"enabled":false,"namespace":""},"nim":{"enabled":false,"namespace":""}}` | Deploy mcp containers specific variables |
| manager.containerPorts.http | int | `8080` |  |
| manager.containerSecurityContext.enabled | bool | `false` |  |
| manager.enabled | bool | `false` | Enable dial-admin deployment_manager deployment |
| manager.env.K8S_KNATIVE_DEPLOYMENT_NAMESPACE | string | `"{{ .Values.configuration.deploy.knative.namespace }}"` |  |
| manager.env.K8S_KNATIVE_ENABLED | string | `"{{ .Values.configuration.deploy.knative.enabled }}"` |  |
| manager.env.K8S_KSERVE_DEPLOYMENT_NAMESPACE | string | `"{{ .Values.configuration.deploy.kserve.namespace }}"` |  |
| manager.env.K8S_KSERVE_ENABLED | string | `"{{ .Values.configuration.deploy.kserve.enabled }}"` |  |
| manager.env.K8S_NIM_DEPLOYMENT_NAMESPACE | string | `"{{ .Values.configuration.deploy.nim.namespace }}"` |  |
| manager.env.K8S_NIM_ENABLED | string | `"{{ .Values.configuration.deploy.nim.enabled }}"` |  |
| manager.extraEnvVarsSecret | string | `"{{ .Release.Name }}-manager-db"` |  |
| manager.image | object | [Documentation](https://kubernetes.io/docs/concepts/containers/images/) | Section to configure the image. |
| manager.image.registry | string | `"docker.io"` | Image registry |
| manager.image.repository | string | `"epam/ai-dial-admin-deployment-manager-backend"` | Image repository |
| manager.image.tag | string | `"0.14.3"` | Image tag (immutable tags are recommended) |
| manager.rbac.create | bool | `true` |  |
| manager.resourcesPreset | string | `"small"` | Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if `resources` is set (recommended for production). [Documentation](https://github.com/bitnami/charts/blob/main/bitnami/common/templates/_resources.tpl#L15) |
| manager.serviceAccount.create | bool | `true` |  |
| nameOverride | string | `""` | String to partially override common.names.name |
| namespaceOverride | string | `""` | String to fully override common.names.namespace |
| postgresql.auth.database | string | `"dial_admin"` | Name of the application database |
| postgresql.auth.password | string | `""` | Password for the application database user |
| postgresql.auth.postgresPassword | string | `""` | Password for the postgres user |
| postgresql.auth.usePasswordFiles | bool | `false` |  |
| postgresql.auth.username | string | `"dial_admin"` | Username for the application database |
| postgresql.commonAnnotations | object | `{}` |  |
| postgresql.commonLabels | object | `{}` |  |
| postgresql.enabled | bool | `true` | Enable bundled PostgreSQL deployment |
| postgresql.global.security.allowInsecureImages | bool | `true` |  |
| postgresql.image.repository | string | `"bitnamilegacy/postgresql"` |  |
| postgresql.primary.initdb.scriptsSecret | string | `"{{ .Release.Name }}-pg-init"` |  |
| postgresql.primary.service.ports.postgresql | string | `"5432"` |  |

## Deployment Manager

The **DIAL Admin Deployment Manager** (`manager`) is an optional component that extends the DIAL Admin chart with model build-and-deploy capabilities. It manages Knative, NIM, and KServe services and requires its own database connection. See the full [configuration reference](https://github.com/epam/ai-dial-admin-deployment-manager-backend/blob/development/docs/configuration.md) for all available environment variables.

Enable the component with:

```yaml
manager:
  enabled: true
```

### Database configuration

The Deployment Manager supports three database vendors: **PostgreSQL**, **MS SQL Server**, and **H2** (in-memory/file-backed). The vendor is controlled by the `DATASOURCE_VENDOR` environment variable (`POSTGRES`, `MS_SQL_SERVER`, or `H2`).

> [!IMPORTANT]
> When `postgresql.enabled: true` and `manager.enabled: true`, the chart renders a Kubernetes Secret named `<release-name>-manager-db` (the default value of `manager.extraEnvVarsSecret`) that is pre-populated with PostgreSQL connection details. If you configure an alternative database (external PostgreSQL, MS SQL Server, or H2) **without** disabling the bundled PostgreSQL, the chart will still generate that same-named secret with PostgreSQL credentials, silently overwriting any external configuration supplied through `manager.extraEnvVarsSecret`. Always set `postgresql.enabled: false` when using a non-bundled database for the Deployment Manager.

#### Bundled PostgreSQL (default)

When `postgresql.enabled: true` the chart automatically:

1. Generates a PostgreSQL init Secret (`<release-name>-pg-init`) that creates the Deployment Manager database and user on first start.
2. Generates a connection Secret (`<release-name>-manager-db`) injected into the manager pod via `manager.extraEnvVarsSecret`.

Both are driven by the following values:

```yaml
manager:
  configuration:
    database:
      name: "deployment_manager"   # used ONLY when postgresql.enabled is true
      user: "deployment_manager"   # used ONLY when postgresql.enabled is true -- see naming note below
      password: ""                 # used ONLY when postgresql.enabled is true
```

> [!NOTE]
> All three fields — `name`, `user`, and `password` — under `manager.configuration.database` are **only** consumed by the chart's auto-generated secrets when `postgresql.enabled: true`. For all other database setups (external PostgreSQL, MS SQL Server, H2) you must supply credentials yourself via `manager.secrets`, `manager.env`, or `manager.extraEnvVarsSecret`.

> [!NOTE]
> The PostgreSQL init Secret (`<release-name>-pg-init`) is **always** rendered when `postgresql.enabled: true`, even when `manager.enabled: false`. If any of `name`, `user`, or `password` is empty, the secret is created with an empty `stringData: {}` and no database or user will be initialised. Follow [PostgreSQL identifier naming rules](https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS) for the `name` and `user` values: use only lowercase letters, digits, and underscores; start with a letter or underscore; maximum 63 characters.

#### External PostgreSQL

Disable the bundled chart and supply the connection details via a pre-created Kubernetes Secret:

```yaml
postgresql:
  enabled: false

manager:
  extraEnvVarsSecret: "my-manager-db-secret"
```

The Secret must contain:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-manager-db-secret
type: Opaque
stringData:
  DATASOURCE_VENDOR: "POSTGRES"
  POSTGRES_HOST: "pg.example.com"
  POSTGRES_PORT: "5432"
  POSTGRES_DATABASE: "deployment_manager"
  POSTGRES_DATASOURCE_USERNAME: "deployment_manager"
  POSTGRES_DATASOURCE_PASSWORD: "changeme"
```

#### MS SQL Server

Disable the bundled chart and supply credentials via the `manager.secrets` map (rendered as a chart-managed Secret):

```yaml
postgresql:
  enabled: false

manager:
  secrets:
    DATASOURCE_VENDOR: "MS_SQL_SERVER"
    MS_SQL_SERVER_HOST: "mssql.example.com"
    MS_SQL_SERVER_PORT: "1433"
    MS_SQL_SERVER_DATABASE: "deployment_manager"
    MS_SQL_SERVER_DATASOURCE_USERNAME: "dm_user"
    MS_SQL_SERVER_DATASOURCE_PASSWORD: "StrongPassword1!"
    # Optional — recommended for case-sensitive collation environments:
    # MS_SQL_SERVER_OPS: "encrypt=true;trustServerCertificate=false;"
```

#### H2 (file-backed)

H2 stores its data in a local file. Because the Deployment Manager container has a read-only root filesystem by default, you must mount a writable volume at the H2 file path and supply the required encryption keys.

Generate the required keys with the upstream helper:

```console
bash <(curl -sSL https://raw.githubusercontent.com/epam/ai-dial-admin-backend/development/secrets-utils/generate_h2_secrets.sh)
```

Store the keys in a Kubernetes Secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-manager-h2-secret
type: Opaque
stringData:
  DATASOURCE_VENDOR: "H2"
  H2_FILE: "/data/deployment_manager"
  H2_DATASOURCE_MASTERKEY: "<generated-master-key>"
  H2_DATASOURCE_ENCRYPTEDFILEKEY: "<generated-encrypted-file-key>"
  H2_DATASOURCE_PASSWORD: "<generated-password>"
```

Disable the bundled PostgreSQL, reference the Secret, and mount a persistent volume for the H2 file:

```yaml
postgresql:
  enabled: false

manager:
  extraEnvVarsSecret: "my-manager-h2-secret"

  extraVolumes:
    - name: h2-data
      persistentVolumeClaim:
        claimName: manager-h2-pvc

  extraVolumeMounts:
    - name: h2-data
      mountPath: /data
```

Create the PVC separately (or use `manager.extraVolumeClaimTemplates` if the manager is deployed as a StatefulSet):

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: manager-h2-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```

> [!WARNING]
> H2 is suitable for development and single-replica setups only. For production, use PostgreSQL or MS SQL Server.

## Upgrading

### To 0.6.0

> [!NOTE]
> The `CORE_CONFIG_VERSION` environment variable is now required if `ENABLE_CORE_CONFIG_VERSION_AUTO_DETECT` is set to `false` for DIAL Admin backend.

1. Specify the DIAL core version in `backend.env.CORE_CONFIG_VERSION`.
1. Change all variables related to the identity provider configuration for the DIAL Admin backend according to the [new format](https://github.com/epam/ai-dial-admin-backend/blob/0.11.2/docs/configuration.md#identity-providers-configuration).

### To 0.9.0

> [!NOTE]
> A new service `manager` (Deployment Manager) is now included and disabled by default.

If `manager.enabled` is set to `true` and this is an upgrade from a previous version, the PostgreSQL init scripts will not run automatically (see [initdb.scriptsSecret](https://github.com/bitnami/charts/tree/main/bitnami/postgresql#initialize-a-fresh-instance) description). You must manually create the database and user for the Manager service.

1. Exec into the PostgreSQL pod:

    ```console
    kubectl exec -it <release-name>-postgresql-0 -- bash
    ```

2. Run the initialization script:

    ```console
    bash /docker-entrypoint-initdb.d/secret/create-multiple-dbs.sh
    ```

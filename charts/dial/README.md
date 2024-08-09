# dial

![Version: 2.8.2](https://img.shields.io/badge/Version-2.8.2-informational?style=flat-square) ![AppVersion: 1.13.0](https://img.shields.io/badge/AppVersion-1.13.0-informational?style=flat-square)

Umbrella chart for DIAL solution

## Prerequisites

- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (optional)
- Ingress controller support in the underlying infrastructure (optional)

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.14.1 |
| https://charts.bitnami.com/bitnami | keycloak | 16.1.7 |
| https://charts.epam-rail.com | core(dial-core) | 2.0.3 |
| https://charts.epam-rail.com | authhelper(dial-extension) | 1.0.3 |
| https://charts.epam-rail.com | chat(dial-extension) | 1.0.3 |
| https://charts.epam-rail.com | themes(dial-extension) | 1.0.3 |
| https://charts.epam-rail.com | openai(dial-extension) | 1.0.3 |
| https://charts.epam-rail.com | bedrock(dial-extension) | 1.0.3 |
| https://charts.epam-rail.com | vertexai(dial-extension) | 1.0.3 |
| https://charts.epam-rail.com | assistant(dial-extension) | 1.0.3 |

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add dial https://charts.epam-rail.com
helm install --name my-release dial/dial
```

The command deploys AI DIAL on the Kubernetes cluster with default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Examples

Due to flexibility of the system, it's impossible to define default values for all parameters and cover all use cases.\
However, we provide a set of [examples](examples) that can be used as a good starting point for your own configuration.

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
helm install my-release dial/dial --set chat.image.tag=latest
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example:

```yaml
# values.yaml file content
chat:
  image:
    tag: latest
```

```console
helm install my-release dial/dial -f values.yaml
```

**NOTE**: You can use the default [values.yaml](values.yaml)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| assistant.commonLabels."app.kubernetes.io/component" | string | `"application"` |  |
| assistant.enabled | bool | `false` | Enable/disable ai-dial-assistant |
| assistant.image.repository | string | `"epam/ai-dial-assistant"` |  |
| assistant.image.tag | string | `"0.7.0"` |  |
| assistant.livenessProbe.enabled | bool | `true` |  |
| assistant.livenessProbe.failureThreshold | int | `3` |  |
| assistant.livenessProbe.httpGet.path | string | `"/health"` |  |
| assistant.livenessProbe.httpGet.port | int | `5000` |  |
| assistant.livenessProbe.initialDelaySeconds | int | `30` |  |
| assistant.livenessProbe.periodSeconds | int | `10` |  |
| assistant.livenessProbe.successThreshold | int | `1` |  |
| assistant.livenessProbe.timeoutSeconds | int | `3` |  |
| assistant.readinessProbe.enabled | bool | `true` |  |
| assistant.readinessProbe.failureThreshold | int | `3` |  |
| assistant.readinessProbe.httpGet.path | string | `"/health"` |  |
| assistant.readinessProbe.httpGet.port | int | `5000` |  |
| assistant.readinessProbe.initialDelaySeconds | int | `15` |  |
| assistant.readinessProbe.periodSeconds | int | `10` |  |
| assistant.readinessProbe.successThreshold | int | `1` |  |
| assistant.readinessProbe.timeoutSeconds | int | `3` |  |
| assistant.startupProbe.enabled | bool | `false` |  |
| assistant.startupProbe.failureThreshold | int | `6` |  |
| assistant.startupProbe.httpGet.path | string | `"/health"` |  |
| assistant.startupProbe.httpGet.port | int | `5000` |  |
| assistant.startupProbe.initialDelaySeconds | int | `30` |  |
| assistant.startupProbe.periodSeconds | int | `10` |  |
| assistant.startupProbe.successThreshold | int | `1` |  |
| assistant.startupProbe.timeoutSeconds | int | `5` |  |
| authhelper.commonLabels."app.kubernetes.io/component" | string | `"authentication"` |  |
| authhelper.containerPorts.http | int | `4088` |  |
| authhelper.enabled | bool | `false` | Enable/disable ai-dial-auth-helper. Set `keycloak.enabled: true` before enabling this. |
| authhelper.image.repository | string | `"epam/ai-dial-auth-helper"` |  |
| authhelper.image.tag | string | `"0.3.0"` |  |
| bedrock.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| bedrock.enabled | bool | `false` | Enable/disable ai-dial-adapter-bedrock |
| bedrock.image.repository | string | `"epam/ai-dial-adapter-bedrock"` |  |
| bedrock.image.tag | string | `"0.13.3"` |  |
| bedrock.livenessProbe.enabled | bool | `true` |  |
| bedrock.livenessProbe.failureThreshold | int | `3` |  |
| bedrock.livenessProbe.httpGet.path | string | `"/health"` |  |
| bedrock.livenessProbe.httpGet.port | int | `5000` |  |
| bedrock.livenessProbe.initialDelaySeconds | int | `30` |  |
| bedrock.livenessProbe.periodSeconds | int | `10` |  |
| bedrock.livenessProbe.successThreshold | int | `1` |  |
| bedrock.livenessProbe.timeoutSeconds | int | `3` |  |
| bedrock.readinessProbe.enabled | bool | `true` |  |
| bedrock.readinessProbe.failureThreshold | int | `3` |  |
| bedrock.readinessProbe.httpGet.path | string | `"/health"` |  |
| bedrock.readinessProbe.httpGet.port | int | `5000` |  |
| bedrock.readinessProbe.initialDelaySeconds | int | `15` |  |
| bedrock.readinessProbe.periodSeconds | int | `10` |  |
| bedrock.readinessProbe.successThreshold | int | `1` |  |
| bedrock.readinessProbe.timeoutSeconds | int | `3` |  |
| bedrock.secrets | object | `{}` |  |
| bedrock.startupProbe.enabled | bool | `false` |  |
| bedrock.startupProbe.failureThreshold | int | `6` |  |
| bedrock.startupProbe.httpGet.path | string | `"/health"` |  |
| bedrock.startupProbe.httpGet.port | int | `5000` |  |
| bedrock.startupProbe.initialDelaySeconds | int | `30` |  |
| bedrock.startupProbe.periodSeconds | int | `10` |  |
| bedrock.startupProbe.successThreshold | int | `1` |  |
| bedrock.startupProbe.timeoutSeconds | int | `5` |  |
| chat.commonLabels."app.kubernetes.io/component" | string | `"application"` |  |
| chat.containerPorts.http | int | `3000` |  |
| chat.enabled | bool | `true` | Enable/disable ai-dial-chat |
| chat.image.repository | string | `"epam/ai-dial-chat"` |  |
| chat.image.tag | string | `"0.15.0"` |  |
| chat.livenessProbe.enabled | bool | `true` |  |
| chat.livenessProbe.failureThreshold | int | `3` |  |
| chat.livenessProbe.httpGet.path | string | `"/api/health"` |  |
| chat.livenessProbe.httpGet.port | string | `"http"` |  |
| chat.livenessProbe.initialDelaySeconds | int | `30` |  |
| chat.livenessProbe.periodSeconds | int | `10` |  |
| chat.livenessProbe.successThreshold | int | `1` |  |
| chat.livenessProbe.timeoutSeconds | int | `3` |  |
| chat.readinessProbe.enabled | bool | `true` |  |
| chat.readinessProbe.failureThreshold | int | `3` |  |
| chat.readinessProbe.httpGet.path | string | `"/api/health"` |  |
| chat.readinessProbe.httpGet.port | string | `"http"` |  |
| chat.readinessProbe.initialDelaySeconds | int | `15` |  |
| chat.readinessProbe.periodSeconds | int | `10` |  |
| chat.readinessProbe.successThreshold | int | `1` |  |
| chat.readinessProbe.timeoutSeconds | int | `3` |  |
| chat.startupProbe.enabled | bool | `false` |  |
| chat.startupProbe.failureThreshold | int | `6` |  |
| chat.startupProbe.httpGet.path | string | `"/health"` |  |
| chat.startupProbe.httpGet.port | string | `"http"` |  |
| chat.startupProbe.initialDelaySeconds | int | `30` |  |
| chat.startupProbe.periodSeconds | int | `10` |  |
| chat.startupProbe.successThreshold | int | `1` |  |
| chat.startupProbe.timeoutSeconds | int | `5` |  |
| core.enabled | bool | `true` | Enable/disable ai-dial-core |
| core.image.tag | string | `"0.14.0"` |  |
| extraDeploy | list | `[]` |  |
| keycloak.enabled | bool | `false` | Enable/disable keycloak |
| keycloak.extraEnvVars[0].name | string | `"KC_FEATURES"` |  |
| keycloak.extraEnvVars[0].value | string | `"token-exchange,admin-fine-grained-authz,declarative-user-profile"` |  |
| keycloak.keycloakConfigCli.enabled | bool | `true` |  |
| keycloak.keycloakConfigCli.extraEnvVars[0].name | string | `"IMPORT_VARSUBSTITUTION_ENABLED"` |  |
| keycloak.keycloakConfigCli.extraEnvVars[0].value | string | `"true"` |  |
| keycloak.postgresql.enabled | bool | `true` |  |
| keycloak.proxy | string | `"edge"` |  |
| openai.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| openai.enabled | bool | `false` | Enable/disable ai-dial-adapter-openai |
| openai.image.repository | string | `"epam/ai-dial-adapter-openai"` |  |
| openai.image.tag | string | `"0.13.1"` |  |
| openai.livenessProbe.enabled | bool | `true` |  |
| openai.livenessProbe.failureThreshold | int | `3` |  |
| openai.livenessProbe.httpGet.path | string | `"/health"` |  |
| openai.livenessProbe.httpGet.port | int | `5000` |  |
| openai.livenessProbe.initialDelaySeconds | int | `30` |  |
| openai.livenessProbe.periodSeconds | int | `10` |  |
| openai.livenessProbe.successThreshold | int | `1` |  |
| openai.livenessProbe.timeoutSeconds | int | `3` |  |
| openai.readinessProbe.enabled | bool | `true` |  |
| openai.readinessProbe.failureThreshold | int | `3` |  |
| openai.readinessProbe.httpGet.path | string | `"/health"` |  |
| openai.readinessProbe.httpGet.port | int | `5000` |  |
| openai.readinessProbe.initialDelaySeconds | int | `15` |  |
| openai.readinessProbe.periodSeconds | int | `10` |  |
| openai.readinessProbe.successThreshold | int | `1` |  |
| openai.readinessProbe.timeoutSeconds | int | `3` |  |
| openai.startupProbe.enabled | bool | `false` |  |
| openai.startupProbe.failureThreshold | int | `6` |  |
| openai.startupProbe.httpGet.path | string | `"/health"` |  |
| openai.startupProbe.httpGet.port | int | `5000` |  |
| openai.startupProbe.initialDelaySeconds | int | `30` |  |
| openai.startupProbe.periodSeconds | int | `10` |  |
| openai.startupProbe.successThreshold | int | `1` |  |
| openai.startupProbe.timeoutSeconds | int | `5` |  |
| themes.commonLabels."app.kubernetes.io/component" | string | `"webserver"` |  |
| themes.containerPorts.http | int | `8080` |  |
| themes.containerSecurityContext.runAsUser | int | `101` |  |
| themes.enabled | bool | `true` | Enable/disable ai-dial-chat-themes |
| themes.image.repository | string | `"epam/ai-dial-chat-themes"` |  |
| themes.image.tag | string | `"0.4.1"` |  |
| themes.livenessProbe.enabled | bool | `true` |  |
| themes.livenessProbe.failureThreshold | int | `3` |  |
| themes.livenessProbe.httpGet.path | string | `"/health"` |  |
| themes.livenessProbe.httpGet.port | string | `"http"` |  |
| themes.livenessProbe.initialDelaySeconds | int | `30` |  |
| themes.livenessProbe.periodSeconds | int | `10` |  |
| themes.livenessProbe.successThreshold | int | `1` |  |
| themes.livenessProbe.timeoutSeconds | int | `3` |  |
| themes.podSecurityContext.fsGroup | int | `101` |  |
| themes.readinessProbe.enabled | bool | `true` |  |
| themes.readinessProbe.failureThreshold | int | `3` |  |
| themes.readinessProbe.httpGet.path | string | `"/health"` |  |
| themes.readinessProbe.httpGet.port | string | `"http"` |  |
| themes.readinessProbe.initialDelaySeconds | int | `15` |  |
| themes.readinessProbe.periodSeconds | int | `10` |  |
| themes.readinessProbe.successThreshold | int | `1` |  |
| themes.readinessProbe.timeoutSeconds | int | `3` |  |
| themes.startupProbe.enabled | bool | `false` |  |
| themes.startupProbe.failureThreshold | int | `6` |  |
| themes.startupProbe.httpGet.path | string | `"/health"` |  |
| themes.startupProbe.httpGet.port | string | `"http"` |  |
| themes.startupProbe.initialDelaySeconds | int | `30` |  |
| themes.startupProbe.periodSeconds | int | `10` |  |
| themes.startupProbe.successThreshold | int | `1` |  |
| themes.startupProbe.timeoutSeconds | int | `5` |  |
| vertexai.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| vertexai.enabled | bool | `false` | Enable/disable ai-dial-adapter-vertexai |
| vertexai.image.repository | string | `"epam/ai-dial-adapter-vertexai"` |  |
| vertexai.image.tag | string | `"0.9.0"` |  |
| vertexai.livenessProbe.enabled | bool | `true` |  |
| vertexai.livenessProbe.failureThreshold | int | `3` |  |
| vertexai.livenessProbe.httpGet.path | string | `"/health"` |  |
| vertexai.livenessProbe.httpGet.port | int | `5000` |  |
| vertexai.livenessProbe.initialDelaySeconds | int | `30` |  |
| vertexai.livenessProbe.periodSeconds | int | `10` |  |
| vertexai.livenessProbe.successThreshold | int | `1` |  |
| vertexai.livenessProbe.timeoutSeconds | int | `3` |  |
| vertexai.readinessProbe.enabled | bool | `true` |  |
| vertexai.readinessProbe.failureThreshold | int | `3` |  |
| vertexai.readinessProbe.httpGet.path | string | `"/health"` |  |
| vertexai.readinessProbe.httpGet.port | int | `5000` |  |
| vertexai.readinessProbe.initialDelaySeconds | int | `15` |  |
| vertexai.readinessProbe.periodSeconds | int | `10` |  |
| vertexai.readinessProbe.successThreshold | int | `1` |  |
| vertexai.readinessProbe.timeoutSeconds | int | `3` |  |
| vertexai.startupProbe.enabled | bool | `false` |  |
| vertexai.startupProbe.failureThreshold | int | `6` |  |
| vertexai.startupProbe.httpGet.path | string | `"/health"` |  |
| vertexai.startupProbe.httpGet.port | int | `5000` |  |
| vertexai.startupProbe.initialDelaySeconds | int | `30` |  |
| vertexai.startupProbe.periodSeconds | int | `10` |  |
| vertexai.startupProbe.successThreshold | int | `1` |  |
| vertexai.startupProbe.timeoutSeconds | int | `5` |  |

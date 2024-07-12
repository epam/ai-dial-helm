# dial

![Version: 2.7.0](https://img.shields.io/badge/Version-2.7.0-informational?style=flat-square) ![AppVersion: 1.12.0](https://img.shields.io/badge/AppVersion-1.12.0-informational?style=flat-square)

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
| authhelper.commonLabels."app.kubernetes.io/component" | string | `"authentication"` |  |
| authhelper.containerPorts.http | int | `4088` |  |
| authhelper.enabled | bool | `false` | Enable/disable ai-dial-auth-helper. Set `keycloak.enabled: true` before enabling this. |
| authhelper.image.repository | string | `"epam/ai-dial-auth-helper"` |  |
| authhelper.image.tag | string | `"0.3.0"` |  |
| bedrock.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| bedrock.enabled | bool | `false` | Enable/disable ai-dial-adapter-bedrock |
| bedrock.image.repository | string | `"epam/ai-dial-adapter-bedrock"` |  |
| bedrock.image.tag | string | `"0.13.1"` |  |
| bedrock.secrets | object | `{}` |  |
| chat.commonLabels."app.kubernetes.io/component" | string | `"application"` |  |
| chat.containerPorts.http | int | `3000` |  |
| chat.enabled | bool | `true` | Enable/disable ai-dial-chat |
| chat.image.repository | string | `"epam/ai-dial-chat"` |  |
| chat.image.tag | string | `"0.14.1"` |  |
| core.enabled | bool | `true` | Enable/disable ai-dial-core |
| core.image.tag | string | `"0.13.0"` |  |
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
| openai.image.tag | string | `"0.13.0"` |  |
| themes.commonLabels."app.kubernetes.io/component" | string | `"webserver"` |  |
| themes.containerPorts.http | int | `8080` |  |
| themes.containerSecurityContext.runAsUser | int | `101` |  |
| themes.enabled | bool | `true` | Enable/disable ai-dial-chat-themes |
| themes.image.repository | string | `"epam/ai-dial-chat-themes"` |  |
| themes.image.tag | string | `"0.4.1"` |  |
| themes.podSecurityContext.fsGroup | int | `101` |  |
| vertexai.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| vertexai.enabled | bool | `false` | Enable/disable ai-dial-adapter-vertexai |
| vertexai.image.repository | string | `"epam/ai-dial-adapter-vertexai"` |  |
| vertexai.image.tag | string | `"0.8.1"` |  |

# dial

![Version: 5.17.3](https://img.shields.io/badge/Version-5.17.3-informational?style=flat-square) ![AppVersion: 1.37.3](https://img.shields.io/badge/AppVersion-1.37.3-informational?style=flat-square)

Umbrella chart for DIAL solution

## Prerequisites

- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (optional)
- Ingress controller support in the underlying infrastructure (optional)

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | keycloak | 24.9.0 |
| https://charts.epam-rail.com | core(dial-core) | 5.0.0 |
| https://charts.epam-rail.com | authhelper(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | chat(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | themes(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | openai(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | bedrock(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | vertexai(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | dial(dial-extension) | 1.4.0 |
| https://charts.epam-rail.com | assistant(dial-extension) | 1.4.0 |
| oci://registry-1.docker.io/bitnamicharts | common | 2.31.4 |

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add dial https://charts.epam-rail.com
helm install my-release dial/dial
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
| assistant.readinessProbe.enabled | bool | `true` |  |
| authhelper.commonLabels."app.kubernetes.io/component" | string | `"authentication"` |  |
| authhelper.containerPorts.http | int | `4088` |  |
| authhelper.enabled | bool | `false` | Enable/disable ai-dial-auth-helper. Set `keycloak.enabled: true` before enabling this. |
| authhelper.image.repository | string | `"epam/ai-dial-auth-helper"` |  |
| authhelper.image.tag | string | `"0.4.0"` |  |
| bedrock.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| bedrock.enabled | bool | `false` | Enable/disable ai-dial-adapter-bedrock |
| bedrock.image.repository | string | `"epam/ai-dial-adapter-bedrock"` |  |
| bedrock.image.tag | string | `"0.34.0"` |  |
| bedrock.livenessProbe.enabled | bool | `true` |  |
| bedrock.readinessProbe.enabled | bool | `true` |  |
| bedrock.secrets | object | `{}` |  |
| chat.commonLabels."app.kubernetes.io/component" | string | `"application"` |  |
| chat.containerPorts.http | int | `3000` |  |
| chat.enabled | bool | `true` | Enable/disable ai-dial-chat |
| chat.image.repository | string | `"epam/ai-dial-chat"` |  |
| chat.image.tag | string | `"0.39.0"` |  |
| chat.livenessProbe.enabled | bool | `true` |  |
| chat.livenessProbe.failureThreshold | int | `6` |  |
| chat.livenessProbe.httpGet.path | string | `"/api/health"` |  |
| chat.readinessProbe.enabled | bool | `true` |  |
| chat.readinessProbe.failureThreshold | int | `6` |  |
| chat.readinessProbe.httpGet.path | string | `"/api/health"` |  |
| core.enabled | bool | `true` | Enable/disable ai-dial-core |
| core.image.tag | string | `"0.37.0"` |  |
| core.livenessProbe.enabled | bool | `true` |  |
| core.readinessProbe.enabled | bool | `true` |  |
| dial.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| dial.enabled | bool | `false` | Enable/disable ai-dial-adapter-dial |
| dial.image.repository | string | `"epam/ai-dial-adapter-dial"` |  |
| dial.image.tag | string | `"0.10.0"` |  |
| dial.livenessProbe.enabled | bool | `true` |  |
| dial.readinessProbe.enabled | bool | `true` |  |
| extraDeploy | list | `[]` |  |
| keycloak.enabled | bool | `false` | Enable/disable keycloak |
| keycloak.extraEnvVars[0].name | string | `"KC_FEATURES"` |  |
| keycloak.extraEnvVars[0].value | string | `"token-exchange,admin-fine-grained-authz"` |  |
| keycloak.global.security.allowInsecureImages | bool | `true` |  |
| keycloak.image.repository | string | `"bitnamilegacy/keycloak"` |  |
| keycloak.keycloakConfigCli.enabled | bool | `true` |  |
| keycloak.keycloakConfigCli.extraEnvVars[0].name | string | `"IMPORT_VARSUBSTITUTION_ENABLED"` |  |
| keycloak.keycloakConfigCli.extraEnvVars[0].value | string | `"true"` |  |
| keycloak.keycloakConfigCli.image.repository | string | `"bitnamilegacy/keycloak-config-cli"` |  |
| keycloak.keycloakConfigCli.image.tag | string | `"6.4.0-debian-12-r11"` |  |
| keycloak.postgresql.auth.usePasswordFiles | bool | `false` |  |
| keycloak.postgresql.enabled | bool | `true` |  |
| keycloak.postgresql.image.repository | string | `"bitnamilegacy/postgresql"` |  |
| keycloak.postgresql.image.tag | string | `"17.6.0-debian-12-r0"` |  |
| keycloak.postgresql.metrics.image.repository | string | `"bitnamilegacy/postgres-exporter"` |  |
| keycloak.postgresql.metrics.image.tag | string | `"0.17.1-debian-12-r15"` |  |
| keycloak.postgresql.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| keycloak.postgresql.volumePermissions.image.tag | string | `"12-debian-12-r50"` |  |
| keycloak.proxy | string | `"edge"` |  |
| keycloak.usePasswordFiles | bool | `false` |  |
| openai.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| openai.enabled | bool | `false` | Enable/disable ai-dial-adapter-openai |
| openai.image.repository | string | `"epam/ai-dial-adapter-openai"` |  |
| openai.image.tag | string | `"0.33.0"` |  |
| openai.livenessProbe.enabled | bool | `true` |  |
| openai.readinessProbe.enabled | bool | `true` |  |
| themes.commonLabels."app.kubernetes.io/component" | string | `"webserver"` |  |
| themes.containerPorts.http | int | `8080` |  |
| themes.containerSecurityContext.runAsUser | int | `101` |  |
| themes.enabled | bool | `true` | Enable/disable ai-dial-chat-themes |
| themes.image.repository | string | `"epam/ai-dial-chat-themes"` |  |
| themes.image.tag | string | `"0.11.0"` |  |
| themes.livenessProbe.enabled | bool | `true` |  |
| themes.podSecurityContext.fsGroup | int | `101` |  |
| themes.readinessProbe.enabled | bool | `true` |  |
| vertexai.commonLabels."app.kubernetes.io/component" | string | `"adapter"` |  |
| vertexai.enabled | bool | `false` | Enable/disable ai-dial-adapter-vertexai |
| vertexai.image.repository | string | `"epam/ai-dial-adapter-vertexai"` |  |
| vertexai.image.tag | string | `"0.28.0"` |  |
| vertexai.livenessProbe.enabled | bool | `true` |  |
| vertexai.readinessProbe.enabled | bool | `true` |  |

## Upgrading

### To 5.4.0

> [!TIP]
> If you don't use custom Core logger configuration, disregard the information below and proceed with Helm upgrade as usual.

> [!CAUTION]
> The upgrade require Core logger configuration update.

Add `data_dir: "/var/tmp/vector"` to `core.logger.config` if custom vector config is used. This is required to run vector without root privileges.

**Example:**

```yaml
core:
  logger:
    config: |
      data_dir: "/var/tmp/vector"
```

### To 5.0.0

> [!TIP]
> If you don't use Keycloak, disregard the information below and proceed with Helm upgrade as usual.

> [!CAUTION]
> The upgrade includes **BREAKING CHANGES** and require **MANUAL ACTIONS**.

In this version, we've updated the following underlying dependencies which require manual actions:

- `bitnami/keycloak` Helm chart version bumped from `16.1.7` to `24.4.3`
  - `keycloak` version bumped from `22.0.3` to `26.0.8`
  - `bitnami/postgresql` Helm chart from `12.12.9` to `16.4.3`
    - `postgresql` version bumped from `15.4.0` to `17.2.0`

Please refer to the official documentation for more details:

- [bitnami/keycloak helm chart changelog](https://github.com/bitnami/charts/blob/main/bitnami/keycloak/CHANGELOG.md), [upgrade notes](https://github.com/bitnami/charts/blob/main/bitnami/keycloak/README.md#upgrading)
- [bitnami/postgresql helm chart changelog](https://github.com/bitnami/charts/blob/main/bitnami/postgresql/CHANGELOG.md), [upgrade notes](https://github.com/bitnami/charts/blob/main/bitnami/postgresql/README.md#upgrading)

> [!IMPORTANT]
> We'd prepared a brief generic upgrade guide below, however, we can not be sure it'll cover all the cases. The steps may vary depending on your configuration and deployment specifics.

1. Stop Keycloak
1. Backup Postgres database, e.g. open Postgres container shell and run (replace `PGPASSWORD` with the actual password):

    ```bash
    export PGUSER=postgres
    export PGPASSWORD=YouShouldReallyChangeThis
    export PGDUMP_DIR=/bitnami/postgresql

    pg_dumpall --clean --if-exists --load-via-partition-root --quote-all-identifiers --no-password > ${PGDUMP_DIR}/pg_dumpall-$(date '+%Y-%m-%d-%H-%M').pgdump
    ```

1. Run `helm upgrade` command with usual arguments and **new** `5.X.X` chart version, with addition of special values:
    - add values

      ```yaml
      keycloak:
        diagnosticMode:
          enabled: true
        keycloakConfigCli:
          enabled: false
        postgresql:
          diagnosticMode:
            enabled: true
      ```

    - delete `declarative-user-profile` from `keycloak.extraEnvVars.*.KC_FEATURES` if it's present
    - delete all occurrences of `bruteForceProtected` option from `keycloak.keycloakConfigCli.configuration` or `realm.yaml` file if it's present/used
    - add `"basic"` to all occurrences of `defaultClientScopes` option usage in `keycloak.keycloakConfigCli.configuration` or `realm.yaml` file if it's present/used, e.g.

        ```diff
        ...
        clientId: chatbot-ui
          name: chatbot-ui
          defaultClientScopes:
        +   - basic
            - web-origins
            - acr
            - profile
            - roles
            - email
            - dial
          optionalClientScopes:
            - address
            - phone
            - offline_access
            - microprofile-jwt
          ...
        ```

        > [!tip]
        > Find detailed information about this change in keycloak-config-cli [migration guide](https://github.com/adorsys/keycloak-config-cli/blob/b2ebdfc26c6ba289d18579295d087ec9003d553e/docs/FEATURES.md#keycloak-version-2501).
1. After `helm upgrade` is finished, open Postgres container shell and run (replace `PGPASSWORD` with the actual password):

    ```bash
    # rename old data dir
    mv /bitnami/postgresql/data /bitnami/postgresql/data_old

    # run postgres manually
    nohup /opt/bitnami/scripts/postgresql/entrypoint.sh /opt/bitnami/scripts/postgresql/run.sh > /dev/null 2>&1 &

    # restore databases from dump (replace `PGPASSWORD` with the actual password)
    export PGUSER=postgres
    export PGPASSWORD=PASSWORD_PLACEHOLDER
    export PGDUMP_DIR=/bitnami/postgresql

    psql -d postgres -f ${PGDUMP_DIR}/pg_dumpall-YYYY-MM-DD-HH-MM.pgdump
    ```

1. Run `helm upgrade` command with usual arguments, **new** `5.X.X` chart version, but without special values
    - delete values

      ```yaml
      keycloak:
        diagnosticMode:
          enabled: true
        keycloakConfigCli:
          enabled: false
        postgresql:
          diagnosticMode:
            enabled: true
      ```

1. Verify DIAL is up and running correctly

### To 4.0.0

Bumping the major version to highlight Redis upgrade in `dial-core` helm chart. No actions required, however you may want to check [Redis® 7.4 release notes](https://raw.githubusercontent.com/redis/redis/7.4/00-RELEASENOTES) and [dial-core-4.0.0 release notes](https://github.com/epam/ai-dial-helm/releases/tag/dial-core-4.0.0) for specific details.

### To 3.0.0

In this version we have to reflect `ai-dial-core` [application configuration parameters renaming](https://github.com/epam/ai-dial-core/pull/455) in version `0.15.1+` by renaming several values in this chart.

- `core.configuration.encryption.password` parameter is renamed to `core.configuration.encryption.secret`
- `core.configuration.encryption.salt` parameter is changed to `core.configuration.encryption.key`

### How to upgrade to version 3.0.0

a) If using encryption Kubernetes secret created by the chart:

1. Update the parameters you have in your current deployment values (e.g. `values.yaml` file or set via `--set`) according to the changes below:
     - `core.configuration.encryption.password` --> `core.configuration.encryption.secret`
     - `core.configuration.encryption.salt` --> `core.configuration.encryption.key`
1. Delete the `*-encryption` secret, e.g. (replace `my-release` with the actual release name):

    ```console
    kubectl delete secret my-release-dial-core-encryption
    ```

1. Proceed with the helm upgrade as usual, e.g.:

    ```console
    helm upgrade my-release dial/dial -f values.yaml
    ```

b) If using your own managed Kubernetes secret (`core.configuration.encryption.existingSecret` is set):

1. Rename keys in your existing secret:

    - `aidial.encryption.password` --> `aidial.encryption.secret`
    - `aidial.encryption.salt` --> `aidial.encryption.key`

    You can update your existing secret to rename or move the keys using the following one-liner command (replace `<your-existing-secret-name>` and `<namespace>` with the actual values):

    ```console
      kubectl get secret <your-existing-secret-name> -o yaml -n <namespace> | jq '.data["aidial.encryption.secret"] = .data["aidial.encryption.password"] | .data["aidial.encryption.key"] = .data["aidial.encryption.salt"] | del(.data["aidial.encryption.password"], .data["aidial.encryption.salt"])' | kubectl replace -f -
    ```

1. Proceed with the helm upgrade as usual, e.g.:

    ```console
    helm upgrade my-release dial/dial -f values.yaml
    ```

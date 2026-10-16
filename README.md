# dial-admin-evaluation

![Version: 0.1.14](https://img.shields.io/badge/Version-0.1.14-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0](https://img.shields.io/badge/AppVersion-0.2.0-informational?style=flat-square)

Umbrella chart for AI DIAL Admin Evaluation services

## Backups

The evaluation database is being migrated from the Bitnami `postgresql` subchart to a
CloudNativePG (CNPG) cluster. Three custom resources are passed as raw manifests through
`evaluation-backend.extraDeploy`, so Helm owns them as part of this release. The
`dial-extension` subchart runs each entry through `tpl`, so `{{ .Release.Namespace }}` and
`{{ .Release.Name }}` work inside them:

```
Cluster (*pgClusterName)
  └── plugins[].parameters.barmanObjectName ──▶ ObjectStore (*pgObjectStoreName)
ScheduledBackup (evaluation-pg-daily)
  └── cluster.name ──────────────────────────▶ Cluster
```

Those cross-references are **YAML aliases**, not repeated strings. A name mismatch between
these objects fails quietly — the plugin reports `barmanObjectName not found` and no backup
ever runs — so each shared name is declared once as an anchor on the field that owns it,
all three on the `Cluster`:

```yaml
metadata:
  name: &pgClusterName dial-admin-evaluation-pg
spec:
  plugins:
    - name: &pgPluginName barman-cloud.cloudnative-pg.io
      parameters:
        barmanObjectName: &pgObjectStoreName evaluation-pg-azure-store
```

The `ObjectStore` and `ScheduledBackup` then refer to `*pgObjectStoreName`,
`*pgClusterName` and `*pgPluginName`. Only names used more than once get an anchor;
single-use values like `destinationPath` are written inline.

Anchors resolve at YAML parse time, so what Helm renders is fully expanded — `helm template`
is the way to confirm what lands in the cluster. They are also file-scoped: an alias will
not resolve from a separate `-f overrides.yaml`, so override the whole `extraDeploy` list
if you need per-environment values.

Backups are physical base backups plus continuous WAL archiving to Azure Blob — not
`pg_dump`. Compression is set per stream: `bzip2` for base backups (highest ratio) and
`zstd` for WAL (keeps continuous archiving ahead of write load).

Before deploying, confirm the CNPG operator and Barman Cloud plugin are present — both are
owned by `aks-platform`, not by this chart:

```bash
kubectl get crd objectstores.barmancloud.cnpg.io && \
  kubectl rollout status deployment -n cnpg-system plugin-barman-cloud
```

Set these in `extraDeploy` before the first deploy. Anchored names need editing only at
their anchor; the aliases follow.

| Setting | Default | Required (Yes/No) | Description |
|---|---|---|---|
| `Cluster.spec.serviceAccountTemplate…/client-id` | `<dial-pg-native-backup client id>` | Yes | Client ID of the `dev-aks-dial-pg-native-backup` managed identity. Backups fail with 403 until this is real. |
| `ObjectStore.spec.configuration.destinationPath` | `.../postgres-backups/evaluation` | Yes | Blob container path. The `postgres-backups` container is not created by Terraform — verify it exists. |
| `Cluster.metadata.name` (`&pgClusterName`) | `dial-admin-evaluation-pg` | No | Cluster name and, by derivation, its ServiceAccount name. Changing it requires a matching federation entry in `aks-platform/dial.tf`. |
| `…parameters.barmanObjectName` (`&pgObjectStoreName`) | `evaluation-pg-azure-store` | No | `ObjectStore` name. Must stay in the same namespace as the `Cluster`. |
| `…plugins[0].name` (`&pgPluginName`) | `barman-cloud.cloudnative-pg.io` | No | Barman Cloud plugin identifier. Fixed by the plugin install. |

The cluster's ServiceAccount (`dial-admin-evaluation-pg`) must also be registered in
`aks-platform/dial.tf` under `local.dial_pg_native_backup_federations`, and that must be
applied first. Renaming the `Cluster` breaks the federated subject and therefore backups.

Migration order matters: keep `evaluation-postgresql.enabled: true` for the run that
creates the CNPG cluster, repoint `POSTGRES_META_DATASOURCE_URL` /
`POSTGRES_ANALYTICS_DATASOURCE_URL` at `dial-admin-evaluation-pg-rw:5432`, verify a
restore, and only then disable the Bitnami subchart.

Full runbook, verification commands and restore/PITR procedure:
`devops/pgnative/BACKUP.md` in the documentation repo.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | evaluation-postgresql(postgresql) | 16.7.12 |
| https://charts.dialx.ai | evaluation-metrics(dial-extension) | 3.1.1 |
| https://charts.dialx.ai | evaluation-backend(dial-extension) | 3.1.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| evaluation-backend.containerPorts.http | int | `8080` |  |
| evaluation-backend.enabled | bool | `true` |  |
| evaluation-backend.fullnameOverride | string | `"dial-admin-evaluation-backend"` |  |
| evaluation-backend.image.registry | string | `"ghcr.io"` |  |
| evaluation-backend.image.repository | string | `"epam/ai-dial-admin-evaluation-framework-backend"` |  |
| evaluation-backend.image.tag | string | `"0.2.0"` |  |
| evaluation-backend.livenessProbe.enabled | bool | `true` |  |
| evaluation-backend.livenessProbe.httpGet.path | string | `"/api/v1/health"` |  |
| evaluation-backend.readinessProbe.enabled | bool | `true` |  |
| evaluation-backend.readinessProbe.httpGet.path | string | `"/api/v1/health"` |  |
| evaluation-metrics.enabled | bool | `true` |  |
| evaluation-metrics.fullnameOverride | string | `"dial-admin-evaluation-metrics"` |  |
| evaluation-metrics.image.registry | string | `"ghcr.io"` |  |
| evaluation-metrics.image.repository | string | `"epam/ai-dial-admin-evaluation-metrics"` |  |
| evaluation-metrics.image.tag | string | `"0.1.0"` |  |
| evaluation-metrics.livenessProbe.enabled | bool | `true` |  |
| evaluation-metrics.livenessProbe.httpGet.path | string | `"/health"` |  |
| evaluation-metrics.readinessProbe.enabled | bool | `true` |  |
| evaluation-metrics.readinessProbe.httpGet.path | string | `"/health"` |  |
| evaluation-postgresql.auth.database | string | `"evaluation-framework"` |  |
| evaluation-postgresql.auth.usePasswordFiles | bool | `false` |  |
| evaluation-postgresql.enabled | bool | `true` |  |
| evaluation-postgresql.fullnameOverride | string | `"dial-admin-evaluation-postgresql"` |  |
| evaluation-postgresql.global.security.allowInsecureImages | bool | `true` |  |
| evaluation-postgresql.image.repository | string | `"bitnamilegacy/postgresql"` |  |
| evaluation-postgresql.primary.initdb.scripts."create-multiple-dbs.sql" | string | `"SELECT 'CREATE DATABASE evaluation_analytics_db'\nWHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'evaluation_analytics_db')\\gexec\n"` |  |
| evaluation-postgresql.primary.initdb.user | string | `"postgres"` |  |
| extraDeploy | list | see the Backups section above | CloudNativePG `Cluster`, `ObjectStore` and `ScheduledBackup` for the evaluation database. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

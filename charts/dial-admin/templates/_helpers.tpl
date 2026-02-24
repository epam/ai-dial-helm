{{/*
Return name for DIAL Admin backend resources
*/}}
{{- define "dialAdmin.backend.fullname" -}}
{{- printf "%s-backend" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dialAdmin.backend.serviceAccountName" -}}
{{- if .Values.backend.serviceAccount.create -}}
    {{ default (include "dialAdmin.backend.fullname" .) .Values.backend.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.backend.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified app name adding the installation's namespace.
*/}}
{{- define "dialAdmin.backend.fullname.namespace" -}}
{{- printf "%s-%s" (include "dialAdmin.backend.fullname" .) (include "common.names.namespace" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return  the proper Storage Class
*/}}
{{- define "dialAdmin.backend.storageClass" -}}
{{- include "common.storage.class" (dict "persistence" .Values.backend.persistence "global" .Values.global) -}}
{{- end -}}

{{/*
Return whether to use the external DB or the built-in subcharts
*/}}
{{- define "dialAdmin.useExternalDB" -}}
{{- if and (or .Values.externalDatabase.existingSecret .Values.externalDatabase.host) (not .Values.postgresql.enabled) -}}
  {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return whether to create an external secret containing the
credentials for the external database or not
*/}}
{{- define "dialAdmin.createExternalDBSecret" -}}
{{- if and (include "dialAdmin.useExternalDB" .) (not .Values.externalDatabase.existingSecret) -}}
  {{- true -}}
{{- end -}}
{{- end -}}

{{- define "dialAdmin.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
{{- end -}}

{{/*
Return the database host for DIAL Admin
*/}}
{{- define "dialAdmin.database.host" -}}
{{- if .Values.postgresql.enabled -}}
  {{- include "dialAdmin.postgresql.fullname" . | quote  -}}
{{- else }}
    {{- .Values.externalDatabase.host | quote }}
{{- end -}}
{{- end -}}

{{/*
Return the database port for DIAL Admin
*/}}
{{- define "dialAdmin.database.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{- print "5432" -}}
{{- else }}
    {{- .Values.externalDatabase.port }}
{{- end -}}
{{- end -}}

{{/*
Return the database name for DIAL Admin
*/}}
{{- define "dialAdmin.database.name" -}}
{{- if .Values.postgresql.enabled -}}
    {{- if .Values.global.postgresql }}
        {{- if .Values.global.postgresql.auth }}
            {{- coalesce .Values.global.postgresql.auth.database .Values.postgresql.auth.database | quote -}}
        {{- else -}}
            {{- .Values.postgresql.auth.database | quote -}}
        {{- end -}}
    {{- else -}}
        {{- .Values.postgresql.auth.database | quote -}}
    {{- end -}}
{{- else }}
    {{- .Values.externalDatabase.database | quote }}
{{- end -}}
{{- end -}}

{{/*
Return the Database user
*/}}
{{- define "dialAdmin.database.user" -}}
{{- if .Values.postgresql.enabled -}}
    {{- if .Values.global.postgresql -}}
        {{- if .Values.global.postgresql.auth -}}
            {{- coalesce .Values.global.postgresql.auth.username .Values.postgresql.auth.username -}}
        {{- else -}}
            {{- .Values.postgresql.auth.username -}}
        {{- end -}}
    {{- else -}}
        {{- .Values.postgresql.auth.username -}}
    {{- end -}}
{{- else -}}
    {{- tpl .Values.externalDatabase.user $ -}}
{{- end -}}
{{- end -}}


{{/*
Return the name of the database secret with its credentials
*/}}
{{- define "dialAdmin.database.secretName" -}}
{{- if .Values.postgresql.enabled -}}
    {{- if .Values.global.postgresql }}
        {{- if .Values.global.postgresql.auth }}
            {{- if .Values.global.postgresql.auth.existingSecret }}
                {{- tpl .Values.global.postgresql.auth.existingSecret $ -}}
            {{- else -}}
                {{- default (include "dialAdmin.postgresql.fullname" .) (tpl .Values.postgresql.auth.existingSecret $) -}}
            {{- end -}}
        {{- else -}}
            {{- default (include "dialAdmin.postgresql.fullname" .) (tpl .Values.postgresql.auth.existingSecret $) -}}
        {{- end -}}
    {{- else -}}
        {{- default (include "dialAdmin.postgresql.fullname" .) (tpl .Values.postgresql.auth.existingSecret $) -}}
    {{- end -}}
{{- else -}}
    {{- if .Values.externalDatabase.existingSecret -}}
        {{- printf "%s" .Values.externalDatabase.existingSecret -}}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) "externaldb" -}}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Add environment variables to configure database values
*/}}
{{- define "dialAdmin.database.secretKey" -}}
{{- if .Values.postgresql.enabled -}}
    {{- print "password" -}}
{{- else -}}
    {{- if .Values.externalDatabase.existingSecret -}}
        {{- if .Values.externalDatabase.existingSecretPasswordKey -}}
            {{- printf "%s" .Values.externalDatabase.existingSecretPasswordKey -}}
        {{- else -}}
            {{- print "password" -}}
        {{- end -}}
    {{- else -}}
        {{- print "password" -}}
    {{- end -}}
{{- end -}}
{{- end -}}


{{/*
Return the name of the database secret with its credentials
*/}}
{{- define "dialAdmin.backend.databaseEnv" -}}
{{- if eq .Values.backend.configuration.datasourceVendor "postgresql" -}}
- name: DATASOURCE_VENDOR
  value: "POSTGRES"
- name: POSTGRES_HOST
  value: {{ include "dialAdmin.database.host" . }}
- name: POSTGRES_PORT
  value: {{ include "dialAdmin.database.port" . | quote }}
- name: POSTGRES_DATABASE
  value: {{ include "dialAdmin.database.name" .  }}
- name: POSTGRES_DATASOURCE_USERNAME
  value: {{ include "dialAdmin.database.user" . }}
- name: POSTGRES_DATASOURCE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "dialAdmin.database.secretName" . }}
      key: {{ include "dialAdmin.database.secretKey" . }}
{{- else if and (include "dialAdmin.useExternalDB" .) (eq .Values.backend.configuration.datasourceVendor "mssql") -}}
- name: DATASOURCE_VENDOR
  value: "MS_SQL_SERVER"
- name: MS_SQL_SERVER_HOST
  value: {{ include "dialAdmin.database.host" . }}
- name: MS_SQL_SERVER_PORT
  value: {{ include "dialAdmin.database.port" . | quote }}
- name: MS_SQL_SERVER_DATABASE
  value: {{ include "dialAdmin.database.name" . }}
- name: MS_SQL_SERVER_DATASOURCE_USERNAME
  value: {{ include "dialAdmin.database.user" . }}
- name: MS_SQL_SERVER_DATASOURCE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "dialAdmin.database.secretName" . }}
      key: {{ include "dialAdmin.database.secretKey" . }}
{{- else if eq .Values.backend.configuration.datasourceVendor "h2" -}}
- name: DATASOURCE_VENDOR
  value: "H2"
- name: H2_FILE
  value: "{{ .Values.backend.persistence.mountPath }}/dial-admin.db"
{{- end -}}
{{- end -}}

{{/*
Return the namespace to the export resources
*/}}
{{- define "dialAdmin.export.namespace" -}}
  {{- if .Values.backend.configuration.export.namespace -}}
  {{- .Values.backend.configuration.export.namespace | quote -}}
  {{- else -}}
  {{- include "common.names.namespace" . | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name of the database secret with its credentials
*/}}
{{- define "dialAdmin.backend.configEnv" -}}
{{- if and .Values.backend.configuration.export.names .Values.backend.configuration.export.key -}}
- name: CONFIG_EXPORT_CREATE_RESOURCES
  value: {{ .Values.backend.configuration.export.create | quote }}
- name: KUBERNETES_CONFIG_NAMESPACE
  value: {{  include "dialAdmin.export.namespace" . }}
  {{- if eq .Values.backend.configuration.export.type "configmap" }}
- name: CONFIG_EXPORT_STORAGETYPE
  value: "CONFIG_MAP"
- name: CONFIG_EXPORT_CONFIGMAP_NAMES
  value: {{ join "," .Values.backend.configuration.export.names | quote }}
- name: CONFIG_EXPORT_CONFIGMAP_KEY
  value: {{ .Values.backend.configuration.export.key | quote }}
  {{- else if eq .Values.backend.configuration.export.type "secret" }}
- name: CONFIG_EXPORT_STORAGETYPE
  value: "KUBE_SECRET"
- name: CONFIG_EXPORT_KUBESECRET_NAMES
  value: {{ join "," .Values.backend.configuration.export.names | quote }}
- name: CONFIG_EXPORT_KUBESECRET_KEY
  value: {{ .Values.backend.configuration.export.key | quote }}
  {{- end -}}
{{- else -}}
- name: CONFIG_EXPORT_STORAGETYPE
  value: "LOCAL_FILE"
- name: CONFIG_EXPORT_OUTPUTFILE_PATH
  value: "{{ .Values.backend.persistence.mountPath }}/core-config.json"
{{- end -}}
{{- end -}}

{{/*
Return name for DIAL Admin deploymentManager resources
*/}}
{{- define "dialAdmin.deploymentManager.fullname" -}}
{{- printf "%s-deployment-manager" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified app name adding the installation's namespace.
*/}}
{{- define "dialAdmin.deploymentManager.fullname.namespace" -}}
{{- printf "%s-%s" (include "dialAdmin.deploymentManager.fullname" .) (include "common.names.namespace" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "dialAdmin.deploymentManager.serviceAccountName" -}}
{{- if .Values.deploymentManager.serviceAccount.create -}}
    {{ default (include "dialAdmin.deploymentManager.fullname" .) .Values.deploymentManager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.deploymentManager.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the database name for DIAL Admin deployment manager
*/}}
{{- define "dialAdmin.deploymentManager.database.name" -}}
{{- if .Values.postgresql.enabled -}}
    {{- .Values.deploymentManager.configuration.datasource.database | quote -}}
{{- else }}
    {{- .Values.externalDatabase.deploymentManagerDatabase | quote }}
{{- end -}}
{{- end -}}

{{/*
Return the Database user
*/}}
{{- define "dialAdmin.deploymentManager.database.user" -}}
{{- if .Values.postgresql.enabled -}}
    {{- .Values.deploymentManager.configuration.datasource.user | quote -}}
{{- else }}
    {{- .Values.externalDatabase.deploymentManagerUser | quote }}
{{- end -}}
{{- end -}}

{{/*
Return the name of the database secret with its credentials
*/}}
{{- define "dialAdmin.deploymentManager.database.password" -}}
{{- if .Values.postgresql.enabled -}}
    {{- printf "%s-%s-%s-%s-%s" (include "common.names.fullname" .) "deployment" "manager" "postgres" "secret" -}}
{{- else -}}
    {{- if .Values.externalDatabase.existingSecret -}}
        {{- printf "%s" .Values.externalDatabase.existingSecret -}}
    {{- else -}}
        {{- printf "%s-%s" (include "common.names.fullname" .) "externaldb" -}}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Add environment variables to configure database values
*/}}
{{- define "dialAdmin.deploymentManager.database.secretKey" -}}
{{- if .Values.postgresql.enabled -}}
    {{- print "password" -}}
{{- else -}}
    {{- if .Values.externalDatabase.existingSecret -}}
        {{- if .Values.externalDatabase.deploymentManagerExistingSecretPasswordKey -}}
            {{- printf "%s" .Values.externalDatabase.deploymentManagerExistingSecretPasswordKey -}}
        {{- else -}}
            {{- print "password" -}}
        {{- end -}}
    {{- else -}}
        {{- print "password" -}}
    {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the name of the database secret with its credentials
*/}}
{{- define "dialAdmin.deploymentManager.databaseEnv" -}}
{{- if eq .Values.deploymentManager.configuration.datasource.datasourceVendor "postgresql" -}}
  DATASOURCE_VENDOR: "POSTGRES"
  POSTGRES_HOST:{{ include "dialAdmin.database.host" . }}
  POSTGRES_PORT: {{ include "dialAdmin.database.port" . | quote }}
  POSTGRES_DATABASE: {{ include "dialAdmin.deploymentManager.database.name" .  }}
  POSTGRES_DATASOURCE_USERNAME: {{ include "dialAdmin.deploymentManager.database.user" . }}
  POSTGRES_DATASOURCE_PASSWORD: {{ include "dialAdmin.deploymentManager.database.password" . }}
{{- else if and (include "dialAdmin.useExternalDB" .) (eq .Values.deploymentManager.configuration.datasource.datasourceVendor "mssql") -}}
  DATASOURCE_VENDOR: "MS_SQL_SERVER"
  MS_SQL_SERVER_HOST: {{ include "dialAdmin.database.host" . }}
  MS_SQL_SERVER_PORT: {{ include "dialAdmin.database.port" . | quote }}
  MS_SQL_SERVER_DATABASE: {{ include "dialAdmin.deploymentManager.database.name" . }}
  MS_SQL_SERVER_DATASOURCE_USERNAME: {{ include "dialAdmin.deploymentManager.database.user" . }}
  MS_SQL_SERVER_DATASOURCE_PASSWORD: {{ include "dialAdmin.deploymentManager.database.password" . }}
{{- else if eq .Values.deploymentManager.configuration.datasource.datasourceVendor "h2" -}}
  DATASOURCE_VENDOR: "H2"
  H2_FILE: "{{ .Values.deploymentManager.persistence.mountPath }}/deploymentManager"
{{- end -}}
{{- end -}}

{{/*
Return the namespace to deploy knative resources
*/}}
{{- define "dialAdmin.knative.namespace" -}}
  {{- if .Values.deploymentManager.configuration.deploy.knative.enabled -}}
  {{- .Values.deploymentManager.configuration.deploy.knative.namespace | quote -}}
  {{- else -}}
  {{- include "common.names.namespace" . | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Return the namespace to deploy nim resources
*/}}
{{- define "dialAdmin.nim.namespace" -}}
  {{- if .Values.deploymentManager.configuration.deploy.nim.enabled -}}
  {{- .Values.deploymentManager.configuration.deploy.nim.namespace | quote -}}
  {{- else -}}
  {{- include "common.names.namespace" . | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Return the namespace to deploy kserve resources
*/}}
{{- define "dialAdmin.kserve.namespace" -}}
  {{- if .Values.deploymentManager.configuration.deploy.kserve.enabled -}}
  {{- .Values.deploymentManager.configuration.deploy.kserve.namespace | quote -}}
  {{- else -}}
  {{- include "common.names.namespace" . | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Return the namespace to build mcp
*/}}
{{- define "dialAdmin.deploymentManager.build.namespace" -}}
  {{- if .Values.deploymentManager.configuration.build.namespace -}}
  {{- .Values.deploymentManager.configuration.build.namespace | quote -}}
  {{- else -}}
  {{- include "common.names.namespace" . | quote -}}
  {{- end -}}
{{- end -}}

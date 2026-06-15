{{/*
Return name for backend resources
*/}}
{{- define "dialCore.names.fullname" -}}
{{- printf "%s-core" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dialCore.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "dialCore.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
{{- $messages := append $messages (include "dialCore.validateValues.foo" .) -}}
{{- $messages := append $messages (include "dialCore.validateValues.bar" .) -}}
*/}}
{{- define "dialCore.validateValues" -}}
{{- $messages := list -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Return name for logger resources
*/}}
{{- define "dialCoreLogger.names.fullname" -}}
{{- template "common.names.fullname" . -}}-logger
{{- end -}}

{{/*
Return name for encryption secret
*/}}
{{- define "dialCore.encryptionSecretName" -}}
{{- template "dialCore.names.fullname" . -}}-encryption
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Validate dial-core required passwords are not empty.

Usage:
{{ include "dialCore.values.requirePasswords" (dict "secret" "secretName" "subchart" false "context" $) }}
Params:
  - secret - String - Required. Name of the secret where dial-core values are stored, e.g: "core-encryption"
  - subchart - Boolean - Optional. Whether dial-core is used as subchart or not. Default: false
*/}}
{{- define "dialCore.values.requirePasswords" -}}
  {{- $existingSecret := include "dialCore.values.existingSecret" . -}}
  {{- $enabled := include "dialCore.values.enabled" . -}}
  {{- $authPrefix := include "dialCore.values.key.encryption" . -}}
  {{- $valueKeySecret := printf "%s.secret" $authPrefix -}}
  {{- $valueKeyKey := printf "%s.key" $authPrefix -}}

  {{- if and (or (not $existingSecret) (eq $existingSecret "\"\"")) (eq $enabled "true") -}}
    {{- $requiredPasswords := list -}}
      {{- $requiredSecret := dict "valueKey" $valueKeySecret "secret" .secret "field" "aidial.encryption.secret" -}}
      {{- $requiredPasswords = append $requiredPasswords $requiredSecret -}}
      {{- $requiredKey := dict "valueKey" $valueKeyKey "secret" .secret "field" "aidial.encryption.key" -}}
      {{- $requiredPasswords = append $requiredPasswords $requiredKey -}}
    {{- include "common.validations.values.multiple.empty" (dict "required" $requiredPasswords "context" .context) -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliary function to get the right value for existingSecret.

Usage:
{{ include "dialCore.values.existingSecret" (dict "context" $) }}
Params:
  - subchart - Boolean - Optional. Whether dial-core is used as subchart or not. Default: false
*/}}
{{- define "dialCore.values.existingSecret" -}}
  {{- if .subchart -}}
    {{- .context.Values.core.configuration.encryption.existingSecret | quote -}}
  {{- else -}}
    {{- .context.Values.configuration.encryption.existingSecret | quote -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliary function to get the right value for enabled dial-core.

Usage:
{{ include "dialCore.values.enabled" (dict "context" $) }}
*/}}
{{- define "dialCore.values.enabled" -}}
  {{- if .subchart -}}
    {{- printf "%v" .context.Values.core.enabled -}}
  {{- else -}}
    {{- printf "%v" (not .context.Values.enabled) -}}
  {{- end -}}
{{- end -}}

{{/*
Auxiliary function to get the right value for the key auth

Usage:
{{ include "dialCore.values.key.encryption" (dict "subchart" "true" "context" $) }}
Params:
  - subchart - Boolean - Optional. Whether dial-core is used as subchart or not. Default: false
*/}}
{{- define "dialCore.values.key.encryption" -}}
  {{- if .subchart -}}
    core.configuration.encryption
  {{- else -}}
    configuration.encryption
  {{- end -}}
{{- end -}}

{{/*
Return Valkey configuration for dial-core for dependency chart
*/}}
{{- define "dialCore.valkeySettings" -}}
{{- if .Values.valkey.enabled -}}
{{- $auth := .Values.valkey.auth | default dict -}}
{{- $aclUsers := $auth.aclUsers | default dict -}}
{{- $defaultUser := get $aclUsers "default" | default dict -}}
{{- $defaultPassword := get $defaultUser "password" | default "" -}}
{{- $existingSecret := $auth.usersExistingSecret | default "" -}}

- name: aidial.redis.singleServerConfig.address
  value: {{ printf "redis://%s:6379" (include "common.names.fullname" .Subcharts.valkey) | quote }}
- name: aidial.redis.singleServerConfig.username
  value: "default"

{{- if $existingSecret }}
- name: aidial.redis.singleServerConfig.password
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret | quote }}
      key: default-password
{{- else if $defaultPassword }}
- name: aidial.redis.singleServerConfig.password
  value: {{ $defaultPassword | quote }}
{{- else }}
- name: aidial.redis.singleServerConfig.password
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-auth" (include "valkey.fullname" .Subcharts.valkey) | quote }}
      key: default-password
{{- end }}

{{- end -}}
{{- end -}}
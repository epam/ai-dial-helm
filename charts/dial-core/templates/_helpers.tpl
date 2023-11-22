{{/*
Return name for backend resources
*/}}
{{- define "dialCore.names.fullname" -}}
{{- template "common.names.fullname" . -}}
{{- end -}}

{{/*
Create the labels to use
*/}}
{{- define "dialCore.labels.standard" -}}
{{- include "common.labels.standard" . }}
app.kubernetes.io/component: core
{{- end -}}

{{/*
Create the matchLabels to use
*/}}
{{- define "dialCore.labels.matchLabels" -}}
{{- include "common.labels.matchLabels" . }}
app.kubernetes.io/component: core
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
{{-   printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}

{{/*
Return name for logger resources
*/}}
{{- define "dialCoreLogger.names.fullname" -}}
{{- template "common.names.fullname" . -}}-logger
{{- end -}}

{{/*
Return name for backend resources
*/}}
{{- define "dialExtension.names.fullname" -}}
{{- template "common.names.fullname" . -}}
{{- end -}}

{{/*
Create the labels to use
*/}}
{{- define "dialExtension.labels.standard" -}}
{{- include "common.labels.standard" . }}
{{- end -}}

{{/*
Create the matchLabels to use
*/}}
{{- define "dialExtension.labels.matchLabels" -}}
{{- include "common.labels.matchLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dialExtension.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "dialExtension.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
{{- $messages := append $messages (include "dialExtension.validateValues.foo" .) -}}
{{- $messages := append $messages (include "dialExtension.validateValues.bar" .) -}}
*/}}
{{- define "dialExtension.validateValues" -}}
{{- $messages := list -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}

{{- if .Values.pdb.create }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ template "dialExtension.names.fullname" . }}
  namespace: {{ include "common.names.namespace" . | quote }}
  labels: {{ include "dialExtension.labels.standard" . | nindent 4 }}
    {{- if .Values.commonLabels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
    {{- end }}
    {{- if .Values.labels }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.labels "context" $ ) | nindent 4 }}
    {{- end }}
  {{- if or .Values.annotations .Values.commonAnnotations }}
  annotations:
    {{- if .Values.annotations }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.annotations "context" $ ) | nindent 4 }}
    {{- end }}
    {{- if .Values.commonAnnotations }}
    {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
    {{- end }}
  {{- end }}
spec:
  {{- if .Values.pdb.minAvailable }}
  minAvailable: {{ .Values.pdb.minAvailable }}
  {{- end }}
  {{- if or .Values.pdb.maxUnavailable (not .Values.pdb.minAvailable)}}
  maxUnavailable: {{ .Values.pdb.maxUnavailable | default 1 }}
  {{- end }}
  selector:
    matchLabels: {{- include "dialExtension.labels.matchLabels" . | nindent 6 }}
{{- end }}

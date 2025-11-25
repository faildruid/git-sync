{{- define "gitsync.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "gitsync.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "gitsync.labels" -}}
app.kubernetes.io/name: {{ include "gitsync.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "gitsync.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gitsync.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "gitsync.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- if .Values.serviceAccount.name -}}
{{- .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "gitsync.fullname" . | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- else -}}
default
{{- end -}}
{{- end -}}

{{- define "gitsync.envSecretName" -}}
{{- if .Values.secretEnv.secretName -}}
{{- .Values.secretEnv.secretName | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-env" (include "gitsync.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "gitsync.sshKeysSecretName" -}}
{{- if .Values.sshKeys.secretName -}}
{{- .Values.sshKeys.secretName | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-ssh-keys" (include "gitsync.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "gitsync.directoriesConfigMapName" -}}
{{- printf "%s-directories" (include "gitsync.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

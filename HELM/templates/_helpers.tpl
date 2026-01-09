{{- define "todo.name" -}}
todo-app
{{- end }}

{{- define "todo.fullname" -}}
{{ .Release.Name }}-todo
{{- end }}

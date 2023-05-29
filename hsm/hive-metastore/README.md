# Building Hive Metastore from Amommendes Repo

Link: https://github.com/amommendes/helm-hive-metastore



# Forward Hive Metastore 
1. Forward Hive Metastore running the following command:
  export POD_NAME=$(kubectl get pods --namespace {{ .Release.Namespace }} -l "app.kubernetes.io/name={{ include "hive-metastore.name" . }},app.kubernetes.io/instance={{ .Release.Name }},app={{ include "hive-metastore.name" . }}" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace {{ .Release.Namespace }} port-forward $POD_NAME 9083:9083
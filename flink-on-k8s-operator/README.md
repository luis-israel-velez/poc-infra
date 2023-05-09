https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/docs/try-flink-kubernetes-operator/quick-start/

#Once per kubernetes clusters
kubectl create -f https://github.com/jetstack/cert-manager/releases/download/v1.8.2/cert-manager.yaml


helm repo add flink-operator-repo https://downloads.apache.org/flink/flink-kubernetes-operator-1.4.0/

helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator

kubectl get pods

helm list

kubectl create -f https://raw.githubusercontent.com/apache/flink-kubernetes-operator/release-1.4/examples/basic.yaml

kubectl logs -f deploy/basic-example

kubectl port-forward svc/basic-example-rest 8081

kubectl delete flinkdeployment/basic-example

#!/bin/sh

#Simple kube state restart only applicable with Spark Pi, we can add input to make it applicable to any other job
kubectl delete --namespace=spark-operator sparkapplication spark-pi

kubectl apply -f examples/spark-pi.yaml

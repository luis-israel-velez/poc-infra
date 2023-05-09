Install options: 

#1 Download repo here: https://github.com/GoogleCloudPlatform/spark-on-k8s-operator 
	This option might be better if you want to run some Spark Examples and modify some of the permission attaching files I think will be important if you go this route. 

#2 Install Helm Chart and simply install on top of Kubernetes
	This might be better if you will simply run the poc-app provided in the other repo since it will be slimer. 
	
	helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

	helm install my-release spark-operator/spark-operator --namespace spark-operator --create-namespace




--GCP

kubectl create clusterrolebinding <user>-cluster-admin-binding --clusterrole=cluster-admin --user=<user>

helm install my-release spark-operator/spark-operator --namespace spark-operator --create-namespace --set webhook.enable=true

kubectl apply -f manifest/spark-application-rbac/spark-application-rbac.yaml

kubectl create clusterrolebinding spark-cluster-admin-binding --clusterrole=cluster-admin --serviceaccount=spark-operator:spark



--S3
aws configure --profile developer

kubectl apply =f developer.yaml

export AWS_DEFAULT_PROFILE=developer --Not sure..

#kubectl create clusterrolebinding awssp-cluster-admin-binding --clusterrole=cluster-admin

helm install my-release spark-operator/spark-operator --namespace spark-operator --create-namespace --set webhook.enable=true

kubectl apply -f manifest/spark-application-rbac/spark-application-rbac.yaml

kubectl create clusterrolebinding spark-cluster-admin-binding --clusterrole=cluster-admin --serviceaccount=spark-operator:spark


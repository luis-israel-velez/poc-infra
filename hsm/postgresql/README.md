# Installing postgresql

https://artifacthub.io/packages/helm/bitnami/postgresql

# Pre-req

1. Existing Kubernetes Cluster 
2. Right Policy Permissions, including CSI Drivers, please see poc-infra/eks/README.md for more information

# Command 

helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update

helm install my-postgresql bitnami/postgresql --version 12.5.5


To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)


To connect to your database run the following command:

    kubectl run my-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:15.3.0-debian-11-r4 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
      --command -- psql --host my-postgresql -U postgres -d postgres -p 5432

    > NOTE: If you access the container using bash, make sure that you execute "/opt/bitnami/scripts/postgresql/entrypoint.sh /bin/bash" in order to avoid the error "psql: local user with ID 1001} does not exist"

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/my-postgresql 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432








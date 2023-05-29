# Installing Hive from Amazon Linux Repo

Medium Link: https://towardsaws.com/hive-metastore-service-on-eks-5409f96f98ed





# Default Values 

postgresql:
  postgresqlUsername: hive
  postgresqlPassword: passwordhere
  postgresqlDatabase: metastore

  initdbScriptsConfigMap: hive-metastore-postgresql-init
image:
  repository: bde2020/hive
  tag: 2.3.2-postgresql-metastore
  pullPolicy: IfNotPresent

resources: {}
conf:
  hiveSite:
    hive_metastore_uris: thrift://hive-metastore:9083
    # if not set, default hive.metastore.warehouse.dir is default to: "hdfs://{{.Release.Name}}-hdfs:8020/user/hive/warehouse"
    # hive.metastore.warehouse.dir:

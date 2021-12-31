# kubeless-benchmark
Benchmark of Kubeless


# Benchmark Setup for Gcloud

Prerequisites:
- Install gcloud cli: https://cloud.google.com/sdk/docs/install
- Install kubectl: https://kubernetes.io/de/docs/tasks/tools/install-kubectl/
- Install Jquery (Remove this)

Alternative install kubectl over gcloud cli:
```
gcloud components install kubectl
```


## GKE
- create project (copy ID to config)
- create service account (admin) (copy service account keyfile path to config)
- Activate Kubelesst API: https://console.cloud.google.com/apis/library/container.googleapis.com?project=csb-kubeless-benchmark


## Kubeless Setup



#### Script
- create cluster
- clusterrole binding



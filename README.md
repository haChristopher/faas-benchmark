# kubeless-benchmark
Benchmark of Kubeless


# Benchmark Setup for Gcloud

Prerequisites:
- Install gcloud cli: https://cloud.google.com/sdk/docs/install
- Install arkade: 
```
curl -sLS https://get.arkade.dev | sudo sh
```
- Install Jquery (Remove this)
- Install faas-cli: 
```
brew install faas-cli
```

- Install maven: 
```
brew install maven
```

Alternative install kubectl over gcloud cli:
```
gcloud components install kubectl
```

Terraform
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## Terraform

```
terraform init
```


## GKE
- create project (copy ID to config)
- create service account (admin) (copy service account keyfile path to config)
- Activate Kubelesst API: https://console.cloud.google.com/apis/library/container.googleapis.com?project=csb-kubeless-benchmark


## Openfaas Setup

Check if deployment was succesfull:
```
# Forward the gateway to your machine
kubectl rollout status -n openfaas deploy/gateway
kubectl port-forward -n openfaas svc/gateway 8080:8080 &

# If basic auth is enabled, you can now log into your gateway:
PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
echo -n $PASSWORD | faas-cli login --username admin --password-stdin

faas-cli store deploy figlet
faas-cli list
```


# Ideas
- use docker container with as setup enviroment with all needed libraries
- python cli for execution (python as glue code)

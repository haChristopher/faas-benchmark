# OpenFaas Benchmark
Benchmark of OpenFaas ...


## Benchmark Setup for Gcloud

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

- Install Docker

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


## Dockerhub

All faas images are public on my dockerhub and can be used.
You can also rebuild them and ad your docker credentials here: 

....

Set rebuild_image Flag

Create your own dockerhub (https://docs.docker.com/docker-hub/)

## GKE
- create project (copy ID to config)docker login
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


## Function Docker Images
All docker images for the benchmark are available on DockerHub (https://hub.docker.com/u/hachristopher)

Example:
```
docker pull hachristopher/faas_bench_python3_simple
```

### Adding your own dockerhub 
... TODO


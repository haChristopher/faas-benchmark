#!/bin/bash

# Loading Config File
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../../config.sh"


# Create RBAC role for OpenFaas ?
kubectl create clusterrolebinding "cluster-admin-openfaas" \
    --clusterrole=cluster-admin \
    --user="$(gcloud config get-value core/account)"


# TODO alternative use Helm directly
# Install openfaas using arkade from helm chart
# arkade install openfaas
arkade install openfaas --load-balancer

# Retrieve external IP of OpenFaas
# kubectl get -n openfaas svc/gateway-external
# export OPENFAAS_URL=http://127.0.0.1:31112

# use port forwarding to access OpenFaas and deploy functions
kubectl port-forward -n openfaas svc/gateway 8080:8080 &

PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)

# Login with faas-cli
echo -n $PASSWORD | faas-cli login --username admin --password-stdin


# deploy functions here.
cd faas_func
faas-cli template pull
faas-cli deploy -f ./function2.yml 


# Create internal load balancer to access openfaas from compute engine



# docker login only for building images


# Kill port forwarding process
# pgrep kubectl | xargs kill -9
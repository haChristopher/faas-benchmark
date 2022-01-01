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
arkade install openfaas

# Retrieve external IP of OpenFaas
kubectl get -n openfaas svc/gateway-external

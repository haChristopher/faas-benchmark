#!/bin/bash

# Loading Config File
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../config.sh"


# Kubernetes Setup
echo "Setting up Kubernetes Cluster in region: ${gke_region}"
gcloud auth activate-service-account --key-file $service_account_key_file
gcloud config set project $project_name


k8s_version=$(gcloud container get-server-config --region=${gke_region} --format=json | jq -r '.validNodeVersions[0]')
echo "Using k8s_version: $k8s_version"


# Create Cluster and Setup Openfaas
gcloud container clusters create "$project_name-cluster" \
    --cluster-version=${k8s_version} \
    --zone=${gke_region} \
    --num-nodes=2 \
    --machine-type=${gke_machine_type}\
    --no-enable-cloud-logging \
    --enable-network-policy \
    --scopes=gke-default,compute-rw,storage-rw


# gcloud container clusters resize --size=2 "$project_name-cluster"


gcloud container clusters get-credentials "$project_name-cluster" -z=${gke_region}




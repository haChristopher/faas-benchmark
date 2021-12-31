#!/bin/bash

# Loading Config File
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../../config.sh"


# Kubernetes Setup
echo "Setting up Kubernetes Cluster in region: $sut_region"
gcloud auth activate-service-account --key-file $service_account_key_file
gcloud config set project $project_name


k8s_version=$(gcloud container get-server-config --region=$sut_region --format=json | jq -r '.validNodeVersions[0]')
echo "Using k8s_version: $k8s_version"

# Create Cluster and Setup Kubeless
gcloud container clusters create "$project_name-cluster" \
    --cluster-version=${k8s_version} \
    --zone="$sut_region-a" \
    --additional-zones="$sut_region-b, $sut_region-c"  \
    --num-nodes=1 \
    --machine-type=n1-standard-2 \
    --scopes=default,storage-rw


gcloud container clusters list


#kubectl create clusterrolebinding kubeless-cluster-admin --clusterrole=cluster-admin --user=<your-gke-user>
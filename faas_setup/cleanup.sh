#!/bin/bash

# Loading Config File
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/../config.sh"


# Connecting to gcloud
echo "Cleaning up Kubernetes Cluster in region: $gke_region"
gcloud auth activate-service-account --key-file $service_account_key_file
gcloud config set project $project_name


# Delete Cluster
echo "Deleting Cluster"
# Could use asynch flag
gcloud container clusters delete "$project_name-cluster" -z=${gke_region}
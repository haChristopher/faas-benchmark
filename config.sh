#!/bin/bash

####### Google Cloud Platform GKE #######
project_name="csb-kubeless-benchmark" 
service_account_key_file="/Users/Christopher/Uni/CSB/csb-kubeless-benchmark-d4a5ced18bab.json"
cluster_name=csb-kubeless-benchmark-cluster

####### GKE Cluster #######
gke_region="europe-west3-a"
gke_num_nodes=1
gke_machine_type="n1-standard-1"

####### SUT Deployment ######

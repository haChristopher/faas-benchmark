#!/bin/bash

####### Google Cloud Platform GKE #######
project_name="csb-kubeless-benchmark" 
service_account_key_file="/Users/Christopher/Uni/CSB/csb-kubeless-benchmark-d4a5ced18bab.json"
cluster_name=csb-kubeless-benchmark-cluster

####### SUT Deployment #######
sut_region=europe-west1
sut_num_nodes=1
sut_machine_type=n1-standard-2
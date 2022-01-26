

# Setup Gcloud Kubernetes Cluster
sh setup/setup.sh

# Deploy openfaas
sh setup/openfaas/deploy.sh

# Generate Test Data and split data into files
some python

# Deploy all cloud functions they can run seperately

# Install java stuff and deploy benchmark clients via java
cd benchmark-client
mvn package

ssh-keygen -b 2048 -t rsa -f ./benchmark -q -N "" -C provisioner

ssh -i benchmark provisioner@ip

# Setup terraform and move data and config files to instances
terraform plan
terraform output -json instance_ips | jq -r '.[0]'



# Python script pinging all machines and sending start command with timestamp


# Machines logging results



# Retrieve logs same python script



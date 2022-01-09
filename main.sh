

cd benchmark-client
mvn package

ssh-keygen -b 2048 -t rsa -f ./benchmark -q -N "" -C provisioner

ssh -i benchmark provisioner@ip

# Python generate and split up data into files


# Setup gcloud kubernetes cluster

# Setup terraform and move data and config files to instances
terraform plan
terraform output -json instance_ips | jq -r '.[0]'

# Python script pinging all machines and sending start command with timestamp


# Machines logging results



# Retrieve logs same python script



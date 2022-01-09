


terraform plan
terraform output -json instance_ips | jq -r '.[0]'



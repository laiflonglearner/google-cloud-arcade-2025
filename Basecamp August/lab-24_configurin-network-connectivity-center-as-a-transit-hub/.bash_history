gcloud compute networks delete default
gcloud auth list
gcloud alpha network-connectivity hubs create transit-hub    --description=Transit_hub
gcloud alpha network-connectivity spokes create bo1     --hub=transit-hub     --description=branch_office1     --vpn-tunnel=transit-to-vpc-a-tu1,transit-to-vpc-a-tu2     --region=us-east1
gcloud alpha network-connectivity spokes create bo2     --hub=transit-hub     --description=branch_office2     --vpn-tunnel=transit-to-vpc-b-tu1,transit-to-vpc-b-tu2     --region=us-west2
ping -c 5 10.20.10.2
ping -c 5 35.237.50.62
ping -c 5 34.94.150.80

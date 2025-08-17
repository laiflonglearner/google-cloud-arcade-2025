gcloud services enable compute.googleapis.com
gcloud services enable dns.googleapis.com
gcloud services list | grep -E 'compute|dns'
gcloud compute firewall-rules create fw-default-iapproxy --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:22,icmp --source-ranges=35.235.240.0/20
gcloud compute firewall-rules create allow-http-traffic --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server
gcloud compute instances create us-client-vm --machine-type e2-micro --zone us-central1-c
gcloud compute instances create europe-client-vm --machine-type e2-micro --zone europe-west1-b
gcloud compute instances create asia-client-vm --machine-type e2-micro --zone asia-southeast1-c
gcloud compute instances create us-web-vm --zone=us-central1-c --machine-type=e2-micro --network=default --subnet=default --tags=http-server --metadata=startup-script='#! /bin/bash
 apt-get update
 apt-get install apache2 -y
 echo "Page served from: us-central1" | \
 tee /var/www/html/index.html
 systemctl restart apache2'
gcloud compute instances create europe-web-vm --zone=europe-west1-b --machine-type=e2-micro --network=default --subnet=default --tags=http-server --metadata=startup-script='#! /bin/bash
 apt-get update
 apt-get install apache2 -y
 echo "Page served from: europe-west1" | \
 tee /var/www/html/index.html
 systemctl restart apache2'
export US_WEB_IP=$(gcloud compute instances describe us-web-vm --zone=us-central1-c --format="value(networkInterfaces.networkIP)")
export EUROPE_WEB_IP=$(gcloud compute instances describe europe-web-vm --zone=europe-west1-b --format="value(networkInterfaces.networkIP)")
gcloud dns managed-zones create example --description=test --dns-name=example.com --networks=default --visibility=private
gcloud dns record-sets create geo.example.com --ttl=5 --type=A --zone=example --routing-policy-type=GEO --routing-policy-data="us-central1=$US_WEB_IP;europe-west1=$EUROPE_WEB_IP"
gcloud dns record-sets list --zone=example

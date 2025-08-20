gcloud config set dataproc/region us-east4
PROJECT_ID=$(gcloud config get-value project) && gcloud config set project $PROJECT_ID
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
gcloud projects add-iam-policy-binding $PROJECT_ID   --member=serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com   --role=roles/storage.admin
gcloud compute networks subnets update default --region=us-east4  --enable-private-ip-google-access
gcloud dataproc clusters create example-cluster --worker-boot-disk-size 500 --worker-machine-type=e2-standard-4 --master-machine-type=e2-standard-4
gcloud dataproc jobs submit spark --cluster example-cluster   --class org.apache.spark.examples.SparkPi   --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000
gcloud dataproc clusters update example-cluster --num-workers 4
gcloud dataproc clusters update example-cluster --num-workers 2

gcloud config set project qwiklabs-gcp-03-adae6c27e942
gcloud config set run/region us-west1
gcloud services enable secretmanager.googleapis.com run.googleapis.com artifactregistry.googleapis.com
gcloud secrets create arcade-secret --replication-policy=automatic
echo -n "t0ps3cr3t!" | gcloud secrets versions add arcade-secret --data-file=-
cat << EOF > app.py

import os
from flask import Flask, jsonify, request
from google.cloud import secretmanager
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)

# Initialize Secret Manager client
# The client will automatically use the service account credentials of the Cloud Run service
secret_manager_client = secretmanager.SecretManagerServiceClient()

# Hardcoded Project ID and Secret ID as per your request
PROJECT_ID = "qwiklabs-gcp-03-adae6c27e942" # Project ID
SECRET_ID = "arcade-secret"   # Secret Identifier

@app.route('/')
def get_secret():
    """
    Retrieves the specified secret from Secret Manager and returns its payload.
    The SECRET_ID and PROJECT_ID are now hardcoded in the application.
    """
    if not SECRET_ID or not PROJECT_ID:
        logging.error("SECRET_ID or PROJECT_ID not configured (should be hardcoded).")
        return jsonify({"error": "Secret ID or Project ID not configured."}), 500

    secret_version_name = f"projects/{PROJECT_ID}/secrets/{SECRET_ID}/versions/latest"

    try:
        logging.info(f"Accessing secret: {secret_version_name}")
        # Access the secret version
        response = secret_manager_client.access_secret_version(request={"name": secret_version_name})
        secret_payload = response.payload.data.decode("UTF-8")

        # IMPORTANT: In a real application, you would process or use the secret
        # here, not return it directly in an HTTP response, especially if the
        # secret is sensitive. This example is for demonstration purposes only.
        return jsonify({"secret_id": SECRET_ID, "secret_value": secret_payload})

    except Exception as e:
        logging.error(f"Failed to retrieve secret '{SECRET_ID}': {e}")
        return jsonify({"error": f"Failed to retrieve secret: {str(e)}"}), 500

if __name__ == '__main__':
    # When running locally, Flask will use the hardcoded values directly.
    # In Cloud Run, these values are used without needing environment variables.
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))

EOF

cat << EOF > requirements.txt

Flask==3.*
google-cloud-secret-manager==2.*

EOF

#Dockerfile example for simple Python Flask app
cat << EOF > Dockerfile

FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "app.py"]

EOF

gcloud artifacts repositories create arcade-images --repository-format=docker --location=us-west1 --description="Docker repository"
docker build -t us-west1-docker.pkg.dev/qwiklabs-gcp-03-adae6c27e942/arcade-images/arcade-secret:latest .
docker run --rm -p 8080:8080 us-west1-docker.pkg.dev/qwiklabs-gcp-03-adae6c27e942/arcade-images/arcade-secret:latest
docker push us-west1-docker.pkg.dev/qwiklabs-gcp-03-adae6c27e942/arcade-images/arcade-secret:latest
gcloud iam service-accounts create arcade-service   --display-name="Arcade Service Account"   --description="Service account for Cloud Run application"
gcloud secrets add-iam-policy-binding arcade-secret --member="serviceAccount:arcade-service@qwiklabs-gcp-03-adae6c27e942.iam.gserviceaccount.com" --role="roles/secretmanager.secretAccessor"
gcloud run deploy arcade-service   --image=us-west1-docker.pkg.dev/qwiklabs-gcp-03-adae6c27e942/arcade-images/arcade-secret:latest   --region=us-west1   --set-secrets SECRET_ENV_VAR=arcade-secret:latest   --service-account arcade-service@qwiklabs-gcp-03-adae6c27e942.iam.gserviceaccount.com   --allow-unauthenticated
gcloud run services describe arcade-service --region=us-west1 --format='value(status.url)'
curl $(gcloud run services describe arcade-service --region=us-west1 --format='value(status.url)') | jq

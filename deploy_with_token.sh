#!/bin/bash

# Set your domain and account ID
DOMAIN="dicklancube"
DOMAIN_OWNER="920492683353"

echo "Fetching CodeArtifact auth token..."
TOKEN=$(aws codeartifact get-authorization-token --domain $DOMAIN --domain-owner $DOMAIN_OWNER --query authorizationToken --output text)

if [ -z "$TOKEN" ]; then
  echo "Failed to get authorization token."
  exit 1
fi

# Export token so Maven can use it
export CODEARTIFACT_AUTH_TOKEN=$TOKEN
echo "Token exported. Running mvn deploy..."

# Run your Maven deploy
mvn deploy

# Unset token for security
unset CODEARTIFACT_AUTH_TOKEN


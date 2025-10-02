#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
APP_NAME="sample-app"
DOCKER_REGISTRY="localhost:5000"
DEPLOYMENT_ENV=${1:-"staging"}

echo -e "${YELLOW}Starting deployment to ${DEPLOYMENT_ENV}...${NC}"

# Pull latest image
IMAGE_TAG="${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_NUMBER:-latest}"
echo -e "${YELLOW}Pulling image: ${IMAGE_TAG}${NC}"
docker pull $IMAGE_TAG

# Stop and remove existing container
echo -e "${YELLOW}Stopping existing containers...${NC}"
docker-compose down || true

# Start new container
echo -e "${YELLOW}Starting new container...${NC}"
docker-compose up -d

# Health check
echo -e "${YELLOW}Performing health check...${NC}"
sleep 30
for i in {1..10}; do
    if curl -f http://localhost:3000/health >/dev/null 2>&1; then
        echo -e "${GREEN}Health check passed!${NC}"
        break
    else
        echo -e "${YELLOW}Health check attempt ${i} failed, retrying...${NC}"
        sleep 10
    fi
    if [ $i -eq 10 ]; then
        echo -e "${RED}Health check failed after 10 attempts${NC}"
        exit 1
    fi
done

echo -e "${GREEN}Deployment completed successfully!${NC}"

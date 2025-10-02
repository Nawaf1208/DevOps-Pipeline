#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting rollback...${NC}"

# Get previous working image
PREVIOUS_IMAGE=$(docker images --filter "reference=localhost:5000/sample-app" --format "{{.Tag}}" | grep -v latest | sort -r | head -2 | tail -1)

if [ -z "$PREVIOUS_IMAGE" ]; then
    echo -e "${RED}No previous image found for rollback${NC}"
    exit 1
fi

echo -e "${YELLOW}Rolling back to image tag: ${PREVIOUS_IMAGE}${NC}"

# Update docker-compose with previous image
sed -i "s/image: localhost:5000\/sample-app:.*/image: localhost:5000\/sample-app:${PREVIOUS_IMAGE}/" docker-compose.yml

# Redeploy
docker-compose down
docker-compose up -d

echo -e "${GREEN}Rollback completed successfully to tag: ${PREVIOUS_IMAGE}${NC}"

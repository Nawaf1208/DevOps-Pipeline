#!/bin/bash

echo "Stopping all DevOps-Pipeline containers..."
docker compose down

echo "Removing unused Docker networks and volumes..."
docker network prune -f
docker volume prune -f

echo "Cleaning up dangling images to save space..."
docker image prune -f

echo "Project environment is now clean."
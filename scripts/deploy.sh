#!/bin/bash
# -------------------------------------------------------------------
# Project: DevOps Task Manager
# Component: Deployment Automation
# Author: Sachin C S
# -------------------------------------------------------------------

# Check if Docker daemon is running
if ! docker info > /dev/null 2>&1; then
    echo "[ERROR] Docker daemon is not running. Please start Docker Desktop and try again."
    exit 1
fi

echo "========================================"
echo "[PIPELINE] STAGE: DEPLOYMENT (DOCKER COMPOSE)"
echo "========================================"

cd "$(dirname "$0")/../docker"

# Stop existing containers
docker-compose down

# Start the stack
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Application Stack is healthy."
    echo "[INFO] Frontend: http://localhost"
    echo "[INFO] Backend:  http://localhost:8081"
else
    echo "[ERROR] Deployment failed."
    exit 1
fi

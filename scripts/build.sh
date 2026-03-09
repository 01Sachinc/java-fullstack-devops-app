#!/bin/bash
# -------------------------------------------------------------------
# Project: DevOps Task Manager
# Component: Build Automation
# Author: Sachin C S
# -------------------------------------------------------------------

echo "========================================"
echo "[PIPELINE] STAGE: MAVEN BUILD (BACKEND)"
echo "========================================"

cd "$(dirname "$0")/../backend"

# Run Maven clean install
mvn clean install -DskipTests

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Maven build successful."
else
    echo "[ERROR] Maven build failed."
    exit 1
fi

echo "========================================"
echo "[PIPELINE] STAGE: DOCKER IMAGE BUILD"
echo "========================================"

docker build -t task-manager-backend:latest .

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Docker image tagged: task-manager-backend:latest"
else
    echo "[ERROR] Docker build failed."
    exit 1
fi

#!/bin/bash

# Configuration variables
CONTAINER_NAME="webapp"
# Update username to match Docker Hub
IMAGE_NAME="01sachinc/webapp:latest"
PORT="80"

echo "Checking if container $CONTAINER_NAME exists..."

# Check if container exists
if [ "$(docker ps -a -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Container $CONTAINER_NAME exists. Stopping and removing..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
else
    echo "Container $CONTAINER_NAME does not exist."
fi

echo "Running new container..."
docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME

echo "Deployment successful. The static web app is now running on port $PORT."

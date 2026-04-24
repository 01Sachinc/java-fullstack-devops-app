pipeline {
    agent any

    environment {
        // Docker Hub account
        DOCKER_USER = "01sachinc"
        IMAGE_NAME = "${DOCKER_USER}/taskmanager-frontend"
        CONTAINER_NAME = "nginx-frontend-container"
        
        // This expects credentials named 'docker-hub-credentials' in Jenkins
        DOCKER_HUB_CREDS = credentials('docker-hub-credentials') 
    }

    stages {
        stage('Pull the source code from GitHub') {
            steps {
                // Pulls from the main branch of your repo
                git branch: 'main', url: 'https://github.com/01Sachinc/java-fullstack-devops-app.git'
            }
        }

        stage('Build the image') {
            steps {
                dir('frontend') {
                    // Stage 1: Build the image
                    sh "docker build -t ${IMAGE_NAME}:temp-build ."
                }
            }
        }

        stage('Change the tag name of Docker Image') {
            steps {
                // Stage 2: Change the tag name
                sh "docker tag ${IMAGE_NAME}:temp-build ${IMAGE_NAME}:latest"
            }
        }

        stage('Do docker login for docker hub') {
            steps {
                // Stage 3: Do docker login for docker hub
                sh 'echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin'
            }
        }

        stage('Push docker image to docker hub') {
            steps {
                // Stage 4: Push docker image to docker hub
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }

        stage('Run the container') {
            steps {
                // Stage 5: Run the container. If present, remove and run new. If not, run directly.
                sh """
                    if [ "\$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
                        echo "Container exists. Removing it..."
                        docker rm -f ${CONTAINER_NAME}
                    fi
                    echo "Running new container..."
                    docker run -d -p 80:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest
                """
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
    }
}

pipeline {
    agent any
    
    environment {
        // Use credentials securely configured in Jenkins
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')
        IMAGE_NAME = "webapp"
        // Ensure this matches your actual Docker Hub username
        DOCKERHUB_USERNAME = "01sachinc"
        DOCKER_IMAGE = "${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
    }
    
    stages {
        stage('Pull Source Code') {
            steps {
                echo 'Pulling source code from GitHub...'
                git url: 'https://github.com/01Sachinc/java-fullstack-devops-app.git', branch: 'main'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }
        
        stage('Tag Docker Image') {
            steps {
                echo 'Tagging Docker Image...'
                sh 'docker tag ${IMAGE_NAME} ${DOCKER_IMAGE}'
            }
        }
        
        stage('Docker Login') {
            steps {
                echo 'Logging into Docker Hub...'
                // Using Jenkins credentials securely, without hardcoding password
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        
        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker Image to Docker Hub...'
                sh 'docker push ${DOCKER_IMAGE}'
            }
        }
        
        stage('Deploy Container') {
            steps {
                echo 'Deploying Container on EC2...'
                sh '''
                    chmod +x deploy.sh
                    ./deploy.sh
                '''
            }
        }
    }
}

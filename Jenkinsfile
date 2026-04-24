pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'myregistry'
        BACKEND_IMAGE = "${DOCKER_REGISTRY}/taskmanager-backend"
        FRONTEND_IMAGE = "${DOCKER_REGISTRY}/taskmanager-frontend"
        IMAGE_TAG = "latest"
    }

    tools {
        maven 'Maven-3' 
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend (Maven)') {
            steps {
                dir('backend') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Docker Build Backend') {
            steps {
                dir('backend') {
                    script {
                        docker.build("${BACKEND_IMAGE}:${IMAGE_TAG}")
                    }
                }
            }
        }

        stage('Docker Build Frontend') {
            steps {
                dir('frontend') {
                    script {
                        docker.build("${FRONTEND_IMAGE}:${IMAGE_TAG}")
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Successfully built Java project and Dockerized the application!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

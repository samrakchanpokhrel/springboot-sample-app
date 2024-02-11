pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY_CREDENTIALS = 'docker_hub_login'
        DOCKER_IMAGE_NAME = 'samrakchanpokhrel/springbootproject'
        DOCKERFILE_PATH = 'Dockerfile'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/samrakchanpokhrel/springboot-sample-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}", "--file ${DOCKERFILE_PATH} .")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDENTIALS}", usernameVariable: 'DOCKER_REGISTRY_USERNAME', passwordVariable: 'DOCKER_REGISTRY_PASSWORD')]) {
                        docker.withRegistry('https://your-docker-registry.com', "${DOCKER_REGISTRY_USERNAME}", "${DOCKER_REGISTRY_PASSWORD}") {
                            docker.image("${DOCKER_IMAGE_NAME}").push()
                        }
                    }
                }
            }
        }
    }
}

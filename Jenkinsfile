pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                // Checkout your source code
                checkout scm
                
                // Build Docker image
                script {
                    docker.build("samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        // Push Docker image to Docker Hub
                        docker.image("samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                script {
                    def prod_ip = 'production_ip'
                    def username = 'ssh_username'

                    // Use SSH agent credentials configured in Jenkins
                    sshagent(credentials: ['ssh_cred']) {
                        // SSH into remote server and run Docker commands
                        sh """
                            ssh ${username}@${prod_ip} '
                                docker pull samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER} &&
                                docker stop springbootproject &&
                                docker rm springbootproject &&
                                docker run --restart always --name springbootproject -p 8080:8080 -d samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}
                            '
                        """
                    }
                }
            }
        }
    }
}

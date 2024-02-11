pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/springboot.zip'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("samrakchanpokhrel/springbootproject")
                    app.inside {
                        sh 'echo $(curl localhost:8080)'
                    }
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
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
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
                    // Use SSH agent credentials configured in Jenkins
                    sshagent(credentials: ['3.237.84.237']) {
                        // SSH into remote server and run Docker commands
                        sh '''
                            ssh ec2-user@3.237.84.237 'docker pull samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}'
                            ssh ec2-user@3.237.84.237 'docker stop springbootproject'
                            ssh ec2-user@3.237.84.237 'docker rm springbootproject'
                            ssh ec2-user@3.237.84.237 'docker run --restart always --name train-schedule -p 8080:8080 -d samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}'
                        '''
                    }
                }
            }
        }
    }
}
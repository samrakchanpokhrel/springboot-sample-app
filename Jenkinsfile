// pipeline {
//     agent any
//     stages {
//         stage('Build Docker Image') {
//             when {
//                 branch 'master'
//             }
//             steps {
//                 // Checkout your source code
//                 checkout scm
                
//                 // Build Docker image
//                 script {
//                     docker.build("samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}")
//                 }
//             }
//         }
//         stage('Push Docker Image') {
//             when {
//                 branch 'master'
//             }
//             steps {
//                 script {
//                     docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
//                         // Push Docker image to Docker Hub
//                         docker.image("samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}").push()
//                     }
//                     }
//                 }
//             }
//         }
//         stage('DeployToProduction') {
//             when {
//                 branch 'master'
//             }
//             steps {
//                 script {
//                     // Use SSH agent credentials configured in Jenkins
//                     sshagent(credentials: ['3.237.84.237']) {
//                         // SSH into remote server and run Docker commands
//                         sh '''
//                             ssh ec2-user@3.237.84.237 'docker pull samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}'
//                             ssh ec2-user@3.237.84.237 'docker stop springbootproject'
//                             ssh ec2-user@3.237.84.237 'docker rm springbootproject'
//                             ssh ec2-user@3.237.84.237 'docker run --restart always --name train-schedule -p 8080:8080 -d samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}'
//                         '''
//                     }
//                 }
//             }
//         }
//     }
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
                // script {
                docker.build("samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}")
                // }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker_hub_login') {
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
                    // Use SSH agent credentials configured in Jenkins
                    sshagent(credentials: ['3.237.84.237']) {
                        // SSH into remote server and run Docker commands
                        sh '''
                            ssh ubuntu@52.207.81.94 'docker pull samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}'
                            ssh ubuntu@52.207.81.94 'docker stop springbootproject'
                            ssh ubuntu@52.207.81.94 'docker rm springbootproject'
                            ssh ubuntu@52.207.81.94 'docker run --restart always --name springbootproject -p 8080:8080 -d samrakchanpokhrel/springbootproject:${env.BUILD_NUMBER}'
                        '''
                    }
                }
            }
        }
    }
}

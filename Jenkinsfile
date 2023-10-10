pipeline {
    agent any


    tools {
        maven "maven"
    }


    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/apotitech/JF-study'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean install package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Define the Docker image name and tag
                    def imageName = 'my-maven-webapp' // apotieri/my-maven-webapp
                    def imageTag = 'latest'

                    // Build the Docker image
                    sh "docker build -t ${imageName}:${imageTag} ."
                }
            }
        }
        stage('Login and Push Docker Image') {
            steps {
                script {
                    // Define the Docker image name and tag
                    def imageName = 'my-maven-webapp'
                    def imageTag = 'latest'

                    withCredentials([usernamePassword(credentialsId: 'DHID', passwordVariable: 'PWD_DOCKER', usernameVariable: 'USER_DOCKER')]) {
                        sh "docker login -u $USER_DOCKER -p $PWD_DOCKER"
                        sh "docker tag my-maven-webapp $USER_DOCKER/my-maven-webapp"
                        sh "docker push $USER_DOCKER/my-maven-webapp"
                    
                    }
                    
                }
            }
        } 
    }
}

pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Define the Docker image name and tag
                    def imageName = 'my-centos-webapp' // apotieri/my-centos-webapp
                    def imageTag = 'latest'

                    // Create a Dockerfile
                    writeFile file: 'Dockerfile', text: '''
                        FROM centos:7
                        RUN yum update -y
                        RUN yum install -y finger httpd
                        EXPOSE 80
                        CMD ["httpd", "-D", "FOREGROUND"]
                    '''

                    // Build the Docker image
                    sh "docker build -t ${imageName}:${imageTag} ."
                }
            }
        }
        stage('Login and Push Docker Image') {
            steps {
                script {
                    // Define the Docker image name and tag
                    def imageName = 'my-centos-webapp'
                    def imageTag = 'latest'

                    withCredentials([usernamePassword(credentialsId: 'DHID', passwordVariable: 'PWD_DOCKER', usernameVariable: 'USER_DOCKER')]) {
                        sh "docker login -u $USER_DOCKER -p $PWD_DOCKER"
                        sh "docker tag my-centos-webapp $USER_DOCKER/my-centos-webapp"
                        sh "docker push $USER_DOCKER/my-centos-webapp"
                    
                    }
                    
                }
            }
        } 
    }
}

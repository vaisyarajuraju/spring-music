pipeline {
    environment {
        registry = "harbor.dell.local/library"
        registryCredential = 'harbor'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Cloning our Git') {
            steps {
                git branch: 'main', credentialsId: '10af89be-b6aa-4e52-9a62-56bda0524dee', url: 'https://github.com/vaisyarajuraju/spring-music.git'
              
                sh "./gradlew sonarqube"
                 
            }           
        }
        stage('Building our image') {
            steps{
                script {
                    dockerImage = docker.build registry + "/spring-music:$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy our image') {
            steps{
                script {
                    docker.withRegistry( 'https://harbor.dell.local/library', 'harbor' ) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry/spring-music:$BUILD_NUMBER"
            }
        }
    }
}

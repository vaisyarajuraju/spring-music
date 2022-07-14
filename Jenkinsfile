pipeline {
    environment {
        registry = "harbor.dell.local/library"
        registryCredential = 'harbor'
        dockerImage = ''
    }
   /*
    agent {
        kubernetes {
            containerTemplate {
                 name 'trivy'
                 image 'aquasec/trivy:0.21.1'
                 command 'sleep'
                 args 'infinity'
            }
        }
    }
    */
    stages {
        stage('Cloning our Git') {
            steps {
                git branch: 'main', credentialsId: '10af89be-b6aa-4e52-9a62-56bda0524dee', url: 'https://github.com/vaisyarajuraju/spring-music.git'
              
                // sh "./gradlew sonarqube"
                 
            }           
        }
        stage('Building our image') {
            steps{
                script {
                    dockerImage = docker.build registry + "/spring-music:$BUILD_NUMBER"
                }
            }
        }
        stage('Scan'){
            //steps{
             //  sh 'trivy spring-music:$BUILD_NUMBER'
             //   sh 'trivy --no-progress --exit-code 1 --severity HIGH,CRITICAL spring-music:$BUILD_NUMBER'
          //  }
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

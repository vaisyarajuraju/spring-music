pipeline {
    environment {
        registry = "harbor.dell.local/library"
        registryCredential = 'harbor'
        dockerImage = ''
    }
    agent any
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
        stage('Push to Harbor') {
            steps{
                script {
                    docker.withRegistry( 'https://harbor.dell.local/library', 'harbor' ) {
                    dockerImage.push()
                    }
                }
            }
        }        
        stage('Scan'){
            steps{
               sh 'trivy image '+registry + "/spring-music:$BUILD_NUMBER"
             //   sh 'trivy --no-progress --exit-code 1 --severity HIGH,CRITICAL spring-music:$BUILD_NUMBER'
            }
        }
        
        stage('validate')
        {
            steps{
                sh '/home/admin/citi-poc/kube-score score openshift-export.yaml'
            }
        }
        

        stage('Deploy to Openshift') {
            steps{
                script {
                   kubernetesDeploy(configs: "deploymentservice.yaml", kubeconfigId: "kubernetes")
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

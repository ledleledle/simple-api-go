pipeline {
  environment {
    dockerimagename = "leon0408/go-simple-api"
    dockerImage = ""
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git 'git@github.com:ledleledle/simple-api-go.git'
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
    stage('Pushing Image') {
      environment {
               registryCredential = 'docker-hub-creds'
        }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }
    stage('Deploying Go container to Kubernetes') {
      steps {
        sh('kubectl apply -f deployment.yaml')
        sh('kubectl apply -f service.yaml')
      }
    }
  }
}
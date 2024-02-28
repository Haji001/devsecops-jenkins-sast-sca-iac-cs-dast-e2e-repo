pipeline {
  agent any
  tools {
    maven 'MAVEN_3.9.6'
  }

  stages {
    stage('Test Maven') {
      steps {
        sh 'mvn --version'
      }
    }
    stage('Comple and Run SonarQube Analysis') {
      steps {
        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
          sh 'echo $SONAR_TOKEN'
      }
    }
    
}


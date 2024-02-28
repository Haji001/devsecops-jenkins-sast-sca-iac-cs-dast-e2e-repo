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
  }
}

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

        stage('Complete and Run SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                    sh "mvn -Dmaven.test.failure.ignore verify sonar:sonar -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=webgoat -Dsonar.host.url=http://localhost:9000/"
                }
            }
        }
    }
}

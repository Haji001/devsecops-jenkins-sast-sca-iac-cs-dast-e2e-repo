pipeline {
  agent any
  tools {
    maven 'Maven'
  }

  stages {
    stage('CompileandRunSonarAnalysis') {
      steps {
        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
          script {
            try {
              sh """
                mvn -Dmaven.test.failure.ignore verify sonar:sonar \
                  -Dsonar.login=$SONAR_TOKEN \
                  -Dsonar.projectKey=devsecops074_devsecops-jenkins-sast-sca-iac-cs-dast-e2e-repo \
                  -Dsonar.organization=devsecops074 \
                  -Dsonar.host.url=https://sonarcloud.io
              """
            } catch (err) {
              echo "Warning: SonarCloud analysis failed - ${err.getMessage()}"
              echo "Check your SonarCloud configuration."
            }
          }
        }
      }
    }
    stage('Build') {
      steps {
        withDockerRegistry([credentialsId: "DOCKER_LOGIN", url: "https://index.docker.io/v1/"]) {
          script {
            app = docker.build("devsecopsguru/testeb:001", ".")
          }
        }
      }
    }
    stage('RunContainerScan') {
      steps {
        withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
          script {
            try {
              sh("snyk container test devsecopsguru/testeb:001 --file=Dockerfile --severity-threshold=high")
            } catch (err) {
              echo err.getMessage()
            }
          }
        }
      }
    }
    stage('RunSnykSCA') {
      steps {
        withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
          sh("mvn snyk:test -fn")
        }
      }
    }
    stage('RunDASTUsingZAP') {
      steps {
        sh("/Applications/ZAP.app/Contents/Java/zap.sh -port 9393 -cmd -quickurl https://www.example.com -quickprogress -quickout ./Output.html")
      }
    }

    stage('checkov') {
      steps {
        sh("checkov -s -f main.tf")
      }
    }

  }
}

pipeline {
  agent any
  stages {
    stage('checkout project') {
      steps {
        checkout scm
      }
    }
    stage('Test') {
      steps {
        sh 'mvn cobertura:cobertura test'
      }
    }
    stage('Report') {
      parallel {
        stage('Report') {
          steps {
            junit 'target/surefire-reports/*.xml'
          }
        }
        stage('Coverage') {
          steps {
            cobertura(coberturaReportFile: 'target/site/cobertura/coverage.xml')
          }
        }
      }
    }
    stage('Package') {
      steps {
        sh 'mvn package'
      }
    }
    stage('Target') {
      steps {
        archiveArtifacts 'target/*.jar'
      }
    }
    stage('Deploy') {
      steps {
        sh 'make deploy-default'
      }
    }
  }
  post {
    always {
      echo 'I will always say Hello again!'

    }

    success {
      echo 'success!'

    }

    failure {
      echo 'failure!'

    }

  }
}
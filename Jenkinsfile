pipeline {
  agent any
  stages {
    stage('checkout project') {
      steps {
        checkout scm
      }
    }
    stage('test') {
      steps {
        sh 'mvn cobertura:cobertura test'
      }
    }
    stage('Report') {
      parallel {
        stage('Report') {
          steps {
            junit 'target/surefire-reports/*.xml'
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
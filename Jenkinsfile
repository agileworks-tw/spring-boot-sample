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
    stage('report') {
      parallel {
        stage('report') {
          steps {
            junit 'target/surefire-reports/*.xml'
          }
        }
        stage('converge') {
          steps {
            cobertura(coberturaReportFile: 'target/site/cobertura/coverage.xml')
          }
        }
      }
    }
    stage('package') {
      steps {
        archiveArtifacts 'mvn package'
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
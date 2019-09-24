pipeline {
  agent any
  stages {
    stage('checkout project') {
      steps {
        checkout scm
      }
    }
    stage('build docker image') {
      steps {
        sh 'make build-docker-env'
      }
    }
    stage('run test') {
      steps {
        sh 'docker-compose run --rm test'
      }
    }
    stage('run package') {
      parallel {
        stage('run package') {
          steps {
            sh 'docker-compose run --rm package'
          }
        }
        stage('reporting') {
          steps {
            junit '**/target/surefire-reports/TEST-*.xml'
          }
        }
      }
    }
    stage('build prod image') {
      parallel {
        stage('build prod image') {
          steps {
            sh 'make build-docker-prod-image'
          }
        }
        stage('archive') {
          steps {
            archiveArtifacts '**/target/*.jar'
          }
        }
      }
    }
    stage('run prod') {
      steps {
        sh 'make deploy-production-local'
      }
    }
  }
  post {
    always {
      echo 'I will always say Hello again!'
      sh 'docker-compose run clean'

    }

    success {
      echo 'success!'

    }

    failure {
      echo 'failure!'

    }

  }
}
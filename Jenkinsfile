pipeline {
  agent any
  stages {
    stage('checkout project&test') {
      steps {
        checkout scm
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
        stage('coverge') {
          steps {
            cobertura(coberturaReportFile: 'target/site/cobertura/coverage.xml')
          }
        }
      }
    }
    
        stage('wait for confirm') {
        input {
            message "Should we deploy?"
            ok "Yes, we should."
            submitter "admin"
            parameters {
                string(name: 'PERSON', defaultValue: 'Mr Breezy', description: 'Who should I say hello to?')
            }
        }
        steps {
            echo "Hello, ${PERSON}, nice to meet you."
        }
    }  

    
    stage('mvn command') {
      steps {
        sh 'mvn package'
      }
    }
    stage('archive') {
      steps {
        archiveArtifacts ' target/*.jar'
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
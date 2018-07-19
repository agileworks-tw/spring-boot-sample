pipeline {
  agent any
  stages {
    stage('checkout project&test') {
      steps {
        checkout scm
        sh 'docker run -v `pwd`:/app -v $HOME/.m2:/root/.m2 -w /app localhost:5000/maven mvn cobertura:cobertura test'
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
        message 'Should we deploy?'
        id 'Yes, we should.'
        submitter 'admin'
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
        sh 'docker run -v `pwd`:/app -v  $HOME/.m2:/root/.m2 -w /app -p 8800:8000 localhost:5000/maven mvn package'
      }
    }
    stage('archive') {
      steps {
        archiveArtifacts ' target/*.jar'
      }
    }
    stage('deploy') {
      steps {
        sh '''docker build -t localhost:5000/spring-boot-sample-prod ./
docker push localhost:5000/spring-boot-sample-prod
docker pull localhost:5000/spring-boot-sample-prod
docker run -d -p 8800:8000 localhost:5000/spring-boot-sample-prod
'''
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
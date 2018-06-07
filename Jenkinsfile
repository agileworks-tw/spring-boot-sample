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
        sh 'docker run -v `pwd`:/app -v $HOME/.m2:/root/.m2 -w /app localhost:5000/maven mvn cobertura:cobertura test'
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
        sh 'docker run -v `pwd`:/app -v  $HOME/.m2:/root/.m2 -w /app -p 8800:8000 localhost:5000/maven mvn package'
      }
    }
    stage('Target') {
      steps {
        archiveArtifacts 'target/*.jar'
      }
    }
    stage('Deploy') {
      steps {
        sh '''docker build -t localhost:5000/spring-boot-sample-prod ./
docker push localhost:5000/spring-boot-sample-prod
docker pull localhost:5000/spring-boot-sample-prod
docker run -d -p 8800:8000 localhost:5000/spring-boot-sample-prod'''
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
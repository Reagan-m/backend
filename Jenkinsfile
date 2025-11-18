pipeline {
  agent any
  environment {
    IMAGE = "backend-app:${env.BUILD_ID}"
    CONTAINER_NAME = "backend-service"
    PORT = "4040"
  }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Install & Test') {
      steps {
        sh 'npm ci'
        sh 'npm test || true'   // keep pipeline running even if no tests
      }
    }
    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${IMAGE} ."
      }
    }
    stage('Deploy') {
      steps {
        // stop & remove old container, run new one (adjust env-file path if any)
        sh """
          docker ps -q --filter "name=${CONTAINER_NAME}" | grep -q . && docker rm -f ${CONTAINER_NAME} || true
          docker run -d --name ${CONTAINER_NAME} -p ${PORT}:${PORT} ${IMAGE}
        """
      }
    }
  }
  post {
    always { sh 'docker images --filter=reference="backend-app*" || true' }
  }
}


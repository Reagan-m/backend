pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "backend-app"
        CONTAINER_NAME = "backend-container"
        NETWORK_NAME   = "my-network"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Reagan-m/Backend.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Stop Old Container') {
            steps {
                sh """
                  docker stop ${CONTAINER_NAME} || true
                  docker rm ${CONTAINER_NAME} || true
                """
            }
        }

        stage('Run New Container') {
            steps {
                sh """
                  docker run -d \
                    --name ${CONTAINER_NAME} \
                    --env-file .env \
                    --network ${NETWORK_NAME} \
                    -p 4040:4040 \
                    ${DOCKER_IMAGE}
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}



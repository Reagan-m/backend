pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Reagan-m/backend.git'
        IMAGE_NAME = 'backend-app'
        CONTAINER_NAME = 'backend-container'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${REPO_URL}", credentialsId: 'github_credentials'
            }
        }

        stage('Clean Old Containers & Images') {
            steps {
                sh '''
                docker rm -f ${CONTAINER_NAME} || true
                docker-compose down || true
                '''
            }
        }

        stage('Build Image & Run Compose') {
            steps {
                sh '''
                docker-compose up -d --build
                '''
            }
        }

        stage('Check Status') {
            steps {
                sh 'docker ps'
            }
        }
    }

    post {
        success {
            echo 'Backend deployed successfully!'
        }
        failure {
            echo 'Backend deployment failed!'
        }
    }
}


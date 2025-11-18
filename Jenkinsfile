pipeline {
    agent any

    environment {
        APP_NAME = "backend-app"
        CONTAINER_NAME = "backend-service"
        PORT = "4040"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            steps {
                sh '''
                npm ci
                npm test || true
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${APP_NAME}:${BUILD_NUMBER} .
                docker tag ${APP_NAME}:${BUILD_NUMBER} ${APP_NAME}:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                # Stop and remove old container if exists
                docker stop ${CONTA


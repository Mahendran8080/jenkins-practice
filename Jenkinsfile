pipeline {
    agent any

    tools {
        nodejs 'Node18'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Pulling code from GitHub'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing npm packages'
                sh 'node --version'
                sh 'npm --version'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests'
                sh 'npm test || true'
            }
        }

        stage('Build') {
            steps {
                echo 'Preparing build artifacts'
                sh 'mkdir -p build && cp index.js package.json build/'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/**'
            }
        }
    }
}


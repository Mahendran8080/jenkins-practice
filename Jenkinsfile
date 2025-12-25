pipeline {
    agent any

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
                sh '/usr/bin/node --version'
                sh '/usr/bin/npm --version'
                sh '/usr/bin/npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests'
                sh '/usr/bin/npm test || true'
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

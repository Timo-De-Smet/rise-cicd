pipeline {
    agent any

    stages {
        stage('Cleanup old container') {
            steps {
                sh 'docker stop riserunning || true'
                sh 'docker rm riserunning ||true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t riserunning:latest . '
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 8080:8080 --name riserunning riserunning:latest'
            }
        }
    }
}
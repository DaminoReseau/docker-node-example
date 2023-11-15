pipeline {
    agent any
    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/DaminoReseau/docker-node-example.git'
            }
        }
        stage('Build Docker image') {
            steps {
                sh 'docker build -t myimage .'
            }
        }
    }
    post {
        success {
            echo 'Build succeeded!'
            mail to: 'damien.lemarchand@viacesi.fr', subject: 'Build succeeded', body: 'The build succeeded!'
        }
        failure {
            echo 'Build failed!'
            mail to: 'damien.lemarchand@viacesi.fr', subject: 'Build failed', body: 'The build failed!'
        }
    }
}

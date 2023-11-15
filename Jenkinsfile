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
        stage('Run unit tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Send email notification') {
            steps {
                emailext body: 'The build has finished successfully.', subject: 'Build Notification', to: 'damien.lemarchand@viacesi.fr'
            }
        }
    }
}

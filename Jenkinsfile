pipeline {
  agent any
  stages {
    stage('Cloner le dépôt') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/DaminoReseau/docker-node-example.git']]])
      }
    }

    stage('Construire l\'image Docker') {
      steps {
        script {
          docker.build('image-jenkins')
        }

      }
    }
    stage('Security Scan') {
            steps {
                script {
                    // Analyse de sécurité avec Trivy
                    def scanResult = sh(script: 'trivy image-jenkins', returnStatus: true)
                    if (scanResult == 1) {
                        discordSend(description: "Vulnérabilités critiques détectées. Arrêt du déploiement.", result: "FAILURE", title: env.JOB_NAME, webhookURL: "https://discord.com/api/webhooks/1174339385563566151/E7vGSpxIZx-A18L59GnJQ9iusE5_qxYgXmsGsugmH_dBb37LGaybeso6p4fXOH4IiJ6p")
                    } else {
                        discordSend(description: "Aucune vulnérabilité critique détectée.", result: "SUCCESS", title: env.JOB_NAME, webhookURL: "https://discord.com/api/webhooks/1174339385563566151/E7vGSpxIZx-A18L59GnJQ9iusE5_qxYgXmsGsugmH_dBb37LGaybeso6p4fXOH4IiJ6p")
                    }
                }
            }
        }
  
  }
  post {
    success {
      script {
        discordSend(description: "Le build a réussi !", result: "SUCCESS", title: env.JOB_NAME, webhookURL: "https://discord.com/api/webhooks/1174339385563566151/E7vGSpxIZx-A18L59GnJQ9iusE5_qxYgXmsGsugmH_dBb37LGaybeso6p4fXOH4IiJ6p")
      }

    }

    failure {
      script {
        discordSend(description: "Le build a échoué.", result: "FAILURE", title: env.JOB_NAME, webhookURL: "https://discord.com/api/webhooks/1174339385563566151/E7vGSpxIZx-A18L59GnJQ9iusE5_qxYgXmsGsugmH_dBb37LGaybeso6p4fXOH4IiJ6p")
      }

    }

  }
}

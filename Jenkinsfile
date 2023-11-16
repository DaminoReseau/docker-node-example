pipeline {
  agent any
  stages {
    stage('Cloner le depot') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/DaminoReseau/docker-node-example.git']]])
      }
    }

    stage('Image build') {
      steps {
        script {
          docker.build('image-jenkins')
        }

      }
    }
    stage('Security Scan') {
            steps {
                script {
                    // Analyse de sécurité avec Trivy dans un conteneur Docker distinct
                    def trivyOutput = sh(script: 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image image-jenkins', returnStdout: true).trim()

                    // Sauvegarder la sortie de Trivy dans un fichier de log
                    writeFile file: 'trivy_scan.log', text: trivyOutput

                    // Afficher le résultat dans la console Jenkins
                    echo "Résultat de l'analyse Trivy :"
                    echo trivyOutput

                    // Éventuellement, ajouter une condition pour stopper le déploiement si des vulnérabilités critiques sont détectées
                    if (trivyOutput.contains('CRITICAL')) {
                        error('Vulnérabilités critiques détectées. Arrêt du déploiement.')
                    } else {
                        echo 'Aucune vulnérabilité critique détectée.'
                    }
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

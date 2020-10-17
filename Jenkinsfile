pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '0'))
    }
    
    agent none
    
    stages {

        stage('Build image') {
            agent { label 'milkshake' }

            steps {

                git branch: 'master',
                    url: 'https://github.com/tarof429/docker-trac.git'                

                script {
                    withEnv(["SHA=${env.GIT_COMMIT}"]) {
                        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                            status = sh(returnStatus: true, script: "echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin")
                            if (status != 0) {
                                error("Bad status!")
                            }

                            status = sh(returnStatus: true, script: "sh ./deploy.sh")
                            if (status != 0) {
                                error("Deployment failed")
                            }
                        }
                    }
                }
            }
        }
    }
}
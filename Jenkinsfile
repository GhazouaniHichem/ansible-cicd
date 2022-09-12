pipeline {

    agent any
    tools {
        nodejs 'node-18.9'
    }
    
    
    stages {
    
        stage("Copy ansible files to server") {
            steps {
                script {
                    echo "Copying all neccessary files to ansible control node"
                    sshagent(['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@13.38.136.194"
                    }
                }
            }
        }



    }
}
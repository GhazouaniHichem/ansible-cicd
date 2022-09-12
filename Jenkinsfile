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
                    sshagent(credentials: ['ansible-server-key']) {
                        sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@13.38.136.194:/home/ubuntu/home"
                        withCredentials([sshUserPrivateKey(credentialsId: "cicd-server-key", keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
                            sh 'scp $keyfile ubuntu@13.38.136.194:/home/ubuntu/home/ssh-key.pem'
                        }
                    }
                }
            }
        }
        stage("Execute Ansible playbook") {
            steps {
                script {
                    echo "Calling Ansible playbook to configure cicd server"
                    def remote = [:]
                    remote.name = 'ansible-server'
                    remote.host = '13.38.136.194'
                    remote.allowAnyHosts = true

                    withCredentials([sshUserPrivateKey(credentialsId: "cicd-server-key", keyFileVariable: 'keyfile', usernameVariable: 'ubuntu')]) {
                        remote.user = 'ubuntu'
                        remote.identityFile = keyfile  
                        sshCommand remote: remote, command: "ansible-playbook home/my-play.yaml"
                    }

                }
            }
        }
}

}
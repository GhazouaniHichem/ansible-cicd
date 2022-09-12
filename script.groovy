def buildImage() {
    echo "building the docker image..."
/*    withCredentials([usernamePassword(credentialsId: 'DockerHub_credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t ghazouanihm/cicd-app:1.1 .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push ghazouanihm/cicd-app:1.1'
        }

        */
}

def deployApp() {
    echo 'deploying the application....'
    sh 'ssh -i ~/web-server-key-pair.pem -o "StrictHostKeyChecking no" ec2-user@13.38.38.61 -y "git clone https://github.com/GhazouaniHichem/devops-cicd.git && cd devops-cicd&& docker-compose up -d"'
//    sh 'git clone https://github.com/GhazouaniHichem/devops-cicd.git'
//    sh 'cd devops-cicd'
//    sh 'docker-compose up -d'

}


return this
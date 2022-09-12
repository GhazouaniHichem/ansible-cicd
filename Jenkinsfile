def gv

pipeline {

    agent any
    
    
    tools {
        nodejs 'node-18.8'
    }
    
    
    stages {
    
        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }

    
        stage("build image") {
            steps {
                script {
                    gv.buildImage()
                }
            }
        }

    
        stage("deploy") {
            steps {
                script {
                    gv.deployApp()
                }
            }
        }
    }
}
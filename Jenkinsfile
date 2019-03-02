pipeline {
    agent any	
    tools {
        maven 'localMaven'
    }	
    stages {
       stage('Initialize') {
            steps {
                echo 'Initializing..'
            }
        }
        stage('Build') {
            steps {
			echo 'Building..'		
			bat 'mvn clean package'                
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}

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
	stage ('Deployments'){
		parallel{
			stage ('Static analysis'){
				steps {
					echo 'Running Checkstyle....'
					build job: 'static analysis'

				}
			}

			stage ("Deploy to Staging"){
				steps {
					echo 'Deploying to staging environment....'
					build job: 'deploy-to-staging'

				}
			}
		}
	}
		
    }
}

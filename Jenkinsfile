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
			bat "docker image build -t tapojitb/simple-webapp:${env.BUILD_ID} ."		    
		    	bat "docker container run -d  --name simple-webapp-a-${env.BUILD_ID} -p 8181:8080 tapojitb/simple-webapp:${env.BUILD_ID}"
		    	bat "docker container run -d  --name simple-webapp-b-${env.BUILD_ID} -p 8282:8080 tapojitb/simple-webapp:${env.BUILD_ID}"
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
	stage ('Deploy to Production'){
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message:'Approve PRODUCTION Deployment?'
                }

                build job: 'deploy-to-Production'
            }
            post {
                success {
                    echo 'Code deployed to Production.'
                }

                failure {
                    echo ' Deployment failed.'
                }
            }
        }
		
    }
}

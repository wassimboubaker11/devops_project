pipeline{
   environment{
      registry = 'wassim11/achat'
      registryCredential= 'dockerID'
      dockerImage = ''
   }

   agent any
   stages{
      stage ('Checkout Git'){
         steps{
            echo 'Pulling...';
               git branch: 'main',
               url : 'https://github.com/wassimboubaker11/devops.git',
               credentialsId: 'gitID';
         }
      }
	   
	  

      stage ("maven clean"){
         steps{
            sh "mvn clean"
	
         }

      }
	    stage('MVN COMPILE')
            {
                steps{
                sh  'mvn compile'
                }
            }

      stage ('creation artifact'){
         steps{
            sh "mvn package -Dmaven.test.skip=true"
	    sh 'mvn install'
         }
      }

      stage ('test'){
         steps{
            sh "mvn test"
         }
      }

      stage('SonarQube Analysis'){
            steps {
                withSonarQubeEnv(credentialsId: 'sonarqueID',installationName: 'sonarq') {
                    sh """
                        mvn sonar:sonar \
			-D sonar.login=admin \
                        -D sonar.password=azerty \
			-D sonar.projectKey=org.springframework.boot \
                        
                    """
                }
                    
            }
                
        }

      stage ('nexus deploiment'){
       steps{
			nexusArtifactUploader artifacts: [[artifactId: 'achat', file: 'target/achat-2.0.jar', type: 'jar']], credentialsId: 'nexusID', groupId: 'tn.esprit.rh', nexusUrl: '192.168.1.22:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases', version: '2.0'
			}
		}
     
     
     

      stage('build image'){
         steps{
            script{
               dockerImage= docker.build registry + ":$BUILD_NUMBER"
            }
         }
      }

      stage('deploiment image'){
         steps{
            script{
               docker.withRegistry( '', registryCredential){
                  dockerImage.push()
               }
            }
         }
      }
	   stage ('run container'){
            steps{
                
                                sh 'docker-compose up -d --build'
            }
        }
	   
 
}

   post{
      success{
         emailext body: 'Build success', subject: 'Jenkins',
to:'wassim.bouabker@esprit.tn'
      }
      failure{
         emailext body: 'Build failure', subject: 'Jenkins',
to:'wassim.bouabker@esprit.tn'
      }
   }
}

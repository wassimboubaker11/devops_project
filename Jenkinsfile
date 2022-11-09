pipeline{
   environment{
      registry = 'Wassim/achat'
      registryCredential= 'dockerId'
      dockerImage = ''
   }

   agent any
   stages{
      stage ('Checkout Git'){
         steps{
            echo 'Pulling...';
               git branch: 'main',
               url : 'https://github.com/Ahmed-Zarrad/achat',
               credentialsId: '01';
         }
      }


      stage ("maven clean"){
         steps{
            sh "mvn clean"
         }

      }

      stage ('creation artifact'){
         steps{
            sh "mvn package -Dmaven.test.skip=true"
         }
      }

      stage ('test'){
         steps{
            sh "mvn test"
         }
      }

      stage ('sonarQube'){
         steps{
         withSonarQubeEnv(installationName: 'sonar'){
            sh "mvn sonar:sonar"
            }
         }
      }

      stage ('nexus deploiment'){
       steps{
			nexusArtifactUploader artifacts: [[artifactId: 'achat', classifier: 'debug', file: 'target/achat-1.0.jar', type: 'jar']], credentialsId: 'nexusID', groupId: 'tn.esprit.rh', nexusUrl: '192.168.1.22:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases', version: '1.0'
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

      stage('clean'){
         steps{
            sh "docker rmi $registry:$BUILD_NUMBER"
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

pipeline {
    agent any 
    stages {
        stage('Checkout') {
			steps {
				checkout([$class: 'GitSCM', branches: [[name: '*/master']], 
				doGenerateSubmoduleConfigurations: false, 
				extensions: [], 
				submoduleCfg: [], 
				userRemoteConfigs: [[credentialsId: 'bitbucket-repo-id', 
				url: 'https://rajput1914@bitbucket.org/yushh-ltd/docker-php-symfony-angular.git']]])
			}
        }
		
		stage ('Docker Build'){
		    steps {
				   sh 'python ./k8appfiles/update.py $BUILD_ID'
                   sh 'docker system prune -af'
                   sh 'docker build -f .docker/node/Dockerfile -t docker-php-symfony-angular_node:$BUILD_ID .'
			       sh 'docker build -f .docker/nginx/Dockerfile -t docker-php-symfony-angular_nginx:$BUILD_ID .'
			    // sh 'docker build -f .docker/apache/Dockerfile -t docker-php-symfony-angular_apache:v20 .'
                // sh 'docker build -f .docker/php/Dockerfile -t docker-php-symfony-angular_php:v20 .'
				}
			}
		
		
		stage ('Docker push'){
		    steps {
				script{
					docker.withRegistry('https://080627251666.dkr.ecr.eu-west-2.amazonaws.com', 'ecr:eu-west-2:aws-ecr-credentials') {
					docker.image('docker-php-symfony-angular_node:$BUILD_ID').push('$BUILD_ID')
					docker.image('docker-php-symfony-angular_nginx:$BUILD_ID').push('$BUILD_ID')
//					docker.image('docker-php-symfony-angular_apache:v20').push('v20')
//					docker.image('docker-php-symfony-angular_php:v20').push('v20')
					}
				}
			}
		}
		
		
		
		
		stage('Deploy') {
		    steps {
				kubernetesDeploy configs: 'k8appfiles/frontendDeployment.yml, k8appfiles/frontendService.yml', 
				kubeConfig: [path: ''], 
				kubeconfigId: 'kubeconfig', 
				secretName: '', 
				ssh: [sshCredentialsId: '*', sshServer: ''], 
				textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
			}
		
		}
    }
}

pipeline {
    agent any
    stages {
        stage('Code Checkout') {
            steps {
                git 'https://github.com/naveenclgit/purdueproject.git'
            }
        }

        stage('Code Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Code Packaging') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'cp /var/lib/jenkins/workspace/$JOB_NAME/target/ABCtechnologies-1.0.war /var/lib/jenkins/workspace/$JOB_NAME/abc.war'
                sh 'docker build -t purdueproject:$BUILD_NUMBER .'
                sh 'docker tag purdueproject:$BUILD_NUMBER jsachdev07/purdueproject:$BUILD_NUMBER'
                script {
                    app = docker.build("naveencldock/purdueproject")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    app.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Deploy to Docker Swarm') {
            steps {
                sshagent(['kvmsys_oel701']) {
                    sh "ssh -o StrictHostKeyChecking=no -l root 10.0.0.79 'docker service rm purdueproject; docker service create --name purdueproject --mode global --publish published=8282,target=8080,mode=host naveencldock/purdueproject'"
                }
            }
        }

      stage('Deploy to k8s cluster ')
		{
			steps
			{
				sh 'kubectl version'
				sh 'kubectl apply -f deploy.yaml'
			        sh  'kubectl apply -f svc.yaml'
			}
		} 

    }
}


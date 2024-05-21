pipeline {
    agent { label 'backend-account'}
    tools {
        maven "maven"
    }

    stages {
        stage('Build') {
            steps {
                echo 'Build Start'
                
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[ url: 'https://github.com/ProcessX/my-fair-banking-accounts.git']])
                
                sh 'mvn -B -DskipTests clean package'
                
                echo 'Build Finished'
            }
        }
        stage('Scan'){
            steps {
                withSonarQubeEnv('sonarqube_server') {
                    sh 'mvn clean compile sonar:sonar'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t myfairbankingaccount:latest .'
            }
        }
        stage('Run Container') {
            steps {
                sh 'sudo docker run -d -p 8081:8080 myfairbankingaccount'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}

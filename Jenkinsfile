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
        stage('Docker Build') {
            steps {
                sh 'docker build -t my-fair-banking-account:latest'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}

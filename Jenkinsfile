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
    }
    post {
        always {
            archiveArtifacts artifacts: '/home/azureuser/workspace/java-build-backend/target/*.jar', fingerprint: true
            junit 'build/reports/**/*.xml'
        }
    }
}

pipeline {
    agent { label 'backend-accounts'}
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
}

pipeline {
    agent { label 'backend-account'}
    tools {
        maven "maven"
    }

    stages {
        stage('Scan'){
            steps {
                withSonarQubeEnv('Sonarqube') {
                    sh 'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                }
            }
        }
        stage('Quality gate'){
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
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

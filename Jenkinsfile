pipeline {
    agent { label 'backend-account'}
    tools {
        maven "maven"
    }

    stages {
        
        stage('Sonarqube Scan'){
            steps {
                withSonarQubeEnv('sonarqube_server') {
                    sh 'mvn clean compile sonar:sonar'
                }
            }
        }
        stage('Security Scan OWASP ZAP') {
            agent { label 'statictest' }
            steps {
                sh 'owasp-zap -port 8081 -cmd -quickurl http://40.89.183.107:8081/ -quickprogress -quickout /var/lib/jenkins/out.xml'
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

        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t myfairbankingaccounts:latest .'
            }
        }
        stage('Run Container') {
            steps {
                sh 'sudo docker run --name myfairbankingaccounts -d -p 8081:8080 myfairbankingaccounts'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}

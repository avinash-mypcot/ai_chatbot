pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = 'G:\\Flutter Projects\\jenkins_distribution\\jenkins-distribution-credential.json' 
    } // Here add your jenkins-distribution-credential.json file path
    stages {
        stage('Git Pull') {
            steps {
                // Cloning the repository from GitHub
                git url: 'https://github.com/avinash-mypcot/ai_chatbot.git',
                branch: 'master'
            }
        }

        // stage('Run Tests') {
        //     steps {
        //         // Running Flutter tests
        //         sh 'flutter test'
        //     }
        // }

        stage('Build Android APK') {
            steps {
                // Building the APK in release mode
                sh 'flutter build apk'
            }
        }
        stage ('Distribute') {
            steps {
        // Running the Gradle commands with the environment variable set
                 bat 'cd android && gradlew.bat assembleRelease appDistributionUploadRelease'
            }
        }
        
        stage('Archive APK') {
            steps {
                // Archiving the release APK
                archiveArtifacts artifacts: '**/build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: false
            }
        }
    }
       
    post {
        always {
            echo 'Pipeline finished.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

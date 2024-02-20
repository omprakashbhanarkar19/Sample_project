pipeline {
    agent any
    stages { 
        stage ("tf initization") {
            steps {
                sh 'terraform init'
            }
        }
        stage ("tf plan") {
            steps {
                sh 'terraform plan'
            }
        }
        stage ("tf apply") {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
       stage ("deploy-stage") {
            steps {
                sh "echo deploy successfull"
            }
        }
    }
}

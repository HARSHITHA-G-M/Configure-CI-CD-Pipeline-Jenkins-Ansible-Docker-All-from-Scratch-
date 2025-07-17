pipeline {
    agent any

    environment {
        IMAGE_NAME = "flaskapp"
        TAR_PATH = "/tmp/${IMAGE_NAME}.tar"
    }

    stages {
        stage('Clone Code') {
            steps {
                git(
                    branch: 'master',
                    url: 'https://github.com/HARSHITHA-G-M/Configure-CI-CD-Pipeline-Jenkins-Ansible-Docker-All-from-Scratch-.git',
                    credentialsId: 'github-pat'
                )
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Save Image Tar') {
            steps {
                sh 'docker save ${IMAGE_NAME}:latest -o ${TAR_PATH}'
            }
        }

        stage('Ansible Deploy to EC2') {
            steps {
                sh '''
                    cp ${TAR_PATH} ansible/
                    cd ansible
                    ansible-playbook -i inventory.ini deploy.yaml \
                      --private-key=~/.ssh/ansible-k8s.pem \
                      -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
                '''
            }
        }
    }
}

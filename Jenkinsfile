pipeline {
  agent any
    stages {
        stage ('Build') {
            steps {
                sh '''#!/bin/bash
                python3.7 -m venv venv
                source venv/bin/activate
                pip install pip --upgrade
                pip install -r requirements.txt
                '''
            }
        }
        stage ('Test') {
            steps {
                sh '''#!/bin/bash
                chmod +x scripts/system_resources_test.sh
                ./scripts/system_resources_test.sh
                '''
            }
        }
        stage ('Deploy') {
          steps {
            sh '''#!/bin/bash
            source venv/bin/activate
            eb create w2-automated_deploys_to_elb_main_env --single
            '''
          }
        }
    }
}

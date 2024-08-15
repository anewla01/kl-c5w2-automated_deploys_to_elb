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
            eb_env="w2-automateddeploystoelbmainenv-env"
            is_eb_env_avail=$(eb list | grep  "${eb_env}" | wc -l | awk '{print $NF}') 

            if [[ "${is_eb_env_avail}" -gt 1 ]]
              then
              echo "Found ${is_eb_env_avail} env, expected 1 at maximum."
              exit 1
            elif [[ "${is_eb_env_avail}" -eq 1 ]]
              then 
              echo "EB Env: ${eb_env} already exists, deploying instead"
              eb deploy "${eb_env}"
            else
              echo "EB Env: ${eb_env} does not exist, creating env"
              eb create ${eb_env} --single
            fi
            '''
          }
        }
    }
}

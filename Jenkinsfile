pipeline {
  agent {
    node {
        label 'master'
    }
  }
  environment {
    DOCKER_IMAGE = 'metacoma/silverkey-web'
    DOCKER_NETWORK = 'webproxy'
    LETSENCRYPT_EMAIL='ryabin.ss@gmail.com'

    HOST_ARTIFACT_DIR='/opt/silverkey/web-artifacts'
    CONTAINER_ARTIFACT_DIR="${HOST_ARTIFACT_DIR}"
  }
  stages {
    stage('Build') {
      steps {
        script {
          step([$class: 'WsCleanup'])
          checkout scm
          if (params.containsKey('ghprbSourceBranch') && ghprbSourceBranch != 'master') {
            label = 'staging'
            siteName = 'staging.silverkey.app'
          } else {
            label = 'latest'
            siteName = 'silverkey.app'
          }
        }
        sh "docker build -t ${DOCKER_IMAGE}:${label} ."
      }
    }
    stage('Run website') {
        steps {
          sh "docker rm -f ${siteName} || :"
          sh "docker run -d -v ${HOST_ARTIFACT_DIR}:${CONTAINER_ARTIFACT_DIR}:ro -e VIRTUAL_HOST=${siteName} -e LETSENCRYPT_HOST=${siteName}  -e LETSENCRYPT_EMAIL=${LETSENCRYPT_EMAIL}  --network=${DOCKER_NETWORK} --name ${siteName} ${DOCKER_IMAGE}:${label}"
        }
    }
  }
}


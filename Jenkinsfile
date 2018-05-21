pipeline {
  agent {
    node {
        label 'master'
    }
  }
  environment {
    dockerhub_image = 'metacoma/silverkey-web'
  }
  stages {
    stage('Build') {
      /*
      agent {
        dockerfile {
          reuseNode true
          label 'master'
        }
      }
      */
      steps {
        script {
          if (ghprbSourceBranch != 'master') {
            label = 'staging'
          } else {
            label = 'latest'
          }
        }
        sh "docker build -t ${dockerhub_image}:${label} ."
        withCredentials([usernamePassword(credentialsId: 'metacoma_dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
         sh """
            echo -n ${DOCKERHUB_PASSWORD} | docker login ${dockerhub_image}:${label} -u ${DOCKERHUB_USERNAME}
            docker push ${dockerhub_image}:${label}
         """
        }
      }
    }
  }
}


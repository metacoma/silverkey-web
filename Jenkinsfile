pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        dockerfile {
          reuseNode true
          label 'master'
        }
      }
    }
  }
}

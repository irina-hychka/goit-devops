pipeline {
    agent {
        kubernetes {
            label 'kaniko'
        }
    }

    environment {
        AWS_REGION = 'us-west-2'
        ECR_REPO = '712242347745.dkr.ecr.us-west-2.amazonaws.com/lesson-8-9-django-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        GIT_REPO = 'https://github.com/irina-hychka/goit-devops'
        BRANCH = 'lesson-8-9'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build & Push Image (Kaniko)') {
            steps {
                container('kaniko') {
                    sh """
                    /kaniko/executor \
                      --dockerfile=Dockerfile \
                      --context=`pwd` \
                      --destination=${ECR_REPO}:${IMAGE_TAG} \
                      --destination=${ECR_REPO}:latest \
                      --verbosity=info
                    """
                }
            }
        }

        stage('Update Helm values') {
            steps {
                container('git') {
                    sh """
                    git config --global user.email "jenkins@example.com"
                    git config --global user.name "jenkins"

                    sed -i 's/tag: .*/tag: "${IMAGE_TAG}"/' Project/charts/django-app/values.yaml

                    git add Project/charts/django-app/values.yaml
                    git commit -m "Update image tag to ${IMAGE_TAG}" || true
                    git push origin ${BRANCH}
                    """
                }
            }
        }
    }
}
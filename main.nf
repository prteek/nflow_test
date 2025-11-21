#!/usr/bin/env nextflow

process build {
    container null

    input:
    val DOCKERFILEPATH
    val IMAGE

    script:
    """
    docker buildx build --platform linux/amd64 -t ${IMAGE} . -f ${DOCKERFILEPATH} --output type=docker
    """
}

process push {
    container null

    input:
    val IMAGE
    val IMAGE_URI

    script:
    """
    docker tag ${IMAGE} ${IMAGE_URI}
    aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin ${IMAGE_URI}; docker push ${IMAGE_URI}
    """
}

process create_ecr_repo {
    container null

    input:
    val ECR_REPO

    script:
    """
    aws ecr create-repository --repository-name ${ECR_REPO} --region eu-west-1
    """
}


workflow {

    IMAGE = "${params.ECR_REPO}:latest"
    DOCKERFILEPATH = file(params.DOCKERFILE)

    if (params.ops == 'build') {
        build(DOCKERFILEPATH, IMAGE)
    }
    else if (params.ops == 'push') {
        push(IMAGE, params.IMAGE_URI)
    }
    else if (params.ops == 'all') {
        build(DOCKERFILEPATH, IMAGE)
        push(IMAGE, params.IMAGE_URI)
    }
    else if (params.ops == 'create_ecr_repo') {
        create_ecr_repo(params.ECR_REPO)
    }
}

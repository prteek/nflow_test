# nflow_test

```shell
nextflow run tutorial.nf -bucket-dir s3://nflow/artefacts/ -profile local
nextflow run tutorial.nf -bucket-dir s3://nflow/artefacts/ -profile awsbatch

```

This is a test repository for nflow tutorials.

## Prep

Not needed to build the image since it already exists.
But if bulding, definitely need to take care of cross platform build and use **buildx and --output type=docker**

```shell
cd docker-image
docker buildx build --platform linux/amd64 -t iprtk/nflow-test:latest . --output type=docker
docker push iprtk/nflow-test:latest

```

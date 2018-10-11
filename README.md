# Simple S3

Simple docker service based on Minio server that is an Amazon S3 (Simple Storage Service) compatible object storage server.

# Pre requirements

* Git
* Docker
* Make
* Python

# Clone

    git clone https://github.com/humbertodias/docker-minio-s3.git
    cd docker-minio-s3

# Server

    make generate_keys
    make up

# Client

Install

    pip install awscli

Environment

    AWS_ACCESS_KEY_ID=CHANGEME
    AWS_SECRET_ACCESS_KEY=CHANGEME

Create a bucket
    
    aws --endpoint-url https://localhost s3 mb s3://mybucket --no-verify-ssl

Copy file to bucket
    
    aws --endpoint-url https://localhost s3 cp /etc/hosts s3://mybucket --no-verify-ssl

List

    aws --endpoint-url https://localhost s3 ls --no-verify-ssl


# References

* [Mino Server](https://hub.docker.com/r/minio/minio/)

* [S3 CLI](https://aws.amazon.com/cli/)

* [S3 GUI](https://cyberduck.io)

* [openssl-alpine](https://github.com/gitphill/openssl-alpine)
# HumanDB API

## About

This project uses [Feathers](http://feathersjs.com), an open source web framework for building modern real-time applications.

## Running locally with node.js and yarn

Run `yarn && yarn start-dev` from the project root directory.

## Help

For more information on all the things you can do with Feathers visit [docs.feathersjs.com](http://docs.feathersjs.com).

## Building and deploying container to AWS manually
- Build the image
`docker build --pull --no-cache -t 413230511243.dkr.ecr.us-east-1.amazonaws.com/hdb-dash-auth:$(git show --pretty=format:%h -s) -f Dockerfile .`

- Deploy the container to AWS
  - First make sure you are logged in. From the docker workspace run the following
  `aws ecr get-login --no-include-email --region us-east-1`
  - Take the generated output and run it on your host machine, this will authenticate your docker daemon against the AWS repo.
  - With auth confirmed, push the image up to AWS
  `docker push 413230511243.dkr.ecr.us-east-1.amazonaws.com/hdb-dash-auth:$(git show --pretty=format:%h -s)`

## Building and deploying container to AWS with Jenkins

[job/hdb01-dash-auth](https://build.humandb.ai/job/hdb01-proto/job/hdb01-app-services/job/hdb01-dash/job/hdb01-dash-auth/)

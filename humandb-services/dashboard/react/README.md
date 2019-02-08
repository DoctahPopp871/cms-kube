# HumanDB Authentication Dashboard

## About

This project is built with [React](https://reactjs.org/), [Semantic-UI](https://semantic-ui.com/) and [Feathers](http://feathersjs.com).

## Running locally with node.js and yarn

Run `yarn && yarn start` from the project root directory.

## Building and deploying container to AWS manually
- Build the image
`docker build --pull --no-cache -t 413230511243.dkr.ecr.us-east-1.amazonaws.com/hdb-dash-fe:$(git show --pretty=format:%h -s) -f Dockerfile .`

- Deploy the container to AWS
  - First make sure you are logged in. From the docker workspace run the following
  `aws ecr get-login --no-include-email --region us-east-1`
  - Take the generated output and run it on your host machine, this will authenticate your docker daemon against the AWS repo.
  - With auth confirmed, push the image up to AWS
  `docker push 413230511243.dkr.ecr.us-east-1.amazonaws.com/hdb-dash-fe:$(git show --pretty=format:%h -s)`

## Building and deploying container to AWS with Jenkins

[job/hdb01-dash-fe](https://build.humandb.ai/job/hdb01-proto/job/hdb01-app-services/job/hdb01-dash/job/hdb01-dash-fe/)

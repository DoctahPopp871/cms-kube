# Manual Deployment from CommandLine
## Build Image
`docker build --pull --no-cache -t hdb-advaita-api:$(git show --pretty=format:%h -s) -f Dockerfile .`
## Run the API Locally
`docker run -d -e "CHAT_KEY=" -e "HDB_HOST=hdb01.humandb.ai" --volume=/tmp:/advaita-results --volume=$(pwd):/var/www/ -p 5500:5500 --restart always --name hdb-advaita-api hdb-advaita-api:$(git show --pretty=format:%h -s)`
- If looking to run the API and develop interactively run the command above with the following appended :
`'yarn && yarn run dev'`
## Deploy to AWS for use with kubernetes
`docker tag hdb-advaita-api:$(git show --pretty=format:%h -s) <AWS Account ID>.dkr.ecr.us-east-1.amazonaws.com/hdb-advaita-api:$(git show --pretty=format:%h -s)`
`docker push <AWS Account ID>.dkr.ecr.us-east-1.amazonaws.com/hdb-advaita-api:$(git show --pretty=format:%h -s)`
## Deploy to HDB01 cluster
- Update the image value in the `advaita-api.yaml` file setting the tag to the current build hash. `$(git show --pretty=format:%h -s)`
- Once done, apply the file `kubectl apply -f advait-api.yaml`
- You can monitor the status of the deployment with `kubectl get events --namespace humandb-01`

## Using Telepresence
`telepresence --swap-deployment hdb-adv-api --expose 5500 --docker-run -e "CHAT_KEY=d757e112ab624d50f8ad4dde9b2df67f08b9980fedd7608a91edaadd087cc614" -e "HDB_HOST=hdb01.humandb.ai" --volume=$(pwd):/var/www --volume=/tmp:/advaita-results -it hdb-advaita-api:057e2a5 'yarn add && yarn run dev'`
docker run -d -e "CHAT_KEY=d757e112ab624d50f8ad4dde9b2df67f08b9980fedd7608a91edaadd087cc614" -e "HDB_HOST=hdb01.humandb.ai" --volume=/tmp:/advaita-results --volume=$(pwd):/var/www/ -p 5500:5500 --res
tart always --name hdb-advaita-api hdb-advaita-api:$(git show --pretty=format:%h -s) yarn add && yarn run dev

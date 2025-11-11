### como baixar apenas um diretório do repositorio

```sh
git clone --no-checkout --filter=blob:none https://github.com/ambientelivre/samples_hop.git
cd samples_hop/
git sparse-checkout init --cone
git sparse-checkout set unit_test
git checkout
```

##

```sh
export HOP_DOCKER_IMAGE=ambientelivre/hop-custom-with-git:2.4.0
export PROJECT_DEPLOYMENT_DIR=/home/hop/apache-hop-minimal-project
```

```sh
docker run -it --rm   --env HOP_LOG_LEVEL=Basic \
--env HOP_FILE_PATH='${PROJECT_HOME}/m ain.hwf'   \
--env HOP_PROJECT_FOLDER=${PROJECT_DEPLOYMENT_DIR}   --env HOP_PROJECT_NAME=apache-hop-minimum-project   --env HOP_ENVIRONMENT_NAME=dev   --env HOP_ENVIRONMENT_CONFIG_FILE_NAME_PATHS=${PROJECT_DEPLOYMENT_DIR}/dev-config.json   --env HOP_RUN_CONFIG=local   --env HOP_CUSTOM_ENTRYPOINT_EXTENSION_SHELL_FILE_PATH=/home/hop/clone-git-repo.sh   --env GIT_REPO_URI=https://github.com/ambientelivre/apache-hop-minimal-project.git   --env GIT_REPO_NAME=apache-hop-minimal-project   --name my-simple-hop-container   ${HOP_DOCKER_IMAGE}
```

#  Hop Custom Imagem

foi necessário fazer o Docker Build para enviar uma Imagem ja com git instalada


## Build and Up Docker Hub

```sh
docker build -t ambientelivre/hop-custom-with-git:2.4.0 .
docker login
docker tag ambientelivre/hop-custom-with-git:2.4.0 ambientelivre/hop-custom-with-git:2.4.0
docker push ambientelivre/hop-custom-with-git:2.4.0
```sh


## Testando a Imagem no Docker

caso queira conectar na Azure adicione as linhas :
```sh
  --env AZURE_ACCOUNT_NAME=conta \
  --env AZURE_ACCOUNT_KEY=key \
```

no comando docker run

# run with repo full

```sh
export HOP_DOCKER_IMAGE=ambientelivre/hop-custom-with-git:2.4.0
export PROJECT_DEPLOYMENT_DIR=/home/hop/apache-hop-minimal-project
```

```sh
docker run -it --rm \
  --env HOP_LOG_LEVEL=Basic \
  --env HOP_FILE_PATH='${PROJECT_HOME}/main.hwf' \
  --env HOP_PROJECT_FOLDER=${PROJECT_DEPLOYMENT_DIR} \
  --env HOP_PROJECT_NAME=apache-hop-minimum-project \
  --env HOP_ENVIRONMENT_NAME=dev \
  --env HOP_ENVIRONMENT_CONFIG_FILE_NAME_PATHS=${PROJECT_DEPLOYMENT_DIR}/dev-config.json \
  --env HOP_RUN_CONFIG=local \
  --env HOP_CUSTOM_ENTRYPOINT_EXTENSION_SHELL_FILE_PATH=/home/hop/clone-git-repo.sh \
  --env GIT_REPO_URI=https://github.com/diethardsteiner/apache-hop-minimal-project.git \
  --env GIT_REPO_NAME=apache-hop-minimal-project \
  --name my-simple-hop-container \
  ${HOP_DOCKER_IMAGE}
```
  
# run with repo branch

```sh
export HOP_DOCKER_IMAGE=ambientelivre/hop-custom-with-git:2.4.0 
export PROJECT_DEPLOYMENT_DIR=/home/hop/apache-hop-minimal-project
```

```sh
docker run -it --rm \
  --env HOP_LOG_LEVEL=Basic \
  --env HOP_FILE_PATH='${PROJECT_HOME}/main.hwf' \
  --env HOP_PROJECT_FOLDER=${PROJECT_DEPLOYMENT_DIR} \
  --env HOP_PROJECT_NAME=apache-hop-minimum-project \
  --env HOP_ENVIRONMENT_NAME=dev \
  --env HOP_ENVIRONMENT_CONFIG_FILE_NAME_PATHS=${PROJECT_DEPLOYMENT_DIR}/dev-config.json \
  --env HOP_RUN_CONFIG=local \
  --env HOP_CUSTOM_ENTRYPOINT_EXTENSION_SHELL_FILE_PATH=/home/hop/clone-git-repo.sh \
  --env GIT_REPO_URI=https://github.com/diethardsteiner/apache-hop-minimal-project.git \
  --env GIT_REPO_NAME=apache-hop-minimal-project \
  --env GIT_REPO_BRANCH=main \
  --name my-simple-hop-container \
  ${HOP_DOCKER_IMAGE}  
```

# run with repo branch and sparse-checkout

```sh
export HOP_DOCKER_IMAGE=ambientelivre/hop-custom-with-git:2.4.0 
export PROJECT_DEPLOYMENT_DIR=/home/hop/apache-hop-minimal-project
```

```sh
docker run -it --rm \
  --env HOP_LOG_LEVEL=Basic \
  --env HOP_FILE_PATH='${PROJECT_HOME}/main.hwf' \
  --env HOP_PROJECT_FOLDER=${PROJECT_DEPLOYMENT_DIR} \
  --env HOP_PROJECT_NAME=apache-hop-minimum-project \
  --env HOP_ENVIRONMENT_NAME=dev \
  --env HOP_ENVIRONMENT_CONFIG_FILE_NAME_PATHS=${PROJECT_DEPLOYMENT_DIR}/dev-config.json \
  --env HOP_RUN_CONFIG=local \
  --env HOP_CUSTOM_ENTRYPOINT_EXTENSION_SHELL_FILE_PATH=/home/hop/clone-git-repo.sh \
  --env GIT_REPO_URI=https://github.com/diethardsteiner/apache-hop-minimal-project.git \
  --env GIT_REPO_NAME=apache-hop-minimal-project \
  --env GIT_REPO_BRANCH=main \
  --env GIT_REPO_CLI=metadata \
  --name my-simple-hop-container \
  ${HOP_DOCKER_IMAGE}  
```

## Importar uma Imagem do Docker Hub para Azure

```sh
az login
az acr import --name SUAEMPRESA --source docker.io/ambientelivre/hop-custom-with-git:2.4.0 --image hop-custom-with-git:2.4.0
```

## fazer o pull no Azure Registry 

```sh
az acr login --name <meuacr>
docker pull ambientelivre/hop-custom-with-git:2.4.0
docker tag ambientelivre/hop-custom-with-git:2.4.0 meuacr.azurecr.io/hop-SUAEMPRESA:2.4.0
docker push meuacr.azurecr.io/hop-SUAEMPRESA:2.4.0
```


## fazer o pull no Docker hub

```sh 
docker login 
docker tag hop-custom-with-git:2.4.0 ambientelivre/hop-custom-with-git:2.4.0
docker image ls
docker tag ambientelivre/hop-custom-with-git:2.4.0 ambientelivre/hop-custom-with-git:2.4.0
docker push ambientelivre/hop-custom-with-git:2.4.0 
```




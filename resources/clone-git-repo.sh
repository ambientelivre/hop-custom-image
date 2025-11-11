#!/bin/bash
#cd /home/hop
#git clone ${GIT_REPO_URI}
#chown -R hop:hop /home/hop/${GIT_REPO_NAME}
cd /home/hop

if [ -n "${GIT_REPO_URI}" ] && [ -z "${GIT_REPO_BRANCH}" ]; then
  echo "[gitscript] Cloning repository ${GIT_REPO_URI}..."
  git clone --depth 1 ${GIT_REPO_URI}
elif [ -n "${GIT_REPO_URI}" ] && [ -n "${GIT_REPO_BRANCH}" ]; then
  echo "[gitscript]  Cloning repository ${GIT_REPO_URI} with branch ${GIT_REPO_BRANCH}..."
  git clone --branch ${GIT_REPO_BRANCH} --depth 1 ${GIT_REPO_URI}
fi

if [ -n "${GIT_REPO_NAME}" ]; then
  echo "[gitscript] Entry in ${GIT_REPO_NAME}..."
  cd ${GIT_REPO_NAME}

  if [ -n "${GIT_REPO_CLI}" ]; then
    echo "[gitscript] Apply sparse-checkout in ${GIT_REPO_CLI}..."
    git sparse-checkout init --cone
    git sparse-checkout set "${GIT_REPO_CLI}"  
  fi  

  echo "[gitscript] Apply permissions hop user to ${GIT_REPO_NAME}..."  
  chown -R hop:hop /home/hop/${GIT_REPO_NAME}
fi

# create hop-config.json
if [[ -n "${AZURE_ACCOUNT_NAME:-}" && -n "${AZURE_ACCOUNT_KEY:-}" ]]; then
  echo "[azurescript] Creating hop-config.json"
  cat <<EOF > /opt/hop/config/hop-config.json
{
    "LocaleDefault" : "en_US",
    "projectsConfig" : {
      "enabled" : true,
      "projectMandatory" : true,
      "defaultProject" : "default",
      "standardParentProject" : "default",
      "projectConfigurations" : [ {
        "projectName" : "default",
        "projectHome" : "config/projects/default",
        "configFilename" : "project-config.json"
      }, {
        "projectName" : "samples",
        "projectHome" : "config/projects/samples",
        "configFilename" : "project-config.json"
      } ]
    },
    "azure" : {
    "account" : "${AZURE_ACCOUNT_NAME}",
    "key" : "${AZURE_ACCOUNT_KEY}",
    "blockIncrement" : "4096"
  }
}
EOF

  echo "[azurescript] Created /opt/hop/config/hop-config.json with Azure connection"
else
  echo "[azurescript] Skipping creation of hop-config.json, not all environment variables set"
fi
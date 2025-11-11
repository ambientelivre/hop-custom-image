## Custom by ambientelivre
# ------------------------------------------------------------------------------
# Dockerfile for Apache Hop
#
# This Dockerfile is designed to build a container for Apache Hop with optional
# repository cloning functionality. It will conditionally clone a repository
# into a specified directory if the TARGET_DIR environment variable is provided.
#
# Usage:
# - Define the TARGET_DIR build argument to specify the target directory where
#   the repository should be cloned.
# - Define the REPO_URL build argument to specify the URL of the Git repository.
#   The REPO_URL can include authentication details in the format:
#   https://<username>:<password>@<repository_url>.
#
# Build Example (with authentication):
# docker build --build-arg TARGET_DIR=/path/to/dir --build-arg REPO_URL=https://user:password@github.com/user/repo.git .
#
# Key Points:
# - The TARGET_DIR variable must be set if you want to clone a repository.
# - The script checks if the TARGET_DIR is non-empty and then performs the following:
#   1. Creates the directory (if not already existing).
#   2. Clones the repository specified in REPO_URL.
# - If the TARGET_DIR is not set or is empty, no cloning occurs.
#
# Authentication:
# - The REPO_URL can include the username and password for Git authentication.
# - Format for URL with authentication:
#   https://<username>:<password>@<repository_url>
#
# ------------------------------------------------------------------------------
# By Marcio Junior Vieira at marcio@ambientelivre.com.br
FROM apache/hop:2.4.0
USER root

# install git
RUN apk update \
  && apk add --no-cache git

ENV GIT_REPO_URI ""
ENV GIT_REPO_BRANCH ""
ENV GIT_REPO_NAME ""
ENV GIT_REPO_CLI ""

# Copy Script Git clone
COPY --chown=hop:hop ./resources/clone-git-repo.sh /home/hop/clone-git-repo.sh

# Copy drivers
COPY --chown=hop:hop ./resources/drivers/jtds-1.3.1.jar  /opt/hop/lib/core/
COPY --chown=hop:hop ./resources/drivers/DatabricksJDBC42.jar  /opt/hop/lib/core/
COPY --chown=hop:hop ./resources/drivers/jaybird-5.0.8.java11.jar  /opt/hop/lib/core/
COPY --chown=hop:hop ./resources/drivers/proprietary/ojdbc11-23.2.0.0.jar  /opt/hop/lib/core/
COPY --chown=hop:hop ./resources/drivers/mariadb-java-client-3.2.0.jar  /opt/hop/lib/core/



USER hop

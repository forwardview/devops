FROM debian:10.6

LABEL maintainer="sasha klepikov <kai@list.ru>"

# Install common packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils lsb-release curl gnupg2 software-properties-common

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install terraform \
    && terraform -install-autocomplete

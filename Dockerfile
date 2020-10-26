FROM debian:10.6

LABEL maintainer="sasha klepikov <kai@list.ru>"

# Install common packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils lsb-release curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update \
    && apt-get -y --no-install-recommends install terraform \
    && terraform -install-autocomplete

# Install Google Cloud SDK
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update \
    && apt-get -y --no-install-recommends install google-cloud-sdk

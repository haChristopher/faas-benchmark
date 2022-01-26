FROM hashicorp/terraform


# Install openfaas cli, arkade, gcloud and kubectl
RUN curl -sSL https://cli.openfaas.com | sudo -E sh
RUN curl -sLS https://get.arkade.dev | sudo sh

# Install java jdk and maven
RUN sudo apt-get -y install default-jdk

# Multi stage build reducing overall size
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
  && rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip \
  && unzip terraform_0.11.3_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm terraform_0.11.3_linux_amd64.zip


CMD ["/bin/bash"]
FROM hashicorp/terraform

RUN curl -SL https://cli.openfaas.com | sh

CMD ["/bin/bash"]
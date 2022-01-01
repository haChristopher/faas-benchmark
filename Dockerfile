FROM ubuntu:20.04

RUN curl -SL https://cli.openfaas.com | sh

CMD ["/bin/bash"]
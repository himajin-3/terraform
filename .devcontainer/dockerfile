FROM hashicorp/terraform:1.8.5

RUN apk add --update \
    git bash openssh \
    aws-cli \
    vim \
    git

RUN git config --global --add safe.directory /workspaces/terraform
#RUN echo "alias ll='ls -la --color'" >> ~/.bashrc && \
#    . ~/.bashrc

USER root
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["terraform"]

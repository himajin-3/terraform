FROM hashicorp/terraform:1.8.5

RUN apk add --update \
    git bash openssh \
    aws-cli \
    vim
ARG UID=1001
ARG GID=1001
#RUN useradd -u $UID -o -m kengo
#RUN groupmod -g $GID -o kengo

RUN echo "alias ll='ls -la --color'" >> ~/.bashrc && \
    . ~/.bashrc

USER root
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["terraform"]

FROM amazon/aws-cli:latest

RUN yum update -y
RUN yum install -y unzip jq tar gzip
RUN curl  -OL https://releases.hashicorp.com/terraform/1.3.4/terraform_1.3.4_linux_amd64.zip
RUN unzip terraform_1.3.4_linux_amd64.zip -d /bin

ENTRYPOINT ["/bin/bash"]
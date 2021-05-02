FROM registry.redhat.io/rhel8/dotnet-21

USER root

WORKDIR /dotnet

RUN yum install -y git && \
    yum clean all

COPY /entrypoint.sh .

ENTRYPOINT ["/dotnet/entrypoint.sh"]

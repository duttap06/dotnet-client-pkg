FROM registry.redhat.io/rhel8/dotnet-21

USER root

WORKDIR /dotnet

RUN yum install -y git && \
    yum clean all

COPY /entrypoint.sh .
COPY /nupkg/*.pem /etc/pki/entitlement
COPY /nupkg/*.pem /usr/local/share/ca-certificates

RUN chmod -R 644 /usr/local/share/ca-certificates
RUN update-ca-certificates

ENTRYPOINT ["/dotnet/entrypoint.sh"]

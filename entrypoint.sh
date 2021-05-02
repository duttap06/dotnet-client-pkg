#!/bin/bash

# Disable the mounting of the host's certs If you don't remove the /etc/rhsm-host mount, 
# you will not be able to use the entitlement as the entitlement will conflict with the ca provided by the host.

rm /etc/rhsm-host

# Install EPEL repo

dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Enable EPEL repo

dnf config-manager --set-enabled epel

# Enable RHEL8 repos

dnf config-manager --set-enabled rhel-8-for-x86_64-baseos-rpms
dnf config-manager --set-enabled rhel-8-for-x86_64-appstream-rpms

# Import the EPEL8 gpg signing key

rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8

# Install necessary RPMs to build

dnf install -y git unzip wget gcc-c++ cyrus-sasl-devel mono-winfx mono-wcf mono-devel swig cpio

# Clone repo that has code fixes

git clone https://github.com/worsco/dotnet-client
cd dotnet-client

# Switch to the branch for RHEL8

git checkout rhel8

# Build the app and create the .nupgk artifact

./build.sh
./build.sh QuickPack

cp /dotnet/dotnet-client/src/Infinispan.HotRod/bin/RelWithDebInfo/Infinispan.HotRod.8.2.0-Alpha2.nupkg /etc/pki/entitlement

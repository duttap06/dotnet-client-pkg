# dotnet-client-pkg
## Generate a NuGet package containing a .NET client with Hot Rod interface for Data Grid

### The following instructions have been modified from https://github.com/worsco/dotnet-client/blob/rhel8/README-rhel8_dotnet-21_container.md

### Pod entitled build (can be performed on RHEL7/RHEL8/FC host)
You need an entitlement for a RHEL8 system
Create a System in https://access.redhat.com/
Click on "Subscriptions"
Click on "Systems"
Click on "New"
System Type: [x] Virutal System
Name: rhel8-container
Architecture: x86_64
Number of vCPUs: 2
Red Hat Enterprise Linux Version: 8
Click on "CREATE"
Attach a subscription to that system
My example: Employee SKU
"Download Certificates" link is now available
Download the entitlement file (.zip file)
Create a directory for the entitlement *.pem and *-key.pem (we will be copying the *.pem file and creating *-key.pem from it)

``` sh
mkdir -p $HOME/Development/rhel8-entitlements/
```

Expand the contents of the downloaded subscription file (it's a long number with dashes ending with .zip)
Inside is a file named consumer_export.zip
Export the /export/entitlement_certificates/*.pem file into $HOME/Development/rhel8-entitlements/
You need to have two files in the $HOME/Development/rhel8-entitlements/, the *.pem, and a copy of that same file with *-key.pem ('-key' appended the the filename)
Log into registry.redhat.io as we will be downloading a container that requires a valid Red Hat account.

``` sh
podman login registry.redhat.io
```

The pod will be run as root, and also needs "--privileged" (when SELinux is enabled) so that we can mount the directory that contains the entitlement within the pod.

``` sh

Run the following from the folder you cloned this git repo in:

#Build the package with the supplied Dockerfile using buildah:
sudo buildah bud -t dotnet-nupkg .

#Run podman to generate the NuGet package and have it copied to the $HOME/Development/rhel8-entitlements folder:
chmod a+x ./podman-run.sh
./podman-run.sh
```

The following file will be copied to your $HOME/Development/rhel8-entitlements:

- Infinispan.HotRod.8.2.0-Alpha2.nupkg



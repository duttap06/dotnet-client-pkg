sudo podman run --privileged -it --user=root --name=dotnet-nupkg \
-v $HOME/Development/rhel8-entitlements/:/etc/pki/entitlement \
localhost/dotnet-nupkg \
["/bin/bash", "-c", "./entrypoint.sh"]

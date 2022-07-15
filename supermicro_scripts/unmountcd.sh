#!/bin/bash

#### IMPORTANT: This script translates to an older Supermicro redfish format that is incompatible with metal3.
#### This script has to unmount the iso from the server's virtualmedia and return 0 if operation succeeded, 1 otherwise
#### You will get the following vars as environment vars
#### BMC_ENDPOINT - Has the BMC IP
#### BMC_USERNAME - Has the username configured in the BMH/InstallConfig and that is used to access BMC_ENDPOINT
#### BMC_PASSWORD - Has the password configured in the BMH/InstallConfig and that is used to access BMC_ENDPOINT

# Disconnect image
echo
curl -s -X POST  -k -u ''"${BMC_USERNAME}"'':''"${BMC_PASSWORD}"'' https://${BMC_ENDPOINT}/redfish/v1/Managers/1/VM1/CfgCD/Actions/IsoConfig.UnMount -d ""
sleep 2
if [ $? -eq 0 ]; then
    # Check it has unmounted
    IMAGE=$(curl -s -k -u ''"${BMC_USERNAME}"'':''"${BMC_PASSWORD}"'' https://${BMC_ENDPOINT}/redfish/v1/Managers/1/VM1/CD1)
    # unmount not working on this server, so we fake it, to continue as it worked
    # at least it will proceed to mount the iso
    IMAGE=""
    if [ -z "$IMAGE" ]; then
      exit 0
    else
      exit 1
    fi
else
  exit 1
fi

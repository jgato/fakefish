#!/bin/bash

#### IMPORTANT: This script translates to an older Supermicro redfish format that is incompatible with metal3.
#### This script has to set the server's boot to once from cd and return 0 if operation succeeded, 1 otherwise
#### You will get the following vars as environment vars
#### BMC_ENDPOINT - Has the BMC IP
#### BMC_USERNAME - Has the username configured in the BMH/InstallConfig and that is used to access BMC_ENDPOINT
#### BMC_PASSWORD - Has the password configured in the BMH/InstallConfig and that is used to access BMC_ENDPOINT
echo
curl -s -X PATCH  -k -u ''"${BMC_USERNAME}"'':''"${BMC_PASSWORD}"'' https://${BMC_ENDPOINT}/redfish/v1/Systems/1 --data '{ "Boot":{"BootSourceOverrideEnabled":"Once","BootSourceOverrideMode":"UEFI","BootSourceOverrideTarget": "Cd"}}'
if [ $? -eq 0 ]; then
  exit 0
else
  exit 1
fi

#!/bin/bash

set -eou pipefail

printf "Filename: $1\n\n";
head $1 >> /dev/null
resource_group_name=$(grep '"resource_group_name"' $1 | head -1 | awk -F\" '{print $4}')
location=$(grep '"location"' $1 | head -1 | awk -F\" '{print $4}')
#network_security_group_id=$(grep '"network_security_group_id"' $1 | head -1 | awk -F\" '{print $4}')
network_security_group_id=$(grep -E '"network_security_group_id".*kubernetes' $1 | head -1 | awk -F\" '{print $4}')
subnet_id=$(grep -E '"subnet_id".*kubernetes' $1 | head -1 | awk -F\" '{print $4}')
public_ip_address_id=$(grep -E '"public_ip_address_id".*kubernetes.*node' $1 | awk -F\" '{print $4}')

printf "resource_group_name:\n$resource_group_name\n\n";
printf "location:\n$location\n\n";
printf "network_security_group_id:\n$network_security_group_id\n\n";
printf "subnet_id:\n$subnet_id\n\n";
printf "public_ip_address_id:\n$public_ip_address_id\n\n";
printf "Done!\n\n";


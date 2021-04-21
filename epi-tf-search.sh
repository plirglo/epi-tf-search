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

sug_last_public_ip_address_digit=$(grep -E '"public_ip_address_id".*kubernetes.*node' $1 | awk -F\" '{print $4}' | tail -n 1| grep -Eo '[0-9]+$' | awk '{print ($1)+1}')
remove_last_char=$(grep -E '"public_ip_address_id".*kubernetes.*node' $1 | awk -F\" '{print $4}' | tail -n 1| sed 's/.$//')

printf "resource_group_name:\n$resource_group_name\n\n";
printf "location:\n$location\n\n";
printf "network_security_group_id:\n$network_security_group_id\n\n";
printf "subnet_id:\n$subnet_id\n\n";
printf "public_ip_address_id:\n$public_ip_address_id\n\n";
printf "suggested next public_ip_address_id:\n$remove_last_char$sug_last_public_ip_address_digit\n\n";
printf "Done!\n\n";


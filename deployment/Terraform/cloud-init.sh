#!/bin/bash
snap install aws-cli --classic
printf "\nexport PUBLIC_HOSTNAME=\$(curl -s ${AwsMetadataServerUrl}/public-hostname)\n" >> /home/${UserName}/.profile
printf "export PUBLIC_IPV4=\$(curl -s ${AwsMetadataServerUrl}/public-ipv4)\n" >> /home/${UserName}/.profile
printf "echo \"env(PUBLIC_HOSTNAME) = \$PUBLIC_HOSTNAME\"\n" >> /home/${UserName}/.profile
printf "echo \"env(PUBLIC_IPV4) = \$PUBLIC_IPV4\"\n" >> /home/${UserName}/.profile
AgentInstanceType=$(curl -s ${AwsMetadataServerUrl}/instance-type)
AgentRegion=$(curl -s ${AwsMetadataServerUrl}/placement/region)
aws configure set region $AgentRegion
Agent1Eth1MacAddress=$(aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=${Agent1Eth1PrivateIpAddresses[0]} | jq .NetworkInterfaces[0].MacAddress --raw-output)
Agent2Eth1MacAddress=$(aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=${Agent2Eth1PrivateIpAddresses[0]} | jq .NetworkInterfaces[0].MacAddress --raw-output)
sed -i "s/00:AA:00:00:01:00/$Agent1Eth1MacAddress/g" /home/${UserName}/${GitRepoName}/configs/*.json
sed -i "s/00:AA:00:00:02:00/$Agent2Eth1MacAddress/g" /home/${UserName}/${GitRepoName}/configs/*.json
Agent1Eth2MacAddress=$(aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=${Agent1Eth2PrivateIpAddresses[0]} | jq .NetworkInterfaces[0].MacAddress --raw-output)
Agent2Eth2MacAddress=$(aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=${Agent2Eth2PrivateIpAddresses[0]} | jq .NetworkInterfaces[0].MacAddress --raw-output)
sed -i "s/00:AA:00:00:03:00/$Agent1Eth2MacAddress/g" /home/${UserName}/${GitRepoName}/configs/*.json
sed -i "s/00:AA:00:00:04:00/$Agent2Eth2MacAddress/g" /home/${UserName}/${GitRepoName}/configs/*.json
Agent1Eth3MacAddress=$(aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=${Agent1Eth3PrivateIpAddresses[0]} | jq .NetworkInterfaces[0].MacAddress --raw-output)
Agent2Eth3MacAddress=$(aws ec2 describe-network-interfaces --filters Name=addresses.private-ip-address,Values=${Agent2Eth3PrivateIpAddresses[0]} | jq .NetworkInterfaces[0].MacAddress --raw-output)
sed -i "s/00:AA:00:00:05:00/$Agent1Eth3MacAddress/g" /home/${UserName}/${GitRepoName}/configs/*.json
sed -i "s/00:AA:00:00:06:00/$Agent2Eth3MacAddress/g" /home/${UserName}/${GitRepoName}/configs/*.json
AgentInstanceTypeSpeed=$(aws ec2 describe-instance-types --filters "Name=instance-type,Values=$AgentInstanceType" --query "InstanceTypes[].[InstanceType, NetworkInfo.NetworkPerformance]" | jq .[0][1] | tr -dc '0-9')
sed -i "s/speed_10_gbps/speed_AgentInstanceTypeSpeed_gbps/g" /home/${UserName}/${GitRepoName}/configs/*.json
sed -i "s/AgentInstanceTypeSpeed/$AgentInstanceTypeSpeed/g" /home/${UserName}/${GitRepoName}/configs/*.json
sed -i "s/speed_10_gbps/speed_AgentInstanceTypeSpeed_gbps/g" /home/${UserName}/${GitRepoName}/*.json
sed -i "s/AgentInstanceTypeSpeed/$AgentInstanceTypeSpeed/g" /home/${UserName}/${GitRepoName}/*.json
locals {
	AgentInstanceType = var.AgentInstanceType
	Agent1InstanceId = "agent1"
	Agent1Eth1PrivateIpAddresses = [ "10.0.2.12", "10.0.2.13" ]
	Agent1Eth2PrivateIpAddresses = [ "10.0.2.32", "10.0.2.33" ]
	Agent1Eth3PrivateIpAddresses = [ "10.0.2.52", "10.0.2.53" ]
	Agent2Eth0PrivateIpAddress = "10.0.10.12"
	Agent2Eth1PrivateIpAddresses = [ "10.0.2.22", "10.0.2.23" ]
	Agent2Eth2PrivateIpAddresses = [ "10.0.2.42", "10.0.2.43" ]
	Agent2Eth3PrivateIpAddresses = [ "10.0.2.62", "10.0.2.63" ]
	Agent2InstanceId = "agent2"
	AppTag = "ubuntu"
	AppVersion = "2204-lts"
	AwsMetadataServerUrl = var.AwsMetadataServerUrl
	GitRepoName = var.GitRepoName
	GitRepoUrl = var.GitRepoUrl
	InboundIPv4CidrBlocks = var.InboundIPv4CidrBlocks
	KengContainerRegistry = var.KengContainerRegistry
	KengContainerRegistryUser = var.KengContainerRegistryUser
	KengContainerRegistryToken = var.KengContainerRegistryToken
	KengControllerImage = var.KengControllerImage
	KengTrafficEngineImage = var.KengTrafficEngineImage
	PackerUserName = "ubuntu"
	PlacementGroupName = "${local.Preamble}-placement-group-${local.Region}"
	PlacementGroupStrategy = "cluster"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}-${local.AppVersion}"
	PrivateSubnetAvailabilityZone = var.PrivateSubnetAvailabilityZone
	PublicSubnetAvailabilityZone = var.PublicSubnetAvailabilityZone
	Region = data.aws_region.current.name
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag
	UserLoginTag = var.UserLoginTag
	UserProjectTag = var.UserProjectTag
}
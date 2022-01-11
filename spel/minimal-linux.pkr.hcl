# Guidance on naming and organizing variables
#
# Variable names are prefixed by builder, or by amigen project. Any variables
# used by many builders are prefixed with the keyword `spel`. Variables are grouped
# by their prefix. Current prefixes
# include:
#   * aws - amazon-ebs builder
#   * azure - azure-arm builder
#   * openstack - openstack builder
#   * virtualbox - virtualbox builder
#   * amigen - used by both amigen7 and amigen8
#   * amigen7 - amigen7 only
#   * amigen8 - amigen8 only
#   * spel - everything else
#
# For variables passed to a builder argument, just apply prefix to the argument
# name. Do not "reinterpret" the argument and create a new name. E.g. for the
# argument `instance_type`, the variable name should be `aws_instance_type`.
#
# For variables used by amigen, consider what the variable is actually being applied
# to within the amigen project, and provide a descriptive name. Avoid abbreviations!
#
# Within each prefix, all variables should be sort alphabetically by name.

###
# Variables for AWS builders
###

variable "aws_ami_groups" {
  description = "List of groups that have access to launch the resulting AMIs. Keyword `all` will make the AMIs publicly accessible"
  type        = list(string)
  default     = []
}

variable "aws_ami_regions" {
  description = "List of regions to copy the AMIs to. Tags and attributes are copied along with the AMIs"
  type        = list(string)
  default     = []
}

variable "aws_ami_users" {
  description = "List of account IDs that have access to launch the resulting AMIs"
  type        = list(string)
  default     = []
}

variable "aws_instance_type" {
  description = "EC2 instance type to use while building the AMIs"
  type        = string
  default     = "t3.2xlarge"
}

variable "aws_force_deregister" {
  description = "Force deregister an existing AMI if one with the same name already exists"
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "Name of the AWS region in which to launch the EC2 instance to create the AMIs"
  type        = string
  default     = "us-east-1"
}

variable "aws_source_ami_centos7_hvm" {
  description = "Source AMI for CentOS 7 HVM builds"
  type        = string
  default     = "ami-00e87074e52e6c9f9"
}

variable "aws_source_ami_centos8stream_hvm" {
  description = "Source AMI for CentOS Stream 8 HVM builds"
  type        = string
  default     = "ami-0ee70e88eed976a1b"
}

variable "aws_source_ami_rhel7_hvm" {
  description = "Source AMI for RHEL 7 HVM builds"
  type        = string
  default     = "ami-073955d8665a7a9e7"
}

variable "aws_source_ami_rhel8_hvm" {
  description = "Source AMI for RHEL 8 HVM builds"
  type        = string
  default     = "ami-06644055bed38ebd9"
}

variable "aws_ssh_interface" {
  description = "Specifies method used to select the value for the host in the SSH connection"
  type        = string
  default     = "public_dns"

  validation {
    condition     = contains(["public_ip", "private_ip", "public_dns", "private_dns", "session_manager"], var.aws_ssh_interface)
    error_message = "Variable `aws_ssh_interface` must be one of: public_ip, private_ip, public_dns, private_dns, or session_manager."
  }
}

variable "aws_subnet_id" {
  description = "ID of the subnet where Packer will launch the EC2 instance. Required if using an non-default VPC"
  type        = string
  default     = null
}

variable "aws_temporary_security_group_source_cidrs" {
  description = "List of IPv4 CIDR blocks to be authorized access to the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

###
# Variables for Azure builders
###

variable "azure_build_resource_group_name" {
  description = "Existing resource group in which the build will run"
  type        = string
  default     = null
}

variable "azure_client_id" {
  description = "Application ID of the AAD Service Principal. Requires either client_secret, client_cert_path or client_jwt to be set as well"
  type        = string
  default     = env("ARM_CLIENT_ID")
}

variable "azure_client_secret" {
  description = "Password/secret registered for the AAD Service Principal"
  type        = string
  default     = env("ARM_CLIENT_SECRET")
}

variable "azure_cloud_environment_name" {
  description = "One of Public, China, Germany, or USGovernment. Defaults to Public. Long forms such as USGovernmentCloud and AzureUSGovernmentCloud are also supported"
  type        = string
  default     = "Public"
}

variable "azure_custom_managed_image_name_centos7" {
  description = "Name of a custom managed image to use as the base image for CentOS7 builds"
  type        = string
  default     = null
}

variable "azure_custom_managed_image_resource_group_name_centos7" {
  description = "Name of the resource group for the custom image in `azure_custom_managed_image_name_centos7`"
  type        = string
  default     = null
}

variable "azure_custom_managed_image_name_rhel7" {
  description = "Name of a custom managed image to use as the base image for RHEL7 builds"
  type        = string
  default     = null
}

variable "azure_custom_managed_image_resource_group_name_rhel7" {
  description = "Name of the resource group for the custom image in `azure_custom_managed_image_name_rhel7`"
  type        = string
  default     = null
}

variable "azure_location" {
  description = "Azure datacenter in which your VM will build"
  type        = string
  default     = null
}

variable "azure_private_virtual_network_with_public_ip" {
  type    = bool
  default = null
}

variable "azure_resource_group_name" {
  description = "Resource group name where the result of the Packer build will be saved. The resource group must already exist"
  type        = string
  default     = null
}

variable "azure_subscription_id" {
  type    = string
  default = env("ARM_SUBSCRIPTION_ID")
}

variable "azure_virtual_network_name" {
  description = "Name of a pre-existing virtual network in which to run the build"
  type        = string
  default     = null
}

variable "azure_virtual_network_resource_group_name" {
  description = "Name of the virtual network resource group in which to run the build"
  type        = string
  default     = null
}

variable "azure_virtual_network_subnet_name" {
  description = "Name of the subnet in which to run the build"
  type        = string
  default     = null
}

variable "azure_vm_size" {
  type    = string
  default = "Standard_DS5_v2"
}

###
# Variables for Openstack builders
###

variable "openstack_insecure" {
  description = "Boolean whether the connection to OpenStack can be done over an insecure connection"
  type        = bool
  default     = false
}

variable "openstack_flavor" {
  description = "ID, name, or full URL for the desired flavor for the server to be created"
  type        = string
  default     = null
}

variable "openstack_floating_ip_network_name" {
  description = "ID or name of an external network that can be used for creation of a new floating IP"
  type        = string
  default     = null
}

variable "openstack_networks" {
  description = "List of networks by UUID to attach to this instance"
  type        = list(string)
  default     = []
}

variable "openstack_security_groups" {
  description = "List of security groups by name to add to this instance"
  type        = list(string)
  default     = []
}

variable "openstack_source_image_name" {
  description = "Name of the base image to use"
  type        = string
  default     = null
}

###
# Variables for Virtualbox/Vagrant builds
###

variable "virtualbox_iso_url_centos7" {
  description = "URL to the CentOS7 .iso to use for Virtualbox builds"
  type        = string
  default     = "http://mirror.cs.vt.edu/pub/CentOS/7/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso"
}

variable "virtualbox_iso_url_centos8" {
  description = "URL to the CentOS8 .iso to use for Virtualbox builds"
  type        = string
  default     = "http://mirror.cs.vt.edu/pub/CentOS/8/isos/x86_64/CentOS-8.1.1911-x86_64-dvd1.iso"
}

variable "virtualbox_vagrantcloud_username" {
  description = "Vagrant Cloud username, used to namespace the vagrant boxes"
  type        = string
  default     = null
}

###
# Variables used by all AMIGEN platforms
###

variable "amigen_build_device" {
  description = "Path of the build device that will be partitioned to create the image"
  type        = string
  default     = "/dev/nvme0n1"
}

variable "amigen_amiutils_source_url" {
  description = "URL of the AMI Utils repo to be cloned using git, containing AWS utility rpms that will be installed to the AMIs"
  type        = string
  default     = ""
}

variable "amigen_aws_cfnbootstrap" {
  description = "URL of the tar.gz bundle containing the CFN bootstrap utilities"
  type        = string
  default     = "https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz"
}

variable "amigen_aws_cliv1_source" {
  description = "URL of the .zip bundle containing the installer for AWS CLI v1"
  type        = string
  default     = "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
}

variable "amigen_aws_cliv2_source" {
  description = "URL of the .zip bundle containing the installer for AWS CLI v2"
  type        = string
  default     = "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
}

variable "amigen_fips_disable" {
  description = "Toggles whether FIPS will be disabled in the images"
  type        = bool
  default     = false
}

variable "amigen_extra_rpms" {
  description = "List of package specs (rpm names or URLs to .rpm files) to install to the builders and images"
  type        = list(string)
  default = [
    "python36",
    "spel-release",
    "ec2-hibinit-agent",
    "ec2-instance-connect",
    "ec2-net-utils",
    "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm",
  ]
}

variable "amigen_grub_timeout" {
  description = "Timeout value to set in the grub config of each image"
  type        = number
  default     = 1
}

variable "amigen_use_default_repos" {
  description = "Modifies the behavior of `amigen_repo_names`. When true, `amigen_repo_names` are appended to the enabled repos. When false, `amigen_repo_names` are used exclusively"
  type        = bool
  default     = true
}

###
# Variables used by AMIgen7
###

variable "amigen7_filesystem_label" {
  description = "Label for the root filesystem when creating bare partitions for EL7 images"
  type        = string
  default     = ""
}

variable "amigen7_package_groups" {
  description = "List of yum repo groups to install into EL7 images"
  type        = list(string)
  default     = ["core"]
}

variable "amigen7_package_manifest" {
  description = "File containing a list of RPMs to use as the build manifest for EL7 images"
  type        = string
  default     = ""
}

variable "amigen7_repo_names" {
  description = "List of yum repo names to enable in the EL7 builders and images"
  type        = list(string)
  default     = ["spel"]
}

variable "amigen7_repo_sources" {
  description = "List of yum package refs (names or urls to .rpm files) that install yum repo definitions in EL7 builders and images"
  type        = list(string)
  default = [
    "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
    "https://spel-packages.cloudarmor.io/spel-packages/repo/spel-release-latest-7.noarch.rpm",
  ]
}

variable "amigen7_source_branch" {
  description = "Branch that will be checked out when cloning AMIgen7"
  type        = string
  default     = "master"
}

variable "amigen7_source_url" {
  description = "URL that will be used to clone AMIgen7"
  type        = string
  default     = "https://github.com/plus3it/AMIgen7.git"
}

variable "amigen7_storage_layout" {
  description = "List of colon-separated tuples (mount:name:size) that describe the desired partitions for LVM-partitioned disks on EL7 images"
  type        = list(string)
  default = [
    "/:rootVol:4",
    "swap:swapVol:2",
    "/home:homeVol:1",
    "/var:varVol:2",
    "/var/log:logVol:2",
    "/var/log/audit:auditVol:100%FREE",
  ]
}

###
# Variables used by AMIgen8
###

variable "amigen8_filesystem_label" {
  description = "Label for the root filesystem when creating bare partitions for EL8 images"
  type        = string
  default     = ""
}

variable "amigen8_package_groups" {
  description = "List of yum repo groups to install into EL8 images"
  type        = list(string)
  default     = ["core"]
}

variable "amigen8_package_manifest" {
  description = "File containing a list of RPMs to use as the build manifest for EL8 images"
  type        = string
  default     = ""
}

variable "amigen8_repo_names" {
  description = "List of yum repo names to enable in the EL8 builders and EL8 images"
  type        = list(string)
  default     = ["spel"]
}

variable "amigen8_repo_sources" {
  description = "List of yum package refs (names or urls to .rpm files) that install yum repo definitions in EL8 builders and images"
  type        = list(string)
  default = [
    "https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
    "https://spel-packages.cloudarmor.io/spel-packages/repo/spel-release-latest-8.noarch.rpm",
  ]
}

variable "amigen8_source_branch" {
  description = "Branch that will be checked out when cloning AMIgen8"
  type        = string
  default     = "master"
}

variable "amigen8_source_url" {
  description = "URL that will be used to clone AMIgen8"
  type        = string
  default     = "https://github.com/plus3it/AMIgen8.git"
}

variable "amigen8_storage_layout" {
  description = "List of colon-separated tuples (mount:name:size) that describe the desired partitions for LVM-partitioned disks on EL8 images"
  type        = list(string)
  default     = []
}

###
# Variables specific to spel
###

variable "spel_description_url" {
  description = "URL included in the AMI description"
  type        = string
  default     = "https://github.com/plus3it/spel"
}

variable "spel_http_proxy" {
  description = "Used as the value for the git config http.proxy setting in the builder nodes"
  type        = string
  default     = ""
}

variable "spel_identifier" {
  description = "Namespace that prefixes the name of the built images"
  type        = string
}

variable "spel_root_volume_size" {
  description = "Size in GB of the root volume"
  type        = number
  default     = 20
}

variable "spel_ssh_username" {
  description = "Name of the user for the ssh connection to the instance. Defaults to `spel`, which is set by cloud-config userdata. If your starting image does not have `cloud-init` installed, override the default user name"
  type        = string
  default     = "spel"
}

variable "spel_version" {
  description = "Version appended to the name of the built images"
  type        = string
}

###
# End of variables blocks
###
# Start of source blocks
###

source "amazon-ebs" "base" {
  ami_groups                  = var.aws_ami_groups
  ami_name                    = "${var.spel_identifier}-${source.name}-${var.spel_version}.x86_64-gp2"
  ami_regions                 = var.aws_ami_regions
  ami_users                   = var.aws_ami_users
  associate_public_ip_address = true
  communicator                = "ssh"
  ena_support                 = true
  force_deregister            = var.aws_force_deregister
  instance_type               = var.aws_instance_type
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = var.spel_root_volume_size
    volume_type           = "gp2"
  }
  max_retries                           = 20
  region                                = var.aws_region
  sriov_support                         = true
  ssh_interface                         = var.aws_ssh_interface
  ssh_port                              = 22
  ssh_pty                               = true
  ssh_timeout                           = "60m"
  ssh_username                          = var.spel_ssh_username
  subnet_id                             = var.aws_subnet_id
  temporary_security_group_source_cidrs = var.aws_temporary_security_group_source_cidrs
  user_data_file                        = "${path.root}/userdata/userdata.cloud"
}

source "azure-arm" "base" {
  client_id                              = var.azure_client_id
  client_secret                          = var.azure_client_secret
  cloud_environment_name                 = var.azure_cloud_environment_name
  communicator                           = "ssh"
  custom_data_file                       = "${path.root}/userdata/userdata.cloud"
  location                               = var.azure_location
  managed_image_name                     = "${var.spel_identifier}-${source.name}-${var.spel_version}"
  managed_image_resource_group_name      = var.azure_resource_group_name
  os_disk_size_gb                        = var.spel_root_volume_size
  os_type                                = "Linux"
  private_virtual_network_with_public_ip = var.azure_private_virtual_network_with_public_ip
  ssh_port                               = 22
  ssh_pty                                = true
  ssh_timeout                            = "60m"
  ssh_username                           = var.spel_ssh_username
  subscription_id                        = var.azure_subscription_id
  use_azure_cli_auth                     = true
  virtual_network_name                   = var.azure_virtual_network_name
  virtual_network_resource_group_name    = var.azure_virtual_network_resource_group_name
  virtual_network_subnet_name            = var.azure_virtual_network_subnet_name
  vm_size                                = var.azure_vm_size
}

source "openstack" "base" {
  flavor                  = var.openstack_flavor
  floating_ip_network     = var.openstack_floating_ip_network_name
  image_name              = "${var.spel_identifier}-${source.name}-${var.spel_version}.x86_64"
  insecure                = var.openstack_insecure
  networks                = var.openstack_networks
  security_groups         = var.openstack_security_groups
  source_image_name       = var.openstack_source_image_name
  ssh_port                = 22
  ssh_timeout             = "30m"
  ssh_username            = var.spel_ssh_username
  use_blockstorage_volume = "false"
  user_data_file          = "${path.root}/userdata/userdata.cloud"
}

source "virtualbox-iso" "base" {
  boot_wait               = "10s"
  disk_size               = 20480
  format                  = "ova"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "RedHat_64"
  headless                = true
  http_directory          = "${path.root}/kickstarts"
  output_directory        = ".spel/${var.spel_version}/${var.spel_identifier}-${source.name}"
  shutdown_command        = "echo '/sbin/halt -h -p' > shutdown.sh; echo 'vagrant'|sudo -S bash 'shutdown.sh'"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  ssh_username            = "vagrant"
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.spel_identifier}-${source.name}-${var.spel_version}"
}

###
# End of source blocks
###
# Start of locals block
###

locals {
  # Join lists to create strings appropriate for environment variables and AMIgen
  # expectations. AMIgen expects some vars to be comma-delimited, and others to
  # be space-delimited.
  amigen_extra_rpms      = join(",", var.amigen_extra_rpms)
  amigen7_package_groups = join(" ", var.amigen7_package_groups) # space-delimited
  amigen7_repo_names     = join(",", var.amigen7_repo_names)
  amigen7_repo_sources   = join(",", var.amigen7_repo_sources)
  amigen7_storage_layout = join(",", var.amigen7_storage_layout)
  amigen8_repo_names     = join(",", var.amigen8_repo_names)
  amigen8_repo_sources   = join(",", var.amigen8_repo_sources)
  amigen8_storage_layout = join(",", var.amigen8_storage_layout)
}

###
# End of locals block
###
# Start of build bock
###

build {
  source "amazon-ebs.base" {
    ami_description = "STIG-partitioned [*NOT HARDENED*], LVM-enabled, \"minimal\" CentOS 7 AMI, with updates through ${formatdate("YYYY-MM-DD", timestamp())}. Default username `maintuser`. See ${var.spel_description_url}."
    name            = "minimal-centos-7-hvm"
    source_ami      = var.aws_source_ami_centos7_hvm
  }

  source "amazon-ebs.base" {
    ami_description = "STIG-partitioned [*NOT HARDENED*], LVM-enabled, \"minimal\" CentOS Stream 8 AMI, with updates through ${formatdate("YYYY-MM-DD", timestamp())}. Default username `maintuser`. See ${var.spel_description_url}."
    name            = "minimal-centos-8stream-hvm"
    source_ami      = var.aws_source_ami_centos8stream_hvm
  }

  source "amazon-ebs.base" {
    ami_description = "STIG-partitioned [*NOT HARDENED*], LVM-enabled, \"minimal\" RHEL 7 AMI (yum and license chargeback included) with updates through ${formatdate("YYYY-MM-DD", timestamp())}. Default username `maintuser`. See ${var.spel_description_url}."
    name            = "minimal-rhel-7-hvm"
    source_ami      = var.aws_source_ami_rhel7_hvm
  }

  source "amazon-ebs.base" {
    ami_description = "STIG-partitioned [*NOT HARDENED*], LVM-enabled, \"minimal\" RHEL 8 AMI, with updates through ${formatdate("YYYY-MM-DD", timestamp())}. Default username `maintuser`. See ${var.spel_description_url}."
    name            = "minimal-rhel-8-hvm"
    source_ami      = var.aws_source_ami_rhel8_hvm
  }

  source "azure-arm.base" {
    custom_managed_image_name                = var.azure_custom_managed_image_name_centos7
    custom_managed_image_resource_group_name = var.azure_custom_managed_image_resource_group_name_centos7
    name                                     = "minimal-centos-7-image"
  }

  source "azure-arm.base" {
    custom_managed_image_name                = var.azure_custom_managed_image_name_rhel7
    custom_managed_image_resource_group_name = var.azure_custom_managed_image_resource_group_name_rhel7
    name                                     = "minimal-rhel-7-image"
  }

  source "openstack.base" {
    name = "minimal-centos-7-image"
  }

  source "virtualbox-iso.base" {
    boot_command = ["<esc><wait>", "linux ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.centos7.minimal.cfg VAGRANT", "<enter><wait>"]
    name         = "minimal-centos-7"
    iso_checksum = "file:http://mirror.cs.vt.edu/pub/CentOS/7/isos/x86_64/sha256sum.txt"
    iso_url      = var.virtualbox_iso_url_centos7
  }

  provisioner "file" {
    destination = "/tmp/retry.sh"
    only = [
      "virtualbox-iso.minimal-centos-7",
    ]
    source = "${path.root}/scripts/retry.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant'|sudo -S -E /bin/sh -ex '{{ .Path }}'"
    only = [
      "virtualbox-iso.minimal-centos-7",
    ]
    scripts = [
      "${path.root}/scripts/base.sh",
      "${path.root}/scripts/virtualbox.sh",
      "${path.root}/scripts/vmware.sh",
      "${path.root}/scripts/vagrant.sh",
      "${path.root}/scripts/dep.sh",
      "${path.root}/scripts/cleanup.sh",
      "${path.root}/scripts/zerodisk.sh",
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E /bin/sh -ex '{{ .Path }}'"
    inline = [
      "/usr/bin/cloud-init status --wait",
      "setenforce 0",
      "yum -y update",
    ]
    only = [
      "amazon-ebs.minimal-centos-7-hvm",
      "amazon-ebs.minimal-centos-8stream-hvm",
      "amazon-ebs.minimal-rhel-7-hvm",
      "amazon-ebs.minimal-rhel-8-hvm",
      "azure-arm.minimal-centos-7-image",
      "azure-arm.minimal-rhel-7-image",
      "openstack.minimal-centos-7-image",
    ]
  }

  provisioner "shell" {
    execute_command   = "{{ .Vars }} sudo -E /bin/sh '{{ .Path }}'"
    expect_disconnect = true
    only = [
      "amazon-ebs.minimal-centos-7-hvm",
      "amazon-ebs.minimal-centos-8stream-hvm",
      "amazon-ebs.minimal-rhel-7-hvm",
      "amazon-ebs.minimal-rhel-8-hvm",
      "azure-arm.minimal-centos-7-image",
      "azure-arm.minimal-rhel-7-image",
      "openstack.minimal-centos-7-image",
    ]
    scripts = [
      "${path.root}/scripts/pivot-root.sh",
    ]
    start_retry_timeout = "15m"
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E /bin/sh -ex '{{ .Path }}'"
    inline = [
      "echo Restarting systemd",
      "systemctl daemon-reexec",
      "echo Killing processes locking /oldroot",
      "fuser -vmk /oldroot",
    ]
    only = [
      "amazon-ebs.minimal-centos-7-hvm",
      "amazon-ebs.minimal-centos-8stream-hvm",
      "amazon-ebs.minimal-rhel-7-hvm",
      "amazon-ebs.minimal-rhel-8-hvm",
      "azure-arm.minimal-centos-7-image",
      "azure-arm.minimal-rhel-7-image",
      "openstack.minimal-centos-7-image",
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E /bin/sh -ex '{{ .Path }}'"
    inline = [
      "echo Unmounting /oldroot",
      "test $(grep -c /oldroot /proc/mounts) -eq 0 || umount /oldroot",
      "echo Unmounting /boot",
      "test $(grep -c /boot /proc/mounts) -eq 0 || umount /boot",
      "echo Unmounting /mnt",
      "test $(grep -c /mnt /proc/mounts) -eq 0 || umount /mnt",
    ]
    only = [
      "amazon-ebs.minimal-centos-7-hvm",
      "amazon-ebs.minimal-rhel-7-hvm",
      "azure-arm.minimal-centos-7-image",
      "azure-arm.minimal-rhel-7-image",
      "openstack.minimal-centos-7-image",
    ]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E /bin/sh -ex '{{ .Path }}'"
    inline = [
      "echo Unmounting /oldroot",
      "test $( grep -c /oldroot /proc/mounts ) -eq 0 || umount /oldroot",
    ]
    only = [
      "amazon-ebs.minimal-centos-8stream-hvm",
      "amazon-ebs.minimal-rhel-8-hvm",
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "SPEL_AMIGENBRANCH=${var.amigen7_source_branch}",
      "SPEL_AMIGENBUILDDEV=${var.amigen_build_device}",
      "SPEL_AMIGENCHROOT=/mnt/ec2-root",
      "SPEL_AMIGENMANFST=${var.amigen7_package_manifest}",
      "SPEL_AMIGENPKGGRP=${local.amigen7_package_groups}",
      "SPEL_AMIGENREPOS=${local.amigen7_repo_names}",
      "SPEL_AMIGENREPOSRC=${local.amigen7_repo_sources}",
      "SPEL_AMIGENROOTNM=${var.amigen7_filesystem_label}",
      "SPEL_AMIGENSOURCE=${var.amigen7_source_url}",
      "SPEL_AMIGENSTORLAY=${local.amigen7_storage_layout}",
      "SPEL_AMIGENVGNAME=VolGroup00",
      "SPEL_AMIUTILSSOURCE=${var.amigen_amiutils_source_url}",
      "SPEL_AWSCFNBOOTSTRAP=${var.amigen_aws_cfnbootstrap}",
      "SPEL_AWSCLIV1SOURCE=${var.amigen_aws_cliv1_source}",
      "SPEL_AWSCLIV2SOURCE=${var.amigen_aws_cliv2_source}",
      "SPEL_BOOTLABEL=/boot",
      "SPEL_BUILDDEPS=lvm2 parted yum-utils unzip git",
      "SPEL_BUILDNAME=${source.name}",
      "SPEL_CLOUDPROVIDER=aws",
      "SPEL_EXTRARPMS=${local.amigen_extra_rpms}",
      "SPEL_FIPSDISABLE=${var.amigen_fips_disable}",
      "SPEL_GRUBTMOUT=${var.amigen_grub_timeout}",
      "SPEL_USEDEFAULTREPOS=${var.amigen_use_default_repos}",
    ]
    execute_command = "{{ .Vars }} sudo -E /bin/sh '{{ .Path }}'"
    only = [
      "amazon-ebs.minimal-centos-7-hvm",
      "amazon-ebs.minimal-rhel-7-hvm",
    ]
    scripts = [
      "${path.root}/scripts/amigen7-build.sh",
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "SPEL_AMIGENBRANCH=${var.amigen7_source_branch}",
      "SPEL_AMIGENBUILDDEV=/dev/vda",
      "SPEL_AMIGENCHROOT=/mnt/ec2-root",
      "SPEL_AMIGENMANFST=${var.amigen7_package_manifest}",
      "SPEL_AMIGENPKGGRP=${local.amigen7_package_groups}",
      "SPEL_AMIGENREPOS=${local.amigen7_repo_names}",
      "SPEL_AMIGENREPOSRC=${local.amigen7_repo_sources}",
      "SPEL_AMIGENSOURCE=${var.amigen7_source_url}",
      "SPEL_AMIGENSTORLAY=${local.amigen7_storage_layout}",
      "SPEL_AMIGENVGNAME=VolGroup00",
      "SPEL_AMIUTILSSOURCE=${var.amigen_amiutils_source_url}",
      "SPEL_AWSCFNBOOTSTRAP=${var.amigen_aws_cfnbootstrap}",
      "SPEL_AWSCLIV1SOURCE=${var.amigen_aws_cliv1_source}",
      "SPEL_AWSCLIV2SOURCE=${var.amigen_aws_cliv2_source}",
      "SPEL_BOOTLABEL=/boot",
      "SPEL_BUILDDEPS=lvm2 parted yum-utils unzip git",
      "SPEL_BUILDNAME=${source.name}",
      "SPEL_CLOUDPROVIDER=openstack",
      "SPEL_EXTRARPMS=${local.amigen_extra_rpms}",
      "SPEL_FIPSDISABLE=${var.amigen_fips_disable}",
      "SPEL_GRUBTMOUT=${var.amigen_grub_timeout}",
      "SPEL_USEDEFAULTREPOS=${var.amigen_use_default_repos}",
    ]
    execute_command = "{{ .Vars }} sudo -E /bin/sh '{{ .Path }}'"
    only = [
      "openstack.minimal-centos-7-image",
    ]
    scripts = [
      "${path.root}/scripts/amigen7-build.sh",
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "SPEL_AMIGENBRANCH=${var.amigen8_source_branch}",
      "SPEL_AMIGENBOOTSIZE=17m",
      "SPEL_AMIGENBUILDDEV=${var.amigen_build_device}",
      "SPEL_AMIGENCHROOT=/mnt/ec2-root",
      "SPEL_AMIGENMANFST=${var.amigen8_package_manifest}",
      "SPEL_AMIGENREPOS=${local.amigen8_repo_names}",
      "SPEL_AMIGENREPOSRC=${local.amigen8_repo_sources}",
      "SPEL_AMIGENROOTNM=${var.amigen8_filesystem_label}",
      "SPEL_AMIGEN8SOURCE=${var.amigen8_source_url}",
      "SPEL_AMIGENSTORLAY=${local.amigen8_storage_layout}",
      "SPEL_AMIGENVGNAME=RootVG",
      "SPEL_AWSCFNBOOTSTRAP=${var.amigen_aws_cfnbootstrap}",
      "SPEL_AWSCLIV1SOURCE=${var.amigen_aws_cliv1_source}",
      "SPEL_AWSCLIV2SOURCE=${var.amigen_aws_cliv2_source}",
      "SPEL_CLOUDPROVIDER=aws",
      "SPEL_EXTRARPMS=${local.amigen_extra_rpms}",
      "SPEL_FIPSDISABLE=true",
      "SPEL_GRUBTMOUT=${var.amigen_grub_timeout}",
      "SPEL_USEDEFAULTREPOS=${var.amigen_use_default_repos}",
    ]
    execute_command = "{{ .Vars }} sudo -E /bin/sh '{{ .Path }}'"
    only = [
      "amazon-ebs.minimal-centos-8stream-hvm",
      "amazon-ebs.minimal-rhel-8-hvm",
    ]
    scripts = [
      "${path.root}/scripts/amigen8-build.sh",
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "SPEL_AMIGENBRANCH=${var.amigen7_source_branch}",
      "SPEL_AMIGENBUILDDEV=/dev/sda",
      "SPEL_AMIGENCHROOT=/mnt/ec2-root",
      "SPEL_AMIGENREPOS=${local.amigen7_repo_names}",
      "SPEL_AMIGENREPOSRC=${local.amigen7_repo_sources}",
      "SPEL_AMIGENSOURCE=${var.amigen7_source_url}",
      "SPEL_AMIGENSTORLAY=${local.amigen7_storage_layout}",
      "SPEL_AMIGENVGNAME=VolGroup00",
      "SPEL_AMIUTILSSOURCE=${var.amigen_amiutils_source_url}",
      "SPEL_AWSCFNBOOTSTRAP=${var.amigen_aws_cfnbootstrap}",
      "SPEL_AWSCLIV1SOURCE=${var.amigen_aws_cliv1_source}",
      "SPEL_AWSCLIV2SOURCE=${var.amigen_aws_cliv2_source}",
      "SPEL_BOOTLABEL=/boot",
      "SPEL_BUILDDEPS=lvm2 parted yum-utils unzip git",
      "SPEL_BUILDNAME=${source.name}",
      "SPEL_CLOUDPROVIDER=azure",
      "SPEL_EXTRARPMS=${local.amigen_extra_rpms}",
      "SPEL_FIPSDISABLE=${var.amigen_fips_disable}",
      "SPEL_GRUBTMOUT=${var.amigen_grub_timeout}",
      "SPEL_HTTP_PROXY=${var.spel_http_proxy}",
      "SPEL_USEDEFAULTREPOS=${var.amigen_use_default_repos}",
    ]
    execute_command = "{{ .Vars }} sudo -E /bin/sh '{{ .Path }}'"
    only = [
      "azure-arm.minimal-centos-7-image",
      "azure-arm.minimal-rhel-7-image",
    ]
    scripts = [
      "${path.root}/scripts/amigen7-build.sh",
    ]
  }

  provisioner "file" {
    destination = ".spel/${var.spel_version}/${var.spel_identifier}-${source.name}.manifest.txt"
    direction   = "download"
    source      = "/tmp/manifest.txt"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh -ex '{{ .Path }}'"
    inline = [
      "chkconfig waagent on",
      "/usr/sbin/waagent -force -deprovision",
      "export HISTSIZE=0",
      "sync",
    ]
    only = [
      "azure-arm.minimal-centos-7-image",
      "azure-arm.minimal-rhel-7-image",
    ]
    skip_clean = true
  }

  post-processor "artifice" {
    files = [
      ".spel/${var.spel_version}/${var.spel_identifier}-${source.name}.manifest.txt",
    ]
  }

  post-processors {
    post-processor "vagrant" {
      keep_input_artifact = false
      compression_level   = 9
      only = [
        "virtualbox-iso.minimal-centos-7",
      ]
      output = ".spel/${var.spel_version}/${var.spel_identifier}-${source.name}.box"
    }

    post-processor "vagrant-cloud" {
      box_tag = "${var.virtualbox_vagrantcloud_username}/${var.spel_identifier}-minimal-centos-7"
      only = [
        "virtualbox-iso.minimal-centos-7",
      ]
      version             = " ${var.spel_version} "
      version_description = "STIG-partitioned, LVM-enabled, \"minimal\" CentOS 7 image, with updates through ${formatdate("YYYY-MM-DD", timestamp())}. Default username `maintuser`. For details, see ${var.spel_description_url}."
    }
  }

  post-processor "manifest" {
    output = ".spel/${var.spel_version}/packer-manifest.json"
  }
}

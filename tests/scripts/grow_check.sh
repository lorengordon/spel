#!/bin/bash
#
set -euo pipefail
#
# Script to exercise growing the partition containing the "/" filesystem
#
################################################################################


ROOT_DEV="$( grep ' / ' /proc/mounts | cut -d " " -f 1 )"

# Extract physical disk device from LVM2 VG
if [[ ${ROOT_DEV} == /dev/mapper/* ]]
then
  ROOT_VOLGRP="$( sed -e 's#/dev/mapper/##' -e 's/-.*$//' <<< "${ROOT_DEV}" )"
  echo "Printing pvdisplay output in case it is needed for troubleshooting..."
  pvdisplay -S vgname="${ROOT_VOLGRP}"
  ROOT_DSKPRT="$(
    pvdisplay -S vgname="${ROOT_VOLGRP}" | \
    awk '/PV Name/{ print $3 }'
  )"
else
  echo "This script requires root on LVM2 volume"
  exit 1
fi

# Separate "/"-hosting partition from base device
if [[ ${ROOT_DSKPRT} == /dev/nvme* ]]
then
  ROOT_DISK="${ROOT_DSKPRT//p*/}"
  ROOT_PART="${ROOT_DSKPRT//*p/}"
elif [[ ${ROOT_DSKPRT} =~ ^/dev/(sda)|(xvd) ]]
then
  ROOT_DISK="${ROOT_DSKPRT%?}"
  ROOT_PART="${ROOT_DSKPRT//${ROOT_DISK}/}"
else
  echo "This script supports nvme, xvd, and sda device naming. Could not determine root partitioning from physical volume: ${ROOT_DSKPRT}" >&2
  exit 1
fi

SEL_MODE="$( getenforce )"

# Run the grow-part task
if [[ -d /sys/fs/selinux ]] ; then setenforce Permissive ; fi
printf "Attempting to grow %s... " "${ROOT_DSKPRT}"
growpart "${ROOT_DISK}" "${ROOT_PART}"
echo "Success!"
if [[ -d /sys/fs/selinux ]] ; then setenforce "${SEL_MODE}" ; fi

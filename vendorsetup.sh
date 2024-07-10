#!/usr/bin/env bash

# Copyright (C) 2024 Android Open Source Project
# Copyright (C) 2024 Sreeshankar K

# Color code variables
R="\033[1;31m";
B="\033[1;34m";
G="\033[1;32m";
N="\033[0m"; # No Color

# Environment variables
SRC_DIR="${PWD}";
KERNEL_DIR="${SRC_DIR}/kernel/oneplus/avicii";
VENDOR_DIR="${SRC_DIR}/vendor/oneplus/avicii";
APPS_DIR="${SRC_DIR}/vendor/oneplus/apps";
KERNEL_REPO="https://github.com/sreeshankark/android_kernel_oneplus_sm7250";
VENDOR_REPO="https://bitbucket.org/sreeshankark/android_vendor_oneplus_avicii";
APPS_REPO="https://bitbucket.org/sreeshankark/android_vendor_oneplus_apps";

# Dependencies
DEPENDENCIES=( "KERNEL" "VENDOR" "APPS" );

# Check if the dependency is available in the correct path
function chk_dependencies() {
echo -e "${B}Checking Dependencies...${N}";
for DEPENDENCY in "${DEPENDENCIES[@]}"
do
	if [ ${DEPENDENCY} = "KERNEL" ];
	then	
		DIR="${KERNEL_DIR}";
		REPO="${KERNEL_REPO}";
		NAME="Kernel Source";
	elif [ ${DEPENDENCY} = "VENDOR" ];
	then	
		DIR="${VENDOR_DIR}";
		REPO="${VENDOR_REPO}";
		NAME="Vendor Blobs";
	elif [ ${DEPENDENCY} = "APPS" ];
	then	
		DIR="${APPS_DIR}";
		REPO="${APPS_REPO}";
		NAME="OnePlus Apps";
	else
		echo -e "${R}Invalid Dependency${N}";
	fi
	if [ -d ${DIR} ]; 
	then
		echo -e "${G}${NAME} found${N}";
	else
		echo -e "${R}${NAME} not found${N}";
		echo -e "${B}Cloning ${NAME}...${N}";
		bash -c "git clone ${REPO} --depth=1 ${DIR}";
		echo -e "${G}Sucessfully cloned ${NAME}${N}";
	fi
done;
}

chk_dependencies;

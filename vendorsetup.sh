#!/usr/bin/env bash

# Copyright (C) 2024-2025 Android Open Source Project
# Copyright (C) 2024-2025 Sreeshankar K

# Color code variables
R="\033[1;31m";
B="\033[1;34m";
G="\033[1;32m";
N="\033[0m"; # No Color

# Environment variables
SRC_DIR="${PWD}";
CLANG_VERSION="r547379";
CLANG_DIR="${SRC_DIR}/prebuilts/clang/host/linux-x86/clang-${CLANG_VERSION}";
FW_DIR="${SRC_DIR}/vendor/oneplus/firmware";
KERNEL_DIR="${SRC_DIR}/kernel/oneplus/avicii";
VENDOR_DIR="${SRC_DIR}/vendor/oneplus/avicii";
APPS_DIR="${SRC_DIR}/vendor/oneplus/apps";
CLANG_TAR="https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main/clang-${CLANG_VERSION}.tar.gz";
FW_REPO="https://bitbucket.org/sreeshankark/android_vendor_oneplus_firmware";
KERNEL_REPO="https://github.com/sreeshankark/android_kernel_oneplus_avicii";
VENDOR_REPO="https://bitbucket.org/sreeshankark/android_vendor_oneplus_avicii";
APPS_REPO="https://bitbucket.org/sreeshankark/android_vendor_oneplus_apps";

# Dependencies
DEPENDENCIES=( "FW" "KERNEL" "VENDOR" "APPS" );

# Check if the dependency is available in the correct path
function chk_dependencies() {
echo -e "${B}Checking Dependencies...${N}";
for DEPENDENCY in "${DEPENDENCIES[@]}"
do
	if [ ${DEPENDENCY} = "FW" ];
	then	
		DIR="${FW_DIR}";
		REPO="${FW_REPO}";
		NAME="Firmware Images";
	elif [ ${DEPENDENCY} = "KERNEL" ];
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
		bash -c "git clone ${REPO} --depth=1 --recursive ${DIR}";
		echo -e "${G}Sucessfully cloned ${NAME}${N}";
	fi
done;
}

function chk_clang() {
if [ -d ${CLANG_DIR} ];
then
	echo -e "${G}Clang/LLVM Prebuilts found${N}";
else
	echo -e "${R}Clang/LLVM Prebuilts not found${N}";
	echo -e "${B}Cloning Clang/LLVM Prebuilts...${N}";
	bash -c "curl -sL ${CLANG_TAR} > clang.tar.gz";
	bash -c "mkdir ${CLANG_DIR}";
	bash -c "tar -xvf clang.tar.gz -C ${CLANG_DIR}";
	bash -c "rm clang.tar.gz";
	echo -e "${G}Sucessfully cloned Clang/LLVM Prebuilts${N}";
fi
}

chk_dependencies;
chk_clang;

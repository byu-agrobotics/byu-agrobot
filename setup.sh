#!/bin/bash
# Created by Nelson Durrant, Sep 2024
#
# Sets up environment requirements on a new RPi 5
# - Run this script on a newly flashed Raspberry Pi 5. After running it, run 'compose.sh' to load in and run the most current image
# - This script can also be used to set up a new development environment on a personal machine
# - Make sure you run this from the root of the top-level repo

function printInfo {
  	echo -e "\033[0m\033[36m[INFO] $1\033[0m"
}

function printWarning {
  	echo -e "\033[0m\033[33m[WARNING] $1\033[0m"
}

function printError {
  	echo -e "\033[0m\033[31m[ERROR] $1\033[0m"
}

if [ "$(uname -m)" == "aarch64" ]; then

	printInfo "Setting up agrobot on a Raspberry Pi 5"
				
	# Install Docker if not already installed
	if ! [ -x "$(command -v docker)" ]; then
		curl -fsSL https://get.docker.com -o get-docker.sh
		sudo sh get-docker.sh
		rm get-docker.sh
		sudo usermod -aG docker agrobot
	else
		printWarning "Docker is already installed"
	fi

	# Install dependencies
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y git vim mosh tmux

	# Set up volumes
	mkdir bag

	# Set up udev rules
	sudo cp config/udev/00-teensy.rules /etc/udev/rules.d/00-teensy.rules
	sudo udevadm control --reload-rules
	sudo udevadm trigger

	# Copy repos from GitHub
	git clone https://github.com/byu-agrobotics/agrobot-ros2.git
	git clone https://github.com/byu-agrobotics/agrobot-teensy.git

else

	printInfo "Setting up agrobot on a development machine"

	# Install dependencies
	sudo apt update
	sudo apt install -y git vim mosh tmux

	# Set up volumes
	mkdir bag

	# Copy repos from GitHub
	git clone https://github.com/byu-agrobotics/agrobot-ros2.git
	git clone https://github.com/byu-agrobotics/agrobot-teensy.git

fi
#!/bin/bash
# Created by Nelson Durrant, Oct 2024
#
# Manages Docker containers and the 'agrobot' tmux session
# - Use 'bash compose.sh down' to stop the container
# - Run this script after running 'setup.sh' to pull the most recent image and run it
# - Make sure you run this from the root of the top-level repo

function printInfo {
  	# print blue
  	echo -e "\033[0m\033[36m[INFO] $1\033[0m"
}

function printWarning {
  	# print yellow
  	echo -e "\033[0m\033[33m[WARNING] $1\033[0m"
}

function printError {
  	# print red
  	echo -e "\033[0m\033[31m[ERROR] $1\033[0m"
}

case $1 in
	"down")
		printWarning "Stopping the AgRobot container..."
		docker compose -f docker/docker-compose.yaml down
		;;
	*)
		printInfo "Loading the AgRobot container..."
		docker compose -f docker/docker-compose.yaml up -d

		# Check if a 'agrobot' tmux session already exists
		if [ "$(docker exec -it agrobot tmux list-sessions | grep agrobot)" == "" ]; then

			# If not, create a new 'agrobot' tmux session
			printWarning "Creating a new tmux session..."
			docker exec -it agrobot tmux new-session -d -s agrobot
			docker exec -it agrobot tmux select-pane -t 0 -T agrobot
			docker exec -it agrobot tmux send-keys "clear && cat ~/config/introduction.txt" Enter

			# Full color and mouse options
			docker exec -it agrobot tmux set-option -g default-terminal "screen-256color"
			docker exec -it agrobot tmux set -g mouse on
		fi
		# Attach to the 'agrobot' tmux session
		docker exec -it agrobot tmux attach -t agrobot
		;;
esac

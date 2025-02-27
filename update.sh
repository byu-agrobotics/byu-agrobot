#!/bin/bash
# Created by Nelson Durrant, Sep 2024
#
# Simply pulls all avaliable updates
# - Make sure you run this from the root of the top-level repo

# Docker updates
docker pull byuagrobotics1/agrobot:latest

# GitHub updates
git pull

cd ./agrobot-ros2
git pull

cd ../agrobot-teensy
git pull

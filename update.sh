#!/bin/bash
# Created by Nelson Durrant, Sep 2024
#
# Simply pulls all avaliable git updates
# - Make sure you run this from the root of the AgRobot repo

git pull

cd ./agrobot-ros2
git pull

cd ../agrobot-teensy
git pull

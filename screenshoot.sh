#!/bin/bash

shot_date=$(date +'%H.%M.%S %m.%d.%Y')
xcrun simctl io booted screenshot "~/Desktop/shot-${shot_date}.png"
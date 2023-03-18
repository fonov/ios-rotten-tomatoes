#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Rotten Tomatoes
#
#  Created by Sergei Fonov on 18.03.23.
#  

if [[ -n $CI && $CI_XCODEBUILD_ACTION = 'archive' ]];
then
  echo "Setting Rotten Tomatoes Beta App Icon"
  APP_ICON_PATH=$CI_WORKSPACE/RottenTomatoes/Assets.xcassets/AppIcon.appiconset

  # Remove existing App Icon
  rm -rf $APP_ICON_PATH

  # Replace with Rotten Tomatoes Beta App Icon
  mv "$CI_WORKSPACE/ci_scripts/AppIcon-Beta.appiconset" $APP_ICON_PATH
fi



#!/bin/bash

set -e

if [ "$DEV_BUILD" = true ]; then
  # if this is a devbuild, we don't have an app to check the .meteor/release file yet,
  # so just install the latest version of Meteor
  printf "\n[-] Installing the latest version of Meteor...\n\n"
  curl -v https://install.meteor.com/ | sh
else
  printf "\n[-] Downloading Meteor $METEOR_VERSION...\n\n"
  mkdir /tmp/.meteor-install-tmp
  # download installer script
  curl -v https://install.meteor.com -o /tmp/install_meteor.sh

  # read in the release version in the app
  #METEOR_VERSION=$(head $APP_SOURCE_DIR/.meteor/release | cut -d "@" -f 2)

  # set the release version in the install script
  #sed -i.bak "s/RELEASE=.*/RELEASE=\"$METEOR_VERSION\"/g" /tmp/install_meteor.sh

  # replace tar command with bsdtar in the install script (bsdtar -xf "$TARBALL_FILE" -C "$INSTALL_TMPDIR")
  # https://github.com/jshimko/meteor-launchpad/issues/39
  #sed -i.bak "s/tar -xzf.*/bsdtar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install_meteor.sh


  #curl --progress-bar --insecure  https://meteorinstall-4168.kxcdn.com/packages-bootstrap/1.6.1/meteor-bootstrap-os.linux.x86_64.tar.gz | tar -xzf - -C "tmp/.meteor-install-tmp" -o
  #wget -t 70 -c https://meteorinstall-4168.kxcdn.com/packages-bootstrap/1.6.1/meteor-bootstrap-os.linux.x86_64.tar.gz -O - | tar -xzf - -C "/tmp/.meteor-install-tmp"


  # install
  printf "\n[-] Installing Meteor $METEOR_VERSION...\n\n"
  sh /tmp/install_meteor.sh
fi

# ----------------------------------------------------------------------------
#
# Package       : pytest-enabler
# Version       : v1.2.0
# Source repo   : https://github.com/jaraco/pytest-enabler
# Tested on     : UBI 8.4
# Script License: Apache License, Version 2 or later
# Maintainer    : Santosh Kulkarni <santoshkulkarni70@gmail.com>
#
# Disclaimer: This script has been tested in non-root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------
#!/bin/bash

if [ -z "$1" ]; then
  export VERSION=master
else
  export VERSION=$1
fi

if [ -d "pytest-enabler" ] ; then
  rm -rf pytest-enabler
fi

# Install Dependent S/W
sudo dnf install -y python36
sudo dnf install -y git
sudo dnf install -y wget

# Download the repos
git clone https://github.com/jaraco/pytest-enabler


# Build and Test pytest-enabler
cd pytest-enabler
git checkout $VERSION

ret=$?

if [ $ret -eq 0 ] ; then
 echo "$Version found to checkout "
else
 echo "$Version not found "
 exit
fi

sudo pip3 install tox

ret=$?

if [ $ret -ne 0 ] ; then
 echo "dependency python pkg install failed "
 exit
else
  tox -e py36
fi

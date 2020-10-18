#!/bin/bash

# Initialize bash profile
PROFILE_CHECK=`grep ". ~/.bashrc_local" /home/vagrant/.bashrc 2> /dev/null`
if [ "${PROFILE_CHECK}" == "" ]
then
INPUT="

### Added via bootstrap.sh at $(date)
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi
"
echo "Set up bashrc local loading"
echo "$INPUT" >> /home/vagrant/.bashrc
fi

if [ -f /home/vagrant/zenn-vagrant/custom-files/bashrc_local ]; then
    echo "Found bashrc_local file & copy it to ~/.bashrc_local"
    cp /home/vagrant/zenn-vagrant/custom-files/bashrc_local /home/vagrant/.bashrc_local
fi
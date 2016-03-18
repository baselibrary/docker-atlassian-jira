#!/bin/bash

#enable job control in script
set -e -m

#####   variables  #####
: ${SSH_PASS:=jenkins}

# add command if needed
if [ "${1:0:1}" = '-' ]; then
  set -- /usr/sbin/sshd "$@"
fi

#run command in background
if [ "$1" = '/usr/sbin/sshd' ]; then
  ##### pre scripts  #####
  echo "========================================================================"
  echo "initialize: update the password and authorized_key                      "
  echo "========================================================================"
  if [ "$AUTHORIZED_KEYS" ]; then
    /usr/bin/ansible local -o -c local -m authorized_key  -a "user=root key=${AUTHORIZED_KEYS}"
  fi
  if [ "$SSH_PASS" ]; then
    echo "root:$SSH_PASS" | chpasswd
  fi
  
  ##### run scripts  #####
  echo "========================================================================"
  echo "startup: sshd                                                           "
  echo "========================================================================"
  exec "$@" &

  #bring command to foreground
  fg
else
  exec "$@"
fi

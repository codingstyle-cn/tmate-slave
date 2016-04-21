#!/bin/bash
gen_key() {
  keytype=$1
  ks="${keytype}_"
  key="keys/ssh_host_${ks}key"
  if [ ! -e "${key}" ] ; then
    awk '{print $2}' /etc/ssh/ssh_host_ecdsa_key.pub | base64 -d | sha256sum -b | sed 's/ .*$//' | xxd -r -p | base64
    return $?
  fi
}

mkdir -p keys
gen_key rsa && gen_key ecdsa || exit 1

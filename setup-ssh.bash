#!/usr/bin/bash

#TODO(markdorrill): add gsutil cp commands here for public and private keys

hostname=$1;
user=$2;
ssh_dir=$3;
key_file=$4;
password_variable=$5;

ssh-keyscan -t rsa $hostname > $ssh_dir/known_hosts;

cat <<EOF >$ssh_dir/config
Hostname $hostname
User $user
IdentityFile $ssh_dir/$key_file
EOF;

chmod 600 $ssh_dir/*;
chmod 644 $ssh_dir/config;

#TODO(markdorrill)
#check if pub key uses password
#if it does then run expect to add it to authorized_keys

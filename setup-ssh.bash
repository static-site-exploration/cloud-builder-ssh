#!/usr/bin/bash
set -e;

#TODO(markdorrill): add gsutil cp commands here for public and private keys

set hostname=$1;
set user=$2;
set ssh_dir=$3;
set key_file=$4;
set password_variable=$5;

ssh-keyscan -t rsa $hostname > $ssh_dir/known_hosts;

cat <<EOF >$ssh_dir/config
Hostname $hostname
User $user
IdentityFile $ssh_dir/$key_file
EOF;

chmod 600 $ssh_dir/*;
chmod 644 $ssh_dir/config;

#TODO(markdorrill)
#check if pub key uses password (can only grep for the word encrpted)

#grep -q "ENCRYPTED"

#if it does then run expect to add it to authorized_keys using ssh-id-copy

# Create a local variable to use for expect argument, using the global one set in the build file
set expect_password=$(eval echo "\$$password_variable_name");

# Exit if the build password variable value has not been set
if [ -z $expect_password ] then;
  
  echo "Error: $password_variable_name has not been set. \n"
  exit 1;
  
fi

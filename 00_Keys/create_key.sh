#!/bin/bash

ssh-keygen -t rsa -b 4096 -C "ubuntu" -f ./id_rsa -m PEM -q -N ""

openssl rsa -in id_rsa -outform pem > id_rsa.pem

chmod 600 id_rsa.pem

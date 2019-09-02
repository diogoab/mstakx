#!/bin/bash 
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 01-k8s-initial.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 02-k8s-dependencies.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 03-k8s-master.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 04-k8s-workers.yml

sleep 15

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 05-k8s-getnodes.yml
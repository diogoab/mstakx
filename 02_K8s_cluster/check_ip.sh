#!/bin/bash
rm -rf ip

gcloud compute instances list | grep k8s-master | awk '{print $5}' >> ip
gcloud compute instances list | grep k8s-worker-1 | awk '{print $5}' >> ip
gcloud compute instances list | grep k8s-worker-2 | awk '{print $5}' >> ip
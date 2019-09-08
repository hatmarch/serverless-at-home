#!/bin/bash

# NOTE: Assumes 01-openfaas-setup.sh (or equivalent) has been run successfully and that oc is currently 
# logged into the target cluster
oc project openfaas

# This should work, but it binds to volume directories for this image (which are empty).  Unclear why kubectl doesn't at all
# seem to respect the VOLUME directives in the Dockerfile (see docker history --no-trunc stefanprodan/faas-grafana)
# oc new-app grafana stefanprodan/faas-grafana:4.6.3

kubectl -n openfaas run \
--image=stefanprodan/faas-grafana:4.6.3 \
--port=3000 \
grafana

oc expose svc/grafana --name grafana

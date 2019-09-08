#!/bin/bash

# NOTE: See Prerequisites in the README.adoc


if [ -z "${TILLER_NAMESPACE}" ]
then
    echo "Tiller namespace is empty, setting to default"
    set TILLER_NAMESPACE="tiller"
fi

HELM_VERSION=$(helm version -s --short | sed -e 's/.*v\(\([0-9]*\.*\)*\)\+.*/\1/')
echo "Helm version is ${HELM_VERSION}"

# install tiller on target OCP cluster
oc process -f https://github.com/openshift/origin/raw/master/examples/helm/tiller-template.yaml \
    -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" \
    -p HELM_VERSION="${HELM_VERSION}" | oc create -f -

# create necessary openfaas namespaces
oc apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml

# Now add the helm chart repo for the project:
helm repo add openfaas https://openfaas.github.io/faas-netes/

# give tiller admin rights to all openfaas related projects
# so that chart can install necessary items
for project in $(oc get projects | grep openfaas | awk '{print $1}') 
do 
    echo "found project $project" 
    oc project $project 
    oc policy add-role-to-user admin "system:serviceaccount:${TILLER_NAMESPACE}:tiller" 
done

# # generate a random password and put in home directory
PASSWORD=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)

oc -n openfaas create secret generic basic-auth \
--from-literal=basic-auth-user=admin \
--from-literal=basic-auth-password="$PASSWORD"

echo $PASSWORD > ~/openfaas-gateway-password.txt

# update repos
helm repo update

# install openfaas
helm upgrade openfaas --install openfaas/openfaas \
    --namespace openfaas  \
    --set basic_auth=true \
    --set functionNamespace=openfaas-fn


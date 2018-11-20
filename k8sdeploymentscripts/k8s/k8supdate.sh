#!/bin/bash
echo "n00b bash to get deployments scripts into kubectl path"
cd Scripts
cd SampleApp
cd k8s
cp * /
cd /

echo "Logging into Azure"
az login -u cronjevanheerden@gmail.com -p __Azurek8sPassword__
echo "Set Account Cronje"
az account set -s --
echo "Installing Kubernetes CLI"
az acs kubernetes install-cli
echo "Connecting to Kubernetes Cluster"
az aks get-credentials --resource-group Container-Services --name services
echo "Set namespace to development"
kubectl config set-context services --namespace=development

echo "Update all Kubernetes Resources as defined in Devops VCS"

kubectl replace --force -f ./deploymentfrontend.json -f ./deploymentdealservice.json -f ./deploymentgateway.json -f ./deploymentproxy.json
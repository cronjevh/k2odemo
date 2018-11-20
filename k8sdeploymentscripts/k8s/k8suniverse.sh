#!/bin/bash
echo "n00b bash to get deployments scripts into kubectl path"
cd Scripts
cd SampleApp
cd k8s
cp * /
cd /

echo "Logging into Azure"
az login -u cronjevanheerden@gmail.com -p %Azurek8sPassword%
echo "Installing Kubernetes CLI"
az acs kubernetes install-cli
echo "Starting the Kubernetes Cluster VM in case it's gone asleep"
az vm start -g MC_Kubernetes_K8sTesting_northeurope -n aks-agentpool-97142859-0
echo "Hacky 3m wait cluster to start up"
sleep 3m
echo "Connecting to Kubernetes Cluster"
az aks get-credentials --resource-group="Kubernetes" --name="K8sTesting"
echo "Wipe all current Kubernetes Resources in Preparation to move to a new cluster"

kubectl delete services --all
kubectl delete deployments --all

echo "Hacky 3m wait for resources to be purged"
sleep 3m

echo "Create all Kubernetes Resources as defined in Devops VCS"

kubectl create -f ./serviceproxy.json -f ./servicemssql.json -f ./servicefrontend.json -f ./servicegateway.json -f ./servicedealservice.json -f ./deploymentmssql.json -f ./deploymentfrontend.json -f ./deploymentdealservice.json -f ./deploymentgateway.json -f ./deploymentproxy.json

echo "Hacky 5m wait for resources to be created"
sleep 5m

echo "Get External IP of Proxy Service"
ExternalIP=( $(kubectl get svc proxy -o json | jq -r '.status[].ingress[].ip') )

echo "Look up Azure name of External IP to update DNS"
IPName=( $(az network public-ip list -g MC_Kubernetes_K8sTesting_northeurope --query "[?ipAddress=='$ExternalIP']" | jq -r '.[].name') )

echo "Update DNS"
az network public-ip update -g MC_Kubernetes_K8sTesting_northeurope -n $IPName --dns-name ir-temp
echo "Logging out of Azure"
az logout
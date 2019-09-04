#!/bin/bash

# variables
namespace=zcp-system
zcp_admin_service_account=zcp-system-admin
tls_secret=cloudzcp-io-cert

# extract secret
registry_crt=$(kubectl get secret "$tls_secret" --namespace "$namespace" -o jsonpath="{.data.tls\.crt}" | base64 --decode)
registry_key=$(kubectl get secret "$tls_secret" --namespace "$namespace" -o jsonpath="{.data.tls\.key}" | base64 --decode)

zcp_admin_secret=$(kubectl get sa zcp-system-admin --namespace "$namespace" -o jsonpath="{.secrets[0].name}")


# create pvc
kubectl create -f adminserver-pvc.yaml --namespace "$namespace"
kubectl create -f mysql-pvc.yaml --namespace "$namespace"
kubectl create -f psql-pvc.yaml --namespace "$namespace"

# install helm chart
helm repo add zcp https://raw.githubusercontent.com/cnpst/charts/master/docs

helm install zcp/zcp-registry --name zcp-registry \
  --namespace "$namespace" \
  -f values-ibm.yaml \
  --set tlsCrt="$registry_crt" \
  --set tlsKey="$registry_key" \
  --set backup.serviceAccount="$zcp_admin_service_account" \
  --set backup.serviceAccountSecretName="$zcp_admin_secret"

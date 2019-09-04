#!/bin/bash

echo -e "Please select number you want to upgrade."
echo "1. All"
echo "2. Registry"
echo "3. Catalog"

echo -e "Insert a number: \c "
read number

if [ $number == 2  -o  $number == 1 ]
then
  echo "Start ZCP Registry upgrade..."

  registry_crt=$(kubectl get secret "$tls_secret" \
  --namespace "$namespace" \
  -o jsonpath="{.data.tls\.crt}" | base64 --decode)

  registry_key=$(kubectl get secret "$tls_secret" \
  --namespace "$namespace" \
  -o jsonpath="{.data.tls\.key}" | base64 --decode)

  zcp_admin_service_account_secret=$(kubectl get sa "$zcp_admin_service_account" \
  --namespace "$namespace" \
  -o jsonpath="{.secrets[0].name}")

  helm upgrade zcp-registry zcp/zcp-registry \
    --namespace "$namespace" \
    --reuse-values \
    -f zcp-registry/values.yaml \
    --set externalDomain="${registry_sub_domain}.${domain}" \
    --set tlsCrt="$registry_crt" \
    --set tlsKey="$registry_key" \
    --set adminserver.adminPassword="${registry_admin_pwd}" \
    --set adminserver.emailHost="${smtp_host}" \
    --set adminserver.emailPort="${smtp_port}" \
    --set adminserver.emailUser="${smtp_user}" \
    --set adminserver.emailFrom="${smtp_from}" \
    --set adminserver.emailPwd="${smtp_pwd}" \
    --set registry.objectStorage.s3.region="${s3_region}" \
    --set registry.objectStorage.s3.regionendpoint="${s3_public_endpoint}" \
    --set registry.objectStorage.s3.accesskey="${s3_accesskey}" \
    --set registry.objectStorage.s3.secretkey="${s3_secretkey}" \
    --set registry.objectStorage.s3.bucket="${registry_s3_bucket}" \
    --set backup.serviceAccount="${zcp_admin_service_account}" \
    --set backup.serviceAccountSecretName="${zcp_admin_service_account_secret}" \
    --set backup.objectStorage.s3.regionendpoint="${s3_private_endpoint}" \
    --set backup.objectStorage.s3.accesskey="${s3_accesskey}" \
    --set backup.objectStorage.s3.secretkey="${s3_secretkey}" \
    --set backup.objectStorage.s3.bucket="${backup_s3_bucket}"

  echo "End ZCP Registry upgrade."
fi

if [ $number == 3  -o  $number == 1 ]
then
  echo "Start ZCP Catalog upgrade..."


  echo "End ZCP Catalog upgrade."
fi

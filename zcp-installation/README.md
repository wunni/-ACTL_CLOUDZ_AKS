# zcp-installation

## Create tls secret

```
e.g)
kubectl create secret tls cloudzcp-io-cert -n zcp-system  --cert cloudzcp.crt --key cloudzcp.key
```

## Set environment variables

Set environment variables.

```
//common
export namespace=
export domain=
export tls_secret=
export realm_publicKey=
export auth_url=
export smtp_host=
export smtp_port=
export smtp_user=
export smtp_from=
export smtp_pwd=
export s3_region=
export s3_public_endpoint=
export s3_private_endpoint=
export s3_accesskey=
export s3_secretkey=
export backup_s3_bucket=
export zcp_admin_service_account=

//catalog
export catalog_client_secret=
export catalog_sub_domain=

//registry
export registry_admin_pwd=
export registry_sub_domain=
export registry_s3_bucket=

e.g.)
//common
export namespace=zcp-system
export domain=cloudzcp.io
export tls_secret=xxx
export realm_publicKey="xxx"
export auth_url=https://keycloak.cloudzcp.io/auth
export smtp_host=smtp.sendgrid.net
export smtp_port=465
export smtp_user=admin@example.com
export smtp_from='admin <admin@example.com>'
export smtp_pwd=xxx
export s3_region=seo-ap-geo
export s3_public_endpoint=s3.seo-ap-geo.objectstorage.softlayer.net
export s3_private_endpoint=s3.seo-ap-geo.objectstorage.service.networklayer.com
export s3_accesskey=xxx
export s3_secretkey=xxx
export backup_s3_bucket=zcp-backup-dev
export zcp_admin_service_account=zcp-system-admin

//catalog
export catalog_client_secret=xxx
export catalog_sub_domain=registry-example

//registry
export registry_admin_pwd=xxx
export registry_sub_domain=registry-example
export registry_s3_bucket=zcp-registry-xxx
```

Confirm the env.

```
//common
echo $namespace
echo $domain
echo $tls_secret
echo $realm_publicKey
echo $auth_url
echo $smtp_host
echo $smtp_port
echo $smtp_user
echo $smtp_from
echo $smtp_pwd
echo $s3_region
echo $s3_public_endpoint
echo $s3_private_endpoint
echo $s3_accesskey
echo $s3_secretkey
echo $backup_s3_bucket
echo $zcp_admin_service_account

//catalog
echo $catalog_client_secret
echo $catalog_sub_domain

//registry
echo $registry_admin_pwd
echo $registry_sub_domain
echo $registry_s3_bucket
```

## Run installation script

Run installation script and insert a number you want to install.

```
./zcp-installation-scripts.sh
1. All
2. Registry
3. Catalog
Insert a number:
```

## Run upgrade script

Run upgrade script and insert a number you want to upgrade.

```
./zcp-upgrade-scripts.sh
1. All
2. Registry
3. Catalog
Insert a number:
```

## Run rollback script

Run rollback script and insert a number you want to rollback.

```
./zcp-rollback-scripts.sh
1. All
2. Registry
3. Catalog
Insert a number:
```

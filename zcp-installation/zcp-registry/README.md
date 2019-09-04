# The zcp-registry Installation Guide

zcp-registry 은 Harbor 기반의 Private Docker Registry 이다.

zcp-registry 를 설치하기 이전에 https용 공인 인증서가 필요하다.

## Clone this project into the desktop
```
$ git clone https://github.com/cnpst/zcp-installation.git
```

## Deploy the application
프로젝트 별로 수정해야 하는 파일은 **values, sh** 두 가지이다.

configuration 파일 디렉토리로 이동한다.

```
$ cd zcp-installation/zcp-registry
```

### 1. values-ibm.yaml 정보 변경
`# CAHNGE` 주석이 포함된 라인의 정보를 수정한다.
```
externalDomain: ***-registry.cloudzcp.io   # CHANGE
...

ingress:
  annotations:
    #ingress.bluemix.net/ALB-ID: private-xxxx-alb1  # CHANGE: IF use Private ALB
...

adminserver:
  image:
    repository: registry.au-syd.bluemix.net/cloudzcp/harbor-adminserver
  #adminPassword: xxxx  #CHANGE
...

registry:
  image:
    repository: registry.au-syd.bluemix.net/cloudzcp/registry-photon
  #objectStorage:  # CHANGE
  #  s3:
  #    region: seo-ap-geo
  #    accesskey: ***   # CHANGE
  #    secretkey: ***   # CHANGE
  #    bucket: zcp-registry-***   # CHANGE
  #    encrypt: "true"
  #    regionendpoint: s3.seo.ap.cloud-object-storage.appdomain.cloud   # CHANGE
...

backup:
  enabled: true
...
  objectStorage:   # CHANGE
    s3:
      region: seo-ap-geo
      accesskey: ***   # CHANGE
      secretkey: ***   # CHANGE
      bucket: zcp-backup-***   # CHANGE
      encrypt: "true"
      regionendpoint: s3.seo.ap.cloud-object-storage.appdomain.cloud   # CHANGE
```

### 2. install.sh 의 변수를 수정한다.
```
#!/bin/bash

# variables
namespace=zcp-system
zcp_admin_service_account=zcp-system-admin
tls_secret=cloudzcp-io-cert
...
```

### 3. 설치 스크립트를 실행하고, 정상적으로 배포되었는지 확인한다.
```
$ ./install.sh
$ kubectl get pod -n zcp-system
```

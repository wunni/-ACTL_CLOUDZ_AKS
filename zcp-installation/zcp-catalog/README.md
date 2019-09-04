# The zcp-catalog Installation Guide

zcp-catalog 는 Monocular 기반의 Helm Repositories Web UI 이다.

zcp-catalog 를 설치하기 이전에 zcp-iam(Keycloak)이 미리 설치되어야 한다.

## Clone this project into the desktop
```
$ git clone https://github.com/cnpst/zcp-installation.git
```

## Deploy the application
프로젝트 별로 수정해야 하는 파일은 **values, ingress** 두 종류이다.

configuration 파일 디렉토리로 이동한다.

```
$ cd zcp-installation/zcp-catalog
```

### 1. zcp-catalog 설치
아래의 helm install을 실행하고, 정상적으로 배포되었는지 확인한다. 
```
$ helm repo add zcp https://raw.githubusercontent.com/cnpst/charts/master/docs
$ helm install zcp/zcp-catalog -n zcp-catalog -f values-zcp-catalog-ibm.yaml
$ kubectl get pod -n zcp-system
```

### 2. zcp-sso 설치
zcp-catalog는 SSO와 권한 관리를 위해 keycloak proxy를 통해 서비스 된다.
이를 위해 zcp-catalog의 ingress는 disable 상태로 설치된다.

#### 2-1. values-zcp-sso.yaml 정보 변경
`# CAHNGE` 주석이 포함된 라인의 **host, secret** 정보를 수정한다.                                           
```                                                                        
...
ingress:
  enabled: false
  annotations:
    #ingress.bluemix.net/ALB-ID: private-xxxx-alb1  # CHANGE
    ingress.bluemix.net/redirect-to-https: "True"
    ingress.bluemix.net/rewrite-path: "serviceName=zcp-catalog-zcp-catalog-ui rewrite=/ui;serviceName=zcp-catalog-zcp-catalog-api rewrite=/"
  hosts:
    - catalog.cloudzcp.io          # CHANGE
  tls:
  - hosts:
    - catalog.cloudzcp.io          # CHANGE
    secretName: cloudzcp-io-cert   # CHANGE

configmap:
  targetUrl: "http://zcp-catalog-zcp-catalog-ui"
  realm: zcp
  resource: catalog
  pattern: /*
  rolesAllowed: admin

  authServerUrl: https://iam.cloudzcp.io/auth   # CHANGE
  secret: 8d7c396d-123e-4c59-8397-f6fe31e34680  # CHANGE: client secret
```

#### 2-2. zcp-sso 설치
아래의 helm install을 실행하고, 정상적으로 배포되었는지 확인한다.
```
$ helm install zcp/zcp-sso -n zcp-sso-catalog -f values-zcp-sso.yaml
$ kubectl get pod -n zcp-system
```

#### 2-3. zcp-sso 용 ingress 설치
zcp-sso Helm Chart에 포함된 ingress 설정은 1개의 path만 지원하기 때문에 별도로 ingress를 생성한다.
먼저 ingress-sso.yaml의 `# CHANGE` 부분을 수정한다.
```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    #ingress.bluemix.net/ALB-ID: private-xxxxx-alb1  # CHANGE
...

spec:
  rules:
  - host: gdi-dev-catalog.cloudzcp.io  # CHANGE
  ...
  tls:
  - hosts:
    - gdi-dev-catalog.cloudzcp.io  # CHANGE
    secretName: cloudzcp-io-cert   # CHANGE
```

ingress를 설치하고, 브라우저를 통해 정상적으로 SSO가 적용되었는지 확인한다.
```
$ kubectl create -f ingress-sso.yaml
```

# Provision OCI Infrastucture

## VCN, Subnet and IP

VCN_NAME = **prod** 

VCN_CIDR = **10.10.0.0/16**

public_lb_subnet = **10.10.0.0/24**

cms_oke_woker_subnet = **10.10.16.0/20**

web_oke_worker_subnet = **10.10.30.0/20**

airs_microservice_oke_subnet = **10.10.50.0/20**

careers_vm_subnet = **10.10.70.0/24**

db_subnet = **10.10.80.0/24**

public_api_gw_subnet = **10.10.5.0/24**

private_lb_subnet = **10.10.55.0/24**

## 🔐 NSG PROD LB

| Direction | Stateless | Source Type | Source      | Destination Type | Destination     | Protocol | Source Port Range | Destination Port Range | Allow      | Description               |
|-----------|-----------|-------------|-------------|------------------|------------------|----------|--------------------|--------------------------|------------|----------------------------|
| Ingress   | No        | CIDR        | 0.0.0.0/0   | CIDR             | All              | TCP      | All                | 443                      | TCP traffic | Allow 443 from all        |
| Ingress   | No        | CIDR        | 0.0.0.0/0   | CIDR             | All              | TCP      | All                | 80                       | TCP traffic | Allow http from all       |
| Egress    | No        | NSG         | NSG-PROD-WEB | NSG              | All              | TCP      | All                | All                      | TCP traffic | Allow LB to web           |
| Egress    | No        | NSG         | NSG-PROD-AIRS | NSG             | All              | TCP      | All                | All                      | TCP traffic | Allow LB to airs          |
| Egress    | No        | NSG         | NSG-PROD-CMS | NSG              | All              | TCP      | All                | All                      | TCP traffic | Allow LB to cms           |


## 🔐 NSG PROD CMS


| Direction | Stateless | Source Type | Source         | Destination Type | Destination     | Protocol | Source Port Range | Destination Port Range | Allow       | Description            |
|-----------|-----------|-------------|-----------------|------------------|------------------|----------|--------------------|--------------------------|-------------|-------------------------|
| Ingress   | No        | NSG         | NSG-PROD-WEB    | NSG              | All              | TCP      | All                | 9090                     | TCP traffic | Allow From NSG-PROD-WEB |
| Egress    | No        | CIDR        | 10.10.80.0/24   | CIDR             | All              | TCP      | All                | 3306                     | TCP traffic | Allow to DB subnet     |
| Ingress   | No        | NSG         | NSG-PROD-LB     | NSG              | All              | TCP      | All                | 443                      | TCP traffic | Allow From NSG-PROD-LB |
| Ingress   | No        | NSG         | NSG-PROD-LB     | NSG              | All              | TCP      | All                | 80                       | TCP traffic | Allow From NSG-PROD-LB |


## 🔐 NSG PROD WEB

| Direction | Stateless | Source Type | Source         | Destination Type | Destination     | Protocol | Source Port Range | Destination Port Range | Allow       | Description            |
|-----------|-----------|-------------|-----------------|------------------|------------------|----------|--------------------|--------------------------|-------------|-------------------------|
| Egress   | No        | NSG         | NSG-PROD-AIRS    | NSG              | All              | TCP      | All                | ALL                     | TCP traffic | Allow To NSG-PROD-AIRS |
| Egress    | No        | CIDR        | 10.10.80.0/24   | CIDR             | All              | TCP      | All                | 3306                     | TCP traffic | Allow to DB subnet     |
| Ingress   | No        | NSG         | NSG-PROD-LB     | NSG              | All              | TCP      | All                | 443                      | TCP traffic | Allow From NSG-PROD-LB |
| Ingress   | No        | NSG         | NSG-PROD-LB     | NSG              | All              | TCP      | All                | 80                       | TCP traffic | Allow From NSG-PROD-LB |

## 🔐 NSG PROD AIRS

| Direction | Stateless | Source Type | Source           | Destination Type | Destination    | Protocol      | Source Port Range | Destination Port Range | Allow        | Description          |
|-----------|-----------|-------------|-------------------|------------------|-----------------|----------------|--------------------|--------------------------|--------------|-----------------------|
| Egress    | No        | CIDR        | 10.10.80.0/24     | CIDR             | All             | All Protocols  | All                | All                      | All traffic  | Allow to db           |
| Ingress   | No        | NSG         | NSG-PROD-WEB      | NSG              | All             | TCP            | All                | 8088                     | TCP traffic  | Allow service         |
| Ingress   | No        | NSG         | NSG-PROD-API-GW   | NSG              | All             | TCP            | All                | 8080                     | TCP traffic  | Allow service         |

## 🔐 NSG PROD CAREERS

| Direction | Stateless | Source Type | Source          | Destination Type | Destination    | Protocol | Source Port Range | Destination Port Range | Allow       | Description          |
|-----------|-----------|-------------|------------------|------------------|-----------------|----------|--------------------|--------------------------|-------------|-----------------------|
| Egress    | No        | CIDR        | 10.10.80.0/24    | CIDR             | All             | TCP      | All                | 3306                     | TCP traffic | Allow egress         |
| Ingress   | No        | NSG         | NSG-PROD-BASTION | NSG              | All             | TCP      | All                | 22                       | TCP traffic | Allow http/h…        |
| Ingress   | No        | NSG         | NSG-PROD-LB      | NSG              | All             | TCP      | All                | 443                      | TCP traffic | Allow http/h…        |
| Ingress   | No        | NSG         | NSG-PROD-LB      | NSG              | All             | TCP      | All                | 80                       | TCP traffic | Allow http/h…        |


## 🔐 NSG PROD API GW

| Direction | Stateless | Source Type | Source    | Destination Type | Destination      | Protocol | Source Port Range | Destination Port Range | Allow       | Description              |
|-----------|-----------|-------------|-----------|------------------|-------------------|----------|--------------------|--------------------------|-------------|---------------------------|
| Ingress   | No        | CIDR        | 0.0.0.0/0 | CIDR             | All               | TCP      | All                | 443                      | TCP traffic | Allow https from any      |
| Egress    | No        | NSG         | NSG-PROD-AIRS | NSG           | All               | TCP      | All                | 443                      | TCP traffic | Allow to AIRS 443         |

## 🔐 NSG PROD BASTION

| Direction | Stateless | Source Type | Source    | Destination Type | Destination | Protocol | Source Port Range | Destination Port Range | Allow       | Description            |
|-----------|-----------|-------------|-----------|------------------|-------------|----------|--------------------|--------------------------|-------------|-------------------------|
| Ingress   | No        | CIDR        | 0.0.0.0/0 | CIDR             | All         | TCP      | All                | 22                       | TCP traffic | Allow https from any   |
| Egress    | No        | CIDR        | 0.0.0.0/0 | CIDR             | All         | TCP      | All                | All                      | TCP traffic | Allow to All           |
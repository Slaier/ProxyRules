# {{ downloadUrl }}

external-controller: 127.0.0.1:9090
port: 7890
socks-port: 7891
redir-port: 7892

{% if customParams.dns %}
dns:
  enable: true
  default-nameserver:
    - 114.114.114.114
    - 180.76.76.76
  nameserver:
    - https://i.233py.com/dns-query
  fallback-filter:
    geoip: false
    ipcidr:
      - 240.0.0.0/4
{% endif %}

proxies:
  {{ getClashNodes(nodeList, customFilters.commonFilter) | json }}

proxy-groups:
- type: fallback
  name: ✈️ Proxy
  proxies:
    - 👉 Prefer
    - 👍 Auto
  url: 'http://connectivitycheck.gstatic.com/generate_204'
  interval: 120

- type: select
  name: 👉 Prefer
  proxies: {{ getClashNodeNames(nodeList, customFilters.commonFilter) | json }}

- type: url-test
  name: 👍 Auto
  proxies: {{ getClashNodeNames(nodeList, customFilters.commonFilter) | json }}
  url: 'http://connectivitycheck.gstatic.com/generate_204'
  interval: 300

rules:
# Dns
- DOMAIN,dns.alidns.com,DIRECT
- DOMAIN,doh.pub,DIRECT
- DOMAIN,i.233py.com,DIRECT

# Force Direct
- DOMAIN,officecdn-microsoft-com.akamaized.net,DIRECT
- DOMAIN,production.cloudflare.docker.com,DIRECT
- DOMAIN-SUFFIX,pkgs.org,DIRECT
- DOMAIN,isofiles.bd581e55.workers.dev,DIRECT

# Epic
- DOMAIN,entitlement-public-service-prod08.ol.epicgames.com,✈️ Proxy
- DOMAIN,lightswitch-public-service-prod06.ol.epicgames.com,✈️ Proxy
- DOMAIN,friends-public-service-prod06.ol.epicgames.com,✈️ Proxy
- DOMAIN,ue-launcher-website-prod.ol.epicgames.com,✈️ Proxy

# Direct
{{ remoteSnippets.direct.main('DIRECT') | clash }}

# LAN
- DOMAIN-SUFFIX,local,DIRECT
- IP-CIDR,127.0.0.0/8,DIRECT
- IP-CIDR,172.16.0.0/12,DIRECT
- IP-CIDR,192.168.0.0/16,DIRECT
- IP-CIDR,10.0.0.0/8,DIRECT
- IP-CIDR,100.64.0.0/10,DIRECT

# Final
- GEOIP,CN,DIRECT
- MATCH,✈️ Proxy

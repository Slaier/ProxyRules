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
    - https://dns.alidns.com/dns-query
    - https://doh.pub/dns-query
  fallback:  # IP addresses who is outside CN in GEOIP will fallback here
    - https://dns.rubyfish.cn/dns-query
    - https://i.233py.com/dns-query
  fallback-filter:
    geoip: true  # Enable GEOIP-based fallback
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
  proxies: {{ getClashNodeNames(nodeList, customFilters.cheapFilter) | json }}

- type: url-test
  name: 👍 Auto
  proxies: {{ getClashNodeNames(nodeList, customFilters.commonFilter) | json }}
  url: 'http://connectivitycheck.gstatic.com/generate_204'
  interval: 300

- type: url-test
  name: 🌎 NHK
  proxies: {{ getClashNodeNames(nodeList, customFilters.nhkFilter) | json }}
  url: 'http://connectivitycheck.gstatic.com/generate_204'
  interval: 300

rules:
# Dns
- DOMAIN,dns.alidns.com,DIRECT
- DOMAIN,doh.pub,DIRECT
- DOMAIN,dns.rubyfish.cn,DIRECT
- DOMAIN,i.233py.com,DIRECT

# Reject
{{ remoteSnippets.advertising.main('REJECT') | clash }}
{{ remoteSnippets.advertisingplus.main('REJECT') | clash }}
{{ remoteSnippets.hijacking.main('REJECT') | clash }}
{{ remoteSnippets.privacy.main('REJECT') | clash }}

# Proxy
{{ remoteSnippets.twitter.main('🌎 NHK') | clash }}
{{ remoteSnippets.global.main('✈️ Proxy') | clash }}

# Direct
{{ remoteSnippets.streamingse.main('DIRECT') | clash }}
{{ remoteSnippets.streamingcn.main('DIRECT') | clash }}
{{ remoteSnippets.china.main('DIRECT') | clash }}
- DOMAIN,production.cloudflare.docker.com,DIRECT
- DOMAIN-SUFFIX,pkgs.org,DIRECT

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

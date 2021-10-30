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
  fake-ip-filter:
    - router.asus.com
    - '+.lan'
    - '+.localdomain'
    - '+.example'
    - '+.invalid'
    - '+.localhost'
    - '+.test'
    - '+.local'
    - '+.home.arpa'
    - '+.msftconnecttest.com'
    - '+.msftncsi.com'
    - '+.localhost.sec.qq.com'
    - '+.localhost.ptlogin2.qq.com'
  nameserver:
    - https://dns.alidns.com/dns-query
    - https://doh.pub/dns-query
  fallback:  # IP addresses who is outside CN in GEOIP will fallback here
    - https://i.233py.com/dns-query
    - https://public.dns.iij.jp/dns-query
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

- type: fallback
  name: 🌎 NHK
  proxies:
    - 👉 NHKPrefer
    - 👍 Auto
  url: 'http://connectivitycheck.gstatic.com/generate_204'
  interval: 300

- type: select
  name: 👉 NHKPrefer
  proxies: {{ getClashNodeNames(nodeList, customFilters.nhkFilter) | json }}

- type: fallback
  name: 🇭🇰 HK
  proxies:
    - 👉 HKPrefer
    - 👍 Auto
  url: 'http://connectivitycheck.gstatic.com/generate_204'
  interval: 300

- type: select
  name: 👉 HKPrefer
  proxies: {{ getClashNodeNames(nodeList, customFilters.cheapFilter) | json }}

rules:
# Dns
- DOMAIN,dns.alidns.com,DIRECT
- DOMAIN,doh.pub,DIRECT
- DOMAIN,i.233py.com,DIRECT
- DOMAIN,public.dns.iij.jp,DIRECT

# Force Direct
- DOMAIN,officecdn-microsoft-com.akamaized.net,DIRECT
- DOMAIN,production.cloudflare.docker.com,DIRECT
- DOMAIN-SUFFIX,pkgs.org,DIRECT

# Spotify
- DOMAIN-SUFFIX,spoti.fi,🇭🇰 HK
- DOMAIN-SUFFIX,scdn.co,🇭🇰 HK
- DOMAIN-KEYWORD,spotify,🇭🇰 HK

# sky
- DOMAIN-SUFFIX,thatgamecompany.com,🇭🇰 HK

# Reject
{{ remoteSnippets.reject.main('REJECT') | clash }}

# Proxy
{{ remoteSnippets.twitter.main('🌎 NHK') | clash }}
{{ remoteSnippets.gfw.main('✈️ Proxy') | clash }}
{{ remoteSnippets.greatfire.main('✈️ Proxy') | clash }}

# Direct
{{ remoteSnippets.direct.main('DIRECT') | clash }}

# Telegram
{{ remoteSnippets.telegram.main('✈️ Proxy') | clash }}

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

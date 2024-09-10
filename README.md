# go-socks5-proxy

![Latest tag from master branch](https://github.com/serjs/socks5-server/workflows/Latest%20tag%20from%20master%20branch/badge.svg)
![Release tag](https://github.com/serjs/socks5-server/workflows/Release%20tag/badge.svg)

Simple socks5 server using go-socks5 with authentication, allowed ips list and destination FQDNs filtering

## Installation
To get started with Cow Proxy, you need to clone the repository and install the necessary dependencies.
```
git clone https://github.com/ShGoudarzi/socks5-server.git
cd socks5-server
docker compose up -d
```


## Usage
```
curl -v --socks5 SERVER_IP:PORT --proxy-user USERNAME:PASSWORD https://youtube.com
```


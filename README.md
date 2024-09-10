# socks5-server

Simple socks5 server using go-socks5 with authentication, allowed ips list and destination FQDNs filtering

## Installation
To get started with socks5-server, you need to clone the repository and install the necessary dependencies.
```
git clone https://github.com/ShGoudarzi/socks5-server.git
cd socks5-server
docker compose up -d
```


## Usage
```
curl -v --socks5 SERVER_IP:PORT --proxy-user USERNAME:PASSWORD https://youtube.com
```


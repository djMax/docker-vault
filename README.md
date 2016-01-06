# docker-vault

[Hashicorp Vault](https://hashicorp.com/blog/vault.html)

This version binds to 0.0.0.0 instead of localhost to be Docker-friendly. It will connect to a linked image named consul.

Example consul start command:
```
docker run -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h consul --name=consul progrium/consul -server -bootstrap -ui-dir /ui
```

To run this image

```
make
make test
```
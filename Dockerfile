FROM alpine:3.2

MAINTAINER Max Metral <max@pyralis.com>

FROM alpine:3.2

ENV VAULT_VERSION 0.4.0
RUN set -x\
 && apk --update add gnupg curl zip\
 && gpg-agent --daemon\
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C\
 && curl -Lf https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip > /tmp/vault.zip\
 && curl -Lf https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS > /tmp/vault.sha256\
 && curl -Lf https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig > /tmp/vault.sig\
 && gpg --verify /tmp/vault.sig /tmp/vault.sha256\
 && [[ "$(grep vault_${VAULT_VERSION}_linux_amd64.zip /tmp/vault.sha256 | awk '{print $1}')" == "$(sha256sum /tmp/vault.zip | awk '{print $1}')" ]]\
 && unzip /tmp/vault -d /usr/local/bin/\
 && rm /tmp/vault*\
 && apk del gnupg curl zip

EXPOSE 8200

ADD vault.json /etc/vault/vault.json

ENTRYPOINT ["/usr/local/bin/vault"]
CMD [ "server", "-config=/etc/vault/vault.json" ]

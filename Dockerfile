FROM fedora

MAINTAINER pioh "thepioh@zoho.com"

RUN dnf install --setopt=tsflags=nodocs -y nginx wget tar perl perl-core gcc \
 && dnf update --setopt=tsflags=nodocs -y \
 && dnf clean all \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
 && cd ~ \
 && wget https://www.openssl.org/source/openssl-1.1.0c.tar.gz \
 && tar xf openssl-1.1.0c.tar.gz \
 && cd openssl* \
 && mkdir -p /opt \
 && ./config --prefix=/opt/openssl --openssldir=/usr/ssl \
 && make \
 && make install \
 && rm -rf /opt/openssl/share \
 && cp -r /opt/openssl/* /usr/ \
 && ldconfig \
 && openssl version \
 && cd ~ \
 && rm -rf openssl* /opt/openssl



EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

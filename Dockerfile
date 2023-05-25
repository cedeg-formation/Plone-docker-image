FROM python:2.7

RUN apt-get update && apt-get install -y \
    libjpeg-dev \
    libxml2-dev \
    libxslt1-dev \
    libbz2-dev \
    zlib1g-dev \
    libreadline-gplv2-dev \
    libssl-dev \
    libsqlite3-dev \
    build-essential \
    libmysqlclient-dev \
    libpq-dev \
    libev-dev \
    libffi-dev \
    libldap2-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    libsnmp-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libopenjp2-7-dev \
    tcl-dev \
    tk-dev \
    wget \
    git \
    curl

RUN useradd -ms /bin/bash -d /opt/plone plone
WORKDIR /opt/plone

USER plone

RUN curl https://launchpad.net/plone/5.2/5.2.4/+download/Plone-5.2.4-UnifiedInstaller.tgz -o Plone-5.2.4-UnifiedInstaller.tgz && \
    tar -xvzf Plone-5.2.4-UnifiedInstaller.tgz && \
    cd Plone-5.2.4-UnifiedInstaller && \
    ./install.sh standalone --target=/opt/plone/zeocluster

WORKDIR /opt/plone/zeocluster

EXPOSE 8080

CMD ["bin/zeoserver", "start"]

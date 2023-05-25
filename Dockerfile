# Utilisez une image de base avec Python et Ubuntu
FROM python:3.7-slim-buster

# Définition des variables d'environnement
ENV PLONE_VERSION=5.2.4
ENV PLONE_MD5=93a74a3bc69701e41339d003ee74ef4c
ENV PLONE_HOME=/plone

# Installation des dépendances système
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libjpeg-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    git \
    libldap2-dev \
    libsasl2-dev \
    build-essential \
    libssl-dev \
    libreadline-dev \
    libbz2-dev \
    libsqlite3-dev \
    libffi-dev \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Téléchargement et installation de Plone
RUN mkdir -p $PLONE_HOME \
    && curl -o plone.tgz https://launchpad.net/plone/$PLONE_VERSION/$PLONE_VERSION/+download/Plone-$PLONE_VERSION-UnifiedInstaller.tgz \
    && echo "$PLONE_MD5  plone.tgz" | md5sum -c - \
    && tar -xzf plone.tgz -C $PLONE_HOME \
    && rm plone.tgz

# Installation de Plone en utilisant l'installateur unifié
WORKDIR $PLONE_HOME/Plone-$PLONE_VERSION-UnifiedInstaller
RUN ./install.sh --password=admin standalone

# Exposition du port HTTP de Plone
EXPOSE 8080

# Lancement de Plone
CMD ["$PLONE_HOME/zinstance/bin/zeoserver", "start"]

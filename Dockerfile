FROM python:3.8

# Installation de Plone
RUN pip install plone

# Configuration de Plone
RUN plone-standalone create --target=/plone --password=admin

WORKDIR /plone/instance

# Exposition du port de Plone
EXPOSE 8080

# Commande pour démarrer Plone
CMD ["bin/instance", "start"]

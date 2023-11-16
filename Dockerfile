FROM ubuntu:latest

# Importation du certificat et de la clé privée
#ADD fullchain.pem /etc/ssl/certs/
#ADD privkey.pem /etc/ssl/private/

# Mise a jour du systeme + Installation paquets
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apache2 apache2-utils jq wget
#RUN apt-get install -y tcpdump

# Activation des modules apache2
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod ssl
RUN a2enmod rewrite

# Création du dossier de certificat
RUN mkdir /certs

# Permet de faire tourner en boucle apache2
CMD ["apache2ctl", "-D", "FOREGROUND"]

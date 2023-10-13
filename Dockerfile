# Following https://github.com/RackTables/racktables#how-to-install-racktables
# as closely as possible to create a standalone dev environement for racktables

# Step 1 prepare the server, using mariadb bc it seems legit
FROM ubuntu:latest

# 1.3 install dependancies
ARG DEBIAN_FRONTEND=noninteractive 
RUN apt-get update 
RUN apt-get install apache2-bin libapache2-mod-php php-gd php-mysql -y -q
RUN apt-get install php-mbstring php-bcmath php-json php-snmp -y -q
RUN apt-get install mariadb-server -y

# 2 download racktables
RUN apt-get install wget -y
RUN wget https://sourceforge.net/projects/racktables/files/latest/download -O /tmp/racktables-latest.zip

# unzip
RUN apt-get install unzip -y
RUN unzip /tmp/racktables-latest.zip
RUN chown -R www-data /RackTables*
RUN chown -R www-data /RackTables*

# Configure Apache
RUN sed -i 's/\/var\/www\/html/\/RackTables-0.22.0\/wwwroot/g' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's/\/var\/www\/html/\/RackTables-0.22.0\/wwwroot/g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i 's/\/var\/www/\/RackTables-0.22.0\/wwwroot/g' /etc/apache2/apache2.conf
EXPOSE 80/tcp

# Start apache and mariadb
RUN echo "#!/bin/bash" > /entrypoint.sh
RUN echo "/etc/init.d/mariadb start" >> /entrypoint.sh
RUN echo "service apache2 start" >> /entrypoint.sh
RUN echo "/bin/bash" >> /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
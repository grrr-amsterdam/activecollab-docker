FROM php:5.6-apache
MAINTAINER David Spreekmeester <david@grrr.nl>

ENV APPLICATION_ENV=development
RUN mkdir -p /var/www/html/public
ADD docker/php.ini /usr/local/etc/php/
ADD docker/httpd.conf /etc/apache2/apache2.conf

WORKDIR /var/www/html

RUN \
	# Update first
	apt-get -y update && \

	# Basics
	#apt-get -y install apt-utils wget && \
	apt-get -y install apt-utils && \

    # Install mod_rewrite on Apache
	a2enmod rewrite && \

	# Install MySql Improved
	apt-get -y install php5-mysql && \
	docker-php-ext-install mysqli && \
    
    # Configure GD 
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \

    # Imap
	docker-php-ext-install imap && \
    

	# Install Node 4.x & NPM
	#wget -qO- https://deb.nodesource.com/setup_4.x | bash - && \
	#apt-get -y install nodejs && \

	# Install ruby gems
	#apt-get -y install ruby rubygems-integration && \
	#gem install scss-lint && \
	#gem install semver && \

	#npm i -g gulp && \
	#npm i -g bower && \
	#npm i -g jshint

EXPOSE 80

# ----------- SOMEDAY
#sudo gem install capistrano

# Install python package manager
#wget https://bootstrap.pypa.io/get-pip.py
#sudo python get-pip.py

# Install aws cli tool
#sudo pip install awscli

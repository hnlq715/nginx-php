FROM million12/centos-supervisor:latest
MAINTAINER Sohpos hnlq.sysu@gmail.com

WORKDIR /workdir

RUN \
  rpm --rebuilddb && yum update -y && \
  `# Install yum-utils (provides yum-config-manager) + some basic web-related tools...` \
  yum install -y yum-utils wget patch mysql tar bzip2 zlib-devel unzip openssh-clients rsync make gcc gcc-c++ && \

  `# Install PHP 7.0 from Remi YUM repository...` \
  rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \

  yum install -y \
    php70-php \
    php70-php-bcmath \
    php70-php-cli \
    php70-php-common \
    php70-php-devel \
    php70-php-fpm \
    php70-php-gd \
    php70-php-gmp \
    php70-php-horde-horde-lz4 \
    php70-php-intl \
    php70-php-json \
    php70-php-mbstring \
    php70-php-mcrypt \
    php70-php-mysqlnd \
    php70-php-opcache \
    php70-php-pdo \
    php70-php-pear \
    php70-php-process \
    php70-php-pspell \

    `# Also install the following PECL packages:` \
    php70-php-pecl-imagick \
    php70-php-pecl-memcached \
    php70-php-pecl-redis \
    php70-php-pecl-uploadprogress \
    php70-php-pecl-uuid \
    php70-php-pecl-zip \

    `# Temporary workaround: one dependant package fails to install when building image (and the yum error is: Error unpacking rpm package httpd-2.4.6-40.el7.centos.x86_64)...` \
    || true && \

  `# Set PATH so it includes newest PHP and its aliases...` \
  ln -sfF /opt/remi/php70/enable /etc/profile.d/php70-paths.sh && \
  `# The above will set PATH when container starts... but not when php is used on container build time.` \
  `# Therefore create symlinks in /usr/local/bin for all PHP tools...` \
  ln -sfF /opt/remi/php70/root/usr/bin/{pear,pecl,phar,php,php-cgi,php-config,phpize} /usr/local/bin/. && \

  php --version && \

  `# Move PHP config files from /etc/opt/remi/php70/* to /etc/* ` \
  mv -f /etc/opt/remi/php70/php.ini /etc/php.ini && ln -s /etc/php.ini /etc/opt/remi/php70/php.ini && \
  rm -rf /etc/php.d && mv /etc/opt/remi/php70/php.d /etc/. && ln -s /etc/php.d /etc/opt/remi/php70/php.d && \

  echo 'PHP 7 installed.'

ADD *.sh .

RUN \
  wget http://luajit.org/download/LuaJIT-2.1.0-beta1.tar.gz && \
  tar xf LuaJIT-2.1.0-beta1.tar.gz && \
  cd LuaJIT-2.1.0-beta1 && \
  make && \
  make install 

RUN bash ./install_nginx.sh

RUN rm -rf /workdir

EXPOSE 80


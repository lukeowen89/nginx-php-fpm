FROM centos

MAINTAINER ngineered <support@ngineered.co.uk>

ENV php_conf /etc/php.ini 
ENV fpm_conf /etc/php-fpm.d/www.conf
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisord.conf
ENV nginx_vhost_dir /etc/nginx/sites-available/

# Create Directories
RUN mkdir -p /etc/nginx && \
    mkdir -p /var/www/site && \
    mkdir -p /root/.ssh &&  \
    mkdir -p /var/log/supervisor \
    mkdir /etc/nginx/sites-available \
    mkdir /etc/nginx/sites-enabled


# Install linux tools
RUN yum install -y bash \
    dmidecode \
    git \
    sharutils \ 
    screen \
    sendmail-cf \
    sysstat \
    vim \
    wget \
    python-setuptools \
    zlib \
    zlib-devel 

# Install linux tools
RUN yum -qy groupinstall "Development Tools"

# Install supervisor
RUN easy_install supervisor

# Enable epel repo to open up access to php56 packages
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install PHP 5.6 packages
RUN yum install -y php56w-cli \ 
    php56w-common \
    php56w-devel\
    php56w-gd \
    php56w-intl \
    php56w-opcache \
    php56w-pdo \
    php56w-mysqlnd \
    php56w-mbstring \
    php56w-soap \
    php56w-pear \
    php56w-fpm \
    memcached \
    libmemcached \
    libmemcached-devel \
    php56w-pecl-memcache \
    php56w-pecl-memcached 
    
# Install Nginx
RUN yum -y install nginx18

# Clean up default files
RUN rm -rf /etc/nginx/nginx.conf \
rm -rf /etc/php-fpm.d/www.conf \
rm -rf /etc/php.ini

# Grab application specific system files from S3
RUN curl https://s3.amazonaws.com/docker-application-files/silverstripe/chamber-music-society/local/php.ini -o ${php_conf} 
RUN curl https://s3.amazonaws.com/docker-application-files/silverstripe/chamber-music-society/local/www.conf -o ${fpm_conf} 
RUN curl https://s3.amazonaws.com/docker-application-files/silverstripe/chamber-music-society/local/nginx.conf -o ${nginx_conf} 


# Grab respective nginx vhost files
RUN cd ${nginx_vhost_dir} && curl -O https://s3.amazonaws.com/docker-application-files/silverstripe/chamber-music-society/local/chambermusicsociety.site 
RUN curl 














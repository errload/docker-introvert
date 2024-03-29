FROM php:7.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    nano \
    tar \
    libonig-dev \
    locales \
    nodejs \
    npm \
    zlib1g-dev \
    libicu-dev \
    supervisor \
    g++ \
    libmcrypt-dev \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \
    && sed -i 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install mysqli pdo_mysql mbstring exif pcntl intl bcmath gd
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd
RUN pecl install mcrypt && docker-php-ext-enable mcrypt

#RUN curl -sS -o /tmp/icu.tar.gz -L http://download.icu-project.org/files/icu4c/55.1/icu4c-55_1-src.tgz \
#    && tar -zxf /tmp/icu.tar.gz -C /tmp \
#    && cd /tmp/icu/source \
#    && ./configure --prefix=/usr/local \
#    && make \
#    && make install

#RUN docker-php-ext-configure intl --with-icu-dir=/usr/local && \
#    docker-php-ext-install intl

COPY --from=composer:latest usr/bin/composer /usr/bin/composer
RUN pecl install xdebug-3.1.5 && docker-php-ext-enable xdebug

RUN mkdir -p /var/www/dev
WORKDIR /var/www/dev

USER root
COPY ./ssh/config /root/.ssh/config
COPY ./ssh/docker_api_sdk_openssh /root/.ssh/docker_api_sdk_openssh
RUN chmod 600 /root/.ssh/docker_api_sdk_openssh
CMD ["php-fpm"]

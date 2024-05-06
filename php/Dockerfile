FROM sh1d0w/alpine-nvim:latest

MAINTAINER Sh1d0w <5074917+Sh1d0w@users.noreply.github.com>

WORKDIR /home/developer

# We will switch to the root user to install
# all needed packages
USER root

# Install PHP 8 and Composer
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
          && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
          && apk update
              
RUN apk add --no-cache \
  php83 \
  php83-ctype \
  php83-tokenizer \
  php83-simplexml \
  php83-dom \
  php83-curl \
  php83-json \
  php83-gd \
  php83-mbstring \
  php83-pdo \
  php83-pdo_mysql \
  php83-xml \
  php83-xmlwriter \
  php83-intl \
  php83-pcntl \ 
  php83-phar \
  php-posix \
  python3 \
  py3-pip \
  py3-pynvim \
  composer && \
  rm -rf /var/cache/apk/*

# RUN rm /usr/bin/php && ln -s /usr/bin/php8 /usr/bin/php
RUN rm /usr/bin/php &&  ln -s /usr/bin/php83 /usr/bin/php

# configuring extensions
RUN echo "extension=tokenizer " >  /etc/php83/conf.d/00_tokenizer.ini 
RUN echo "extension=dom " >  /etc/php83/conf.d/00_dom.ini 
RUN echo "extension=simplexml " >  /etc/php83/conf.d/00_simplexml.ini 

# Switch back as the developer user
USER developer

# Prepare directories where we will install some extra tools
RUN mkdir -p /home/developer/tools/php-cs-fixer && \ 
  mkdir /home/developer/bin

# Install PHP Actor
RUN git clone https://github.com/phpactor/phpactor.git tools/phpactor && \ 
  cd tools/phpactor && \ 
  composer install && \
  cd /home/developer/bin && \
  ln -s /home/developer/tools/phpactor/bin/phpactor phpactor

# Install php-cs-fixer
RUN composer require --working-dir=tools/php-cs-fixer friendsofphp/php-cs-fixer && \
  cd /home/developer/bin && \
  ln -s /home/developer/tools/php-cs-fixer/vendor/bin/php-cs-fixer php-cs-fixer

# Install Coc plugins
RUN nvim +'CocInstall -sync coc-phpactor coc-php-cs-fixer' +qall

COPY --chown=developer nvim/plugins.vim .config/nvim/plugins.vim

RUN nvim +'PlugInstall' +qall

# Change user to create a folder
USER root
RUN  chown developer .config/
USER developer
RUN mkdir -p .config/coc/extensions/@yaegassy/coc-phpstan-data && \
  chown developer:developer .config/coc/extensions/@yaegassy/coc-phpstan-data

# RUN nvim +'CocCommand phpstan.download' +qall

RUN composer global require phpstan/phpstan

RUN mkdir workspace

RUN echo "export PATH=$HOME/bin:$HOME/.composer/vendor/bin:$PATH" >> .bashrc

COPY --chown=developer nvim .config/nvim/php
COPY --chown=developer nvim/coc-settings.json .config/nvim

RUN echo "runtime ./php/init.vim" >> .config/nvim/init.vim

WORKDIR /src

ENTRYPOINT ["nvim", "/src"]

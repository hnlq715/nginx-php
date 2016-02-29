#!/bin/bash

version=1.8.1
pcreVersion=8.37
ndkVersion=0.2.19
vtsVersion=0.1.8
setVersion=0.29

if [ ! -e "nginx-$version.tar.gz" ]; then
  wget http://nginx.org/download/nginx-$version.tar.gz
fi

if [ ! -d "nginx-$version" ]; then
  tar xf nginx-$version.tar.gz
fi

if [ ! -e "pcre-$pcreVersion.tar.gz" ]; then
  wget http://jaist.dl.sourceforge.net/project/pcre/pcre/$pcreVersion/pcre-$pcreVersion.tar.gz
fi

if [ ! -d "pcre-$pcreVersion" ]; then
  tar xf pcre-$pcreVersion.tar.gz
fi

if [ ! -e "v$ndkVersion.tar.gz" ]; then
  wget https://github.com/simpl/ngx_devel_kit/archive/v$ndkVersion.tar.gz
fi

if [ ! -d "v$ndkVersion" ]; then
  tar xf v$ndkVersion.tar.gz
fi

if [ ! -e "v$vtsVersion.tar.gz" ]; then
  wget https://github.com/vozlt/nginx-module-vts/archive/v$vtsVersion.tar.gz
fi

if [ ! -d "nginx-module-vts-$vtsVersion" ]; then
  tar xf v$vtsVersion.tar.gz
fi

if [ ! -e "v$setVersion.tar.gz" ]; then
  wget https://github.com/openresty/set-misc-nginx-module/archive/v$setVersion.tar.gz
fi

if [ ! -d "set-misc-nginx-module-$vtsVersion" ]; then
  tar xf v$setVersion.tar.gz
fi

export LUAJIT_LIB=/usr/local/lib
export LUAJIT_INC=/usr/local/include/luajit-2.1/

wget https://github.com/openresty/lua-nginx-module/archive/v0.10.1rc1.tar.gz
tar xf v0.10.1rc1.tar.gz

cd nginx-$version/ \
        && ./configure \
                --with-ld-opt="-Wl,-rpath,/usr/local/lib/" \
                --with-pcre=../pcre-$pcreVersion \
                --with-pcre-jit \
                --with-http_stub_status_module \
                --with-debug \
                --add-module=../ngx_devel_kit-$ndkVersion \
                --add-module=../lua-nginx-module-0.10.1rc1 \
                --add-module=../nginx-module-vts-$vtsVersion \
                --add-module=../set-misc-nginx-module-$setVersion \
        && make


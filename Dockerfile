FROM trueosiris/ubuntu-dotnet:2.1.4
MAINTAINER tim@chaubet.be
LABEL docker-ptmagic.version="2.1.2"
ADD VERSION .

ENV TZ 'Europe/Brussels'
ENV PG_VERSION 2.1.2
# to be fixed: the zip is pulled in the dockerfile. changing the version won't change the zipfile from the default.
                       
RUN mkdir -p /opt/pt-magic/ptm-binance \
 && cd /opt/pt-magic/ptm-binance \ 
 && wget https://github.com/PTMagicians/PTMagic/releases/download/$PG_VERSION/PTM.$PG_VERSION.zip \
 && unzip -o *.zip \
 && mv -v PTM\ $PG_VERSION/* . \
 && mv -v PTMagic/* . \
 && rm *.zip 

VOLUME ["/mnt/profittrailer","/mnt/ptmagic"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["PTMagic.dll"]

FROM wsly89/ubuntu-dotnet:latest
MAINTAINER tim@chaubet.be
LABEL docker-ptmagic.version="2.2.1"
ADD VERSION .

ENV TZ 'Europe/Brussels'
ENV PG_VERSION 2.2.1
                       
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

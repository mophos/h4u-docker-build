FROM mophos/mmis-nginx

LABEL maintainer="Naphattharawat <naphattharawat@gmail.com>"

WORKDIR /home/h4u

RUN npm i npm@latest -g

RUN npm i -g pm2

RUN npm i -g typescript

RUN  apk add --no-cache --virtual \
  # deps \
  python
# build-base 

COPY ./dist ./h4u-his-dist

RUN git clone https://github.com/mophos/h4u-api-his.git \
  && cd h4u-api-his && npm i && npm i mssql@4.1.0  && npx tsc && cd ..

COPY ./server-script/ .

RUN npm init -y && npm i express

COPY ./config/nginx.conf /etc/nginx

COPY ./config/process.json .

CMD /usr/sbin/nginx && /usr/bin/pm2-runtime process.json

EXPOSE 80

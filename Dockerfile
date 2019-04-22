FROM node:8

USER root

RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

ENV HOME=/home/node

WORKDIR $HOME/app

RUN npm i -g npm

RUN npm install -g @angular/cli && npm cache clean --force

EXPOSE 4200

CMD [ "node" ]
COPY ./Angular-project /home/node/app/frontend
RUN chown -R node:node /home/node/app/
RUN chmod 777 -R /home/node/app/
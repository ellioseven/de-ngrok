FROM node:9
MAINTAINER elliot.mitchum@ellioseven.com.au

ENV APP_NPM_GLOBAL_DIR /home/node/.npm-packages
ENV LT_HOST localhost
ENV LT_PORT 80
ENV LT_SUBDOMAIN de-tunnel
ENV PATH /home/node/.npm-packages/bin:$PATH

# Install global packages to '$APP_NPM_GLOBAL_DIR'.
RUN mkdir -p $APP_NPM_GLOBAL_DIR \
	&& echo "prefix=$APP_NPM_GLOBAL_DIR" >> /home/node/.npmrc \
	&& chown -R node:node /home/node

USER node
RUN npm install -g localtunnel
CMD ["sh", "-c", "lt -l $LT_HOST -p $LT_PORT -s $LT_SUBDOMAIN"]

FROM node:18.11.0-slim

# Puppeteer dependencies, from: https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker

# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer installs, work.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update \
    && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && apt-get install -y --no-install-recommends wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get install -y --no-install-recommends google-chrome-stable fonts-ebgaramond-extra fonts-liberation fonts-freefont-ttf ttf-mscorefonts-installer fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb

USER root
WORKDIR /app
RUN npm install puppeteer
COPY ./nginx.conf /nginx.conf

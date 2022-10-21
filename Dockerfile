FROM node:18.11.0-slim AS build

# Puppeteer dependencies, from: https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker

# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer installs, work.
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends wget gnupg ca-certificates \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get install -y --no-install-recommends chromium fonts-liberation fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

FROM build
WORKDIR /tmp
RUN PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm install puppeteer
COPY . /tmp/

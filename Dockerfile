# base image
FROM node:9.6.1

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# set working directory
RUN cd  /home
RUN mkdir angularapp
WORKDIR /home/angularapp
RUN cd  /home
WORKDIR /home/angularapp

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /home/angularapp/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /home/angularapp/package.json
RUN npm install
RUN npm install -g @angular/cli@1.7.1 --unsafe

# add app
COPY . /home/angularapp

# start app
CMD ng serve --host 0.0.0.0

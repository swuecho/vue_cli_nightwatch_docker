FROM timbru31/java-node # selenium require java 

# credit: https://gist.github.com/varyonic/dea40abcf3dd891d204ef235c6e8dd79

RUN apt-get install -y wget unzip 
RUN apt-get update -y
RUN apt-get install -y nginx # nginx is used to serve the vue app

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 75.0.3770.90 # the google-chrome-stable is version 75
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR
# RUN ls /chromedriver # debug
RUN /chromedriver/chromedriver --version
ENV CHROMEDRIVER_PATH  /chromedriver/chromedriver 

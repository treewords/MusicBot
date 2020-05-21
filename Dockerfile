FROM ubuntu:bionic

LABEL maintainer="Gheonea Iulian <gheonea.iulian@gmail.com>"

ENV BOT_USER="3000" \
    BOT_GROUP="3000" \
    BOT_DIR="/musicbot" \
    BOT_DL_URL="https://github.com/treewords/MusicBot.git" \
	
RUN groupadd -g "$SINUS_GROUP" musicbot && \
    useradd -u "$BOT_USER" -g "$BOT_GROUP" -d "$BOT_DIR" musicbot && \	
    	
# Install build tools
RUN apt-get install build-essential unzip -y && \
    apt-get install software-properties-common -y && \

# Install system dependencies
RUN apt-get update -y && \
    apt-get install git ffmpeg libopus-dev libffi-dev libsodium-dev python3-pip && \
    apt-get upgrade -y apt-get -q upgrade -y && \
	
# Clone the MusicBot to your home directory
RUN mkdir -p "$BOT_DIR" && \
    git clone "$SBOT_DL_URL" && \
    cd $BOT_DIR/MusicBot && \	
    mv Dockerfile README.md bootstrap.py data logs requirements.txt run.py update.bat update.sh LICENSE bin config dockerentry.py musicbot run.bat run.sh update.py /$BOT_DIR && \
    cd $BOT_DIR && \
    rm -r -f MusicBot && \
    chown -fR musicbot:musicbot "$BOT_DIR" && \
    rm -rf /tmp/* /var/tmp/*
	
USER musicbot
WORKDIR "$BOT_DIR"

VOLUME ["$BOT_DIR/config"]

ENTRYPOINT ["python3", "dockerentry.py"]

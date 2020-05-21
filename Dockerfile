FROM ubuntu:bionic

LABEL maintainer="Gheonea Iulian <gheonea.iulian@gmail.com>"

ENV BOT_USER="3000" \
    BOT_GROUP="3000" \
    BOT_DIR="/musicbot" \
    BOT_DL_URL="https://github.com/treewords/MusicBot.git"
	
RUN groupadd -g "$BOT_GROUP" musicbot && \
    useradd -u "$BOT_USER" -g "$BOT_GROUP" -d "$BOT_DIR" musicbot
    	
# Install build tools
RUN apt update -y \
    && apt -y install build-essential \
    unzip \
    software-properties-common

# Install system dependencies
RUN apt-get update -y \
    && apt-get -y install git \
    ffmpeg \
    libopus-dev \
    libffi-dev \
    libsodium-dev \
    python3-pip
	
# Clone the MusicBot to your home directory
RUN mkdir -p "$BOT_DIR" && \
    git clone "$BOT_DL_URL" -b master
    	
USER musicbot
WORKDIR "$BOT_DIR"

VOLUME ["$BOT_DIR/config"]

ENTRYPOINT ["python3", "dockerentry.py"]

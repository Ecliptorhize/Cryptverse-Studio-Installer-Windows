FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl wget unzip git nodejs npm rustc cargo && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g roblox-ts eslint prettier

RUN curl -L https://github.com/argon-rbx/argon/releases/download/2.0.25/argon-2.0.25-linux-x86_64.zip -o argon.zip \
    && unzip argon.zip \
    && mv argon /usr/local/bin/argon \
    && rm argon.zip

RUN curl -L https://github.com/UpliftGames/wally/releases/download/v0.3.2/wally-v0.3.2-linux.zip -o wally.zip \
    && unzip wally.zip \
    && mv wally /usr/local/bin/wally \
    && rm wally.zip

CMD ["bash"]

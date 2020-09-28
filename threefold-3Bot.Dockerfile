FROM ubuntu:latest

# capture build arguements
ARG USER
ARG USER_GROUP
ENV WORK_DIR=/usr/local

# take explicit control of the timezone as universal for now
ENV TZ=Etc/Universal
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# update the distribution and get the latest security patched
RUN apt-get -y update
RUN apt-get -y upgrade

# get the dependencies for threefold build
RUN ["apt-get", "install", "-y", "git","python3-pip","redis-server","tmux", "nginx", "libnss3-tools", "wget", "python3-venv"]
RUN pip3 install poetry

# setup GO build env
RUN wget "https://golang.org/dl/go1.15.2.linux-amd64.tar.gz"
# validate distribution checksum
RUN echo "b49fda1ca29a1946d6bb2a5a6982cf07ccd2aba849289508ee0f9918f6bb4552  go1.15.2.linux-amd64.tar.gz" | sha256sum -c -
RUN tar -C /usr/local -xzf go1.15.2.linux-amd64.tar.gz && rm go1.15.2.linux-amd64.tar.gz
ENV GO_HOME=/usr/local/go
ENV PATH=$PATH:$GO_HOME/bin

# mkcert SSL for encryption in flight
RUN git clone https://github.com/FiloSottile/mkcert \
&& cd mkcert && go build -ldflags "-X main.Version=$(git describe --tags)" \
&& ./mkcert -install

WORKDIR $WORK_DIR

#define non-root user and group
ARG USER
ARG USER_GROUP
RUN addgroup --gid $USER_GROUP threebot
RUN adduser --disabled-password --gecos '' --uid $USER --gid $USER threebot
RUN chown -R $USER .
USER threebot

# get threefold and setup the working dir
RUN git clone https://github.com/Threefoldtech/js-sdk
WORKDIR $WORK_DIR/js-sdk
RUN poetry update
RUN poetry install

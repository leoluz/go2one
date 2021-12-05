FROM golang:1.17.3-bullseye

ARG NVIM_VERSION=0.6.0
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIM_HOME=/home/nvim
ENV NVIM_BIN=${NVIM_HOME}/squashfs-root/usr/bin/nvim
ENV NVIM_CONFIG=${NVIM_HOME}/.config/nvim

# Set the locale
RUN apt-get update && apt upgrade -y && apt-get install -y ca-certificates locales git curl ripgrep fzf
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN mv /go/bin/gopls /usr/local/bin
RUN mv /go/bin/dlv /usr/local/bin

RUN useradd -ms /bin/bash nvim
USER nvim

WORKDIR ${NVIM_HOME}
RUN wget https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage && \
    chmod +x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    rm nvim.appimage

RUN mkdir -p ${NVIM_HOME}/.local/share/nvim/site/pack/packer/start && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

RUN mkdir -p ${NVIM_CONFIG}
ADD nvim/init.lua ${NVIM_CONFIG}/init.lua
ADD nvim/lua ${NVIM_CONFIG}/lua

RUN ${NVIM_BIN} --headless -c 'autocmd User PackerComplete quitall' +PackerSync

RUN mkdir ${NVIM_HOME}/work
WORKDIR ${NVIM_HOME}/work

CMD ["/home/nvim/squashfs-root/usr/bin/nvim"]

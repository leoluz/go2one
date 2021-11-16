FROM golang:1.17.3-bullseye

ARG NVIM_VERSION=v0.5.1
ENV NVIM_HOME=/home/nvim
ENV NVIM_BIN=${NVIM_HOME}/squashfs-root/usr/bin/nvim
ENV NVIM_CONFIG=${NVIM_HOME}/.config/nvim
RUN useradd -ms /bin/bash nvim
USER nvim

RUN go install golang.org/x/tools/gopls@latest

WORKDIR ${NVIM_HOME}

RUN wget https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage && \
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

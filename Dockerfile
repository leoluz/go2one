FROM golang:1.17.3-bullseye

ARG NVIM_VERSION=v0.5.1
WORKDIR /home/nvim

RUN wget https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage && \
    chmod +x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    rm nvim.appimage


CMD ["/home/nvim/squashfs-root/usr/bin/nvim"]

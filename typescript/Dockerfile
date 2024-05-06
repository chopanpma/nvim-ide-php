FROM sh1d0w/alpine-nvim:latest

MAINTAINER Sh1d0w <5074917+Sh1d0w@users.noreply.github.com>

WORKDIR /home/developer

USER root

RUN mkdir -p /home/developer/.config/coc

RUN  chown -R  developer /home/developer/.config/coc

USER developer



RUN nvim +'CocInstall -sync coc-prettier coc-eslint coc-cssmodules coc-tsserver' +qall

COPY --chown=developer nvim .config/nvim/typescript

COPY --chown=developer nvim/coc-settings.json .config/nvim

COPY --chown=developer nvim/memos.json .config/coc

RUN echo "runtime ./typescript/init.vim" >> .config/nvim/init.vim

WORKDIR /src

ENTRYPOINT ["nvim", "/src"]

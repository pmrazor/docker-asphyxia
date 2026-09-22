FROM alpine:latest
LABEL maintainer=pmrazor
ENV ASPHYXIA_VERSION=1.70b
ENV ASPHYXIA_PLUGIN_VERSION=0.5
WORKDIR /usr/local/share
COPY bootstrap.sh .
RUN chmod +x bootstrap.sh &&\
    apk add gcompat libgcc libstdc++ &&\
    wget https://github.com/asphyxia-core/core/releases/download/v${ASPHYXIA_VERSION}/asphyxia-core-linux-x64.zip &&\
    wget https://github.com/asphyxia-core/plugins/archive/refs/tags/${ASPHYXIA_PLUGIN_VERSION}.zip &&\
    mkdir -p ./asphyxia &&\
    unzip asphyxia-core-linux-x64.zip -d ./asphyxia &&\
    unzip ${ASPHYXIA_PLUGIN_VERSION}.zip -d ./ &&\
    cp -r plugins-${ASPHYXIA_PLUGIN_VERSION}/* ./asphyxia/plugins &&\
    mv ./asphyxia/plugins ./asphyxia/plugins_default &&\
    mkdir -p ./asphyxia/plugins &&\
    rm *.zip &&\
    rm -rf plugins-${ASPHYXIA_PLUGIN_VERSION} &&\
    chmod -R 774 ./asphyxia
CMD ["/bin/sh", "/usr/local/share/bootstrap.sh"]

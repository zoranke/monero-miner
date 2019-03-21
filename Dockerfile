FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget

ENV XMRIG_VERSION=2.14.1 XMRIG_SHA256=bb9c62aefa457d436ebdc82aa36f08955b2cbfdfbbc6394b2e039b9cffaface4

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  rm xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ["./xmrig"]
CMD ["--url=xmr.pool.minergate.com:45700", "--user=jacky.deng@pm.me", "--pass=Docker", "-k", "--max-cpu-usage=100"]

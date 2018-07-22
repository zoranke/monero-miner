FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget

ENV XMRIG_VERSION=2.6.4 XMRIG_SHA256=34d390a499d2098bce92e6b85b4858ee6255a7e2d4e03197ba4f6a759efe349c

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ["./xmrig"]
CMD ["--url=pool.supportxmr.com:5555", "--user=56wohsdz3NFBW5GimAULS74ZNWbG5vyksiS6HYwSpd9MVpVtDKW9Fx4UsKXjZR46xqhCq13KnnWDvEBbA8WrTQg1RMENtPb", "--pass=Docker", "-k", "--max-cpu-usage=60"]

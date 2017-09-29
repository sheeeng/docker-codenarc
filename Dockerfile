FROM groovy:2.4

USER root

ENV CODENARC_VERSION=1.0
ENV SLF4J_VERSION=1.7.25
ENV GMETRICS_VERSION=1.0

RUN wget https://netcologne.dl.sourceforge.net/project/codenarc/codenarc/CodeNarc%201.0/CodeNarc-1.0.jar \
    -P /opt/CodeNarc-$CODENARC_VERSION

RUN wget -qO- https://www.slf4j.org/dist/slf4j-$SLF4J_VERSION.tar.gz | tar xvz -C /opt

RUN wget https://github.com/dx42/gmetrics/releases/download/v$GMETRICS_VERSION/GMetrics-$GMETRICS_VERSION.jar \
    -P /opt/GMetrics-$GMETRICS_VERSION

RUN cd /opt/CodeNarc-$CODENARC_VERSION; \
    wget http://codenarc.sourceforge.net/StarterRuleSet-AllRulesByCategory.groovy.txt \
    -O all.groovy

COPY codenarc /usr/bin

USER groovy

WORKDIR /ws

ENTRYPOINT ["codenarc"]

ARG GROOVY_VERSION="2.5.6"
FROM groovy:"${GROOVY_VERSION}"

USER root

ENV CODENARC_VERSION=1.3
ENV SLF4J_VERSION=1.7.26
ENV GMETRICS_VERSION=1.0

RUN wget \
    https://netcologne.dl.sourceforge.net/project/codenarc/codenarc/CodeNarc%20$CODENARC_VERSION/CodeNarc-$CODENARC_VERSION.jar \
    --directory-prefix /opt/CodeNarc-$CODENARC_VERSION \
    --no-verbose

RUN wget \
    --output-document - https://www.slf4j.org/dist/slf4j-$SLF4J_VERSION.tar.gz \
    --quiet \
    | \
        tar \
        --directory /opt \
        --extract \
        --gunzip \
        --verbose

RUN wget \
    https://github.com/dx42/gmetrics/releases/download/v$GMETRICS_VERSION/GMetrics-$GMETRICS_VERSION.jar \
    --directory-prefix /opt/GMetrics-$GMETRICS_VERSION \
    --no-verbose

COPY codenarc /usr/bin

USER groovy

WORKDIR /workspace

# http://central.maven.org/maven2/org/codehaus/groovy/groovy/2.5.6/groovy-2.5.6.jar
# http://central.maven.org/maven2/org/codehaus/groovy/groovy-templates/2.5.6/groovy-templates-2.5.6.jar
# http://central.maven.org/maven2/org/codehaus/groovy/groovy-xml/2.5.6/groovy-xml-2.5.6.jar

ENTRYPOINT ["codenarc"]

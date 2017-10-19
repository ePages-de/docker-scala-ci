FROM openjdk:8u131-jdk
MAINTAINER Christian Hoffmeister <mail@choffmeister.de>

ENV DOCKER_VERSION="17.06.2-ce"
ENV DOCKER_SHA="2a4206fea5d3d3f4373e13569538522417e2c9d3"
ENV SCALA_VERSION="2.12.3"
ENV SCALA_SHA="05501f1f39e58273a05ef99bb2f5c23affb5a416"
ENV SBT_VERSION="0.13.15"
ENV SBT_HASH="46f07dbfec874be8687072e07d2c3f22b4f7cc76"

WORKDIR /tmp
RUN \
  wget https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
  echo "$DOCKER_SHA  docker-$DOCKER_VERSION.tgz" | shasum -c - && \
  tar xf docker-$DOCKER_VERSION.tgz && \
  mv docker /opt/docker && \
  ln -s /opt/docker/docker /usr/bin/docker && \
  rm -r docker-$DOCKER_VERSION.tgz
RUN \
  wget http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  echo "$SCALA_SHA  scala-$SCALA_VERSION.tgz" | shasum -c - && \
  tar xf scala-$SCALA_VERSION.tgz && \
  mv scala-$SCALA_VERSION /opt/scala && \
  ln -s /opt/scala/bin/fsc /usr/bin/fsc && \
  ln -s /opt/scala/bin/scala /usr/bin/scala && \
  ln -s /opt/scala/bin/scalac /usr/bin/scalac && \
  ln -s /opt/scala/bin/scaladoc /usr/bin/scaladoc && \
  ln -s /opt/scala/bin/scalap /usr/bin/scalap && \
  rm scala-$SCALA_VERSION.tgz
RUN \
  wget https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
  echo "$SBT_HASH  sbt-$SBT_VERSION.tgz" | shasum -c - && \
  tar xf sbt-$SBT_VERSION.tgz && \
  mv sbt /opt/sbt && \
  ln -s /opt/sbt/bin/sbt /usr/bin/sbt && \
  rm sbt-$SBT_VERSION.tgz && \
  mkdir project && \
  echo "sbt.version=0.13.12" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.13" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.14" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.15" > project/build.properties && \
  sbt sbtVersion && \
  rm -rf project

WORKDIR /root
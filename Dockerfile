# based on https://registry.hub.docker.com/u/samtstern/android-sdk/dockerfile/ with openjdk-8
FROM java:8

MAINTAINER FUJI Goro <g.psy.va+github@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 rsync --no-install-recommends && \
    apt-get clean

# Download and untar SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz
RUN curl -L "${ANDROID_SDK_URL}" | tar --no-same-owner -xz -C /usr/local
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# Install Android SDK components
ENV ANDROID_SDK_COMPONENTS platform-tools,build-tools-22.0.1,android-21,extra-android-m2repository,extra-google-m2repository
RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_SDK_COMPONENTS}"

# Support Gradle
ENV TERM dumb
ENV JAVA_OPTS -Xms256m -Xmx512m


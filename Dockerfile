FROM ubuntu

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl

# Install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install graphics libraries/drivers
ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :1
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:oibaf/graphics-drivers
RUN apt-get install -y libvulkan1 mesa-vulkan-drivers vulkan-utils
RUN apt-get install -y gcc xserver-xorg-video-dummy x11-apps libxrandr2 libxi6

ADD dummy.conf /etc/X11/xorg.conf
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

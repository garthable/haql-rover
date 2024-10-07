FROM ros:humble as base
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
  && apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

# install common packages
RUN apt-get update; \
  apt-get install -y -q \
  git \
  build-essential \
  cmake \
  python3 \
  qtbase5-dev \
  libqt5svg5-dev \
  libzmq3-dev \
  libdw-dev \
  libtinfo-dev \
  libncurses5-dev \
  libncursesw5-dev \
  iproute2 \
  ros-humble-robot-localization \
  ros-humble-foxglove-bridge \
  ros-humble-grid-map \
  ros-humble-joint-state-broadcaster \
  ros-humble-diff-drive-controller \
  ros-humble-nav2-bringup ; \
  rm -rf /var/lib/apt/lists/*
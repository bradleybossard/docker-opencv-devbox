FROM bradleybossard/docker-common-devbox

RUN apt-get update --fix-missing

RUN apt-get install --yes build-essential cmake git pkg-config libjpeg8-dev \
                          libtiff5 libjasper-dev libpng12-dev \
                          libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev \
                          libv4l-dev python2.7-dev

WORKDIR /root

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

RUN pip install numpy

RUN git clone https://github.com/Itseez/opencv.git; cd opencv; git checkout 3.0.0

WORKDIR /root

RUN git clone https://github.com/Itseez/opencv_contrib.git; cd opencv_contrib; git checkout 3.0.0

WORKDIR /root/opencv
RUN mkdir -p /root/opencv/build
WORKDIR /root/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D INSTALL_C_EXAMPLES=ON \
          -D INSTALL_PYTHON_EXAMPLES=ON \
          -D OPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib/modules \
          -D BUILD_EXAMPLES=ON ..

RUN make -j4

RUN make install
RUN ldconfig



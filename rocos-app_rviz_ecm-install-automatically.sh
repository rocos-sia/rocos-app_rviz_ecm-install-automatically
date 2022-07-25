
###
 # @Author: JC
 # @Date: 2022年07月25日10:56:24
 # @LastEditTime: 2022-07-16 17:28:27
 # @LastEditors: DESKTOP-S1QDRL5
 # @Description: In User Settings Edit

### 

#!/bin/bash

###依赖安装###

sudo apt install \
qttools5-dev \
libqt5gamepad5-dev \
libeigen3-dev \
libyaml-cpp-dev \
liborocos-kdl-dev \
libqt5x11extras5-dev \
libboost-all-dev git  cmake libxt-dev -y

#########

 popd popd popd  popd popd popd  popd popd popd  popd popd popd  popd popd popd  popd popd popd  popd popd popd 


mkdir -p dev
pushd dev
    ###grpc###
    git clone --recurse-submodules -b v1.46.3 --depth 1 --shallow-submodules https://github.com/grpc/grpc
    pushd grpc
        git submodule update --init --recursive
        mkdir -p cmake/build
        pushd cmake/build
            cmake -DgRPC_INSTALL=ON \
                -DgRPC_BUILD_TESTS=OFF \
                -DCMAKE_INSTALL_PREFIX=/opt/grpc \
                ../..
            make -j$(nproc)  
            make install
        popd
    popd 
    ############    

    ###VTK###
    wget -nc https://www.vtk.org/files/release/8.2/VTK-8.2.0.tar.gz
    tar -zxvf   VTK-8.2.0.tar.gz
    pushd VTK-8.2.0
        mkdir -p build
        pushd build
            cmake -DModule_vtkGUISupportQtOpenGL=true -DModule_vtkInfovisBoostGraphAlgorithms=true ..
            make -j `nproc`
            sudo make install
        popd
    popd
    sudo echo -e "\n/usr/local/lib" >> /etc/ld.so.conf
    ldconfig
    ############    

    ###rviz###
    git clone https://github.com/thinkexist1989/rocos-viz.git --depth=1 
    pushd rocos-viz/
        mkdir build 
        pushd build
            cmake   -DCMAKE_BUILD_TYPE=Release ..
            make -j`nproc`
        popd
    popd
    ############    

    ###app###
    sudo apt install \
    libboost-all-dev \
    libyaml-cpp-dev\
    qt5-default\
    libeigen3-dev\
    liburdfdom-dev \
    libtinyxml2-dev -y

    git clone https://github.com/thinkexist1989/rocos-app.git --depth=1  -b JC-master
    pushd rocos-app
        mkdir build 
        pushd build
            cmake   -DCMAKE_BUILD_TYPE=Release ..
            make -j`nproc`
        popd
    popd
    ############    

    

    ###ecm###
   git clone https://github.com/thinkexist1989/rocos-ecm.git --depth=1 
    pushd rocos-ecm/
        mkdir build 
        pushd build
            cmake   -DCMAKE_BUILD_TYPE=Release ..
            make -j`nproc`
        popd
    popd
    ############    

popd


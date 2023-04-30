#!/bin/bash

# install k3d, please input your password
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# create k3d cluster
# クラスター作ったら勝手にk3dクラスターのcontextが選択される
k3d cluster create iot


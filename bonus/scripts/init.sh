#!/bin/bash

# ==== Color definition ==== #
ylw="\033[33m"
grn="\033[32m"
blu="\033[34m"
mgn="\033[35m"
cyn="\033[36m"
nc="\033[m"

# install repo
echo -e "${grn}add helm repository.${nc}"
helm repo add gitlab https://charts.gitlab.io
helm repo update

# install gitlab cli
echo -e "${grn}install gitlab command.${nc}"
glab_version="1.29.4"
if [ `uname -m` = "arm64" ] ;then
# arm64の時はapple silicon決め打ち
target="macOS_arm64"
else
target="Linux_x86_64"
fi
curl -OL https://gitlab.com/gitlab-org/cli/-/releases/v${glab_version}/downloads/glab_${glab_version}_${target}.tar.gz
mkdir glab
tar -zxvf glab_${glab_version}_${target}.tar.gz -C glab
sudo mv glab/bin/glab /usr/local/bin/glab
rm -rf glab

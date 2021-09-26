#!/bin/bash

# download source codes
mkdir -p v2ray_pkg
echo "# download source codes"
git clone https://github.com/v2fly/v2ray-core.git
#git clone https://github.com/v2fly/v2ray-core.git --branch=v4.42.2 --depth=1

# download dependencies
echo "# download dependencies"
cd v2ray-core
go mod download

# compile
echo "# compile"
CGO_ENABLE=0 go build -o ../v2ray_pkg/v2ray -trimpath -ldflags "-s -w -buildid=" ./main
CGO_ENABLE=0 go build -o ../v2ray_pkg/v2ctl -trimpath -ldflags "-s -w -buildid=" -tags confonly ./infra/control/main

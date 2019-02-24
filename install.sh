#!/bin/sh

git clone https://github.com/saibing/bingo.git
cd bingo
export GOPROXY=https://athens.azurefd.net/
GO111MODULE=on go install
mv $GOPATH/bin/bingo /usr/local/bin
unset GOPROXY
cd ..
rm -rf ./bingo

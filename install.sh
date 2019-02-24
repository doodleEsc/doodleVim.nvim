#!/bin/sh

# install go language server
git clone https://github.com/saibing/bingo.git
cd bingo
export GOPROXY=https://athens.azurefd.net/
GO111MODULE=on go install
mv $GOPATH/bin/bingo /usr/local/bin
unset GOPROXY
cd ..
rm -rf ./bingo

# install python language server
pip3 uninstall python-language-server -y
pip3 install 'python-language-server[all]' --upgrade

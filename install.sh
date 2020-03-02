#!/bin/sh

# install go language server
# go get -u golang.org/x/tools/cmd/gopls
GO111MODULE=on go get golang.org/x/tools/gopls


# install python language server
pip3 uninstall python-language-server -y
pip3 install 'python-language-server[all]' --upgrade


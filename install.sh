#!/bin/sh

#install minpac
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac

#install nodejs
curl -sL install-node.now.sh | sh
npm install -g typescript typescript-language-server

# install go language server
go get -u golang.org/x/tools/cmd/gopls
mv $GOPATH/bin/gopls /usr/local/bin
rm -rf $GOPATH/src/*

# install python language server
pip3 uninstall python-language-server -y
pip3 install 'python-language-server[yapf,rope,pyflakes,mccabe,pycodestyle]' --upgrade

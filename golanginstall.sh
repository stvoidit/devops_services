GOVERSION=$1
GOTARGZ="go$GOVERSION.linux-amd64.tar.gz"

cd $HOME && wget --no-hsts https://golang.org/dl/$GOTARGZ && sudo tar -C /usr/local -xzf $GOTARGZ && rm $GOTARGZ
echo set $GOPATH
if [ "$GOPATH" != "$HOME/go" ]; then echo 'export GOPATH=$HOME/go' >>$HOME/.bashrc; fi
if [ "$GOROOT" != "/usr/local/go" ]; then echo 'export GOROOT=/usr/local/go' >>$HOME/.bashrc; fi
if [ "$GOPATH" != "$HOME/go" ]; then echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >>$HOME/.bashrc; fi

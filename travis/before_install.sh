#!/bin/bash -e

if [ $LUA = "luajit" ]; then
	if [ $LUAJIT_VER = "2.0" ]; then
		sudo add-apt-repository ppa:mwild1/ppa -y && sudo apt-get update -y;
	fi
	if [ $LUAJIT_VER = "2.1" ]; then
		sudo add-apt-repository ppa:neomantra/luajit-v2.1 -y && sudo apt-get update -y;
	fi
fi

if [[ $LUA = "lua5.3" ]]; then
	LUA_V="5.3.0"
	wget "http://www.lua.org/ftp/lua-${LUA_V}.tar.gz"
	tar xf "lua-${LUA_V}.tar.gz"
	pushd "lua-${LUA_V}"
		make linux
		sudo make install
	popd
else
	sudo apt-get install $LUA
	sudo apt-get install $LUA_DEV
fi
lua$LUA_SFX -v
# Install a recent luarocks release
wget http://luarocks.org/releases/$LUAROCKS_BASE.tar.gz
tar zxvpf $LUAROCKS_BASE.tar.gz
pushd $LUAROCKS_BASE
	# esto quedo medio feo
	if [[ $LUA = "lua5.3" ]]; then
		./configure --lua-version=$LUA_VER --with-lua-include="$LUA_INCDIR"
	else
		./configure --lua-version=$LUA_VER --lua-suffix=$LUA_SFX --with-lua-include="$LUA_INCDIR"
	fi
	make build && sudo make install
popd
cd $TRAVIS_BUILD_DIR

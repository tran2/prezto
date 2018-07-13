if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release)="Ubuntu" ]; then
	echo "Installing Tmux for Ubuntu"
	sudo apt-get update -yqqu
	sudo add-apt-repository -yu ppa:pi-rho/dev
	sudo apt-get update -yqqu
	sudo apt-get install -yqqu python-software-properties software-properties-common
	sudo apt-get install -yqq tmux-next=2.3~20160913~bzr3547+20-1ubuntu1~ppa0~ubuntu16.04.1
	tmux-next -V
fi

UBUNTU_INSTALLS="curl git neovim tmux zsh"

all: git tmux vim zsh

git: FORCE
	rm -f ~/.gitconfig
	ln -s ${PWD}/git/.gitconfig ~/

tmux: FORCE
	rm -rf ~/.tmux*
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	ln -s ${PWD}/tmux/.tmux.conf ~/
	~/.tmux/plugins/tpm/bin/install_plugins

vim: vimrc vim-plugins

vimrc: FORCE
	rm -f ~/.vimrc
	rm -f ~/.ctrlpignore
	rm -f ~/.eslintrc
	ln -s ${PWD}/vim/.vimrc ~/
	ln -s ${PWD}/vim/.ctrlpignore ~/
	ln -s ${PWD}/vim/.eslintrc ~/

vim-plugins: FORCE
	rm -rf ~/.vim/bundle
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

zsh: FORCE
	rm -f ~/.zshrc
	ln -s ${PWD}/zsh/.zshrc ~/
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

prep-ubuntu: FORCE
	sudo apt-get install $(UBUNTU_INSTALLS)

FORCE:

# just for fun
sudo yum install zsh
sudo chsh -s $(which zsh) $(whoami)
cd $HOME
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | zsh
ln -sf ./sbc/.zshrc ~/.zshrc

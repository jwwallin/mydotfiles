
# Install the dotfiles
git clone --bare  git@github.com:jwwallin/mydotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

# install Pathogen for vim
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install solarized colorscheme for vim
cd $HOME/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git

# Set the newly downloaded bash_profile as the source
source $HOME/bash_profile


Dotfiles
========

My dotfiles using [stow][stow].

You can just use the config of one of the applications using...

    stow vim

or all of them using

    stow *

My change was inspired by this [stow article][stow_article]

Emacs
-----

You can check [emacs configuration page][emacs].

Using vundle
------------

    $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    $ vim +BundleInstall +qall

Using oh-my-zsh
---------------

    $ git clone https://github.com/javaguirre/oh-my-zsh.git ~/.oh-my-zsh


[stow]: http://www.gnu.org/software/stow/
[stow_article]: http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
[emacs]: https://github.com/javaguirre/dotfiles/blob/master/emacs/.emacs.d/javaguirre.org

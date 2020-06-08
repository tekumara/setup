#!/bin/sh	

# pyenv can't be lazy loaded using the same technique for 
# virtualenvwrapper because if a virtualenv is activated before
# pyenv loads (eg: by an IDE terminal) it will break the virtualenv
eval "$(pyenv init - zsh --no-rehash)"

# lazy load virtualenvwrapper for faster shell startup times
# faster than pyenv virtualenvwrapper_lazy
__vew_init() {
    pyenv virtualenvwrapper
}	

mkvirtualenv() {
	__vew_init	
	mkvirtualenv "$@"	
}

workon() {
	__vew_init	
	workon "$@"	
}
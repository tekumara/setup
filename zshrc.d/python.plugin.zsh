#!/bin/sh	

# lazy load pyenv & virtualenvwrapper for faster shell startup times

__pyenv_init() {
    eval "$(command pyenv init -)"
    pyenv virtualenvwrapper_lazy

    unset -f python
    unset -f pip
}	

pyenv() {	
	__pyenv_init	
	pyenv "$@"	
}	

python() {	
	__pyenv_init	
	python "$@"	
}	

pip() {	
	__pyenv_init	
	pip "$@"	
}

mkvirtualenv() {
	__pyenv_init	
	mkvirtualenv "$@"	
}

workon() {
	__pyenv_init	
	workon "$@"	
}
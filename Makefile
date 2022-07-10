## The Makefile includes instructions on running the commands

install:
# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
	pip install -r requirements.txt &&\
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	sudo chmod +x /bin/hadolint
	
env:
	which python3
	python3 --version
	which pytest
	which pylint
	
lint:
	hadolint Dockerfile --ignore DL4000
	pylint --disable=R,C,W1203,W1202 app.py

all: setup install env lint

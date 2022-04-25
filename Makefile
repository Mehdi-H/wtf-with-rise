SHELL := /bin/bash
.SHELLFLAGS = -ec
.SILENT:
MAKEFLAGS += --silent
.ONESHELL:
default: help

help:
	echo -e "Please use \`make \033[36m<target>\033[0m\`"
	echo -e "👉\t where \033[36m<target>\033[0m is one of"
	grep -E '^\.PHONY: [a-zA-Z_-]+ .*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = "(: |##)"}; {printf "• \033[36m%-30s\033[0m %s\n", $$2, $$3}'

.PHONY: dependencies ## ⬇️ installe les dépendances
dependencies:
	pip install -U pip
	pip install -r requirements.txt
	echo "🏁 Dépendances python installées"

.PHONY: slide-exports  ## export des slides
slide-exports:
	jupyter nbconvert --to slides README.ipynb --output-dir=exports/
	echo "🗂 Slides exportées au format HTML dans file://$(PWD)/exports/README.slides.html"
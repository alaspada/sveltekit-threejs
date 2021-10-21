SHELL:=/usr/bin/env bash
# Basic vars
THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PRJ_NAME:=$(shell basename ${THIS_DIR})

#Suppress makes own output
#.SILENT:

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

.DEFAULT_GOAL := help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-\.]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

run.dev: ## Execute a dev server
	@npm run dev -- --open --host
SHELL = /bin/bash

.PHONY: help
help: ## Display this help message
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: prepare
prepare: ### Install dependencies
	flutter pub get

.PHONY: generatePigeon
generatePigeon: ### Generate Pigeon code
	dart run pigeon --input pigeon_api.dart

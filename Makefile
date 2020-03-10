.DEFAULT_GOAL := help

DOWNLOAD_URL := "https://bitcoin.org/bin/bitcoin-core-0.19.1/bitcoin-0.19.1-x86_64-linux-gnu.tar.gz"
IMAGE_TAG := "bitcoin-core-gui"

build: ## build the image
	docker build . \
		-t "${IMAGE_TAG}" \
		--build-arg DOWNLOAD_URL="${DOWNLOAD_URL}"

help: ## show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

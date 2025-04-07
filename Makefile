.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Helpers

.PHONY: devcontainer
devcontainer: ## Build devcontainer image locally
	docker build --no-cache --rm -f ".devcontainer/Dockerfile" -t monitor-operator-devcontainer:latest ".devcontainer" 

.PHONY: cluster
cluster: ## Setup kind cluster with operators
	./hacks/kind-create-cluster.sh
	./hacks/infra-monitoring.sh
	kubectl apply -k config/crd

.PHONY: debug
debug: ## Run shell-operator locally
	mkdir -p .debug
	sudo shell-operator
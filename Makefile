.PHONY: run_website stop_website install_kind install_kubectl \
	create_kind_cluster create_docker_registry

run_website:
  	docker build -t sampleapp.com . && \
	  docker run --rm --name sampleapp.com -p 8000:80 -d sampleapp.com

stop_website:
	docker stop sampleapp.com

install_kind:
	if ./kind --version | grep -q 'kind version'; \
	then echo "---> kind already installed; skipping"; \
	else curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-darwin-arm64 && \
      chmod +x ./kind && \
	    ./kind --version; \
	fi 

install_kubectl: 
	brew install kubectl

create_kind_cluster: install_kind install_kubectl create_docker_registry
	kind create cluster --name samplapp.com && \
	  kubectl get nodes

create_docker_registry:
	if docker ps | grep -q 'local-registry'; \
	then echo "---> local-registry already created; skipping"; \
	else docker run --name local-registry -d --restart=always -p 8001:8000 registry:2; \
	fi

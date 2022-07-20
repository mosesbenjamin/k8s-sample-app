.PHONY: run_website stop_website install_kind install_kubectl \
	create_kind_cluster

run_website:
  	docker build -t sampleapp.com . && \
	  docker run --rm --name sampleapp.com -p 8000:80 -d sampleapp.com

stop_website:
	docker stop sampleapp.com

install_kind:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-darwin-arm64 && \
      chmod +x ./kind && \
	    ./kind --version 

install_kubectl: 
	brew install kubectl

create_kind_cluster: install_kind install_kubectl
	kind create cluster --name samplapp.com && \
	  kubectl get nodes
	  
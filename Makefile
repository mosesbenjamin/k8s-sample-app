.PHONY: run_website stop_website install_kind install_kubectl \
	create_kind_cluster create_docker_registry connect_registry_to_kind_network \
	connect_registry_to_kind create_kind_cluster_with_registry delete_kind_cluster \
	delete_docker_registry

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
	kind create cluster --name sampleapp.com --config kind_config.yml || true && \
	  kubectl get nodes

create_docker_registry:
	if docker ps | grep -q 'local-registry'; \
	then echo "---> local-registry already created; skipping"; \
	else docker run --name local-registry -d --restart=always -p 8000:8000 registry:2; \
	fi

connect_registry_to_kind_network:
	docker network connect kind local-registry || true

connect_registry_to_kind: connect_registry_to_kind_network
	kubectl apply -f kind_configmap.yml

create_kind_cluster_with_registry:
	$(MAKE) create_kind_cluster && $(MAKE) connect_registry_to_kind

delete_kind_cluster: delete_docker_registry
	kind delete cluster --name sampleapp.com

delete_docker_registry: 
	docker stop local-registry && docker rm local-registry
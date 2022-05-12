.PHONY: default

default: up ip ## Tests the ansible setup in the build container
	ansible-playbook ansible/local.yml -i ansible/hosts --extra-vars "ansible_sudo_pass=test"

install: ## Runs the ansible setup on the local machine
	echo 'localhost ansible_connection=local ansible_python_interpreter="/usr/bin/python3.9"' > ansible/hosts
	ansible-playbook ansible/local.yml -i ansible/hosts --ask-become-pass

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

ip: ## Gets the containers IP and puts it in the hosts file
	echo "`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu` \
				 ansible_connection=ssh \
				 ansible_user=test \
				 ansible_ssh_pass=test" > ansible/hosts


# Container management commands
up: ## Starts up the container in the background
	docker-compose up -d

down: ## Stops the container and destroys the volumes
	docker-compose down -v

build: ## Builds the docker container from the Dockerfile
	docker-compose build

connect: ## Connects to the ubuntu contianer via SSH
	ssh test@`cat ansible/hosts`
